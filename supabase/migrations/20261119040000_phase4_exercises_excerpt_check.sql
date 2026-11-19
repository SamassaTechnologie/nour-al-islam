-- Un extrait coranique d'exercice est complet ou absent : sourate, verset et mots tous renseignes.
alter table public.content_questions drop constraint content_questions_excerpt;
alter table public.content_questions add constraint content_questions_excerpt check (
  (surah is null and ayah is null and word_from is null and word_to is null)
  or (surah is not null and ayah is not null and word_from is not null and word_to is not null
      and ayah >= 1 and word_from >= 1 and word_to >= word_from and word_to - word_from < 12)
);
