-- Bonnes manières 14 : le-repentir-et-la-demande-de-pardon
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$le-repentir-et-la-demande-de-pardon$x$, 'lesson', $x$adab$x$, 'fr', 14) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le repentir (at-tawba) et la demande de pardon (al-istighfār)$x$, $x$Ne désespérez pas de la miséricorde d'Allah : Il pardonne tous les péchés à celui qui se repent. Le Prophète ﷺ se repentait cent fois par jour ; Allah se réjouit du repentir de Son serviteur. Les conditions du repentir, sa limite dans le temps, et l'homme qui avait tué quatre-vingt-dix-neuf personnes.$x$, $x$1. Ne désespérez pas
Allah dit : ô Mes serviteurs qui avez commis des excès à votre propre détriment, ne désespérez pas de la miséricorde d'Allah ; Allah pardonne tous les péchés (sourate az-Zumar, 39:53). Il ordonne aux croyants de se repentir d'un repentir sincère (sourate at-Taḥrīm, 66:8), et à tous de se repentir afin de réussir (sourate an-Nūr, 24:31). Il loue ceux qui, après une faute, se souviennent d'Allah, demandent pardon et ne persistent pas sciemment (sourate Āl ʿImrān, 3:135). Et celui qui se repent, croit et fait de bonnes œuvres, Allah change ses mauvaises actions en bonnes (sourate al-Furqān, 25:70).

