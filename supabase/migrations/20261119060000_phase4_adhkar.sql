-- Phase 4 : invocations authentiques (adhkar).
-- Une categorie d'invocations est un contenu (rubrique 'adhkar') ; chaque invocation est une ligne liee
-- a une version : relue, comprise dans l'empreinte et verrouillee avec elle, comme les exercices.
-- Le texte arabe est repris tel que la source le publie (scripts/adhkar), jamais saisi a la main.

create table public.content_adhkar (
  id uuid primary key default gen_random_uuid(),
  revision_id uuid not null references public.content_revisions (id) on delete cascade,
  ord bigint generated always as identity,
  title text not null check (char_length(btrim(title)) between 3 and 120),
  arabic text not null check (char_length(btrim(arabic)) between 2 and 2000),
  transliteration text not null check (char_length(btrim(transliteration)) between 2 and 2000),
  meaning text not null check (char_length(btrim(meaning)) between 2 and 2000),
  repeat_count smallint not null default 1 check (repeat_count between 1 and 1000),
  when_to_say text check (when_to_say is null or char_length(btrim(when_to_say)) between 2 and 300),
  virtue text check (virtue is null or char_length(btrim(virtue)) between 2 and 1000),
  collection text not null check (char_length(btrim(collection)) between 2 and 120),
  hadith_number text not null check (char_length(btrim(hadith_number)) between 1 and 40),
  grade text not null check (char_length(btrim(grade)) between 2 and 200),
  graded_by text not null check (char_length(btrim(graded_by)) between 2 and 300),
  url text not null check (url ~ '^https://'),
  note text check (note is null or char_length(btrim(note)) between 2 and 1000)
);
create index content_adhkar_revision_idx on public.content_adhkar (revision_id, ord);

create function private.guard_dhikr()
returns trigger
language plpgsql
set search_path = ''
as $$
declare
  rev uuid := case when tg_op = 'DELETE' then old.revision_id else new.revision_id end;
  current_status public.content_status;
begin
  select r.status into current_status from public.content_revisions r where r.id = rev;
  if current_status is not null and current_status not in ('draft', 'changes_requested') then
    raise exception 'Cette version est verrouillée : créez une nouvelle version pour la modifier.';
  end if;
  if tg_op = 'DELETE' then return old; end if;
  if new.arabic !~ '[ء-ي]' then raise exception 'Le texte arabe doit contenir des lettres arabes.'; end if;
  new.title := btrim(new.title);
  new.arabic := btrim(new.arabic);
  new.transliteration := btrim(new.transliteration);
  new.meaning := btrim(new.meaning);
  new.when_to_say := nullif(btrim(coalesce(new.when_to_say, '')), '');
  new.virtue := nullif(btrim(coalesce(new.virtue, '')), '');
  new.note := nullif(btrim(coalesce(new.note, '')), '');
  return new;
end;
$$;

create trigger content_adhkar_guard before insert or update or delete on public.content_adhkar
  for each row execute function private.guard_dhikr();

-- Empreinte : les invocations n'y entrent que si la version en a, pour garder les empreintes existantes.
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
  ), '{}'::jsonb) || coalesce((
    select jsonb_build_object('adhkar', jsonb_agg(to_jsonb(d) - array['id', 'revision_id', 'ord'] order by d.ord))
    from public.content_adhkar d where d.revision_id = r.id having count(*) > 0
  ), '{}'::jsonb))::text, 'UTF8')), 'hex')
  from public.content_revisions r where r.id = rev;
$$;

-- Une nouvelle version reprend aussi les invocations.
create or replace function private.copy_children(p_from uuid, p_to uuid)
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
  insert into public.content_adhkar (revision_id, title, arabic, transliteration, meaning, repeat_count, when_to_say, virtue, collection, hadith_number, grade, graded_by, url, note)
  select p_to, d.title, d.arabic, d.transliteration, d.meaning, d.repeat_count, d.when_to_say, d.virtue, d.collection, d.hadith_number, d.grade, d.graded_by, d.url, d.note
  from public.content_adhkar d where d.revision_id = p_from order by d.ord;
$$;

revoke all on function private.guard_dhikr() from public, anon, authenticated;
revoke all on function private.copy_children(uuid, uuid) from public, anon, authenticated;

alter table public.content_adhkar enable row level security;
create policy content_adhkar_read on public.content_adhkar for select to anon, authenticated
  using (private.is_published_revision(revision_id) or (select private.is_staff()));
create policy content_adhkar_insert on public.content_adhkar for insert to authenticated with check (private.can_edit_revision(revision_id));
create policy content_adhkar_delete on public.content_adhkar for delete to authenticated using (private.can_edit_revision(revision_id));
revoke all on public.content_adhkar from anon, authenticated;
grant select on public.content_adhkar to anon, authenticated;
grant insert (revision_id, title, arabic, transliteration, meaning, repeat_count, when_to_say, virtue, collection, hadith_number, grade, graded_by, url, note) on public.content_adhkar to authenticated;
grant delete on public.content_adhkar to authenticated;
