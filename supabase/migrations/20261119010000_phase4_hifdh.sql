create table public.hifdh_progress (
  user_id uuid not null references auth.users (id) on delete cascade,
  ayah_id smallint not null references public.ayahs (id),
  surah smallint not null references public.surahs (number),
  level smallint not null default 0 check (level between 0 and 5),
  reviews integer not null default 0 check (reviews >= 0),
  next_review date not null default current_date,
  last_reviewed_at timestamptz not null default now(),
  primary key (user_id, ayah_id)
);
create index hifdh_due_idx on public.hifdh_progress (user_id, next_review, ayah_id);
create index hifdh_surah_idx on public.hifdh_progress (user_id, surah);
create index hifdh_ayah_idx on public.hifdh_progress (ayah_id);
create index hifdh_surah_fk_idx on public.hifdh_progress (surah);

alter table public.hifdh_progress enable row level security;
create policy hifdh_select_own on public.hifdh_progress for select to authenticated using (user_id = (select auth.uid()));
create policy hifdh_insert_own on public.hifdh_progress for insert to authenticated with check (user_id = (select auth.uid()));
create policy hifdh_update_own on public.hifdh_progress for update to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
revoke all on public.hifdh_progress from anon, authenticated;
grant select, insert, update on public.hifdh_progress to authenticated;

create function public.hifdh_rate(p_ayah smallint, p_known boolean)
returns table (level smallint, next_review date)
language sql security invoker set search_path = '' as $$
  with verse as (
    select a.id, a.surah, h.level as old_level, coalesce(h.reviews, 0) as old_reviews
    from public.ayahs a
    left join public.hifdh_progress h on h.ayah_id = a.id and h.user_id = (select auth.uid())
    where a.id = p_ayah
  ), rated as (
    select v.*, case when p_known then least(coalesce(v.old_level + 1, 0), 5)::smallint else 0::smallint end as new_level from verse v
  )
  insert into public.hifdh_progress as p (user_id, ayah_id, surah, level, reviews, next_review, last_reviewed_at)
  select (select auth.uid()), r.id, r.surah, r.new_level, r.old_reviews + 1,
    case when p_known then current_date + (array[1, 3, 7, 14, 30, 60])[r.new_level + 1] else current_date end, now()
  from rated r
  on conflict (user_id, ayah_id) do update set level = excluded.level, reviews = excluded.reviews, next_review = excluded.next_review, last_reviewed_at = excluded.last_reviewed_at
  returning p.level, p.next_review;
$$;

create function public.hifdh_summary()
returns table (surah smallint, worked integer, due integer)
language sql stable security invoker set search_path = '' as $$
  select h.surah, count(*)::integer, (count(*) filter (where h.next_review <= current_date))::integer
  from public.hifdh_progress h where h.user_id = (select auth.uid()) group by h.surah;
$$;

revoke all on function public.hifdh_rate(smallint, boolean), public.hifdh_summary() from public, anon;
grant execute on function public.hifdh_rate(smallint, boolean), public.hifdh_summary() to authenticated;
