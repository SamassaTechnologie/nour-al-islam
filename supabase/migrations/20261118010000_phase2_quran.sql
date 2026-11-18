create extension if not exists pg_trgm with schema extensions;

create table public.quran_sources (
  id text primary key,
  kind text not null check (kind in ('text', 'translation')),
  title text not null,
  author text,
  publisher text not null,
  version text not null,
  language text not null,
  license text not null,
  source_url text not null,
  notice text,
  file_sha256 text,
  content_sha256 text,
  item_count integer,
  is_default boolean not null default false,
  locked_at timestamptz,
  created_at timestamptz not null default now()
);
create unique index quran_sources_one_default on public.quran_sources (kind) where is_default;

create table public.surahs (
  number smallint primary key check (number between 1 and 114),
  name_ar text not null,
  name_translit text not null,
  name_en text not null,
  ayah_count smallint not null check (ayah_count > 0),
  first_ayah_id smallint not null,
  revelation_order smallint not null,
  revelation_place text not null check (revelation_place in ('Meccan', 'Medinan'))
);

create table public.ayahs (
  id smallint primary key check (id between 1 and 6236),
  surah smallint not null references public.surahs (number),
  number smallint not null check (number > 0),
  text_uthmani text not null,
  bismillah_length smallint not null default 0,
  text_clean text not null,
  search_text text generated always as (translate(text_clean, 'أإآٱىة', 'ااااىه')) stored,
  juz smallint not null check (juz between 1 and 30),
  hizb smallint not null check (hizb between 1 and 60),
  rub smallint not null check (rub between 1 and 4),
  page smallint not null check (page between 1 and 604),
  unique (surah, number)
);
create index ayahs_juz_idx on public.ayahs (juz, id);
create index ayahs_hizb_idx on public.ayahs (hizb, id);
create index ayahs_search_trgm_idx on public.ayahs using gin (search_text extensions.gin_trgm_ops);

create table public.translation_verses (
  source_id text not null references public.quran_sources (id),
  ayah_id smallint not null references public.ayahs (id),
  text text not null,
  footnotes text,
  search_vector tsvector generated always as (to_tsvector('french'::regconfig, text)) stored,
  primary key (source_id, ayah_id)
);
create index translation_verses_ayah_idx on public.translation_verses (ayah_id);
create index translation_verses_search_idx on public.translation_verses using gin (search_vector);

create function private.reject_change()
returns trigger language plpgsql set search_path = '' as $$
begin
  raise exception 'Le contenu coranique importe ne peut pas etre modifie (%).', tg_table_name using errcode = '42501';
end;
$$;

create function private.reject_insert_when_locked()
returns trigger language plpgsql set search_path = '' as $$
declare wanted text := coalesce(to_jsonb(new) ->> 'source_id', 'tanzil-uthmani-1.1');
begin
  if exists (select 1 from public.quran_sources s where s.id = wanted and s.locked_at is not null) then
    raise exception 'Source verrouillee : %', wanted using errcode = '42501';
  end if;
  return new;
end;
$$;

create function private.protect_locked_source()
returns trigger language plpgsql set search_path = '' as $$
begin
  if old.locked_at is not null and (to_jsonb(new) - 'is_default') is distinct from (to_jsonb(old) - 'is_default') then
    raise exception 'Source verrouillee : %', old.id using errcode = '42501';
  end if;
  return new;
end;
$$;

create trigger surahs_no_change before update or delete on public.surahs for each row execute function private.reject_change();
create trigger ayahs_no_change before update or delete on public.ayahs for each row execute function private.reject_change();
create trigger translation_verses_no_change before update or delete on public.translation_verses for each row execute function private.reject_change();
create trigger surahs_no_truncate before truncate on public.surahs execute function private.reject_change();
create trigger ayahs_no_truncate before truncate on public.ayahs execute function private.reject_change();
create trigger translation_verses_no_truncate before truncate on public.translation_verses execute function private.reject_change();
create trigger surahs_locked before insert on public.surahs for each row execute function private.reject_insert_when_locked();
create trigger ayahs_locked before insert on public.ayahs for each row execute function private.reject_insert_when_locked();
create trigger translation_verses_locked before insert on public.translation_verses for each row execute function private.reject_insert_when_locked();
create trigger quran_sources_protect before update on public.quran_sources for each row execute function private.protect_locked_source();

revoke all on function private.reject_change() from public;
revoke all on function private.reject_insert_when_locked() from public;
revoke all on function private.protect_locked_source() from public;

alter table public.quran_sources enable row level security;
alter table public.surahs enable row level security;
alter table public.ayahs enable row level security;
alter table public.translation_verses enable row level security;

create policy "quran_sources_public_read" on public.quran_sources for select to anon, authenticated using (locked_at is not null);
create policy "surahs_public_read" on public.surahs for select to anon, authenticated using (true);
create policy "ayahs_public_read" on public.ayahs for select to anon, authenticated using (true);
create policy "translation_verses_public_read" on public.translation_verses for select to anon, authenticated using (true);

