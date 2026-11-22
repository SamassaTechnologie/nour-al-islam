LESSON = dict(
    position=17,
    slug='l-invocation-et-ses-regles',
    title="L'invocation (ad-duʿā’) et ses règles",
    summary="« Invoquez-Moi, Je vous répondrai » ; l'invocation est l'adoration. Allah est proche ; on L'invoque avec humilité et en secret. Demander avec résolution, ne pas se hâter, ne pas invoquer pour un péché ni pour rompre les liens de parenté ; le gain licite ; les moments favorables : la prosternation et le dernier tiers de la nuit.",
    body="""1. Invoquez-Moi
Allah dit : votre Seigneur a dit : invoquez-Moi, Je vous répondrai (sourate Ghāfir, 40:60). Quand Mes serviteurs t'interrogent sur Moi, Je suis tout proche : Je réponds à l'appel de celui qui M'invoque (sourate al-Baqara, 2:186). Invoquez votre Seigneur avec humilité et en secret (sourate al-Aʿrāf, 7:55). Et c'est Lui qui répond à l'homme en détresse quand il L'invoque (sourate an-Naml, 27:62).
Le Prophète ﷺ a dit :
« {{AR:tirmidhi:3372|الدعاء|هو العبادة}} » (ad-duʿā’u huwa l-ʿibāda).
Sens : « L'invocation, c'est l'adoration. » Puis il récita le verset 40:60 (al-Tirmidhī n° 3372, d'après an-Nuʿmān ibn Bashīr ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir).

2. Demander avec résolution
Le Prophète ﷺ a dit : quand l'un de vous invoque, qu'il demande avec résolution et ne dise pas : ô Allah, si Tu veux, donne-moi ; car personne ne peut contraindre Allah (al-Bukhārī n° 6338, d'après Anas).

3. Ne pas se hâter
Le Prophète ﷺ a dit :
« {{AR:muslim:6936|لا يزال يستجاب للعبد|ما لم يستعجل}} » (lā yazālu yustajābu li-l-ʿabdi mā lam yadʿu bi-ithmin aw qaṭīʿati raḥim, mā lam yastaʿjil).
Sens : « L'invocation du serviteur continue d'être exaucée tant qu'il n'invoque pas pour un péché ou pour rompre les liens de parenté, et tant qu'il ne se hâte pas. » On demanda ce qu'est se hâter ; il répondit : dire j'ai invoqué et invoqué, et je ne vois pas de réponse, puis se lasser et abandonner l'invocation (Muslim n° 2735, d'après Abū Hurayra ; hadith authentique ; voir aussi al-Bukhārī n° 6340).

4. Le gain licite
Le Prophète ﷺ a dit qu'Allah est bon et n'accepte que ce qui est bon. Puis il parla de l'homme qui voyage longtemps, échevelé et couvert de poussière, qui tend les mains vers le ciel : ô Seigneur, ô Seigneur ! alors que sa nourriture est illicite, sa boisson illicite, son vêtement illicite, et qu'il a été nourri d'illicite : comment lui répondrait-on ? (Muslim n° 1015, d'après Abū Hurayra ; voir la leçon sur le hadith 10 des Quarante d'an-Nawawī).

5. Les moments favorables
Le Prophète ﷺ a dit :
« {{AR:muslim:1083|أقرب ما يكون العبد|فأكثروا الدعاء}} » (aqrabu mā yakūnu l-ʿabdu min rabbihi wa huwa sājid, fa-aktharū d-duʿā’).
Sens : « Le moment où le serviteur est le plus proche de son Seigneur, c'est quand il est prosterné : multipliez donc les invocations. » (Muslim n° 482, d'après Abū Hurayra ; hadith authentique).
Le dernier tiers de la nuit : Allah descend au ciel de ce bas monde et dit : qui M'invoque, que Je lui réponde ? (al-Bukhārī n° 1145 ; voir la leçon « Les noms et les attributs d'Allah »).
Pour son frère absent : l'ange dit « et à toi la même chose » (Muslim n° 2732 ; voir la leçon « La fraternité »).

6. Ce que l'élève peut retenir
- L'invocation est une adoration : on n'invoque qu'Allah.
- On L'invoque avec humilité, avec résolution, sans se lasser.
- On n'invoque pas pour un péché ni pour rompre les liens de parenté.
- Le gain illicite empêche l'exaucement.
- On profite de la prosternation et du dernier tiers de la nuit.

Exercice : cette semaine, multipliez les invocations pendant la prosternation, et une nuit, levez-vous avant le fajr pour invoquer, puis répondez aux questions.""",
    refs=[
        quran(40, 60),
        quran(2, 186),
        quran(7, 55),
        quran(27, 62),
        coll('tirmidhi', 3372, 'Ḥasan ṣaḥīḥ (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir)', "Jugements affichés sur sunnah.com",
             "« L'invocation, c'est l'adoration », d'après an-Nuʿmān ibn Bashīr",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6338, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Demander avec résolution, d'après Anas"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2735c',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="L'invocation exaucée tant qu'on ne se hâte pas, d'après Abū Hurayra", url='https://sunnah.com/muslim:2735c',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6340, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Exaucé tant qu'il ne se hâte pas », d'après Abū Hurayra"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='1015',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Allah est bon et n'accepte que ce qui est bon », d'après Abū Hurayra", url='https://sunnah.com/muslim:1015'),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='482',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Le plus proche de son Seigneur quand il est prosterné, d'après Abū Hurayra", url='https://sunnah.com/muslim:482',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 1145, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "La descente d'Allah au dernier tiers de la nuit, d'après Abū Hurayra"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2732a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="L'invocation pour son frère absent, d'après Abū d-Dardā’", url='https://sunnah.com/muslim:2732a'),
    ],
    questions=[
        ("Que promet Allah à celui qui L'invoque ?", ["Je vous répondrai", "Rien", "Seulement le vendredi"], 0,
         "Sourate Ghāfir, 40:60."),
        ("Comment le Prophète ﷺ a-t-il défini l'invocation ?", ["C'est l'adoration", "Une simple habitude", "Une parole sans valeur"], 0,
         "Al-Tirmidhī n° 3372."),
        ("Faut-il dire « ô Allah, si Tu veux, donne-moi » ?", ["Non, on demande avec résolution", "Oui, toujours", "Seulement la nuit"], 0,
         "Al-Bukhārī n° 6338."),
        ("Qu'est-ce que « se hâter » dans l'invocation ?", ["Dire : j'ai invoqué sans réponse, puis abandonner", "Invoquer vite", "Invoquer souvent"], 0,
         "Muslim n° 2735."),
        ("Pour quoi ne doit-on pas invoquer ?", ["Pour un péché ou pour rompre les liens de parenté", "Pour la santé", "Pour ses parents"], 0,
         "Muslim n° 2735."),
        ("Qu'est-ce qui empêche l'exaucement dans le hadith de l'homme qui voyage longtemps ?", ["Sa nourriture et son vêtement illicites", "Son voyage", "Ses cheveux"], 0,
         "Muslim n° 1015."),
        ("Quand le serviteur est-il le plus proche de son Seigneur ?", ["Quand il est prosterné", "Quand il dort", "Quand il mange"], 0,
         "Muslim n° 482."),
        ("Quel moment de la nuit est favorable à l'invocation ?", ["Le dernier tiers", "Le début seulement", "Aucun"], 0,
         "Al-Bukhārī n° 1145."),
    ],
)
