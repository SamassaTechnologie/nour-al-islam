-- Invocations qui consistent a reciter des versets : le texte et sa traduction sont lus dans le texte
-- coranique verrouille (sourate, versets), jamais saisis. Le texte arabe et le sens restent alors vides.

alter table public.content_adhkar
  add column surah smallint references public.surahs (number),
  add column ayah_from smallint,
  add column ayah_to smallint,
  alter column arabic drop not null,
  alter column meaning drop not null,
  add constraint content_adhkar_text_or_quran check (
    (surah is null and ayah_from is null and ayah_to is null and arabic is not null and meaning is not null)
    or (surah is not null and ayah_from >= 1 and ayah_to >= ayah_from and arabic is null and meaning is null)
  );

create or replace function private.guard_dhikr()
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
  if new.arabic is not null and new.arabic !~ '[ء-ي]' then raise exception 'Le texte arabe doit contenir des lettres arabes.'; end if;
  if new.surah is not null and not exists (select 1 from public.ayahs a where a.surah = new.surah and a.number = new.ayah_to) then
    raise exception 'Ces versets n''existent pas dans cette sourate.';
  end if;
  new.title := btrim(new.title);
  new.arabic := nullif(btrim(coalesce(new.arabic, '')), '');
  new.transliteration := btrim(new.transliteration);
  new.meaning := nullif(btrim(coalesce(new.meaning, '')), '');
  new.when_to_say := nullif(btrim(coalesce(new.when_to_say, '')), '');
  new.virtue := nullif(btrim(coalesce(new.virtue, '')), '');
  new.note := nullif(btrim(coalesce(new.note, '')), '');
  return new;
end;
$$;

-- Empreinte : les colonnes de versets n'y entrent que lorsqu'elles sont remplies (empreintes existantes inchangees).
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
    select jsonb_build_object('adhkar', jsonb_agg(
      to_jsonb(d) - array['id', 'revision_id', 'ord'] - (case when d.surah is null then array['surah', 'ayah_from', 'ayah_to'] else array[]::text[] end)
      order by d.ord))
    from public.content_adhkar d where d.revision_id = r.id having count(*) > 0
  ), '{}'::jsonb))::text, 'UTF8')), 'hex')
  from public.content_revisions r where r.id = rev;
$$;

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
  insert into public.content_adhkar (revision_id, title, arabic, transliteration, meaning, repeat_count, when_to_say, virtue, collection, hadith_number, grade, graded_by, url, note, surah, ayah_from, ayah_to)
  select p_to, d.title, d.arabic, d.transliteration, d.meaning, d.repeat_count, d.when_to_say, d.virtue, d.collection, d.hadith_number, d.grade, d.graded_by, d.url, d.note, d.surah, d.ayah_from, d.ayah_to
  from public.content_adhkar d where d.revision_id = p_from order by d.ord;
$$;

revoke all on function private.guard_dhikr() from public, anon, authenticated;
revoke all on function private.copy_children(uuid, uuid) from public, anon, authenticated;
grant insert (surah, ayah_from, ayah_to) on public.content_adhkar to authenticated;
