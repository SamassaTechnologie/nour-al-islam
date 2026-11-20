-- Hadith 32 d'an-Nawawī : nawawi-32-pas-de-prejudice
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-32-pas-de-prejudice$x$, 'lesson', 'hadith', 'fr', 32) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 32 : ni préjudice, ni riposte préjudiciable$x$, $x$Il est interdit de nuire à soi-même ou aux autres, et de répondre au tort par un tort excessif : un grand principe de la Loi islamique.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:32}}

Traduction du sens : D'après Abū Saʿīd Saʿd ibn Mālik ibn Sinān al-Khudrī : le Messager d'Allah ﷺ a dit : « Pas de préjudice, ni de riposte préjudiciable. » An-Nawawī a dit : hadith ḥasan, rapporté avec une chaîne remontant au Prophète ﷺ par Ibn Mājah, ad-Dāraquṭnī et d'autres ; Mālik l'a rapporté dans le Muwaṭṭaʾ de manière mursal (sans mentionner Abū Saʿīd), et il a plusieurs voies qui se renforcent les unes les autres.

2. La phrase à retenir
« {{NAWX:32:135:159}} » (lā ḍarara wa lā ḍirār).
Sens : « Pas de préjudice, ni de riposte préjudiciable. »

3. Explication
Il faut écarter le tort, envers soi-même comme envers les autres : il n'est permis ni de se nuire ni de nuire à autrui, de quelque manière que ce soit. Il n'est pas non plus permis de répondre au tort par un tort, sauf dans le cadre du talion, sans excès (selon HadeethEnc).

4. Ce que l'élève peut retenir
- Il est interdit de dépasser la mesure lorsqu'on rend la pareille.
- Allah n'a rien ordonné à Ses serviteurs qui leur cause du tort.
- Ce hadith pose un principe : le tort est interdit, en paroles, en actes ou par négligence.
- Parmi les règles de la Loi islamique : « le préjudice doit être écarté ».

Exercice : donnez un exemple de « riposte préjudiciable » à éviter dans une dispute, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$32$x$, $x$Ḥasan (bon) selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Pas de préjudice, ni de riposte préjudiciable, d'après Abū Saʿīd al-Khudrī$x$, null, null, $x$https://sunnah.com/nawawi40:32$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Sunan ad-Dāraquṭnī$x$, $x$Ad-Dāraquṭnī$x$, $x$Hadith n° 3079 (selon HadeethEnc)$x$, $x$https://hadeethenc.com/fr/browse/hadith/66531$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan Ibn Mājah$x$, $x$Numérotation de sunnah.com$x$, $x$2341$x$, $x$Ḥasan selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Livre des jugements$x$, null, null, $x$https://sunnah.com/ibnmajah:2341$x$, $x$An-Nawawī renvoie à ce numéro (« voir n° 2341 ») ; à cet endroit, le hadith est rapporté par une autre voie.$x$),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66531$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66531$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « lā ḍarara wa lā ḍirār » ?$x$, array[$x$Pas de préjudice, ni de riposte préjudiciable$x$, $x$Pas de prière sans ablutions$x$, $x$Pas de commerce le vendredi$x$]::text[], 0, $x$Il est interdit de nuire et de répondre au tort par un tort.$x$),
  (2, $x$Est-il permis de se nuire à soi-même ?$x$, array[$x$Non$x$, $x$Oui$x$]::text[], 0, $x$Il n'est permis de nuire ni à soi-même ni aux autres.$x$),
  (3, $x$Quel grade an-Nawawī donne-t-il à ce hadith ?$x$, array[$x$Ḥasan$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$Il ajoute que ses différentes voies se renforcent les unes les autres.$x$),
  (4, $x$Quelle règle de la Loi islamique découle de ce hadith ?$x$, array[$x$Le préjudice doit être écarté$x$, $x$Chacun fait ce qu'il veut$x$, $x$Le plus fort a toujours raison$x$]::text[], 0, $x$C'est une règle citée par HadeethEnc.$x$),
  (5, $x$Allah a-t-Il ordonné quelque chose qui nuit à Ses serviteurs ?$x$, array[$x$Non$x$, $x$Oui$x$]::text[], 0, $x$C'est l'un des enseignements du hadith.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 32 d'an-Nawawī$x$),
       rv.h = '31e638b96267c9e103629b0b0d1e37ca' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
