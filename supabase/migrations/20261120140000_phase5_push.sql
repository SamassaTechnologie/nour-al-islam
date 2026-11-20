-- Rappels (notifications Web Push) : heures de priere et invocations du matin et du soir.
-- Les abonnements ne sont lus et ecrits que par la fonction Edge « push » (role service) : aucun acces direct.
-- Position arrondie a 0,01° (environ 1 km), seulement pour calculer les heures.
create extension if not exists pg_cron;
create extension if not exists pg_net with schema extensions;

create table public.push_subscriptions (
  id uuid primary key default gen_random_uuid(),
  endpoint text not null unique check (endpoint ~ '^https://' and char_length(endpoint) <= 1000),
  p256dh text not null check (char_length(p256dh) between 20 and 200),
  auth text not null check (char_length(auth) between 8 and 100),
  lat numeric(5,2) not null check (lat between -90 and 90),
  lng numeric(5,2) not null check (lng between -180 and 180),
  tz text not null check (char_length(tz) <= 64),
  method text not null check (char_length(method) <= 40),
  asr text not null check (asr in ('standard', 'hanafi')),
  prayers boolean not null default true,
  adhkar boolean not null default true,
  locale text not null default 'fr' check (locale in ('fr', 'ar')),
  sent jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.push_subscriptions enable row level security;
revoke all on public.push_subscriptions from anon, authenticated;

-- Jeton qui autorise la minuterie a declencher les envois (genere ici, jamais affiche).
select vault.create_secret(encode(extensions.gen_random_bytes(32), 'hex'), 'push_cron_token', 'Minuterie des rappels');

-- Lecture et ecriture des secrets des rappels, reservees au role service (fonction Edge).
create or replace function public.push_secret(p_name text) returns text
language sql stable security definer set search_path = '' as $$
  select decrypted_secret from vault.decrypted_secrets where name = p_name and p_name in ('push_cron_token', 'vapid_public', 'vapid_private') limit 1
$$;
create or replace function public.push_store_vapid(p_public text, p_private text) returns void
language plpgsql security definer set search_path = '' as $$
begin
  if exists (select 1 from vault.secrets where name = 'vapid_public') then return; end if;
  perform vault.create_secret(p_public, 'vapid_public', 'Cle publique VAPID');
  perform vault.create_secret(p_private, 'vapid_private', 'Cle privee VAPID');
end $$;
revoke all on function public.push_secret(text), public.push_store_vapid(text, text) from public, anon, authenticated;
grant execute on function public.push_secret(text), public.push_store_vapid(text, text) to service_role;

-- Chaque minute : demander a la fonction Edge d'envoyer les rappels dus.
select cron.schedule('push-rappels', '* * * * *', $cron$
  select net.http_post(
    url := 'https://zkrjqmirszwjuepmccvd.supabase.co/functions/v1/push',
    headers := jsonb_build_object('Content-Type', 'application/json', 'x-cron-token', (select decrypted_secret from vault.decrypted_secrets where name = 'push_cron_token')),
    body := '{"action":"tick"}'::jsonb,
    timeout_milliseconds := 25000
  );
$cron$);
