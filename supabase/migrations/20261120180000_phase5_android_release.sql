-- Téléchargement de l'application Android : espace public en lecture seule.
-- Seule la fonction Edge « release » (rôle service, jeton secret du coffre) peut y déposer un fichier.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('downloads', 'downloads', true, 52428800, array['application/vnd.android.package-archive'])
on conflict (id) do nothing;

select vault.create_secret(encode(extensions.gen_random_bytes(32), 'hex'), 'release_token', 'Dépôt des versions de l''application Android');

create or replace function public.release_secret() returns text
language sql stable security definer set search_path = '' as $$
  select decrypted_secret from vault.decrypted_secrets where name = 'release_token' limit 1
$$;
revoke all on function public.release_secret() from public, anon, authenticated;
grant execute on function public.release_secret() to service_role;
