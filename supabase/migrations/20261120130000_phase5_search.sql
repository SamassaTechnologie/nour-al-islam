-- Recherche dans les lecons et les invocations (en plus de search_quran).
-- security invoker : chacun ne trouve que ce qu'il a le droit de lire (RLS).
create extension if not exists unaccent with schema extensions;

-- Fonctions pures de normalisation (sans acces aux donnees).
-- Francais et translitteration : sans accents, sans signes ʿ ʾ ’, en minuscules.
create or replace function public.norm_latin(t text) returns text
language sql stable set search_path = '' as $$
  select lower(extensions.unaccent('extensions.unaccent'::regdictionary, regexp_replace(coalesce(t, ''), '[ʿʾ’''`‘]', '', 'g')))
$$;
-- Arabe : sans voyelles ni signes, alif et ta marbuta unifies (comme search_quran).
create or replace function public.norm_arabic(t text) returns text
language sql immutable set search_path = '' as $$
  select translate(regexp_replace(coalesce(t, ''), '[ً-ٰٟۖ-ۭـ]', '', 'g'), 'أإآٱىة', 'ااااىه')
$$;
revoke all on function public.norm_latin(text), public.norm_arabic(text) from public;
grant execute on function public.norm_latin(text), public.norm_arabic(text) to anon, authenticated;

create or replace function public.search_content(query text, max_results integer default 30)
returns table (slug text, section text, kind text, title text, summary text, body text, dhikr text, rank real)
language sql stable security invoker set search_path = '' as $$
  with q as (
    select btrim(query) as raw,
           replace(replace(replace(public.norm_latin(btrim(query)), '\', '\\'), '%', '\%'), '_', '\_') as latin,
           replace(replace(replace(public.norm_arabic(btrim(query)), '\', '\\'), '%', '\%'), '_', '\_') as arabic,
           btrim(query) ~ '[؀-ۿ]' as is_arabic
  ), docs as (
    select i.slug, i.section, i.kind::text as kind, r.id as rid, r.title, r.summary, r.body
    from public.content_items i
    join public.content_revisions r on r.id = i.published_revision_id
  ), lessons as (
    select d.slug, d.section, d.kind, d.title, d.summary, d.body, null::text as dhikr,
      (case when public.norm_latin(d.title) like '%' || q.latin || '%' then 2 else 0 end
       + ts_rank(to_tsvector('french'::regconfig, d.title || ' ' || d.summary || ' ' || d.body), websearch_to_tsquery('french'::regconfig, q.raw)))::real as rank
    from docs d cross join q
    where (q.is_arabic and public.norm_arabic(d.body) like '%' || q.arabic || '%')
       or (not q.is_arabic and (
            public.norm_latin(d.title || ' ' || d.summary || ' ' || d.body) like '%' || q.latin || '%'
            or to_tsvector('french'::regconfig, d.title || ' ' || d.summary || ' ' || d.body) @@ websearch_to_tsquery('french'::regconfig, q.raw)))
  ), adhkar as (
    select distinct on (d.slug) d.slug, d.section, d.kind, d.title, d.summary, ''::text as body, a.title as dhikr, 1.5::real as rank
    from docs d join public.content_adhkar a on a.revision_id = d.rid cross join q
    where (q.is_arabic and public.norm_arabic(coalesce(a.arabic, '')) like '%' || q.arabic || '%')
       or (not q.is_arabic and public.norm_latin(concat_ws(' ', a.title, a.transliteration, a.meaning, a.when_to_say, a.virtue)) like '%' || q.latin || '%')
    order by d.slug, a.ord
  ), hits as (
    select * from lessons
    union all
    select a.* from adhkar a where not exists (select 1 from lessons l where l.slug = a.slug)
  )
  select h.slug, h.section, h.kind, h.title, h.summary, h.body, h.dhikr, h.rank
  from hits h cross join q
  where char_length(q.raw) between 2 and 80
  order by h.rank desc, h.title
  limit least(greatest(coalesce(max_results, 30), 1), 50);
$$;
revoke all on function public.search_content(text, integer) from public;
grant execute on function public.search_content(text, integer) to anon, authenticated;
