-- Famille 3 : les-droits-et-devoirs-des-epoux
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$les-droits-et-devoirs-des-epoux$x$, 'lesson', $x$famille$x$, 'fr', 3) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Les droits et devoirs des époux$x$, $x$Vivre ensemble selon le convenable : les femmes ont des droits équivalents à leurs devoirs. Le meilleur est le meilleur envers sa famille ; les droits de l'épouse (nourriture, habillement, respect) ; les droits du mari ; ne pas détester son épouse pour un défaut ; la dépense pour la famille, la plus grande récompense.$x$, $x$1. Le principe : le convenable
Allah dit : comportez-vous avec elles selon le convenable ; si vous avez de l'aversion pour elles, il se peut que vous ayez de l'aversion pour une chose où Allah a mis un grand bien (sourate an-Nisā’, 4:19). Et elles ont des droits équivalents à leurs devoirs, selon le convenable ; les hommes ont cependant un degré au-dessus d'elles (sourate al-Baqara, 2:228).
Allah dit aussi que les hommes ont autorité (qawwāmūn) sur les femmes, en raison des faveurs qu'Allah a accordées aux uns sur les autres et de ce qu'ils dépensent de leurs biens (sourate an-Nisā’, 4:34). La suite de ce verset traite des conflits entre époux : elle demande l'explication des savants et sera étudiée dans une leçon à part.

