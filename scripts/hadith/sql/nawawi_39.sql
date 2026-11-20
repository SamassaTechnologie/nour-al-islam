-- Hadith 39 d'an-Nawawī : nawawi-39-l-erreur-l-oubli-et-la-contrainte
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-39-l-erreur-l-oubli-et-la-contrainte$x$, 'lesson', 'hadith', 'fr', 39) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 39 : l'erreur, l'oubli et la contrainte$x$, $x$Allah a pardonné à cette communauté le péché commis par erreur, par oubli ou sous la contrainte ; mais les droits des gens et la réparation restent dus.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:39}}

Traduction du sens : D'après Ibn ʿAbbās : le Messager d'Allah ﷺ a dit : « Allah m'a pardonné, pour ma communauté, l'erreur, l'oubli et ce à quoi ils ont été contraints. » An-Nawawī a dit : hadith ḥasan, rapporté par Ibn Mājah (n° 2045), al-Bayhaqī et d'autres.

2. La phrase à retenir
« {{NAWX:39:95:189}} » (inna llāha tajāwaza lī ʿan ummatī l-khaṭaʾa wa n-nisyāna wa mā stukrihū ʿalayh).
Sens : « Allah m'a pardonné, pour ma communauté, l'erreur, l'oubli et ce à quoi ils ont été contraints. »

3. Explication
Allah a pardonné à cette communauté dans trois situations (selon HadeethEnc) :
- L'erreur : ce qui arrive sans le vouloir, quand on vise une chose et qu'une autre se produit.
- L'oubli : on connaissait une chose, puis on l'a oubliée au moment d'agir.
- La contrainte : on est forcé de faire ce qu'on ne veut pas, sans pouvoir s'y opposer.
Point important : ce pardon concerne le péché entre le serviteur et son Seigneur. Les droits des gens restent dus : celui qui tue par erreur doit le prix du sang ; celui qui abîme un véhicule par erreur doit le réparer.

4. Ce que l'élève peut retenir
- La miséricorde d'Allah envers Ses serviteurs est immense.
- C'est une grâce particulière envers le Prophète ﷺ et sa communauté.
- La levée du péché ne supprime pas l'obligation de réparer : celui qui a oublié ses ablutions en se croyant en état de pureté n'a pas de péché, mais il doit refaire les ablutions et la prière.
- L'excuse de la contrainte a des conditions, par exemple que celui qui menace soit réellement capable d'exécuter sa menace.

Exercice : donnez un exemple d'erreur et un exemple d'oubli, et dites ce qu'il faut réparer dans chaque cas, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$39$x$, $x$Ḥasan (bon) selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Allah a pardonné l'erreur, l'oubli et la contrainte, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/nawawi40:39$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan Ibn Mājah$x$, $x$Numérotation de sunnah.com$x$, $x$2045$x$, $x$Ḥasan selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Livre du divorce$x$, null, null, $x$https://sunnah.com/ibnmajah:2045$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4216$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4216$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quelles sont les trois situations pardonnées dans ce hadith ?$x$, array[$x$L'erreur, l'oubli et la contrainte$x$, $x$La colère, la paresse et l'orgueil$x$, $x$Le mensonge, le vol et la tricherie$x$]::text[], 0, $x$« L'erreur, l'oubli et ce à quoi ils ont été contraints. »$x$),
  (2, $x$Celui qui abîme le bien d'autrui par erreur doit-il réparer ?$x$, array[$x$Oui$x$, $x$Non$x$]::text[], 0, $x$Le pardon concerne le péché ; les droits des gens restent dus.$x$),
  (3, $x$Celui qui a prié en ayant oublié ses ablutions doit-il refaire sa prière ?$x$, array[$x$Oui, après avoir fait ses ablutions$x$, $x$Non, jamais$x$]::text[], 0, $x$Il n'a pas de péché, mais il doit refaire les ablutions et la prière.$x$),
  (4, $x$Qu'est-ce que l'erreur (al-khaṭaʾ) ?$x$, array[$x$Viser une chose et qu'une autre se produise sans le vouloir$x$, $x$Faire exprès une faute$x$, $x$Refuser d'apprendre$x$]::text[], 0, $x$C'est l'explication donnée par HadeethEnc.$x$),
  (5, $x$Quel grade an-Nawawī donne-t-il à ce hadith ?$x$, array[$x$Ḥasan$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$Il dit : hadith ḥasan.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 39 d'an-Nawawī$x$),
       rv.h = '799081380d9297e266d50c0a6f161073' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
