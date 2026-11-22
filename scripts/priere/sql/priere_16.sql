-- Prière 16 : la-priere-de-l-eclipse-salat-al-kusuf
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-priere-de-l-eclipse-salat-al-kusuf$x$, 'lesson', $x$priere$x$, 'fr', 16) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La prière de l'éclipse (ṣalāt al-kusūf)$x$, $x$Lors d'une éclipse du soleil ou de la lune : l'appel « aṣ-ṣalātu jāmiʿa », deux unités avec deux inclinaisons et deux récitations dans chacune, la récitation à voix haute, le sermon, et ce qu'il faut faire (invoquer, glorifier, prier, donner l'aumône). Son jugement et les autres manières rapportées.$x$, $x$1. Une éclipse n'est pas liée à la mort de quelqu'un
Le soleil s'éclipsa le jour de la mort d'Ibrāhīm, fils du Prophète ﷺ, et les gens dirent que c'était à cause de sa mort. Le Prophète ﷺ dit que le soleil et la lune ne s'éclipsent ni pour la mort ni pour la vie de personne (al-Bukhārī n° 1043).
Dans son sermon, il dit :
« إِنَّ الشَّمْسَ وَالْقَمَرَ آيَتَانِ مِنْ آيَاتِ اللَّهِ، لاَ يَنْخَسِفَانِ لِمَوْتِ أَحَدٍ وَلاَ لِحَيَاتِهِ، فَإِذَا رَأَيْتُمْ ذَلِكَ فَادْعُوا اللَّهَ وَكَبِّرُوا، وَصَلُّوا وَتَصَدَّقُوا » (inna sh-shamsa wa l-qamara āyatāni min āyāti llāh, lā yankhasifāni li-mawti aḥadin wa lā li-ḥayātih, fa-idhā ra’aytum dhālika fa-dʿū llāha wa kabbirū, wa ṣallū wa taṣaddaqū).
Sens : « Le soleil et la lune sont deux signes parmi les signes d'Allah ; ils ne s'éclipsent ni pour la mort ni pour la vie de personne. Quand vous voyez cela, invoquez Allah, dites « Allāhu akbar », priez et donnez l'aumône. » (al-Bukhārī n° 1044 ; hadith authentique).

2. Son jugement
Sunna fortement recommandée : an-Nawawī rapporte l'accord des savants, et Ibn Ḥajar dit que c'est l'avis de la majorité ; Abū ʿAwāna l'a déclarée obligatoire, et une obligation est aussi rapportée d'Abū Ḥanīfa et de certains auteurs hanafites (Ṣalāt al-kusūf, usul.ai, citant an-Nawawī, Ibn Qudāma, Ibn Ḥajar et as-Saʿdī).
Elle se prie pour l'éclipse du soleil comme pour celle de la lune (fiqh.islamonline.net, « Ṣalāt al-kusūf »).

3. L'appel
Quand le soleil s'éclipsa au temps du Prophète ﷺ :
« نُودِيَ إِنَّ الصَّلاَةَ جَامِعَةٌ » (nūdiya inna ṣ-ṣalāta jāmiʿa).
Sens : « On appela : la prière rassemble ! » (al-Bukhārī n° 1045 ; hadith authentique).

4. La manière : deux unités, deux inclinaisons dans chacune
D'après ʿĀ'isha (al-Bukhārī n° 1044 et 1046) :
- le takbīr d'entrée, puis une longue récitation ;
- une longue inclinaison ;
- on se relève en disant « samiʿa llāhu liman ḥamidah », sans se prosterner, et on récite de nouveau, moins longtemps ;
- une deuxième inclinaison, moins longue que la première ;
- on se relève en disant « samiʿa llāhu liman ḥamidah, rabbanā wa laka l-ḥamd », puis on se prosterne longuement ;
- la deuxième unité se fait de la même manière.
Soit quatre inclinaisons et quatre prosternations en deux unités (al-Bukhārī n° 1065). La récitation est à voix haute (même hadith).
C'est la manière la plus authentique, avec deux récitations et deux inclinaisons par unité, et celui qui manque la première inclinaison a manqué l'unité (Ibn Bāz, binbaz.org.sa, fatwa n° 25126).
D'autres manières sont rapportées : trois, quatre ou cinq inclinaisons par unité, ou une seule ; les hanbalites permettent toutes celles qui sont rapportées, la meilleure étant deux (islamonline.net ; ar-Rawḍa an-nadiyya de Ṣiddīq Ḥasan Khān).

5. Après la prière
Le Prophète ﷺ fit un sermon après la prière (al-Bukhārī n° 1044). Si l'éclipse continue après la prière, on ne la refait pas : on s'occupe du takbīr, de l'invocation, du rappel d'Allah et de l'aumône (Ibn Bāz, fatwa n° 25126).

6. Ce que l'élève peut retenir
- Une éclipse est un signe d'Allah, pas un signe de la mort de quelqu'un.
- On appelle « aṣ-ṣalātu jāmiʿa ».
- Deux unités, deux récitations et deux inclinaisons dans chacune ; à voix haute.
- Puis un sermon ; on invoque, on glorifie et on donne l'aumône.

Exercice : expliquez à un ami pourquoi une éclipse ne signifie pas la mort d'une personne importante, avec le hadith. Puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1043$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'éclipse du jour de la mort d'Ibrāhīm, d'après al-Mughīra ibn Shuʿba$x$, null, null, $x$https://sunnah.com/bukhari:1043$x$, null),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1044$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La prière de l'éclipse et le sermon, d'après ʿĀ'isha$x$, null, null, $x$https://sunnah.com/bukhari:1044$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Ṣalāt al-kusūf : le jugement de la prière de l'éclipse$x$, $x$Ouvrage sur la prière de l'éclipse (usul.ai)$x$, $x$Page 21$x$, $x$https://usul.ai/t/salah-al-kusuf/21$x$, $x$Cite an-Nawawī (accord), Ibn Qudāma, Ibn Ḥajar (majorité ; Abū ʿAwāna : obligation ; rapporté d'Abū Ḥanīfa), as-Saʿdī.$x$),
  (4, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La prière de l'éclipse : jugement, temps et manière$x$, $x$fiqh.islamonline.net$x$, $x$Article en ligne$x$, $x$https://fiqh.islamonline.net/صلاة-الكسوف-حكمها-ووقتها-وكيفيتها/$x$, $x$Sunna appuyée ; appel « aṣ-ṣalātu jāmiʿa » ; l'éclipse de la lune comme celle du soleil ; Ibn al-Qayyim sur la répétition de l'inclinaison.$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1045$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'appel « aṣ-ṣalātu jāmiʿa », d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/bukhari:1045$x$, $x$Texte copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1046$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le détail de la prière de l'éclipse, d'après ʿĀ'isha$x$, null, null, $x$https://sunnah.com/bukhari:1046$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1065$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Récitation à voix haute ; quatre inclinaisons en deux unités, d'après ʿĀ'isha$x$, null, null, $x$https://sunnah.com/bukhari:1065$x$, null),
  (8, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Les deux inclinaisons de la prière de l'éclipse et sa répétition$x$, $x$ʿAbd al-ʿAzīz ibn Bāz$x$, $x$Fatwa n° 25126, binbaz.org.sa$x$, $x$https://binbaz.org.sa/fatwas/25126$x$, $x$Deux récitations et deux inclinaisons par unité, le plus authentique ; on ne refait pas la prière ; l'unité se rattrape par la première inclinaison.$x$),
  (9, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Règles et manière de la prière de l'éclipse$x$, $x$islamonline.net$x$, $x$Article en ligne$x$, $x$https://islamonline.net/أحكام-وكيفية-صلاة-الخسوف-والكسوف/$x$, $x$Majorité : deux inclinaisons par unité ; les hanbalites permettent les autres manières rapportées.$x$),
  (10, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$ar-Rawḍa an-nadiyya : la prière des deux éclipses$x$, $x$Ṣiddīq Ḥasan Khān (commentaire d'ad-Durar al-bahiyya d'ash-Shawkānī)$x$, $x$Livre de la prière (Wikisource arabe)$x$, $x$https://ar.wikisource.org/wiki/الروضة_الندية_شرح_الدرر_البهية/كتاب_الصلاة/باب_صلاة_الكسوفين$x$, $x$Le plus authentique : deux inclinaisons par unité ; autres nombres rapportés.$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Une éclipse est-elle causée par la mort de quelqu'un ?$x$, array[$x$Non, c'est un signe d'Allah$x$, $x$Oui$x$, $x$Seulement pour les rois$x$]::text[], 0, $x$Al-Bukhārī n° 1043 et 1044.$x$),
  (2, $x$Que dit-on pour appeler à la prière de l'éclipse ?$x$, array[$x$Aṣ-ṣalātu jāmiʿa$x$, $x$L'appel complet et l'iqāma$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 1045.$x$),
  (3, $x$Combien d'inclinaisons dans chaque unité, selon la manière la plus authentique ?$x$, array[$x$Deux$x$, $x$Une$x$, $x$Cinq$x$]::text[], 0, $x$Al-Bukhārī n° 1044 ; Ibn Bāz, fatwa n° 25126.$x$),
  (4, $x$Combien d'unités compte la prière de l'éclipse ?$x$, array[$x$Deux$x$, $x$Quatre$x$, $x$Une$x$]::text[], 0, $x$Al-Bukhārī n° 1065.$x$),
  (5, $x$La récitation est-elle à voix haute ?$x$, array[$x$Oui$x$, $x$Non, toujours à voix basse$x$, $x$Elle n'a pas de récitation$x$]::text[], 0, $x$Al-Bukhārī n° 1065.$x$),
  (6, $x$Que faire quand on voit une éclipse, d'après le hadith ?$x$, array[$x$Invoquer, glorifier, prier et donner l'aumône$x$, $x$Fermer les yeux$x$, $x$Rester chez soi sans rien faire$x$]::text[], 0, $x$Al-Bukhārī n° 1044.$x$),
  (7, $x$Si l'éclipse continue après la prière, la refait-on ?$x$, array[$x$Non, on invoque et on fait l'aumône$x$, $x$Oui, jusqu'à la fin$x$, $x$On prie le ẓuhr$x$]::text[], 0, $x$Ibn Bāz, fatwa n° 25126.$x$),
  (8, $x$Quel est le jugement de cette prière selon la majorité ?$x$, array[$x$Sunna fortement recommandée$x$, $x$Interdite$x$, $x$Obligatoire comme les cinq prières selon tous$x$]::text[], 0, $x$Ṣalāt al-kusūf (usul.ai), citant Ibn Ḥajar.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Prière 16$x$),
       rv.h = 'ee52ef8eb2b7fd70682463978334d4f7' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