2. Le Prophète ﷺ se repentait chaque jour
Le Prophète ﷺ a dit :
« يَا أَيُّهَا النَّاسُ تُوبُوا إِلَى اللَّهِ فَإِنِّي أَتُوبُ فِي الْيَوْمِ إِلَيْهِ مِائَةَ مَرَّةٍ » (yā ayyuhā n-nāsu tūbū ilā llāh, fa-innī atūbu fī l-yawmi ilayhi mi’ata marra).
Sens : « Ô gens, repentez-vous auprès d'Allah, car je me repens auprès de Lui cent fois par jour. » (Muslim n° 2702, d'après al-Agharr al-Muzanī ; hadith authentique).
Il a dit aussi : par Allah, je demande pardon à Allah et je me repens auprès de Lui plus de soixante-dix fois par jour (al-Bukhārī n° 6307, d'après Abū Hurayra). Pour « le maître de la demande de pardon » (sayyid al-istighfār), voir les invocations du matin et du soir (al-Bukhārī n° 6306).

3. Allah se réjouit du repentir
Le Prophète ﷺ a dit :
« اللَّهُ أَفْرَحُ بِتَوْبَةِ عَبْدِهِ مِنْ أَحَدِكُمْ سَقَطَ عَلَى بَعِيرِهِ، وَقَدْ أَضَلَّهُ فِي أَرْضِ فَلاَةٍ » (allāhu afraḥu bi-tawbati ʿabdihi min aḥadikum saqaṭa ʿalā baʿīrihi wa qad aḍallahu fī arḍi falāt).
Sens : « Allah se réjouit davantage du repentir de Son serviteur que l'un de vous qui retrouve son chameau après l'avoir perdu dans un désert. » (al-Bukhārī n° 6309, d'après Anas ibn Mālik ; hadith authentique).
Et Allah tend Sa main la nuit pour que se repente celui qui a mal agi le jour, et Il tend Sa main le jour pour que se repente celui qui a mal agi la nuit, jusqu'à ce que le soleil se lève à l'ouest (Muslim n° 2759, d'après Abū Mūsā).

4. Les conditions du repentir
D'après IslamQA (réponse n° 289765), les conditions du repentir sincère sont : quitter le péché, regretter ce qui est passé, et être résolu à ne pas y revenir. Si le péché touche les droits des gens (biens, honneur, personne), il faut une quatrième condition : leur rendre leur droit ou obtenir leur pardon. Cheikh Ibn Bāz a expliqué de même qu'il faut rendre les biens à leurs propriétaires ou leur demander de pardonner (binbaz.org.sa, audio n° 1135).
La limite dans le temps : Allah accepte le repentir du serviteur tant que son âme n'arrive pas à la gorge (al-Tirmidhī n° 3537, d'après Ibn ʿUmar ; « ḥasan » selon al-Albānī et Aḥmad Shākir).

5. L'homme qui avait tué quatre-vingt-dix-neuf personnes
Le Prophète ﷺ raconta qu'un homme des fils d'Isrā’īl avait tué quatre-vingt-dix-neuf personnes. Il demanda à un moine s'il pouvait se repentir ; celui-ci répondit non, et l'homme le tua aussi. Puis un autre lui conseilla d'aller vers un certain village. La mort le surprit en chemin ; il s'était tourné vers ce village. Les anges de la miséricorde et ceux du châtiment se disputèrent à son sujet, et Allah lui pardonna (al-Bukhārī n° 3470, d'après Abū Saʿīd al-Khudrī, récit résumé).

6. Ce que l'élève peut retenir
- On ne désespère jamais de la miséricorde d'Allah.
- Le Prophète ﷺ demandait pardon plus de soixante-dix fois et se repentait cent fois par jour.
- Allah se réjouit du repentir de Son serviteur.
- Conditions : quitter le péché, regretter, être résolu à ne pas recommencer, et rendre les droits des gens.
- On se repent sans attendre : le repentir n'est plus accepté quand l'âme arrive à la gorge.

Exercice : prenez l'habitude de dire « astaghfiru llāh wa atūbu ilayh » plusieurs fois chaque jour, et si vous avez fait du tort à quelqu'un, réparez-le cette semaine, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 39::int, 53::int, 53::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 66::int, 8::int, 8::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 24::int, 31::int, 31::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 3::int, 135::int, 135::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$quran$x$::public.reference_kind, 25::int, 70::int, 70::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2702b$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Repentez-vous auprès d'Allah… cent fois par jour », d'après al-Agharr al-Muzanī$x$, null, null, $x$https://sunnah.com/muslim:2702b$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6307$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Plus de soixante-dix fois par jour, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:6307$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6306$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le maître de la demande de pardon (sayyid al-istighfār)$x$, null, null, $x$https://sunnah.com/bukhari:6306$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6309$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Allah se réjouit du repentir de Son serviteur, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:6309$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2759$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Allah tend Sa main la nuit et le jour, d'après Abū Mūsā$x$, null, null, $x$https://sunnah.com/muslim:2759$x$, null),
  (11, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 289765 : les conditions du repentir sincère$x$, $x$IslamQA (sous la direction de Muḥammad Ṣāliḥ al-Munajjid)$x$, $x$Réponse n° 289765$x$, $x$https://islamqa.info/ar/answers/289765$x$, $x$Quitter le péché, regretter, être résolu à ne pas y revenir ; rendre les droits des gens si le péché les touche.$x$),
  (12, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Les conditions du repentir sincère (audio)$x$, $x$ʿAbd al-ʿAzīz ibn Bāz$x$, $x$Audio n° 1135, site officiel binbaz.org.sa$x$, $x$https://binbaz.org.sa/audios/1135$x$, $x$Rendre les biens et les droits à leurs propriétaires ou leur demander de pardonner.$x$),
  (13, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$3537$x$, $x$Ḥasan (al-Albānī, Aḥmad Shākir)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Le repentir accepté tant que l'âme n'arrive pas à la gorge, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/tirmidhi:3537$x$, null),
  (14, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$3470$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'homme qui avait tué quatre-vingt-dix-neuf personnes, d'après Abū Saʿīd al-Khudrī$x$, null, null, $x$https://sunnah.com/bukhari:3470$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Faut-il désespérer de la miséricorde d'Allah après de nombreux péchés ?$x$, array[$x$Non : Allah pardonne tous les péchés à celui qui se repent$x$, $x$Oui$x$, $x$Seulement après certains péchés$x$]::text[], 0, $x$Sourate az-Zumar, 39:53.$x$),
  (2, $x$Combien de fois par jour le Prophète ﷺ se repentait-il selon le hadith d'al-Agharr ?$x$, array[$x$Cent fois$x$, $x$Une fois$x$, $x$Jamais$x$]::text[], 0, $x$Muslim n° 2702.$x$),
  (3, $x$À quoi le hadith compare-t-il la joie d'Allah devant le repentir ?$x$, array[$x$À celle d'un homme qui retrouve son chameau perdu dans le désert$x$, $x$À celle d'un marchand$x$, $x$À rien$x$]::text[], 0, $x$Al-Bukhārī n° 6309.$x$),
  (4, $x$Lequel de ces éléments est une condition du repentir ?$x$, array[$x$Regretter ce qui est passé$x$, $x$Recommencer le péché$x$, $x$Le cacher aux autres$x$]::text[], 0, $x$IslamQA n° 289765.$x$),
  (5, $x$Que faut-il ajouter si le péché touche les droits d'une personne ?$x$, array[$x$Lui rendre son droit ou obtenir son pardon$x$, $x$Rien$x$, $x$Seulement prier$x$]::text[], 0, $x$IslamQA n° 289765 ; Ibn Bāz, audio n° 1135.$x$),
  (6, $x$Jusqu'à quand Allah accepte-t-Il le repentir du serviteur ?$x$, array[$x$Tant que son âme n'arrive pas à la gorge$x$, $x$Jusqu'à 40 ans$x$, $x$Seulement pendant Ramaḍān$x$]::text[], 0, $x$Al-Tirmidhī n° 3537.$x$),
  (7, $x$Jusqu'à quand Allah tend-Il Sa main pour accepter le repentir des gens ?$x$, array[$x$Jusqu'au lever du soleil à l'ouest$x$, $x$Jusqu'au vendredi$x$, $x$Une seule fois$x$]::text[], 0, $x$Muslim n° 2759.$x$),
  (8, $x$Que fit Allah pour l'homme qui avait tué quatre-vingt-dix-neuf personnes puis s'était repenti ?$x$, array[$x$Il lui pardonna$x$, $x$Il refusa son repentir$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 3470.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 14$x$),
       rv.h = 'c81dd0b8bc1cf0e6644975717f75e9f4' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
