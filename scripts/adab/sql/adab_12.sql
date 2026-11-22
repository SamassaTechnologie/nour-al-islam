-- Bonnes manières 12 : les-manieres-de-la-mosquee
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$les-manieres-de-la-mosquee$x$, 'lesson', $x$adab$x$, 'fr', 12) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Les manières de la mosquée$x$, $x$Les mosquées appartiennent à Allah. Venir à la prière avec calme, prier deux unités avant de s'asseoir, ne pas venir avec l'odeur de l'ail, ne pas passer devant celui qui prie, garder la mosquée propre, ne pas y chercher un objet perdu ; le mérite de construire une mosquée et d'y attendre la prière ; les femmes à la mosquée ; la douceur envers celui qui ignore.$x$, $x$1. Les mosquées appartiennent à Allah
Allah dit que les mosquées sont à Allah : n'invoquez donc personne avec Lui (sourate al-Jinn, 72:18). Il loue les hommes qui, dans les maisons qu'Allah a permis d'élever, Le glorifient matin et soir, sans que le commerce les détourne de Son rappel ni de la prière (sourate an-Nūr, 24:36-37).
Construire une mosquée : ʿUthmān ibn ʿAffān rapporta que le Prophète ﷺ a dit : celui qui construit une mosquée en recherchant le visage d'Allah, Allah lui construit son équivalent au Paradis (al-Bukhārī n° 450).

2. Venir avec calme
Le Prophète ﷺ a dit :
« إِذَا سَمِعْتُمُ الإِقَامَةَ فَامْشُوا إِلَى الصَّلاَةِ، وَعَلَيْكُمْ بِالسَّكِينَةِ وَالْوَقَارِ وَلاَ تُسْرِعُوا، فَمَا أَدْرَكْتُمْ فَصَلُّوا وَمَا فَاتَكُمْ فَأَتِمُّوا » (idhā samiʿtumu l-iqāmata fa-mshū ilā ṣ-ṣalāh, wa ʿalaykum bi-s-sakīnati wa l-waqār, wa lā tusriʿū, fa-mā adraktum fa-ṣallū, wa mā fātakum fa-atimmū).
Sens : « Quand vous entendez l'iqāma, marchez vers la prière avec calme et dignité, et ne vous précipitez pas : priez ce que vous rattrapez, et complétez ce que vous avez manqué. » (al-Bukhārī n° 636, d'après Abū Hurayra ; hadith authentique).
Pour l'invocation en entrant et en sortant de la mosquée, voir la page des invocations (Muslim n° 713).

3. Deux unités avant de s'asseoir
Le Prophète ﷺ a dit :
« إِذَا دَخَلَ أَحَدُكُمُ الْمَسْجِدَ فَلْيَرْكَعْ رَكْعَتَيْنِ قَبْلَ أَنْ يَجْلِسَ » (idhā dakhala aḥadukumu l-masjida fa-l-yarkaʿ rakʿatayni qabla an yajlis).
Sens : « Quand l'un de vous entre dans la mosquée, qu'il prie deux unités avant de s'asseoir. » (al-Bukhārī n° 444, d'après Abū Qatāda ; hadith authentique).

4. Respecter la mosquée et ceux qui y prient
- L'odeur : le Prophète ﷺ a dit, à propos de l'ail : celui qui en a mangé, qu'il ne s'approche pas de notre mosquée (al-Bukhārī n° 853, d'après Ibn ʿUmar).
- La propreté : cracher dans la mosquée est une faute, et son expiation est de l'enterrer (al-Bukhārī n° 415, d'après Anas).
- L'objet perdu : celui qui entend un homme réclamer à voix haute un objet perdu dans la mosquée, qu'il dise : qu'Allah ne te le rende pas, car les mosquées n'ont pas été construites pour cela (Muslim n° 568, d'après Abū Hurayra).
- Passer devant celui qui prie : si celui qui passe devant celui qui prie savait ce qu'il encourt, il lui serait meilleur d'attendre quarante plutôt que de passer devant lui ; le rapporteur Abū n-Naḍr ne savait plus s'il avait dit quarante jours, mois ou années (al-Bukhārī n° 510, d'après Abū Juhaym).

5. Le mérite d'y rester
Le Prophète ﷺ a dit que les anges prient pour l'un de vous tant qu'il reste à l'endroit où il a prié sans perdre ses ablutions, en disant : ô Allah, pardonne-lui ; ô Allah, fais-lui miséricorde (al-Bukhārī n° 445, d'après Abū Hurayra).

