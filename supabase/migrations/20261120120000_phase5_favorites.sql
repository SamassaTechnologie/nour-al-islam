-- Favoris : lecons et categories d'invocations (content_items) gardees par l'utilisateur.
-- Les versets du Coran gardent leurs propres signets (quran_bookmarks).
create table public.favorites (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  item_id uuid not null references public.content_items (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, item_id)
);
create index favorites_item_idx on public.favorites (item_id);

alter table public.favorites enable row level security;
create policy favorites_select_own on public.favorites for select to authenticated
  using (user_id = (select auth.uid()));
create policy favorites_insert_own on public.favorites for insert to authenticated
  with check (user_id = (select auth.uid()));
create policy favorites_delete_own on public.favorites for delete to authenticated
  using (user_id = (select auth.uid()));
revoke all on public.favorites from anon, authenticated;
grant select, insert, delete on public.favorites to authenticated;
