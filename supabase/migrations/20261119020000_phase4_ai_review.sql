-- Relecture provisoire par l'assistant IA : visible par l'equipe seulement,
-- jusqu'a la validation d'un reviseur humain qui rend le contenu public.
alter table public.content_revisions add column review_kind text
  constraint content_revisions_review_kind_check check (review_kind in ('ai', 'scholar'));
alter table public.content_revisions add constraint content_revisions_published_review_kind
  check (status <> 'published' or review_kind is not null);

create or replace function private.is_published_revision(rev uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.content_items i join public.content_revisions r on r.id = i.published_revision_id
    where i.published_revision_id = rev and r.review_kind = 'scholar');
$$;

alter policy content_items_read on public.content_items
  using (private.is_published_revision(published_revision_id) or (select private.is_staff()));
grant select (review_kind) on public.content_revisions to anon;

create or replace function private.content_action(p_revision uuid, p_action text, p_note text default null)
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
    update public.content_revisions r set status = next_status, review_kind = 'scholar', reviewer_id = me, reviewer_name = my_name, published_at = now() where r.id = rev.id;
    update public.content_items i set published_revision_id = rev.id where i.id = item.id;
  elsif p_action = 'validate' then
    if my_role <> 'reviewer' then raise exception 'Seul un réviseur religieux peut valider.'; end if;
    if not private.is_aal2() then raise exception 'La double authentification est requise pour valider.'; end if;
    if rev.status <> 'published' or item.published_revision_id is distinct from rev.id or rev.review_kind is distinct from 'ai' then
      raise exception 'Cette version n''attend pas de validation.';
    end if;
    if rev.author_id = me then raise exception 'Un réviseur ne peut pas valider son propre texte.'; end if;
    if rev.content_hash is distinct from private.revision_hash(rev.id) then raise exception 'Le contenu a changé depuis sa relecture.'; end if;
    next_status := 'published';
    update public.content_revisions r set review_kind = 'scholar', reviewer_id = me, reviewer_name = my_name, published_at = now() where r.id = rev.id;
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


create function private.ai_log(p_item uuid, p_revision uuid, p_action text, p_from text, p_to text, p_note text)
returns void language sql security definer set search_path = '' as $$
  insert into public.audit_log (actor_name, action, item_id, revision_id, from_value, to_value, note)
  values ('Claude (assistant IA)', p_action, p_item, p_revision, p_from, p_to, p_note);
$$;

create function private.ai_request_changes(p_revision uuid, p_note text)
returns public.content_status language plpgsql security definer set search_path = '' as $$
declare
  rev public.content_revisions;
  note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  if note is null then raise exception 'Indiquez les corrections demandées.'; end if;
  select * into rev from public.content_revisions r where r.id = p_revision for update;
  if not found then raise exception 'Version introuvable.'; end if;
  if rev.status not in ('source_check', 'in_review') then raise exception 'Cette version ne peut pas être renvoyée.'; end if;
  update public.content_references x set verified_by = null, verified_name = null, verified_at = null where x.revision_id = rev.id;
  update public.content_revisions r set status = 'changes_requested', content_hash = null where r.id = rev.id;
  perform private.ai_log(rev.item_id, rev.id, 'request_changes', rev.status::text, 'changes_requested', note);
  return 'changes_requested';
end;
$$;

create function private.ai_review(p_revision uuid, p_note text)
returns public.content_status language plpgsql security definer set search_path = '' as $$
declare
  ai constant text := 'Claude (assistant IA)';
  rev public.content_revisions;
  item public.content_items;
  note text := nullif(btrim(coalesce(p_note, '')), '');
begin
  if note is null then raise exception 'Indiquez le compte rendu de la relecture.'; end if;
  select * into rev from public.content_revisions r where r.id = p_revision for update;
  if not found then raise exception 'Version introuvable.'; end if;
  if rev.status not in ('draft', 'changes_requested') then raise exception 'Seul un brouillon peut être relu par l''IA.'; end if;
  select * into item from public.content_items i where i.id = rev.item_id for update;
  if exists (select 1 from public.content_revisions r where r.id = item.published_revision_id and r.review_kind = 'scholar') then
    raise exception 'Ce contenu est validé par un réviseur : sa nouvelle version doit passer par la relecture humaine.';
  end if;
  if char_length(btrim(rev.body)) < 20 then raise exception 'Le texte est trop court.'; end if;
  if not exists (select 1 from public.content_references x where x.revision_id = rev.id) then raise exception 'Ajoutez au moins une référence.'; end if;
  if item.kind = 'legal_opinion' and not exists (select 1 from public.content_opinions o where o.revision_id = rev.id) then
    raise exception 'Un avis juridique doit présenter au moins un avis attribué et sourcé.';
  end if;
  update public.content_references x set verified_by = null, verified_name = ai, verified_at = now() where x.revision_id = rev.id;
  update public.content_revisions r set status = 'superseded' where r.id = item.published_revision_id;
  update public.content_revisions r set status = 'published', review_kind = 'ai', submitted_at = now(), content_hash = private.revision_hash(rev.id),
    source_checked_by = null, source_checked_name = ai, source_checked_at = now(), reviewer_id = null, reviewer_name = ai, published_at = now()
  where r.id = rev.id;
  update public.content_items i set published_revision_id = rev.id where i.id = item.id;
  perform private.ai_log(item.id, rev.id, 'ai_review', rev.status::text, 'published', note);
  return 'published';
end;
$$;

revoke all on function private.ai_log(uuid, uuid, text, text, text, text), private.ai_request_changes(uuid, text), private.ai_review(uuid, text) from public, anon, authenticated;
