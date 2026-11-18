create schema if not exists private;
revoke all on schema private from public;

create type public.app_role as enum ('user', 'editor', 'reviewer', 'admin');

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  display_name text not null
    constraint profiles_display_name_length check (char_length(btrim(display_name)) between 2 and 60),
  preferred_locale text not null default 'fr'
    constraint profiles_locale_supported check (preferred_locale in ('fr', 'ar')),
  role public.app_role not null default 'user',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.profiles is 'Profil applicatif. Le role ne peut pas etre modifie par son titulaire.';

create index profiles_role_idx on public.profiles (role) where role <> 'user';

alter table public.profiles enable row level security;

create function private.has_role(required public.app_role)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.profiles p
    where p.id = (select auth.uid()) and p.role = required
  );
$$;

revoke all on function private.has_role(public.app_role) from public;
grant usage on schema private to authenticated;
grant execute on function private.has_role(public.app_role) to authenticated;

create policy "profiles_select_own_or_admin"
  on public.profiles for select to authenticated
  using (id = (select auth.uid()) or (select private.has_role('admin')));

create policy "profiles_update_own"
  on public.profiles for update to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

revoke all on public.profiles from anon, authenticated;
grant select on public.profiles to authenticated;
grant update (display_name, preferred_locale) on public.profiles to authenticated;

create function private.touch_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger profiles_touch_updated_at
  before update on public.profiles
  for each row execute function private.touch_updated_at();

create function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  wanted_name text := left(btrim(coalesce(new.raw_user_meta_data ->> 'display_name', '')), 60);
  wanted_locale text := new.raw_user_meta_data ->> 'preferred_locale';
begin
  if char_length(wanted_name) < 2 then
    wanted_name := 'Utilisateur';
  end if;
  if wanted_locale is null or wanted_locale not in ('fr', 'ar') then
    wanted_locale := 'fr';
  end if;
  insert into public.profiles (id, display_name, preferred_locale)
  values (new.id, wanted_name, wanted_locale);
  return new;
end;
$$;

revoke all on function private.handle_new_user() from public;
revoke all on function private.touch_updated_at() from public;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function private.handle_new_user();
