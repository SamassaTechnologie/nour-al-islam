-- Phase 3 : contenus religieux, circuit de validation et journal d'audit.
create type public.content_kind as enum ('lesson', 'explanation', 'legal_opinion');
create type public.content_status as enum ('draft', 'source_check', 'in_review', 'changes_requested', 'published', 'superseded', 'withdrawn');
create type public.reference_kind as enum ('quran', 'hadith', 'book');

create function private.my_role()
returns public.app_role language sql stable security definer set search_path = '' as $$
  select p.role from public.profiles p where p.id = (select auth.uid());
$$;
create function private.is_staff()
returns boolean language sql stable set search_path = '' as $$
  select coalesce(private.my_role() in ('editor', 'reviewer', 'admin'), false);
$$;
create function private.is_aal2()
returns boolean language sql stable set search_path = '' as $$
  select coalesce((select auth.jwt()) ->> 'aal', '') = 'aal2';
$$;

create table public.content_items (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (char_length(slug) <= 80 and slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  kind public.content_kind not null,
  section text not null check (section in ('aqida', 'purification', 'priere', 'jeune', 'zakat', 'hajj', 'fiqh', 'sira', 'hadith', 'tafsir', 'tajwid', 'arabe', 'adab', 'famille')),
  locale text not null default 'fr' check (locale in ('fr', 'ar')),
  created_by uuid references public.profiles (id) on delete set null,
  published_revision_id uuid,
  created_at timestamptz not null default now()
);

create table public.content_revisions (
  id uuid primary key default gen_random_uuid(),
  item_id uuid not null references public.content_items (id) on delete cascade,
  number integer not null check (number > 0),
  title text not null check (char_length(btrim(title)) between 3 and 160),
  summary text not null default '' check (char_length(summary) <= 400),
  body text not null default '' check (char_length(body) <= 60000),
  ai_assisted boolean not null default false,
  status public.content_status not null default 'draft',
  author_id uuid references public.profiles (id) on delete set null,
  author_name text not null,
  submitted_at timestamptz,
  source_checked_by uuid references public.profiles (id) on delete set null,
  source_checked_name text,
  source_checked_at timestamptz,
  reviewer_id uuid references public.profiles (id) on delete set null,
  reviewer_name text,
  published_at timestamptz,
  content_hash text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (item_id, number)
);
create unique index content_one_open_revision on public.content_revisions (item_id)
  where status in ('draft', 'source_check', 'in_review', 'changes_requested');
create index content_revisions_status_idx on public.content_revisions (status);
create index content_revisions_author_idx on public.content_revisions (author_id);
create index content_revisions_checker_idx on public.content_revisions (source_checked_by);
create index content_revisions_reviewer_idx on public.content_revisions (reviewer_id);
create index content_items_creator_idx on public.content_items (created_by);

alter table public.content_items
  add constraint content_items_published_revision_id_fkey
  foreign key (published_revision_id) references public.content_revisions (id) on delete set null;
create index content_items_published_idx on public.content_items (published_revision_id);

create table public.content_references (
  id uuid primary key default gen_random_uuid(),
  revision_id uuid not null references public.content_revisions (id) on delete cascade,
  ord bigint generated always as identity,
  kind public.reference_kind not null,
  surah smallint references public.surahs (number),
  ayah_from smallint check (ayah_from > 0),
  ayah_to smallint,
  collection text check (char_length(collection) <= 160),
  edition text check (char_length(edition) <= 200),
  hadith_number text check (char_length(hadith_number) <= 40),
  grade text check (char_length(grade) <= 120),
  graded_by text check (char_length(graded_by) <= 160),
  source_title text check (char_length(source_title) <= 240),
  author text check (char_length(author) <= 160),
  locator text check (char_length(locator) <= 160),
  url text check (char_length(url) <= 500 and url ~ '^https://'),
  note text check (char_length(note) <= 600),
  verified_by uuid references public.profiles (id) on delete set null,
  verified_name text,
  verified_at timestamptz,
  constraint reference_quran_complete check (kind <> 'quran' or (surah is not null and ayah_from is not null and ayah_to is not null and ayah_to >= ayah_from)),
  constraint reference_hadith_complete check (kind <> 'hadith' or (
    nullif(btrim(collection), '') is not null and nullif(btrim(edition), '') is not null and nullif(btrim(hadith_number), '') is not null
    and nullif(btrim(source_title), '') is not null and nullif(btrim(grade), '') is not null and nullif(btrim(graded_by), '') is not null)),
  constraint reference_book_complete check (kind <> 'book' or (
    nullif(btrim(source_title), '') is not null and nullif(btrim(author), '') is not null and nullif(btrim(locator), '') is not null))
);
create index content_references_revision_idx on public.content_references (revision_id, ord);
create index content_references_surah_idx on public.content_references (surah);
create index content_references_verifier_idx on public.content_references (verified_by);

create table public.content_opinions (
  id uuid primary key default gen_random_uuid(),
  revision_id uuid not null references public.content_revisions (id) on delete cascade,
  ord bigint generated always as identity,
  holder text not null check (char_length(btrim(holder)) between 2 and 160),
  opinion text not null check (char_length(btrim(opinion)) between 3 and 4000),
  source text not null check (char_length(btrim(source)) between 3 and 400)
);
create index content_opinions_revision_idx on public.content_opinions (revision_id, ord);

create table public.audit_log (
  id bigint generated always as identity primary key,
  at timestamptz not null default now(),
  actor_id uuid,
  actor_name text not null,
  action text not null,
  item_id uuid,
  revision_id uuid,
  target_user uuid,
  from_value text,
  to_value text,
  note text
);
create index audit_log_item_idx on public.audit_log (item_id, id desc);
create index audit_log_recent_idx on public.audit_log (id desc);

create function private.forbid_change()
returns trigger language plpgsql set search_path = '' as $$
begin
  raise exception 'Le journal ne peut pas être modifié.';
end;
$$;
create trigger audit_log_append_only before update or delete on public.audit_log
  for each row execute function private.forbid_change();

create trigger content_revisions_touch before update on public.content_revisions
  for each row execute function private.touch_updated_at();

create function private.guard_revision()
returns trigger language plpgsql set search_path = '' as $$
begin
  if (new.title, new.summary, new.body, new.ai_assisted) is distinct from (old.title, old.summary, old.body, old.ai_assisted)
     and old.status not in ('draft', 'changes_requested') then
    raise exception 'Cette version est verrouillée : créez une nouvelle version pour la modifier.';
  end if;
  return new;
end;
$$;
create trigger content_revisions_guard before update on public.content_revisions
  for each row execute function private.guard_revision();

create function private.guard_child()
returns trigger language plpgsql set search_path = '' as $$
declare
  rev uuid := case when tg_op = 'DELETE' then old.revision_id else new.revision_id end;
  current_status public.content_status;
  max_ayah smallint;
  verification constant text[] := array['verified_by', 'verified_name', 'verified_at'];
begin
  select r.status into current_status from public.content_revisions r where r.id = rev;
  if tg_table_name = 'content_references' and tg_op = 'UPDATE'
     and (to_jsonb(new) - verification) = (to_jsonb(old) - verification) then
    return new;
  end if;
  if current_status is not null and current_status not in ('draft', 'changes_requested') then
    raise exception 'Cette version est verrouillée : créez une nouvelle version pour la modifier.';
  end if;
  if tg_op = 'DELETE' then return old; end if;
  if tg_table_name = 'content_references' then
    new.verified_by := null; new.verified_name := null; new.verified_at := null;
    if new.kind = 'quran' then
      select s.ayah_count into max_ayah from public.surahs s where s.number = new.surah;
      if max_ayah is null or new.ayah_to > max_ayah then
        raise exception 'Ce verset n''existe pas dans cette sourate.';
      end if;
    end if;
  end if;
  return new;
end;
$$;
create trigger content_references_guard before insert or update or delete on public.content_references
  for each row execute function private.guard_child();
create trigger content_opinions_guard before insert or update or delete on public.content_opinions
  for each row execute function private.guard_child();

create function private.can_edit_revision(rev uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select coalesce(private.my_role() in ('editor', 'admin'), false) and exists (
    select 1 from public.content_revisions r where r.id = rev and r.status in ('draft', 'changes_requested'));
$$;
create function private.is_published_revision(rev uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (select 1 from public.content_items i where i.published_revision_id = rev);
$$;

create function private.write_log(p_action text, p_item uuid, p_revision uuid, p_user uuid, p_from text, p_to text, p_note text)
returns void language sql security definer set search_path = '' as $$
  insert into public.audit_log (actor_id, actor_name, action, item_id, revision_id, target_user, from_value, to_value, note)
  select (select auth.uid()), coalesce((select p.display_name from public.profiles p where p.id = (select auth.uid())), 'Système'),
    p_action, p_item, p_revision, p_user, p_from, p_to, p_note;
$$;

create function private.revision_hash(rev uuid)
returns text language sql stable security definer set search_path = '' as $$
  select encode(sha256(convert_to(jsonb_build_object(
    'title', r.title, 'summary', r.summary, 'body', r.body, 'ai', r.ai_assisted,
    'references', (select coalesce(jsonb_agg(to_jsonb(x) - array['id', 'revision_id', 'ord', 'verified_by', 'verified_name', 'verified_at'] order by x.ord), '[]'::jsonb) from public.content_references x where x.revision_id = r.id),
    'opinions', (select coalesce(jsonb_agg(jsonb_build_array(o.holder, o.opinion, o.source) order by o.ord), '[]'::jsonb) from public.content_opinions o where o.revision_id = r.id)
  )::text, 'UTF8')), 'hex')
  from public.content_revisions r where r.id = rev;
$$;

create function private.create_content(p_slug text, p_kind public.content_kind, p_section text, p_locale text, p_title text)
returns uuid language plpgsql security definer set search_path = '' as $$
declare
  me uuid := (select auth.uid());
  my_name text;
  new_item uuid;
  new_revision uuid;
begin
  if coalesce(private.my_role() in ('editor', 'admin'), false) is false then
    raise exception 'Création réservée aux éditeurs et administrateurs.';
  end if;
  select p.display_name into my_name from public.profiles p where p.id = me;
  insert into public.content_items (slug, kind, section, locale, created_by) values (p_slug, p_kind, p_section, p_locale, me) returning id into new_item;
  insert into public.content_revisions (item_id, number, title, author_id, author_name) values (new_item, 1, btrim(p_title), me, my_name) returning id into new_revision;
  perform private.write_log('created', new_item, new_revision, null, null, 'draft', null);
  return new_item;
end;
$$;

create function private.new_revision(p_item uuid)
returns uuid language plpgsql security definer set search_path = '' as $$
declare
  me uuid := (select auth.uid());
  my_name text;
  base public.content_revisions;
  created uuid;
begin
  if coalesce(private.my_role() in ('editor', 'admin'), false) is false then
    raise exception 'Action réservée aux éditeurs et administrateurs.';
  end if;
  perform 1 from public.content_items i where i.id = p_item for update;
  if not found then raise exception 'Contenu introuvable.'; end if;
  if exists (select 1 from public.content_revisions r where r.item_id = p_item and r.status in ('draft', 'source_check', 'in_review', 'changes_requested')) then
    raise exception 'Une version est déjà en cours pour ce contenu.';
  end if;
  select * into base from public.content_revisions r where r.item_id = p_item order by r.number desc limit 1;
  select p.display_name into my_name from public.profiles p where p.id = me;
  insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_id, author_name)
  values (p_item, base.number + 1, base.title, base.summary, base.body, base.ai_assisted, me, my_name) returning id into created;
  insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
  select created, x.kind, x.surah, x.ayah_from, x.ayah_to, x.collection, x.edition, x.hadith_number, x.grade, x.graded_by, x.source_title, x.author, x.locator, x.url, x.note
  from public.content_references x where x.revision_id = base.id order by x.ord;
  insert into public.content_opinions (revision_id, holder, opinion, source)
  select created, o.holder, o.opinion, o.source from public.content_opinions o where o.revision_id = base.id order by o.ord;
  perform private.write_log('new_version', p_item, created, null, null, 'draft', null);
  return created;
end;
$$;

create function private.verify_reference(p_reference uuid, p_verified boolean)
returns void language plpgsql security definer set search_path = '' as $$
declare
  me uuid := (select auth.uid());
  my_name text;
  rev public.content_revisions;
  ref public.content_references;
begin
  if not private.is_staff() then raise exception 'Action réservée à l''équipe.'; end if;
  select * into ref from public.content_references x where x.id = p_reference;
  if not found then raise exception 'Référence introuvable.'; end if;
  select * into rev from public.content_revisions r where r.id = ref.revision_id for update;
  if rev.status <> 'source_check' then raise exception 'Cette version n''est pas à l''étape de vérification.'; end if;
  if rev.author_id = me then raise exception 'L''auteur ne peut pas vérifier ses propres références.'; end if;
  select p.display_name into my_name from public.profiles p where p.id = me;
  update public.content_references x set
    verified_by = case when p_verified then me end,
    verified_name = case when p_verified then my_name end,
    verified_at = case when p_verified then now() end
  where x.id = p_reference;
  perform private.write_log(case when p_verified then 'reference_verified' else 'reference_unverified' end, rev.item_id, rev.id, null, null, p_reference::text, null);
end;
$$;

create function private.content_action(p_revision uuid, p_action text, p_note text default null)
returns public.content_status language plpgsql security definer set search_path = '' as $$
declare
  me uuid := (select auth.uid());
  my_role public.app_role;
  my_name text;
  rev public.content_revisions;
  item public.content_items;
  note text := nullif(btrim(coalesce(p_note, '')), '');
  next_status public.content_status;
begin
  select p.role, p.display_name into my_role, my_name from public.profiles p where p.id = me;
  if my_role is null or my_role = 'user' then raise exception 'Action réservée à l''équipe.'; end if;
  select * into rev from public.content_revisions r where r.id = p_revision for update;
  if not found then raise exception 'Version introuvable.'; end if;
  select * into item from public.content_items i where i.id = rev.item_id for update;

  if p_action = 'submit' then
    if my_role not in ('editor', 'admin') then raise exception 'Envoi réservé aux éditeurs et administrateurs.'; end if;
    if rev.status not in ('draft', 'changes_requested') then raise exception 'Cette version a déjà été envoyée.'; end if;
    if char_length(btrim(rev.body)) < 20 then raise exception 'Le texte est trop court pour être envoyé.'; end if;
    if not exists (select 1 from public.content_references x where x.revision_id = rev.id) then raise exception 'Ajoutez au moins une référence.'; end if;
    if item.kind = 'legal_opinion' and not exists (select 1 from public.content_opinions o where o.revision_id = rev.id) then
      raise exception 'Un avis juridique doit présenter au moins un avis attribué et sourcé.';
    end if;
    next_status := 'source_check';
    update public.content_revisions r set status = next_status, submitted_at = now(), content_hash = private.revision_hash(rev.id),
      source_checked_by = null, source_checked_name = null, source_checked_at = null where r.id = rev.id;
  elsif p_action = 'confirm_sources' then
    if rev.status <> 'source_check' then raise exception 'Cette version n''est pas à l''étape de vérification.'; end if;
    if rev.author_id = me then raise exception 'L''auteur ne peut pas confirmer ses propres sources.'; end if;
    if exists (select 1 from public.content_references x where x.revision_id = rev.id and x.verified_at is null) then
      raise exception 'Toutes les références doivent être vérifiées.';
    end if;
    next_status := 'in_review';
    update public.content_revisions r set status = next_status, source_checked_by = me, source_checked_name = my_name, source_checked_at = now() where r.id = rev.id;
  elsif p_action = 'request_changes' then
    if rev.status not in ('source_check', 'in_review') then raise exception 'Cette version ne peut pas être renvoyée.'; end if;
    if rev.status = 'in_review' and my_role <> 'reviewer' then raise exception 'Seul un réviseur peut renvoyer une version en relecture.'; end if;
    if note is null then raise exception 'Indiquez les corrections demandées.'; end if;
    next_status := 'changes_requested';
    update public.content_references x set verified_by = null, verified_name = null, verified_at = null where x.revision_id = rev.id;
    update public.content_revisions r set status = next_status, content_hash = null where r.id = rev.id;
  elsif p_action = 'publish' then
    if my_role <> 'reviewer' then raise exception 'Seul un réviseur religieux peut publier.'; end if;
    if not private.is_aal2() then raise exception 'La double authentification est requise pour publier.'; end if;
    if rev.status <> 'in_review' then raise exception 'Cette version n''est pas en relecture.'; end if;
    if rev.author_id = me then raise exception 'Un réviseur ne peut pas publier son propre texte.'; end if;
    if rev.content_hash is distinct from private.revision_hash(rev.id) then raise exception 'Le contenu a changé depuis son envoi.'; end if;
    if exists (select 1 from public.content_references x where x.revision_id = rev.id and x.verified_at is null) then
      raise exception 'Toutes les références doivent être vérifiées.';
    end if;
    next_status := 'published';
    update public.content_revisions r set status = 'superseded' where r.id = item.published_revision_id;
    update public.content_revisions r set status = next_status, reviewer_id = me, reviewer_name = my_name, published_at = now() where r.id = rev.id;
    update public.content_items i set published_revision_id = rev.id where i.id = item.id;
  elsif p_action = 'withdraw' then
    if my_role not in ('reviewer', 'admin') then raise exception 'Retrait réservé aux réviseurs et administrateurs.'; end if;
    if not private.is_aal2() then raise exception 'La double authentification est requise pour retirer un contenu.'; end if;
    if rev.status <> 'published' or item.published_revision_id is distinct from rev.id then raise exception 'Cette version n''est pas publiée.'; end if;
    if note is null then raise exception 'Indiquez le motif du retrait.'; end if;
    next_status := 'withdrawn';
    update public.content_items i set published_revision_id = null where i.id = item.id;
    update public.content_revisions r set status = next_status where r.id = rev.id;
  else
    raise exception 'Action inconnue.';
  end if;

  perform private.write_log(p_action, item.id, rev.id, null, rev.status::text, next_status::text, note);
  return next_status;
end;
$$;

create function private.admin_list_users()
returns table (id uuid, display_name text, email text, role public.app_role, created_at timestamptz, has_mfa boolean)
language plpgsql stable security definer set search_path = '' as $$
begin
  if private.my_role() is distinct from 'admin' or not private.is_aal2() then
    raise exception 'Accès réservé à l''administrateur authentifié par double facteur.';
  end if;
  return query
    select p.id, p.display_name, u.email::text, p.role, p.created_at,
      exists (select 1 from auth.mfa_factors f where f.user_id = p.id and f.status = 'verified')
    from public.profiles p join auth.users u on u.id = p.id order by p.created_at;
end;
$$;

create function private.admin_set_role(p_user uuid, p_role public.app_role)
returns void language plpgsql security definer set search_path = '' as $$
declare
  old_role public.app_role;
begin
  if private.my_role() is distinct from 'admin' or not private.is_aal2() then
    raise exception 'Accès réservé à l''administrateur authentifié par double facteur.';
  end if;
  perform pg_advisory_xact_lock(hashtext('nour_admin_roles'));
  select p.role into old_role from public.profiles p where p.id = p_user for update;
  if old_role is null then raise exception 'Utilisateur introuvable.'; end if;
  if old_role = p_role then return; end if;
  if old_role = 'admin' and (select count(*) from public.profiles p where p.role = 'admin') = 1 then
    raise exception 'Il doit rester au moins un administrateur.';
  end if;
  update public.profiles p set role = p_role where p.id = p_user;
  perform private.write_log('role_changed', null, null, p_user, old_role::text, p_role::text, null);
end;
$$;

create function public.create_content(p_slug text, p_kind public.content_kind, p_section text, p_locale text, p_title text)
returns uuid language sql set search_path = '' as $$ select private.create_content(p_slug, p_kind, p_section, p_locale, p_title); $$;
create function public.new_content_revision(p_item uuid)
returns uuid language sql set search_path = '' as $$ select private.new_revision(p_item); $$;
create function public.verify_content_reference(p_reference uuid, p_verified boolean)
returns void language sql set search_path = '' as $$ select private.verify_reference(p_reference, p_verified); $$;
create function public.content_action(p_revision uuid, p_action text, p_note text default null)
returns public.content_status language sql set search_path = '' as $$ select private.content_action(p_revision, p_action, p_note); $$;
create function public.admin_list_users()
returns table (id uuid, display_name text, email text, role public.app_role, created_at timestamptz, has_mfa boolean)
language sql stable set search_path = '' as $$ select * from private.admin_list_users(); $$;
create function public.admin_set_role(p_user uuid, p_role public.app_role)
returns void language sql set search_path = '' as $$ select private.admin_set_role(p_user, p_role); $$;

do $$
declare f text;
begin
  foreach f in array array[
    'private.my_role()', 'private.is_staff()', 'private.is_aal2()', 'private.can_edit_revision(uuid)', 'private.is_published_revision(uuid)',
    'private.create_content(text, public.content_kind, text, text, text)', 'private.new_revision(uuid)', 'private.verify_reference(uuid, boolean)',
    'private.content_action(uuid, text, text)', 'private.admin_list_users()', 'private.admin_set_role(uuid, public.app_role)',
    'public.create_content(text, public.content_kind, text, text, text)', 'public.new_content_revision(uuid)', 'public.verify_content_reference(uuid, boolean)',
    'public.content_action(uuid, text, text)', 'public.admin_list_users()', 'public.admin_set_role(uuid, public.app_role)'
  ] loop
    execute format('revoke all on function %s from public, anon', f);
    execute format('grant execute on function %s to authenticated', f);
  end loop;
  foreach f in array array['private.is_staff()', 'private.is_published_revision(uuid)', 'private.my_role()'] loop
    execute format('grant execute on function %s to anon', f);
  end loop;
  foreach f in array array['private.write_log(text, uuid, uuid, uuid, text, text, text)', 'private.revision_hash(uuid)', 'private.guard_revision()', 'private.guard_child()', 'private.forbid_change()'] loop
    execute format('revoke all on function %s from public', f);
  end loop;
end;
$$;
grant usage on schema private to anon;

alter table public.content_items enable row level security;
alter table public.content_revisions enable row level security;
alter table public.content_references enable row level security;
alter table public.content_opinions enable row level security;
alter table public.audit_log enable row level security;

create policy content_items_read on public.content_items for select to anon, authenticated
  using (published_revision_id is not null or (select private.is_staff()));
create policy content_revisions_read on public.content_revisions for select to anon, authenticated
  using (private.is_published_revision(id) or (select private.is_staff()));
create policy content_revisions_edit on public.content_revisions for update to authenticated
  using (private.can_edit_revision(id)) with check (private.can_edit_revision(id));
create policy content_references_read on public.content_references for select to anon, authenticated
  using (private.is_published_revision(revision_id) or (select private.is_staff()));
create policy content_references_insert on public.content_references for insert to authenticated with check (private.can_edit_revision(revision_id));
create policy content_references_delete on public.content_references for delete to authenticated using (private.can_edit_revision(revision_id));
create policy content_opinions_read on public.content_opinions for select to anon, authenticated
  using (private.is_published_revision(revision_id) or (select private.is_staff()));
create policy content_opinions_insert on public.content_opinions for insert to authenticated with check (private.can_edit_revision(revision_id));
create policy content_opinions_delete on public.content_opinions for delete to authenticated using (private.can_edit_revision(revision_id));
create policy audit_log_read on public.audit_log for select to authenticated using ((select private.is_staff()));

revoke all on public.content_items, public.content_revisions, public.content_references, public.content_opinions, public.audit_log from anon, authenticated;
grant select (id, slug, kind, section, locale, published_revision_id, created_at) on public.content_items to anon, authenticated;
grant select (id, item_id, number, title, summary, body, status, author_name, reviewer_name, source_checked_name, published_at) on public.content_revisions to anon;
grant select on public.content_revisions to authenticated;
grant update (title, summary, body, ai_assisted) on public.content_revisions to authenticated;
grant select (id, revision_id, ord, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) on public.content_references to anon;
grant select on public.content_references to authenticated;
grant insert (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) on public.content_references to authenticated;
grant delete on public.content_references to authenticated;
grant select on public.content_opinions to anon, authenticated;
grant insert (revision_id, holder, opinion, source) on public.content_opinions to authenticated;
grant delete on public.content_opinions to authenticated;
grant select on public.audit_log to authenticated;
