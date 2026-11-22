-- Famille 1 : le-mariage-sa-place-et-le-choix-du-conjoint
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$le-mariage-sa-place-et-le-choix-du-conjoint$x$, 'lesson', $x$famille$x$, 'fr', 1) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le mariage : sa place en islam et le choix du conjoint$x$, $x$Le mariage est un signe d'Allah, fait d'affection et de miséricorde, et une sunna du Prophète ﷺ. L'encouragement aux jeunes qui en ont les moyens, et le jeûne pour les autres ; choisir la personne pieuse ; la meilleure jouissance de ce monde ; le consentement de la femme ; accepter celui dont on agrée la religion et le caractère.$x$, $x$1. Un signe d'Allah
Allah dit que parmi Ses signes, Il a créé pour vous, de vous-mêmes, des épouses pour que vous viviez en tranquillité auprès d'elles, et Il a mis entre vous affection et miséricorde (sourate ar-Rūm, 30:21). Il ordonne de marier ceux d'entre vous qui sont seuls (sourate an-Nūr, 24:32), et interdit d'épouser les associatrices et de marier les associateurs tant qu'ils n'ont pas cru (sourate al-Baqara, 2:221).

2. Une sunna du Prophète ﷺ
Trois hommes vinrent s'informer de l'adoration du Prophète ﷺ ; ils la trouvèrent peu de chose. L'un dit : je prierai toute la nuit, toujours ; un autre : je jeûnerai toujours ; un autre : je me tiendrai à l'écart des femmes et ne me marierai jamais. Le Prophète ﷺ dit : je suis celui d'entre vous qui craint le plus Allah, mais je jeûne et je romps le jeûne, je prie et je dors, et j'épouse des femmes ; celui qui se détourne de ma sunna n'est pas des miens (al-Bukhārī n° 5063, d'après Anas).

