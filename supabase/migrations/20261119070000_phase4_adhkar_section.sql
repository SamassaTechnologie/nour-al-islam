-- Rubrique des invocations (affichee dans « Prière »).
alter table public.content_items drop constraint content_items_section_check;
alter table public.content_items add constraint content_items_section_check check (section = any (array[
  'aqida', 'purification', 'priere', 'jeune', 'zakat', 'hajj', 'fiqh', 'sira', 'hadith', 'tafsir', 'tajwid', 'arabe', 'adab', 'famille', 'adhkar'
]));
