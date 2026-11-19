-- Phase 4 : exercices (questions a choix) des lecons et resultats des utilisateurs.
-- Les questions font partie d'une version : elles sont relues, empreintes et verrouillees avec elle.

create table public.content_questions (
  id uuid primary key default gen_random_uuid(),
  revision_id uuid not null references public.content_revisions (id) on delete cascade,
  ord bigint generated always as identity,
  prompt text not null check (char_length(btrim(prompt)) between 3 and 300),
  display text check (display is null or char_length(btrim(display)) between 1 and 40),
  surah smallint references public.surahs (number),
  ayah smallint,
  word_from smallint,
  word_to smallint,
  options text[] not null check (array_ndims(options) = 1 and cardinality(options) between 2 and 5),
  answer smallint not null check (answer >= 0 and answer < cardinality(options)),
  explanation text not null check (char_length(btrim(explanation)) between 3 and 600),
  constraint content_questions_excerpt check (
    (surah is null and ayah is null and word_from is null and word_to is null)
    or (surah is not null and ayah >= 1 and word_from >= 1 and word_to >= word_from and word_to - word_from < 12)
  )
);
create index content_questions_revision_idx on public.content_questions (revision_id, ord);
create index content_questions_surah_idx on public.content_questions (surah);

-- Verrou de version, choix non vides et distincts, extrait lu dans le texte coranique verrouille.
create function private.guard_question()
returns trigger
language plpgsql
set search_path = ''
as $$
declare
  rev uuid := case when tg_op = 'DELETE' then old.revision_id else new.revision_id end;
  current_status public.content_status;
  verse text;
begin
  select r.status into current_status from public.content_revisions r where r.id = rev;
  if current_status is not null and current_status not in ('draft', 'changes_requested') then
    raise exception 'Cette version est verrouillée : créez une nouvelle version pour la modifier.';
  end if;
  if tg_op = 'DELETE' then return old; end if;
  if exists (select 1 from unnest(new.options) o where o is null or char_length(btrim(o)) not between 1 and 200) then
    raise exception 'Chaque choix doit contenir entre 1 et 200 caractères.';
  end if;
  new.prompt := btrim(new.prompt);
  new.display := nullif(btrim(coalesce(new.display, '')), '');
  new.explanation := btrim(new.explanation);
  new.options := array(select btrim(o) from unnest(new.options) with ordinality u(o, n) order by n);
  if (select count(distinct o) from unnest(new.options) o) <> cardinality(new.options) then
    raise exception 'Deux choix sont identiques.';
  end if;
  if new.surah is not null then
    select btrim(substr(a.text_uthmani, a.bismillah_length + 1)) into verse
    from public.ayahs a where a.surah = new.surah and a.number = new.ayah;
    if verse is null then raise exception 'Ce verset n''existe pas dans cette sourate.'; end if;
    if new.word_to > cardinality(regexp_split_to_array(verse, ' ')) then
      raise exception 'Ce verset ne contient pas autant de mots.';
    end if;
  end if;
  return new;
end;
$$;

create trigger content_questions_guard before insert or update or delete on public.content_questions
  for each row execute function private.guard_question();

-- Empreinte : les questions n'y entrent que si la version en a, pour garder les empreintes existantes.
create or replace function private.revision_hash(rev uuid)
returns text
language sql
stable security definer
set search_path = ''
as $$
  select encode(sha256(convert_to((jsonb_build_object(
    'title', r.title, 'summary', r.summary, 'body', r.body, 'ai', r.ai_assisted,
    'references', (select coalesce(jsonb_agg(to_jsonb(x) - array['id', 'revision_id', 'ord', 'verified_by', 'verified_name', 'verified_at'] order by x.ord), '[]'::jsonb) from public.content_references x where x.revision_id = r.id),
    'opinions', (select coalesce(jsonb_agg(jsonb_build_array(o.holder, o.opinion, o.source) order by o.ord), '[]'::jsonb) from public.content_opinions o where o.revision_id = r.id)
  ) || coalesce((
    select jsonb_build_object('questions', jsonb_agg(jsonb_build_array(q.prompt, q.display, q.surah, q.ayah, q.word_from, q.word_to, q.options, q.answer, q.explanation) order by q.ord))
    from public.content_questions q where q.revision_id = r.id having count(*) > 0
  ), '{}'::jsonb))::text, 'UTF8')), 'hex')
  from public.content_revisions r where r.id = rev;
$$;

-- Une nouvelle version reprend aussi les questions.
create or replace function private.new_revision(p_item uuid)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := (select auth.uid());
  my_name text;
  base public.content_revisions;
  created uuid;
begin
  if coalesce(private.my_role() in ('editor', 'admin'), false) is false then
    raise exception 'Action réservée aux éditeurs et administrateurs.';
  end if;
  perform 1 from public.content_items i where i.id = p_item for update;
  if not found then raise exception 'Contenu introuvable.'; end if;
  if exists (select 1 from public.content_revisions r where r.item_id = p_item and r.status in ('draft', 'source_check', 'in_review', 'changes_requested')) then
    raise exception 'Une version est déjà en cours pour ce contenu.';
  end if;
  select * into base from public.content_revisions r where r.item_id = p_item order by r.number desc limit 1;
  select p.display_name into my_name from public.profiles p where p.id = me;
  insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_id, author_name)
  values (p_item, base.number + 1, base.title, base.summary, base.body, base.ai_assisted, me, my_name) returning id into created;
  perform private.copy_children(base.id, created);
  perform private.write_log('new_version', p_item, created, null, null, 'draft', null);
  return created;