3. L'encouragement aux jeunes
Le Prophète ﷺ a dit :
« يَا مَعْشَرَ الشَّبَابِ مَنِ اسْتَطَاعَ مِنْكُمُ الْبَاءَةَ فَلْيَتَزَوَّجْ، وَمَنْ لَمْ يَسْتَطِعْ فَعَلَيْهِ بِالصَّوْمِ فَإِنَّهُ لَهُ وِجَاءٌ » (yā maʿshara sh-shabāb, mani staṭāʿa minkumu l-bā’ata fa-l-yatazawwaj, wa man lam yastaṭiʿ fa-ʿalayhi bi-ṣ-ṣawmi fa-innahu lahu wijā’).
Sens : « Ô assemblée de jeunes ! Que celui d'entre vous qui en a les moyens se marie ; et celui qui ne le peut pas, qu'il jeûne, car cela le protège. » (al-Bukhārī n° 5065, d'après ʿAbd Allāh ibn Masʿūd ; hadith authentique).

4. Choisir la personne pieuse
Le Prophète ﷺ a dit :
« تُنْكَحُ الْمَرْأَةُ لأَرْبَعٍ لِمَالِهَا وَلِحَسَبِهَا وَجَمَالِهَا وَلِدِينِهَا، فَاظْفَرْ بِذَاتِ الدِّينِ تَرِبَتْ يَدَاكَ » (tunkaḥu l-mar’atu li-arbaʿ : li-mālihā wa li-ḥasabihā wa jamālihā wa li-dīnihā, fa-ẓfar bi-dhāti d-dīni taribat yadāk).
Sens : « On épouse une femme pour quatre choses : sa fortune, sa noblesse, sa beauté et sa religion. Choisis celle qui a la religion, sinon tes mains seront couvertes de poussière. » (al-Bukhārī n° 5090, d'après Abū Hurayra ; hadith authentique).
Et il a dit :
« الدُّنْيَا مَتَاعٌ وَخَيْرُ مَتَاعِ الدُّنْيَا الْمَرْأَةُ الصَّالِحَةُ » (ad-dunyā matāʿ, wa khayru matāʿi d-dunyā al-mar’atu ṣ-ṣāliḥa).
Sens : « Ce monde est une jouissance, et la meilleure jouissance de ce monde est la femme vertueuse. » (Muslim n° 1467, d'après ʿAbd Allāh ibn ʿAmr ; hadith authentique).
Du côté de la femme : le Prophète ﷺ a dit que si quelqu'un dont vous agréez la religion et le caractère vient demander (votre fille) en mariage, mariez-le ; sinon il y aura sur terre une épreuve et une grande corruption (al-Tirmidhī n° 1084, d'après Abū Hurayra). Degré discuté : al-Tirmidhī rapporte qu'al-Bukhārī jugeait plus juste la version mursal (sans le Compagnon) ; al-Albānī et Aḥmad Shākir le jugent « ḥasan », Zubayr ʿAlī Zaʾī faible.

5. Le consentement de la femme
Le Prophète ﷺ a dit : on ne marie pas la femme déjà mariée auparavant sans la consulter, ni la vierge sans lui demander sa permission. On demanda : comment se donne sa permission ? Il répondit : par son silence (al-Bukhārī n° 5136, d'après Abū Hurayra).
Les conditions du contrat de mariage (tuteur, témoins, dot) seront étudiées dans une leçon suivante.

6. Ce que l'élève peut retenir
- Le mariage est un signe d'Allah et une sunna du Prophète ﷺ.
- Celui qui en a les moyens se marie ; les autres jeûnent.
- On choisit en premier la religion et le caractère.
- On ne marie pas une femme sans son consentement.

Exercice : citez les quatre raisons pour lesquelles on épouse une femme selon le hadith, et dites laquelle le Prophète ﷺ recommande, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 30::int, 21::int, 21::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 24::int, 32::int, 32::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 2::int, 221::int, 221::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5063$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les trois hommes et « celui qui se détourne de ma sunna », d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:5063$x$, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5065$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ô assemblée de jeunes ! », d'après Ibn Masʿūd$x$, null, null, $x$https://sunnah.com/bukhari:5065$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5090$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« On épouse une femme pour quatre choses », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5090$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1467$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« La meilleure jouissance de ce monde est la femme vertueuse », d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/muslim:1467$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1084$x$, $x$Ḥasan (al-Albānī, Aḥmad Shākir) ; faible (Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Si quelqu'un dont vous agréez la religion et le caractère… », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/tirmidhi:1084$x$, $x$Al-Tirmidhī rapporte qu'al-Bukhārī jugeait plus juste la version mursal.$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5136$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le consentement de la femme, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5136$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qu'Allah a-t-Il mis entre les époux selon 30:21 ?$x$, array[$x$Affection et miséricorde$x$, $x$Rivalité$x$, $x$Rien$x$]::text[], 0, $x$Sourate ar-Rūm, 30:21.$x$),
  (2, $x$Que dit le Prophète ﷺ de celui qui se détourne de sa sunna, comme celui qui refuse de se marier pour adorer ?$x$, array[$x$Il n'est pas des miens$x$, $x$Il est le meilleur$x$, $x$C'est recommandé$x$]::text[], 0, $x$Al-Bukhārī n° 5063.$x$),
  (3, $x$Que conseille le Prophète ﷺ au jeune qui n'a pas les moyens de se marier ?$x$, array[$x$Le jeûne$x$, $x$Rien$x$, $x$Abandonner la prière$x$]::text[], 0, $x$Al-Bukhārī n° 5065.$x$),
  (4, $x$Que recommande le Prophète ﷺ parmi les quatre raisons d'épouser une femme ?$x$, array[$x$Sa religion$x$, $x$Sa fortune$x$, $x$Sa beauté$x$]::text[], 0, $x$Al-Bukhārī n° 5090.$x$),
  (5, $x$Quelle est la meilleure jouissance de ce monde selon le hadith ?$x$, array[$x$La femme vertueuse$x$, $x$L'or$x$, $x$Les maisons$x$]::text[], 0, $x$Muslim n° 1467.$x$),
  (6, $x$Que faut-il regarder chez celui qui demande une femme en mariage, selon al-Tirmidhī n° 1084 ?$x$, array[$x$Sa religion et son caractère$x$, $x$Sa richesse seulement$x$, $x$Sa tribu seulement$x$]::text[], 0, $x$Al-Tirmidhī n° 1084.$x$),
  (7, $x$Peut-on marier une femme sans son consentement ?$x$, array[$x$Non$x$, $x$Oui$x$, $x$Seulement si elle est jeune$x$]::text[], 0, $x$Al-Bukhārī n° 5136.$x$),
  (8, $x$Comment la vierge donne-t-elle sa permission selon le hadith ?$x$, array[$x$Par son silence$x$, $x$Par écrit seulement$x$, $x$Elle n'a pas à la donner$x$]::text[], 0, $x$Al-Bukhārī n° 5136.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Famille 1$x$),
       rv.h = 'd8a12b73ec6180aa0a9472fa0cabda38' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
