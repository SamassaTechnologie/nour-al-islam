-- Bonnes manières 17 : l-invocation-et-ses-regles
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$l-invocation-et-ses-regles$x$, 'lesson', $x$adab$x$, 'fr', 17) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$L'invocation (ad-duʿā’) et ses règles$x$, $x$« Invoquez-Moi, Je vous répondrai » ; l'invocation est l'adoration. Allah est proche ; on L'invoque avec humilité et en secret. Demander avec résolution, ne pas se hâter, ne pas invoquer pour un péché ni pour rompre les liens de parenté ; le gain licite ; les moments favorables : la prosternation et le dernier tiers de la nuit.$x$, $x$1. Invoquez-Moi
Allah dit : votre Seigneur a dit : invoquez-Moi, Je vous répondrai (sourate Ghāfir, 40:60). Quand Mes serviteurs t'interrogent sur Moi, Je suis tout proche : Je réponds à l'appel de celui qui M'invoque (sourate al-Baqara, 2:186). Invoquez votre Seigneur avec humilité et en secret (sourate al-Aʿrāf, 7:55). Et c'est Lui qui répond à l'homme en détresse quand il L'invoque (sourate an-Naml, 27:62).
Le Prophète ﷺ a dit :
« الدُّعَاءُ هُوَ الْعِبَادَةُ » (ad-duʿā’u huwa l-ʿibāda).
Sens : « L'invocation, c'est l'adoration. » Puis il récita le verset 40:60 (al-Tirmidhī n° 3372, d'après an-Nuʿmān ibn Bashīr ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir).

2. Demander avec résolution
Le Prophète ﷺ a dit : quand l'un de vous invoque, qu'il demande avec résolution et ne dise pas : ô Allah, si Tu veux, donne-moi ; car personne ne peut contraindre Allah (al-Bukhārī n° 6338, d'après Anas).

3. Ne pas se hâter
Le Prophète ﷺ a dit :
« لاَ يَزَالُ يُسْتَجَابُ لِلْعَبْدِ مَا لَمْ يَدْعُ بِإِثْمٍ أَوْ قَطِيعَةِ رَحِمٍ مَا لَمْ يَسْتَعْجِلْ » (lā yazālu yustajābu li-l-ʿabdi mā lam yadʿu bi-ithmin aw qaṭīʿati raḥim, mā lam yastaʿjil).
Sens : « L'invocation du serviteur continue d'être exaucée tant qu'il n'invoque pas pour un péché ou pour rompre les liens de parenté, et tant qu'il ne se hâte pas. » On demanda ce qu'est se hâter ; il répondit : dire j'ai invoqué et invoqué, et je ne vois pas de réponse, puis se lasser et abandonner l'invocation (Muslim n° 2735, d'après Abū Hurayra ; hadith authentique ; voir aussi al-Bukhārī n° 6340).

4. Le gain licite
Le Prophète ﷺ a dit qu'Allah est bon et n'accepte que ce qui est bon. Puis il parla de l'homme qui voyage longtemps, échevelé et couvert de poussière, qui tend les mains vers le ciel : ô Seigneur, ô Seigneur ! alors que sa nourriture est illicite, sa boisson illicite, son vêtement illicite, et qu'il a été nourri d'illicite : comment lui répondrait-on ? (Muslim n° 1015, d'après Abū Hurayra ; voir la leçon sur le hadith 10 des Quarante d'an-Nawawī).

5. Les moments favorables
Le Prophète ﷺ a dit :
« أَقْرَبُ مَا يَكُونُ الْعَبْدُ مِنْ رَبِّهِ وَهُوَ سَاجِدٌ فَأَكْثِرُوا الدُّعَاءَ » (aqrabu mā yakūnu l-ʿabdu min rabbihi wa huwa sājid, fa-aktharū d-duʿā’).
Sens : « Le moment où le serviteur est le plus proche de son Seigneur, c'est quand il est prosterné : multipliez donc les invocations. » (Muslim n° 482, d'après Abū Hurayra ; hadith authentique).
Le dernier tiers de la nuit : Allah descend au ciel de ce bas monde et dit : qui M'invoque, que Je lui réponde ? (al-Bukhārī n° 1145 ; voir la leçon « Les noms et les attributs d'Allah »).
Pour son frère absent : l'ange dit « et à toi la même chose » (Muslim n° 2732 ; voir la leçon « La fraternité »).

