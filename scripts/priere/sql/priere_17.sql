-- Prière 17 : la-priere-pour-demander-la-pluie-salat-al-istisqa
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-priere-pour-demander-la-pluie-salat-al-istisqa$x$, 'lesson', $x$priere$x$, 'fr', 17) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La prière pour demander la pluie (ṣalāt al-istisqā’)$x$, $x$Quand la pluie manque : sortir humblement vers le lieu de prière, invoquer en levant les mains, retourner son manteau, prier deux unités à voix haute. Son jugement (sunna selon la majorité ; invocation seulement selon Abū Ḥanīfa), les takbīr (deux avis), l'invocation pendant le sermon du vendredi et ce que l'on dit quand il pleut.$x$, $x$1. Son jugement
La prière pour la pluie est une sunna : avis de la majorité (malikites, shafiʿites, hanbalites, et Abū Yūsuf et Muḥammad, élèves d'Abū Ḥanīfa) ; son caractère légal est rapporté comme un accord. Abū Ḥanīfa disait qu'il n'y a pas de prière propre à la demande de pluie, mais seulement l'invocation ; an-Nawawī et ash-Shawkānī disent que lui seul a tenu cet avis (Dorar, n° 1844).

2. Sortir humblement
Ibn ʿAbbās dit que le Prophète ﷺ sortit en habits simples, avec humilité et en suppliant, jusqu'au lieu de prière ; il ne cessa d'invoquer, de supplier et de dire « Allāhu akbar », puis il pria deux unités comme il prie à l'Aïd (Abū Dāwūd n° 1165 ; ḥasan selon al-Albānī).

3. La manière
ʿAbd Allāh ibn Zayd dit que le Prophète ﷺ :
« خَرَجَ إِلَى الْمُصَلَّى فَاسْتَسْقَى، فَاسْتَقْبَلَ الْقِبْلَةَ، وَقَلَبَ رِدَاءَهُ، وَصَلَّى رَكْعَتَيْنِ » (kharaja ilā l-muṣallā fa-stasqā, fa-staqbala l-qiblata, wa qalaba ridā’ahu, wa ṣallā rakʿatayn).
Sens : « sortit vers le lieu de prière, demanda la pluie, se tourna vers la qibla, retourna son manteau et pria deux unités. » (al-Bukhārī n° 1012 ; hadith authentique).
Il récita à voix haute dans ces deux unités (al-Bukhārī n° 1024).
En levant les mains pour demander la pluie, il tourna le dos de ses mains vers le ciel (Muslim n° 895).
Les takbīr supplémentaires : deux avis.
- comme à l'Aïd (sept et cinq) : avis d'ash-Shāfiʿī (al-Alūka, « Ṣalāt al-istisqā’ ») ; c'est aussi la manière décrite par Ibn Bāz (Dorar, n° 1743, citant Fatāwā Nūr ʿalā d-darb) ;
- comme dans les autres prières, sans takbīr supplémentaires : avis de Mālik (al-Alūka, même article).
Le sermon : il est rapporté avant la prière et après ; les deux sont de la sunna (ar-Rawḍa an-nadiyya de Ṣiddīq Ḥasan Khān).

4. Demander la pluie pendant le sermon du vendredi
Un homme entra pendant que le Prophète ﷺ faisait le sermon du vendredi et dit que les troupeaux périssaient et que les chemins étaient coupés. Le Prophète ﷺ leva les mains et dit, trois fois :
« اللَّهُمَّ أَغِثْنَا » (allāhumma aghithnā).
Sens : « Ô Allah, secours-nous ! » (al-Bukhārī n° 1014 ; hadith authentique).
Anas dit qu'il n'y avait aucun nuage ; un nuage apparut, s'étendit et il plut. Le vendredi suivant, on lui demanda d'arrêter la pluie, et il demanda qu'elle tombe autour d'eux et non sur eux (même référence).

5. Quand il pleut
Quand il voyait la pluie, il disait :
« صَيِّبًا نَافِعًا » (ṣayyiban nāfiʿā).
Sens : « Une pluie abondante et utile ! » (al-Bukhārī n° 1032 ; hadith authentique).

6. Ce que l'élève peut retenir
- Demander la pluie est une sunna ; la prière, selon la majorité.
- Sortir humblement, invoquer, se tourner vers la qibla, retourner son manteau.
- Deux unités à voix haute ; takbīr comme à l'Aïd selon ash-Shāfiʿī, sans selon Mālik.
- On peut aussi demander la pluie pendant le sermon du vendredi.
- Quand il pleut : « ṣayyiban nāfiʿā ».

Exercice : apprenez par cœur « allāhumma aghithnā » et « ṣayyiban nāfiʿā ». Puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie de fiqh : le jugement de la prière pour la pluie$x$, $x$Dorar (ad-Durar as-Saniyya)$x$, $x$Section n° 1844$x$, $x$https://dorar.net/feqhia/1844$x$, $x$Sunna selon la majorité ; Abū Ḥanīfa : invocation sans prière (an-Nawawī, Sharḥ Muslim 6/187 ; ash-Shawkānī, Nayl al-awṭār 4/9).$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$1165$x$, $x$Ḥasan (al-Albānī) ; ḥasan ṣaḥīḥ (Shuʿayb al-Arnaʾūṭ)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Sortir humblement et prier comme à l'Aïd, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/abudawud:1165$x$, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1012$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Se tourner vers la qibla, retourner le manteau, prier deux unités, d'après ʿAbd Allāh ibn Zayd$x$, null, null, $x$https://sunnah.com/bukhari:1012$x$, $x$Texte copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1024$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La récitation à voix haute, d'après ʿAbd Allāh ibn Zayd$x$, null, null, $x$https://sunnah.com/bukhari:1024$x$, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$895b$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Le dos des mains vers le ciel, d'après Anas$x$, null, null, $x$https://sunnah.com/muslim:895b$x$, null),
  (6, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Ṣalāt al-istisqā'$x$, $x$al-Alūka$x$, $x$Article n° 74835$x$, $x$https://www.alukah.net/zoulghina/11718/74835/$x$, $x$Récitation à voix haute par accord ; takbīr comme à l'Aïd selon ash-Shāfiʿī, comme les autres prières selon Mālik.$x$),
  (7, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie de fiqh : les takbīr supplémentaires$x$, $x$Dorar (ad-Durar as-Saniyya)$x$, $x$Section n° 1743$x$, $x$https://dorar.net/feqhia/1743$x$, $x$Ibn Bāz (Fatāwā Nūr ʿalā d-darb 13/399) : la prière de la pluie comme celle de l'Aïd, sept et cinq takbīr.$x$),
  (8, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$ar-Rawḍa an-nadiyya : la prière pour la pluie$x$, $x$Ṣiddīq Ḥasan Khān (commentaire d'ad-Durar al-bahiyya d'ash-Shawkānī)$x$, $x$Livre de la prière (Wikisource arabe)$x$, $x$https://ar.wikisource.org/wiki/الروضة_الندية_شرح_الدرر_البهية/كتاب_الصلاة/باب_صلاة_الإستسقاء$x$, $x$Sunna en cas de sécheresse ; sermon rapporté avant et après la prière.$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1014$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Allāhumma aghithnā » pendant le sermon du vendredi, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:1014$x$, $x$Invocation copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1032$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ṣayyiban nāfiʿā » quand il pleut, d'après ʿĀ'isha$x$, null, null, $x$https://sunnah.com/bukhari:1032$x$, $x$Invocation copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Selon la majorité, quel est le jugement de la prière pour la pluie ?$x$, array[$x$Une sunna$x$, $x$Une obligation pour chacun$x$, $x$Une innovation$x$]::text[], 0, $x$Dorar n° 1844.$x$),
  (2, $x$Que disait Abū Ḥanīfa ?$x$, array[$x$On demande la pluie par l'invocation, sans prière propre$x$, $x$Elle est obligatoire$x$, $x$Elle se prie quatre unités$x$]::text[], 0, $x$Dorar n° 1844.$x$),
  (3, $x$Comment le Prophète ﷺ sortit-il pour demander la pluie ?$x$, array[$x$En habits simples, avec humilité$x$, $x$En habits de fête$x$, $x$À cheval avec une armée$x$]::text[], 0, $x$Abū Dāwūd n° 1165.$x$),
  (4, $x$Que fit-il de son manteau ?$x$, array[$x$Il le retourna$x$, $x$Il le jeta$x$, $x$Il le donna$x$]::text[], 0, $x$Al-Bukhārī n° 1012.$x$),
  (5, $x$Combien d'unités, et comment est la récitation ?$x$, array[$x$Deux unités, à voix haute$x$, $x$Quatre unités, à voix basse$x$, $x$Une unité, sans récitation$x$]::text[], 0, $x$Al-Bukhārī n° 1012 et 1024.$x$),
  (6, $x$Que dit-il pendant le sermon du vendredi pour la pluie ?$x$, array[$x$Allāhumma aghithnā, trois fois$x$, $x$Ghufrānak$x$, $x$Subḥāna llāh$x$]::text[], 0, $x$Al-Bukhārī n° 1014.$x$),
  (7, $x$Que dit-on quand il pleut ?$x$, array[$x$Ṣayyiban nāfiʿā$x$, $x$Astaghfiru llāh$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 1032.$x$),
  (8, $x$Y a-t-il des takbīr comme à l'Aïd ?$x$, array[$x$Deux avis : oui selon ash-Shāfiʿī, non selon Mālik$x$, $x$Tous disent oui$x$, $x$Tous disent non$x$]::text[], 0, $x$Al-Alūka, « Ṣalāt al-istisqā’ ».$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Prière 17$x$),
       rv.h = 'fd4a6ff3462522d404c7256ffd5aab98' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
