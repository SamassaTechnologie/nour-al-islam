-- Tableau de bord : activite quotidienne de chaque utilisateur.
-- Les compteurs sont tenus par des declencheurs (jamais ecrits par le navigateur).
-- Le jour est le jour UTC (comme current_date cote serveur et les revisions de memorisation).

create table public.user_activity_days (
  user_id uuid not null references auth.users (id) on delete cascade,
  day date not null,
  exercises integer not null default 0 check (exercises >= 0),
  reviews integer not null default 0 check (reviews >= 0),
  readings integer not null default 0 check (readings >= 0),
  primary key (user_id, day)
);

alter table public.user_activity_days enable row level security;
create policy activity_select_own on public.user_activity_days for select to authenticated
  using (user_id = (select auth.uid()));
revoke all on public.user_activity_days from anon, authenticated;
grant select on public.user_activity_days to authenticated;

create or replace function private.bump_activity(p_user uuid, p_at timestamptz, p_kind text)
returns void language plpgsql security definer set search_path = '' as $$
declare d date := (p_at at time zone 'UTC')::date;
begin
  insert into public.user_activity_days as a (user_id, day, exercises, reviews, readings)
  values (p_user, d, (p_kind = 'exercise')::int, (p_kind = 'review')::int, (p_kind = 'reading')::int)
  on conflict (user_id, day) do update set
    exercises = a.exercises + (p_kind = 'exercise')::int,
    reviews = a.reviews + (p_kind = 'review')::int,
    readings = a.readings + (p_kind = 'reading')::int;
end $$;
revoke all on function private.bump_activity(uuid, timestamptz, text) from public, anon, authenticated;

create or replace function private.on_quiz_attempt() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
  perform private.bump_activity(new.user_id, new.created_at, 'exercise');
  return null;
end $$;

create or replace function private.on_hifdh_review() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
  if new.last_reviewed_at is not null and (tg_op = 'INSERT' or new.last_reviewed_at is distinct from old.last_reviewed_at) then
    perform private.bump_activity(new.user_id, new.last_reviewed_at, 'review');
  end if;
  return null;
end $$;

create or replace function private.on_quran_reading() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
  if tg_op = 'INSERT' or new.updated_at is distinct from old.updated_at then
    perform private.bump_activity(new.user_id, new.updated_at, 'reading');
  end if;
  return null;
end $$;

revoke all on function private.on_quiz_attempt() from public, anon, authenticated;
revoke all on function private.on_hifdh_review() from public, anon, authenticated;
revoke all on function private.on_quran_reading() from public, anon, authenticated;

create trigger quiz_attempts_activity after insert on public.quiz_attempts
  for each row execute function private.on_quiz_attempt();
create trigger hifdh_progress_activity after insert or update on public.hifdh_progress
  for each row execute function private.on_hifdh_review();
create trigger quran_reading_activity after insert or update on public.quran_reading_history
  for each row execute function private.on_quran_reading();

-- Reprise de l'activite deja enregistree (une ligne par jour et par type).
insert into public.user_activity_days (user_id, day, exercises, reviews, readings)
select user_id, day, sum(e)::int, sum(r)::int, sum(q)::int from (
  select user_id, (created_at at time zone 'UTC')::date as day, 1 as e, 0 as r, 0 as q from public.quiz_attempts
  union all
  select user_id, (last_reviewed_at at time zone 'UTC')::date, 0, 1, 0 from public.hifdh_progress where last_reviewed_at is not null
  union all
  select user_id, (updated_at at time zone 'UTC')::date, 0, 0, 1 from public.quran_reading_history
) s group by user_id, day
on conflict (user_id, day) do nothing;