revoke all on public.quran_sources, public.surahs, public.ayahs, public.translation_verses from anon, authenticated;
grant select on public.quran_sources, public.surahs, public.ayahs, public.translation_verses to anon, authenticated;
grant select, insert, update on public.quran_sources, public.surahs, public.ayahs, public.translation_verses to service_role;

create table public.quran_bookmarks (
  user_id uuid not null references auth.users (id) on delete cascade,
  ayah_id smallint not null references public.ayahs (id),
  created_at timestamptz not null default now(),
  primary key (user_id, ayah_id)
);
create index quran_bookmarks_ayah_idx on public.quran_bookmarks (ayah_id);

create table public.quran_reading_history (
  user_id uuid not null references auth.users (id) on delete cascade,
  surah smallint not null references public.surahs (number),
  ayah_id smallint not null references public.ayahs (id),
  updated_at timestamptz not null default now(),
  primary key (user_id, surah)
);
create index quran_reading_history_recent_idx on public.quran_reading_history (user_id, updated_at desc);
create index quran_reading_history_surah_idx on public.quran_reading_history (surah);
create index quran_reading_history_ayah_idx on public.quran_reading_history (ayah_id);

alter table public.quran_bookmarks enable row level security;
alter table public.quran_reading_history enable row level security;

create policy "bookmarks_select_own" on public.quran_bookmarks for select to authenticated using (user_id = (select auth.uid()));
create policy "bookmarks_insert_own" on public.quran_bookmarks for insert to authenticated with check (user_id = (select auth.uid()));
create policy "bookmarks_delete_own" on public.quran_bookmarks for delete to authenticated using (user_id = (select auth.uid()));
create policy "history_select_own" on public.quran_reading_history for select to authenticated using (user_id = (select auth.uid()));
create policy "history_insert_own" on public.quran_reading_history for insert to authenticated with check (user_id = (select auth.uid()));
create policy "history_update_own" on public.quran_reading_history for update to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));

revoke all on public.quran_bookmarks, public.quran_reading_history from anon, authenticated;
grant select, insert, delete on public.quran_bookmarks to authenticated;
grant select, insert, update on public.quran_reading_history to authenticated;

create function public.search_quran(query text, max_results integer default 30)
returns table (ayah_id smallint, surah smallint, number smallint, text_uthmani text, bismillah_length smallint, translation text)
language sql
stable
security invoker
set search_path = ''
as $$
  with q as (
    select btrim(query) as raw,
           translate(regexp_replace(btrim(query), '[ً-ٰٟۖ-ۭـ]', '', 'g'), 'أإآٱىة', 'ااااىه') as arabic,
           btrim(query) ~ '[؀-ۿ]' as is_arabic
  ), src as (
    select s.id from public.quran_sources s where s.kind = 'translation' and s.is_default and s.locked_at is not null limit 1
  )
  select a.id, a.surah, a.number, a.text_uthmani, a.bismillah_length, t.text
  from public.ayahs a
  cross join q
  left join src on true
  left join public.translation_verses t on t.ayah_id = a.id and t.source_id = src.id
  where char_length(q.raw) between 2 and 80
    and (
      (q.is_arabic and a.search_text like '%' || replace(replace(replace(q.arabic, '\', '\\'), '%', '\%'), '_', '\_') || '%')
      or (not q.is_arabic and t.search_vector @@ websearch_to_tsquery('french'::regconfig, q.raw))
    )
  order by a.id
  limit least(greatest(coalesce(max_results, 30), 1), 50);
$$;
revoke all on function public.search_quran(text, integer) from public;
grant execute on function public.search_quran(text, integer) to anon, authenticated;

create function public.juz_starts()
returns table (juz smallint, surah smallint, number smallint, ayah_count bigint)
language sql stable security invoker set search_path = '' as $$
  select a.juz, (array_agg(a.surah order by a.id))[1], (array_agg(a.number order by a.id))[1], count(*)
  from public.ayahs a group by a.juz order by a.juz;
$$;
revoke all on function public.juz_starts() from public;
grant execute on function public.juz_starts() to anon, authenticated;

insert into public.quran_sources (id, kind, title, author, publisher, version, language, license, source_url, is_default) values
 ('tanzil-uthmani-1.1', 'text', 'Tanzil Quran Text (Uthmani)', null, 'Tanzil Project', '1.1', 'ar', 'Creative Commons Attribution 3.0', 'https://tanzil.net', true),
 ('quranenc-french_rashid-1.0.3', 'translation', 'Traduction française des sens du Noble Coran', 'Rachid Maach', 'QuranEnc.com', '1.0.3', 'fr', 'Conditions de republication de QuranEnc.com', 'https://quranenc.com/fr/browse/french_rashid', true);