2. Le meilleur envers sa famille
Le Prophète ﷺ a dit :
« خَيْرُكُمْ خَيْرُكُمْ لأَهْلِهِ وَأَنَا خَيْرُكُمْ لأَهْلِي » (khayrukum khayrukum li-ahlih, wa anā khayrukum li-ahlī).
Sens : « Le meilleur d'entre vous est le meilleur envers sa famille, et je suis le meilleur d'entre vous envers ma famille. » (al-Tirmidhī n° 3895, d'après ʿĀ’isha ; authentique selon al-Albānī et Aḥmad Shākir).
Et : les croyants à la foi la plus complète sont ceux qui ont le meilleur caractère, et les meilleurs d'entre vous sont les meilleurs envers leurs femmes (al-Tirmidhī n° 1162, d'après Abū Hurayra ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī et al-Albānī).
Et : traitez bien les femmes (al-Bukhārī n° 5186, d'après Abū Hurayra). Le Prophète ﷺ aidait sa famille à la maison (al-Bukhārī n° 676).

3. Les droits de l'épouse
On demanda au Prophète ﷺ quel est le droit de l'épouse sur son mari. Il répondit :
« أَنْ تُطْعِمَهَا إِذَا طَعِمْتَ وَتَكْسُوَهَا إِذَا اكْتَسَيْتَ - أَوِ اكْتَسَبْتَ - وَلاَ تَضْرِبِ الْوَجْهَ وَلاَ تُقَبِّحْ وَلاَ تَهْجُرْ إِلاَّ فِي الْبَيْتِ » (an tuṭʿimahā idhā ṭaʿimt, wa taksuwahā idhā ktasayt (awi ktasabt), wa lā taḍribi l-wajh, wa lā tuqabbiḥ, wa lā tahjur illā fī l-bayt).
Sens : « Que tu la nourrisses quand tu te nourris, que tu l'habilles quand tu t'habilles, que tu ne frappes pas le visage, que tu ne l'insultes pas, et que tu ne t'éloignes d'elle qu'à l'intérieur de la maison. » Abū Dāwūd explique « ne l'insulte pas » : ne pas lui dire « qu'Allah t'enlaidisse » (Abū Dāwūd n° 2142, d'après Muʿāwiya al-Qushayrī ; « ḥasan ṣaḥīḥ » selon al-Albānī).
La dépense pour la famille : de l'argent donné dans le sentier d'Allah, pour affranchir, en aumône au pauvre ou dépensé pour sa famille, celui qui a la plus grande récompense est celui dépensé pour sa famille (Muslim n° 995, d'après Abū Hurayra).

4. Les droits du mari
Le Prophète ﷺ a dit : il n'est pas permis à la femme de jeûner quand son mari est présent sans sa permission, ni de faire entrer quelqu'un chez lui sans sa permission (al-Bukhārī n° 5195, d'après Abū Hurayra). Et : si l'homme appelle sa femme au lit et qu'elle refuse de venir, les anges la maudissent jusqu'au matin (al-Bukhārī n° 5193, d'après Abū Hurayra). Pour les cas particuliers (maladie, excuse, détails du jeûne concerné), interrogez un savant.

5. Ne pas détester son épouse pour un défaut
Le Prophète ﷺ a dit :
« لاَ يَفْرَكْ مُؤْمِنٌ مُؤْمِنَةً إِنْ كَرِهَ مِنْهَا خُلُقًا رَضِيَ مِنْهَا آخَرَ » (lā yafrak mu’minun mu’minatan, in kariha minhā khuluqan raḍiya minhā ākhar).
Sens : « Que le croyant ne déteste pas une croyante : s'il n'aime pas en elle un trait de caractère, il en aimera un autre. » (Muslim n° 1469, d'après Abū Hurayra ; hadith authentique).

6. Ce que l'élève peut retenir
- On vit avec son conjoint selon le convenable ; chacun a des droits et des devoirs.
- Le meilleur est le meilleur envers sa famille.
- L'épouse a droit à la nourriture, à l'habillement et au respect ; on ne frappe pas le visage et on n'insulte pas.
- Le mari a des droits : la permission pour jeûner quand il est présent et pour l'entrée chez lui, et l'intimité conjugale.
- On regarde les qualités de son conjoint plutôt que ses défauts.

Exercice : citez deux droits de l'épouse et deux droits du mari mentionnés dans les hadiths, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 4::int, 19::int, 19::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 2::int, 228::int, 228::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 4::int, 34::int, 34::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$3895$x$, $x$Authentique (al-Albānī, Aḥmad Shākir)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Le meilleur d'entre vous est le meilleur envers sa famille », d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/tirmidhi:3895$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1162$x$, $x$Ḥasan ṣaḥīḥ (al-Tirmidhī, al-Albānī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Les meilleurs d'entre vous sont les meilleurs envers leurs femmes », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/tirmidhi:1162$x$, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5186$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Traitez bien les femmes », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5186$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$676$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le Prophète ﷺ au service de sa famille, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/bukhari:676$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$2142$x$, $x$Ḥasan ṣaḥīḥ (al-Albānī) ; ḥasan (Shuʿayb al-Arnaʾūṭ)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Le droit de l'épouse sur son mari, d'après Muʿāwiya al-Qushayrī$x$, null, null, $x$https://sunnah.com/abudawud:2142$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$995$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$La dépense pour sa famille a la plus grande récompense, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:995$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5195$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le jeûne et l'entrée chez le mari avec sa permission, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5195$x$, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5193$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le refus de répondre à l'appel du mari, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5193$x$, null),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1469a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Que le croyant ne déteste pas une croyante », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:1469a$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Comment se comporter avec son épouse selon 4:19 ?$x$, array[$x$Selon le convenable$x$, $x$Avec dureté$x$, $x$Avec indifférence$x$]::text[], 0, $x$Sourate an-Nisā’, 4:19.$x$),
  (2, $x$Qui est le meilleur d'entre nous selon le hadith de ʿĀ’isha ?$x$, array[$x$Le meilleur envers sa famille$x$, $x$Le plus riche$x$, $x$Le plus fort$x$]::text[], 0, $x$Al-Tirmidhī n° 3895.$x$),
  (3, $x$Lequel de ces droits appartient à l'épouse selon Abū Dāwūd n° 2142 ?$x$, array[$x$Être nourrie et habillée comme son mari$x$, $x$Être insultée$x$, $x$Être frappée au visage$x$]::text[], 0, $x$Abū Dāwūd n° 2142.$x$),
  (4, $x$Quelle dépense a la plus grande récompense selon Muslim n° 995 ?$x$, array[$x$Celle faite pour sa famille$x$, $x$Celle faite pour soi$x$, $x$Aucune$x$]::text[], 0, $x$Muslim n° 995.$x$),
  (5, $x$Selon le hadith, la femme peut-elle jeûner sans la permission de son mari présent ?$x$, array[$x$Non$x$, $x$Oui, toujours$x$, $x$Seulement le lundi$x$]::text[], 0, $x$Al-Bukhārī n° 5195.$x$),
  (6, $x$Que dit le hadith de celui qui n'aime pas un trait de caractère de son épouse ?$x$, array[$x$Il en aimera un autre$x$, $x$Il doit la quitter$x$, $x$Il doit l'insulter$x$]::text[], 0, $x$Muslim n° 1469.$x$),
  (7, $x$Que dit 2:228 des droits des femmes ?$x$, array[$x$Elles ont des droits équivalents à leurs devoirs, selon le convenable$x$, $x$Elles n'ont aucun droit$x$, $x$Elles ont seulement des devoirs$x$]::text[], 0, $x$Sourate al-Baqara, 2:228.$x$),
  (8, $x$Que faisait le Prophète ﷺ dans sa maison ?$x$, array[$x$Il aidait sa famille$x$, $x$Il se faisait servir en tout$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 676.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Famille 3$x$),
       rv.h = '46e9f67656f01993ec64f01840692dc5' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
