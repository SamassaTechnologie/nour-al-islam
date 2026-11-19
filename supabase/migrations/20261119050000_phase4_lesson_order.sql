-- Ordre des lecons dans leur parcours : place choisie par un editeur ou un administrateur, inscrite au journal.
alter table public.content_items add column position smallint check (position between 1 and 999);
grant select (position) on public.content_items to anon, authenticated;

create function private.set_position(p_item uuid, p_position smallint)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  old_position smallint;
begin
  if coalesce(private.my_role() in ('editor', 'admin'), false) is false then
    raise exception 'Action réservée aux éditeurs et administrateurs.';
  end if;
  if p_position is not null and p_position not between 1 and 999 then
    raise exception 'La place doit être comprise entre 1 et 999.';
  end if;
  select i.position into old_position from public.content_items i where i.id = p_item for update;
  if not found then raise exception 'Contenu introuvable.'; end if;
  if old_position is not distinct from p_position then return; end if;
  update public.content_items i set position = p_position where i.id = p_item;
  perform private.write_log('position_changed', p_item, null, null, old_position::text, p_position::text, null);
end;
$$;
revoke all on function private.set_position(uuid, smallint) from public, anon, authenticated;
grant execute on function private.set_position(uuid, smallint) to authenticated;

create function public.set_content_position(p_item uuid, p_position smallint)
returns void
language sql
set search_path = ''
as $$ select private.set_position(p_item, p_position); $$;
revoke all on function public.set_content_position(uuid, smallint) from public, anon;
grant execute on function public.set_content_position(uuid, smallint) to authenticated;

-- Parcours actuel.
update public.content_items set position = 1 where slug = 'les-28-lettres-arabes';
update public.content_items set position = 2 where slug = 'voyelles-sukun-chadda';
update public.content_items set position = 3 where slug = 'voyelles-longues';
update public.content_items set position = 4 where slug = 'tanwin-et-hamza';
update public.content_items set position = 5 where slug = 'alif-de-liaison-et-article';
update public.content_items set position = 1 where slug = 'nun-sakina-et-tanwin';
