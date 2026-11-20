-- Hadith 29 d'an-Nawawī : nawawi-29-l-oeuvre-qui-mene-au-paradis
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-29-l-oeuvre-qui-mene-au-paradis$x$, 'lesson', 'hadith', 'fr', 29) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 29 : l'œuvre qui fait entrer au Paradis$x$, $x$Muʿādh demande une œuvre qui mène au Paradis ; le Prophète ﷺ lui cite les piliers, les portes du bien, la tête de l'affaire, et lui recommande de retenir sa langue.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:29}}

Traduction du sens : D'après Muʿādh ibn Jabal, qui a dit : j'ai dit : « Ô Messager d'Allah ! Indique-moi une œuvre qui me fera entrer au Paradis et m'éloignera du Feu. » Il a dit : « Tu m'as interrogé sur une chose immense, et pourtant elle est facile pour celui à qui Allah la facilite : adore Allah sans rien Lui associer, accomplis la prière, donne la zakat, jeûne le Ramaḍān et fais le pèlerinage à la Maison. » Puis il a dit : « Veux-tu que je t'indique les portes du bien ? Le jeûne est une protection, l'aumône éteint le péché comme l'eau éteint le feu, et la prière de l'homme au milieu de la nuit. » Puis il a récité les versets 16 et 17 de la sourate 32 (as-Sajda), qui décrivent ceux qui quittent leur lit pour invoquer leur Seigneur. Puis il a dit : « Veux-tu que je t'indique la tête de l'affaire, son pilier et son sommet ? » J'ai dit : « Oui, ô Messager d'Allah. » Il a dit : « La tête de l'affaire est l'islam, son pilier est la prière, et son sommet est le jihād. » Puis il a dit : « Veux-tu que je t'indique ce qui tient tout cela ? » J'ai dit : « Oui, ô Messager d'Allah. » Il a pris sa propre langue et a dit : « Retiens ceci. » J'ai dit : « Ô Prophète d'Allah ! Serons-nous donc tenus responsables de ce que nous disons ? » Il a dit : « Que ta mère te perde ! [une expression arabe d'étonnement] Qu'est-ce qui fait tomber les gens sur leur visage — ou il a dit : sur leur nez — dans le Feu, sinon ce que récoltent leurs langues ? » Rapporté par at-Tirmidhī (n° 2616), qui a dit : hadith ḥasan ṣaḥīḥ.

2. La phrase à retenir
« {{NAWX:29:1022:1041}} » (kuffa ʿalayka hādhā).
Sens : « Retiens ceci » (ta langue).

3. Explication
Selon HadeethEnc, Muʿādh voyageait avec le Prophète ﷺ et s'est approché de lui pour poser sa question. La réponse : l'œuvre est immense, mais facile pour celui à qui Allah la facilite ; c'est l'accomplissement des obligations de l'islam :
- adorer Allah seul, sans associé ;
- accomplir les cinq prières obligatoires avec leurs conditions, leurs piliers et leurs obligations ;
- donner la zakat sur les biens qui atteignent le seuil fixé par la Loi, à ceux qui y ont droit ;
- jeûner le Ramaḍān et accomplir le pèlerinage.
Le Prophète ﷺ ajoute ensuite des portes du bien (le jeûne volontaire, l'aumône, la prière de nuit) et termine par la garde de la langue, car les paroles peuvent mener au Feu.

4. Ce que l'élève peut retenir
- Les Compagnons tenaient à apprendre et posaient beaucoup de questions au Prophète ﷺ.
- Ils savaient que les œuvres sont une cause d'entrée au Paradis.
- La question de Muʿādh est immense, car elle touche le but de l'existence : le Paradis ou le Feu.
- L'entrée au Paradis découle de l'accomplissement des piliers de l'islam.
- Il faut surveiller sa langue.

Exercice : citez les trois « portes du bien » de ce hadith, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$29$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$L'œuvre qui fait entrer au Paradis, d'après Muʿādh ibn Jabal$x$, null, null, $x$https://sunnah.com/nawawi40:29$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2616$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/tirmidhi:2616$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan Ibn Mājah$x$, $x$Numérotation de sunnah.com$x$, $x$3973$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$HadeethEnc$x$, $x$Livre des épreuves$x$, null, null, $x$https://sunnah.com/ibnmajah:3973$x$, null),
  (4, $x$quran$x$::reference_kind, 32::int, 16::int, 17::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66530$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66530$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que demandait Muʿādh au Prophète ﷺ ?$x$, array[$x$Une œuvre qui fait entrer au Paradis et éloigne du Feu$x$, $x$Un conseil de commerce$x$, $x$La date de la fin du monde$x$]::text[], 0, $x$C'est la question au début du hadith.$x$),
  (2, $x$Quel est le pilier de « l'affaire » ?$x$, array[$x$La prière$x$, $x$Le commerce$x$, $x$Le voyage$x$]::text[], 0, $x$« La tête de l'affaire est l'islam, son pilier est la prière. »$x$),
  (3, $x$À quoi l'aumône est-elle comparée ?$x$, array[$x$À l'eau qui éteint le feu$x$, $x$À une montagne$x$, $x$À une lumière$x$]::text[], 0, $x$« L'aumône éteint le péché comme l'eau éteint le feu. »$x$),
  (4, $x$Que montre le Prophète ﷺ en prenant sa langue ?$x$, array[$x$Qu'il faut retenir sa langue$x$, $x$Qu'il faut parler beaucoup$x$, $x$Qu'il était malade$x$]::text[], 0, $x$« Retiens ceci. »$x$),
  (5, $x$Quels versets le Prophète ﷺ a-t-il récités dans ce hadith ?$x$, array[$x$Sourate 32, versets 16 et 17$x$, $x$Sourate 1, verset 1$x$, $x$Sourate 112$x$]::text[], 0, $x$Ils décrivent ceux qui quittent leur lit pour invoquer leur Seigneur.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 29 d'an-Nawawī$x$),
       rv.h = '5c7c1e9dc5377732bfa89f17a04fdcd3' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