6. Ce que l'élève peut retenir
- L'invocation est une adoration : on n'invoque qu'Allah.
- On L'invoque avec humilité, avec résolution, sans se lasser.
- On n'invoque pas pour un péché ni pour rompre les liens de parenté.
- Le gain illicite empêche l'exaucement.
- On profite de la prosternation et du dernier tiers de la nuit.

Exercice : cette semaine, multipliez les invocations pendant la prosternation, et une nuit, levez-vous avant le fajr pour invoquer, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 40::int, 60::int, 60::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 2::int, 186::int, 186::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 7::int, 55::int, 55::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 27::int, 62::int, 62::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$3372$x$, $x$Ḥasan ṣaḥīḥ (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« L'invocation, c'est l'adoration », d'après an-Nuʿmān ibn Bashīr$x$, null, null, $x$https://sunnah.com/tirmidhi:3372$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6338$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Demander avec résolution, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:6338$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2735c$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$L'invocation exaucée tant qu'on ne se hâte pas, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2735c$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6340$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Exaucé tant qu'il ne se hâte pas », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:6340$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1015$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Allah est bon et n'accepte que ce qui est bon », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:1015$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$482$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Le plus proche de son Seigneur quand il est prosterné, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:482$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1145$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La descente d'Allah au dernier tiers de la nuit, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:1145$x$, null),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2732a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$L'invocation pour son frère absent, d'après Abū d-Dardā’$x$, null, null, $x$https://sunnah.com/muslim:2732a$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que promet Allah à celui qui L'invoque ?$x$, array[$x$Je vous répondrai$x$, $x$Rien$x$, $x$Seulement le vendredi$x$]::text[], 0, $x$Sourate Ghāfir, 40:60.$x$),
  (2, $x$Comment le Prophète ﷺ a-t-il défini l'invocation ?$x$, array[$x$C'est l'adoration$x$, $x$Une simple habitude$x$, $x$Une parole sans valeur$x$]::text[], 0, $x$Al-Tirmidhī n° 3372.$x$),
  (3, $x$Faut-il dire « ô Allah, si Tu veux, donne-moi » ?$x$, array[$x$Non, on demande avec résolution$x$, $x$Oui, toujours$x$, $x$Seulement la nuit$x$]::text[], 0, $x$Al-Bukhārī n° 6338.$x$),
  (4, $x$Qu'est-ce que « se hâter » dans l'invocation ?$x$, array[$x$Dire : j'ai invoqué sans réponse, puis abandonner$x$, $x$Invoquer vite$x$, $x$Invoquer souvent$x$]::text[], 0, $x$Muslim n° 2735.$x$),
  (5, $x$Pour quoi ne doit-on pas invoquer ?$x$, array[$x$Pour un péché ou pour rompre les liens de parenté$x$, $x$Pour la santé$x$, $x$Pour ses parents$x$]::text[], 0, $x$Muslim n° 2735.$x$),
  (6, $x$Qu'est-ce qui empêche l'exaucement dans le hadith de l'homme qui voyage longtemps ?$x$, array[$x$Sa nourriture et son vêtement illicites$x$, $x$Son voyage$x$, $x$Ses cheveux$x$]::text[], 0, $x$Muslim n° 1015.$x$),
  (7, $x$Quand le serviteur est-il le plus proche de son Seigneur ?$x$, array[$x$Quand il est prosterné$x$, $x$Quand il dort$x$, $x$Quand il mange$x$]::text[], 0, $x$Muslim n° 482.$x$),
  (8, $x$Quel moment de la nuit est favorable à l'invocation ?$x$, array[$x$Le dernier tiers$x$, $x$Le début seulement$x$, $x$Aucun$x$]::text[], 0, $x$Al-Bukhārī n° 1145.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 17$x$),
       rv.h = '2897fc83cbe66ee79f3df3c8631fc8a9' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
