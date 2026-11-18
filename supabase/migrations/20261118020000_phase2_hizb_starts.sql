create function public.hizb_starts()
returns table (hizb smallint, rub smallint, surah smallint, number smallint, ayah_count bigint)
language sql stable security invoker set search_path = '' as $$
  select a.hizb, a.rub, (array_agg(a.surah order by a.id))[1], (array_agg(a.number order by a.id))[1], count(*)
  from public.ayahs a group by a.hizb, a.rub order by a.hizb, a.rub;
$$;
revoke all on function public.hizb_starts() from public;
grant execute on function public.hizb_starts() to anon, authenticated;