end;
$$;

create function private.copy_children(p_from uuid, p_to uuid)
returns void
language sql
security definer
set search_path = ''
as $$
  insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
  select p_to, x.kind, x.surah, x.ayah_from, x.ayah_to, x.collection, x.edition, x.hadith_number, x.grade, x.graded_by, x.source_title, x.author, x.locator, x.url, x.note
  from public.content_references x where x.revision_id = p_from order by x.ord;
  insert into public.content_opinions (revision_id, holder, opinion, source)
  select p_to, o.holder, o.opinion, o.source from public.content_opinions o where o.revision_id = p_from order by o.ord;
  insert into public.content_questions (revision_id, prompt, display, surah, ayah, word_from, word_to, options, answer, explanation)
  select p_to, q.prompt, q.display, q.surah, q.ayah, q.word_from, q.word_to, q.options, q.answer, q.explanation
  from public.content_questions q where q.revision_id = p_from order by q.ord;
$$;

-- Nouvelle version redigee par l'assistant IA (appel reserve au proprietaire de la base).
create function private.ai_new_revision(p_item uuid)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  base public.content_revisions;
  created uuid;
begin
  perform 1 from public.content_items i where i.id = p_item for update;
  if not found then raise exception 'Contenu introuvable.'; end if;
  if exists (select 1 from public.content_revisions r where r.item_id = p_item and r.status in ('draft', 'source_check', 'in_review', 'changes_requested')) then
    raise exception 'Une version est déjà en cours pour ce contenu.';
  end if;
  if exists (select 1 from public.content_items i join public.content_revisions r on r.id = i.published_revision_id where i.id = p_item and r.review_kind = 'scholar') then
    raise exception 'Ce contenu est validé par un réviseur : sa nouvelle version doit passer par la relecture humaine.';
  end if;
  select * into base from public.content_revisions r where r.item_id = p_item order by r.number desc limit 1;
  insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_id, author_name)
  values (p_item, base.number + 1, base.title, base.summary, base.body, true, null, 'Claude (assistant IA)') returning id into created;
  perform private.copy_children(base.id, created);
  perform private.ai_log(p_item, created, 'new_version', null, 'draft', null);
  return created;
end;
$$;

revoke all on function private.guard_question() from public, anon, authenticated;
revoke all on function private.copy_children(uuid, uuid) from public, anon, authenticated;
revoke all on function private.ai_new_revision(uuid) from public, anon, authenticated;

alter table public.content_questions enable row level security;
create policy content_questions_read on public.content_questions for select to anon, authenticated
  using (private.is_published_revision(revision_id) or (select private.is_staff()));
create policy content_questions_insert on public.content_questions for insert to authenticated with check (private.can_edit_revision(revision_id));
create policy content_questions_delete on public.content_questions for delete to authenticated using (private.can_edit_revision(revision_id));
revoke all on public.content_questions from anon, authenticated;
grant select on public.content_questions to anon, authenticated;
grant insert (revision_id, prompt, display, surah, ayah, word_from, word_to, options, answer, explanation) on public.content_questions to authenticated;
grant delete on public.content_questions to authenticated;

-- Resultats : chaque utilisateur ne voit et n'ajoute que les siens, pour une version publiee visible.
create table public.quiz_attempts (
  id bigint generated always as identity primary key,
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  item_id uuid not null references public.content_items (id) on delete cascade,
  revision_id uuid references public.content_revisions (id) on delete set null,
  score smallint not null check (score >= 0),
  total smallint not null check (total between 1 and 100),
  created_at timestamptz not null default now(),
  constraint quiz_attempts_score_within_total check (score <= total)
);
create index quiz_attempts_user_idx on public.quiz_attempts (user_id, item_id, created_at desc);
create index quiz_attempts_item_idx on public.quiz_attempts (item_id);
create index quiz_attempts_revision_idx on public.quiz_attempts (revision_id);

alter table public.quiz_attempts enable row level security;
create policy quiz_attempts_select_own on public.quiz_attempts for select to authenticated
  using (user_id = (select auth.uid()));
create policy quiz_attempts_insert_own on public.quiz_attempts for insert to authenticated
  with check (
    user_id = (select auth.uid())
    and exists (select 1 from public.content_items i where i.id = quiz_attempts.item_id and i.published_revision_id = quiz_attempts.revision_id)
    and total = (select count(*) from public.content_questions q where q.revision_id = quiz_attempts.revision_id)
  );
revoke all on public.quiz_attempts from anon, authenticated;
grant select on public.quiz_attempts to authenticated;
grant insert (item_id, revision_id, score, total) on public.quiz_attempts to authenticated;
