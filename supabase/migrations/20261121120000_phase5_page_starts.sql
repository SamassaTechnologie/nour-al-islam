-- Debut de chaque page du Mushaf de Medine (604 pages) : premier verset et juz, pour le plan de lecture.
create or replace function public.page_starts()
returns table(page smallint, surah smallint, number smallint, juz smallint)
language sql
stable
set search_path to ''
as $$
  select a.page, (array_agg(a.surah order by a.id))[1], (array_agg(a.number order by a.id))[1], (array_agg(a.juz order by a.id))[1]
  from public.ayahs a group by a.page order by a.page;
$$;

grant execute on function public.page_starts() to anon, authenticated;
