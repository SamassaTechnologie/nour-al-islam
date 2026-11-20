-- Assistant IA : limite de questions par personne et par jour (le texte des questions n'est pas garde).
create table public.assistant_usage (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users (id) on delete cascade,
  created_at timestamptz not null default now()
);
create index assistant_usage_user_day on public.assistant_usage (user_id, created_at);
alter table public.assistant_usage enable row level security;
create policy assistant_usage_select_own on public.assistant_usage for select to authenticated using (user_id = (select auth.uid()));
revoke all on public.assistant_usage from anon, authenticated;
grant select on public.assistant_usage to authenticated;

-- Reserve une question si la limite du jour (UTC) n'est pas atteinte ; renvoie le nombre restant, ou -1.
create or replace function public.assistant_take_quota(p_limit integer default 20) returns integer
language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); used integer; lim integer := least(greatest(coalesce(p_limit, 20), 1), 20);
begin
  if uid is null then return -1; end if;
  perform pg_advisory_xact_lock(hashtext(uid::text));
  select count(*) into used from public.assistant_usage where user_id = uid and created_at >= date_trunc('day', now() at time zone 'UTC') at time zone 'UTC';
  if used >= lim then return -1; end if;
  insert into public.assistant_usage (user_id) values (uid);
  return lim - used - 1;
end $$;
revoke all on function public.assistant_take_quota(integer) from public, anon;
grant execute on function public.assistant_take_quota(integer) to authenticated;
