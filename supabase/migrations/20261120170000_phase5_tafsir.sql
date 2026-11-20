-- Tafsir : textes publiés par QuranEnc.com, importés sans modification et verrouillés comme la traduction.
-- Chaque entrée garde l'identifiant, le type et les bornes de versets donnés par la source.

alter table public.quran_sources drop constraint quran_sources_kind_check;
alter table public.quran_sources add constraint quran_sources_kind_check check (kind in ('text', 'translation', 'tafsir'));

create table public.tafsir_entries (
  source_id text not null references public.quran_sources (id),
  entry_id integer not null,
  surah smallint not null references public.surahs (number),
  from_ayah smallint not null check (from_ayah >= 0),
  to_ayah smallint not null,
  entry_type text,
  text text not null,
  footnotes text,
  primary key (source_id, entry_id),
  check (to_ayah >= from_ayah)
);
create index tafsir_entries_surah_idx on public.tafsir_entries (source_id, surah, entry_id);

create trigger tafsir_entries_no_change before update or delete on public.tafsir_entries for each row execute function private.reject_change();
create trigger tafsir_entries_no_truncate before truncate on public.tafsir_entries execute function private.reject_change();
create trigger tafsir_entries_locked before insert on public.tafsir_entries for each row execute function private.reject_insert_when_locked();

alter table public.tafsir_entries enable row level security;
create policy "tafsir_entries_public_read" on public.tafsir_entries for select to anon, authenticated
  using (exists (select 1 from public.quran_sources s where s.id = source_id and s.locked_at is not null));
revoke all on public.tafsir_entries from anon, authenticated;
grant select on public.tafsir_entries to anon, authenticated;
grant select, insert on public.tafsir_entries to service_role;

insert into public.quran_sources (id, kind, title, author, publisher, version, language, license, source_url, notice, is_default) values
 ('quranenc-french_mokhtasar-1.0.0', 'tafsir', 'Le Résumé de l''Exégèse du noble Coran (al-Mukhtaṣar fī tafsīr al-Qurʾān al-Karīm), traduction française',
  'Centre d''Exégèse pour les Études Coraniques (Markaz Tafsīr)', 'QuranEnc.com', '1.0.0', 'fr', 'Conditions de republication de QuranEnc.com',
  'https://quranenc.com/fr/browse/french_mokhtasar',
  'Traduction française du Résumé de l''Exégèse du noble Coran, publiée par le Centre d''Exégèse pour les Études Coraniques, version 1.0.0, diffusée par QuranEnc.com. Le contenu est reproduit sans modification, ajout ni suppression.', true),
 ('quranenc-arabic_saadi-1.0.0', 'tafsir', 'Taysīr al-Karīm ar-Raḥmān fī tafsīr kalām al-Mannān (Tafsir as-Saʿdī)',
  'ʿAbd ar-Raḥmān ibn Nāṣir as-Saʿdī', 'QuranEnc.com', '1.0.0', 'ar', 'Conditions de republication de QuranEnc.com',
  'https://quranenc.com/ar/browse/arabic_saadi',
  'Tafsir du cheikh ʿAbd ar-Raḥmān ibn Nāṣir as-Saʿdī, version 1.0.0, diffusé par QuranEnc.com. Le contenu est reproduit sans modification, ajout ni suppression.', false);