6. Les femmes à la mosquée
Le Prophète ﷺ a dit : n'empêchez pas les servantes d'Allah (d'aller) aux mosquées d'Allah (al-Bukhārī n° 900, d'après Ibn ʿUmar). Et il a dit aux femmes : quand l'une de vous se rend à la mosquée, qu'elle ne se parfume pas (Muslim n° 443, d'après Zaynab, épouse d'Ibn Masʿūd).

7. La douceur envers celui qui ignore
Un bédouin urina dans la mosquée ; les gens se levèrent contre lui. Le Prophète ﷺ dit : laissez-le, et versez sur son urine un seau d'eau ; vous avez été envoyés pour faciliter, et non pour rendre les choses difficiles (al-Bukhārī n° 220, d'après Abū Hurayra).

8. Ce que l'élève peut retenir
- On vient à la mosquée avec calme, sans courir.
- On prie deux unités avant de s'asseoir.
- On n'y vient pas avec une mauvaise odeur, on la garde propre, on n'y réclame pas un objet perdu, on ne passe pas devant celui qui prie.
- Les anges prient pour celui qui reste à sa place après la prière.
- On enseigne avec douceur à celui qui ne sait pas.

Exercice : la prochaine fois que vous entrez dans une mosquée, appliquez ces manières (calme, deux unités, propreté), puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 72::int, 18::int, 18::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 24::int, 36::int, 37::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$450$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Construire une mosquée, d'après ʿUthmān ibn ʿAffān$x$, null, null, $x$https://sunnah.com/bukhari:450$x$, null),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$636$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Venir à la prière avec calme et dignité, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:636$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$713a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Invocation en entrant et en sortant de la mosquée$x$, null, null, $x$https://sunnah.com/muslim:713a$x$, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$444$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Deux unités avant de s'asseoir, d'après Abū Qatāda$x$, null, null, $x$https://sunnah.com/bukhari:444$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$853$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Celui qui a mangé de l'ail, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:853$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$415$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Cracher dans la mosquée, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:415$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$568a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Réclamer un objet perdu dans la mosquée, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:568a$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$510$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Passer devant celui qui prie, d'après Abū Juhaym$x$, null, null, $x$https://sunnah.com/bukhari:510$x$, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$445$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les anges prient pour celui qui reste à sa place, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:445$x$, null),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$900$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« N'empêchez pas les servantes d'Allah… », d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:900$x$, null),
  (13, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$443b$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$La femme qui se rend à la mosquée ne se parfume pas, d'après Zaynab$x$, null, null, $x$https://sunnah.com/muslim:443b$x$, null),
  (14, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$220$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le bédouin dans la mosquée : « vous avez été envoyés pour faciliter », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:220$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Comment doit-on marcher vers la prière quand on entend l'iqāma ?$x$, array[$x$Avec calme et dignité, sans se précipiter$x$, $x$En courant$x$, $x$Lentement pour arriver après$x$]::text[], 0, $x$Al-Bukhārī n° 636.$x$),
  (2, $x$Que fait-on en entrant dans la mosquée, avant de s'asseoir ?$x$, array[$x$On prie deux unités$x$, $x$On s'allonge$x$, $x$On parle fort$x$]::text[], 0, $x$Al-Bukhārī n° 444.$x$),
  (3, $x$Que dit le Prophète ﷺ à celui qui a mangé de l'ail ?$x$, array[$x$Qu'il ne s'approche pas de notre mosquée$x$, $x$Qu'il vienne au premier rang$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 853.$x$),
  (4, $x$Quelle est l'expiation du crachat dans la mosquée ?$x$, array[$x$L'enterrer$x$, $x$Rien$x$, $x$Jeûner un jour$x$]::text[], 0, $x$Al-Bukhārī n° 415.$x$),
  (5, $x$Que dit-on à celui qui réclame un objet perdu dans la mosquée ?$x$, array[$x$Qu'Allah ne te le rende pas$x$, $x$Je vais t'aider$x$, $x$Rien$x$]::text[], 0, $x$Muslim n° 568.$x$),
  (6, $x$Que font les anges pour celui qui reste à sa place après la prière ?$x$, array[$x$Ils demandent pardon et miséricorde pour lui$x$, $x$Rien$x$, $x$Ils le blâment$x$]::text[], 0, $x$Al-Bukhārī n° 445.$x$),
  (7, $x$Que dit le hadith sur les femmes et la mosquée ?$x$, array[$x$N'empêchez pas les servantes d'Allah d'aller aux mosquées$x$, $x$Elles n'y vont jamais$x$, $x$Elles y vont parfumées$x$]::text[], 0, $x$Al-Bukhārī n° 900 ; Muslim n° 443.$x$),
  (8, $x$Comment le Prophète ﷺ réagit-il au bédouin qui urina dans la mosquée ?$x$, array[$x$Avec douceur : laissez-le et versez de l'eau$x$, $x$Il le chassa$x$, $x$Il le frappa$x$]::text[], 0, $x$Al-Bukhārī n° 220.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 12$x$),
       rv.h = '20abcafe4ed2666d3bce88e9bbe448e9' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
