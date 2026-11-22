LESSON = dict(
    position=14,
    slug='le-voyageur-derriere-un-imam-resident-et-le-resident-derriere-un-voyageur',
    title="Le voyageur qui prie derrière un imam résident, et le résident derrière un voyageur",
    summary="Le voyageur qui prie derrière un imam résident suit l'imam et prie quatre unités (Ibn ʿAbbās : « la sunna d'Abū l-Qāsim » ; Ibn ʿUmar à Minā). Le résident derrière un imam voyageur complète sa prière après le salut de l'imam (ʿUmar à La Mecque). Avec les avis des savants.",
    body="""Rappel : la leçon « Raccourcir la prière en voyage » explique que le voyageur prie deux unités au lieu de quatre pour le ẓuhr, le ʿaṣr et le ʿishā’. Cette leçon traite le cas de la prière en groupe.

1. Le principe : suivre l'imam
Le Prophète ﷺ dit :
« {{AR:bukhari:722|إنما جعل الإمام|فلا تختلفوا عليه}} » (innamā juʿila l-imāmu li-yu’tamma bihi fa-lā takhtalifū ʿalayh).
Sens : « L'imam n'a été placé que pour être suivi ; ne vous opposez donc pas à lui. » (al-Bukhārī n° 722 ; hadith authentique).

2. Le voyageur derrière un imam résident
Mūsā ibn Salama demanda à Ibn ʿAbbās comment prier à La Mecque quand il ne priait pas avec l'imam ; il répondit :
« {{AR:muslim:1577|ركعتين|القاسم}} » (rakʿatayn, sunnata abī l-qāsim).
Sens : « Deux unités : la sunna d'Abū l-Qāsim (le Prophète ﷺ). » (Muslim n° 688 ; hadith authentique).
Dans une autre version, Mūsā ibn Salama dit : quand nous sommes avec vous, nous prions quatre unités, et quand nous revenons à nos tentes, deux. Ibn ʿAbbās répondit : c'est la sunna d'Abū l-Qāsim ﷺ (rapportée par Aḥmad ; citée par Dorar, n° 1472).
Ibn ʿUmar, quand il priait à Minā avec l'imam, priait quatre unités, et quand il priait seul, deux (Muslim n° 694 ; hadith authentique).
Les avis :
- il complète quatre unités : Ibn ʿAbd al-Barr rapporte l'accord des savants qu'il complète s'il rattrape une unité avec l'imam, et la plupart disent qu'il complète dès qu'il entre dans la prière avant le salut de l'imam (Dorar, n° 1472). Ibn Bāz juge que c'est le plus juste des deux avis (fiqh.islamonline.net, « L'imam résident pour le voyageur et le voyageur pour le résident »).
- d'autres avis existent : selon certains, il ne complète que s'il rattrape au moins une unité ; selon d'autres, il raccourcit dans tous les cas (présentation des avis sur le forum Multaqā ahl at-tafsīr, à vérifier dans les ouvrages de fiqh).

3. Le résident derrière un imam voyageur
ʿUmar ibn al-Khaṭṭāb pria deux unités avec les gens de La Mecque, puis dit : « Ô gens de La Mecque, complétez votre prière, car nous sommes des voyageurs. » (Mālik, al-Muwaṭṭa’ ; parole de ʿUmar, chaîne authentique d'après les spécialistes cités sur Shamela).
Ibn Bāz : le résident qui prie le ẓuhr, le ʿaṣr ou le ʿishā’ derrière un voyageur prie quatre unités ; il complète sa prière après le salut de l'imam voyageur (fiqh.islamonline.net, même article).

4. Ce que l'élève peut retenir
- On suit l'imam.
- Voyageur derrière un imam résident : il prie quatre unités, selon la plupart des savants.
- Voyageur seul ou avec d'autres voyageurs : deux unités.
- Résident derrière un imam voyageur : l'imam salue après deux unités, et le résident complète seul.

Exercice : vous êtes en voyage et vous priez le ʿaṣr derrière l'imam de la mosquée du village. Combien d'unités priez-vous ? Et si l'imam est en voyage et vous non ? Puis répondez aux questions.""",
    refs=[
        coll('bukhari', 722, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« L'imam n'a été placé que pour être suivi », d'après Abū Hurayra",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='688a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Deux unités, la sunna d'Abū l-Qāsim », d'après Ibn ʿAbbās", url='https://sunnah.com/muslim:688a',
             note="Réponse d'Ibn ʿAbbās copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        book("Encyclopédie de fiqh : le voyageur qui prie derrière un résident complète", "Dorar (ad-Durar as-Saniyya)", "Section n° 1472",
             "https://dorar.net/feqhia/1472",
             "Version d'Aḥmad (quatre avec l'imam, deux seul) ; accord rapporté par Ibn ʿAbd al-Barr (at-Tamhīd 16/315) ; an-Nawawī (al-Majmūʿ 4/341)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='694c',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Ibn ʿUmar à Minā : quatre avec l'imam, deux seul", url='https://sunnah.com/muslim:694c'),
        book("L'imam résident pour le voyageur et le voyageur pour le résident", "fiqh.islamonline.net (citant Ibn Bāz et Aḥmad Huraydī)", "Article en ligne",
             "https://fiqh.islamonline.net/إمامة-المقيم-للمسافر-والمسافر-للمقيم/",
             "Ibn Bāz : le voyageur derrière le résident complète, selon le plus juste des deux avis ; le résident derrière le voyageur complète après son salut."),
        book("La prière du voyageur derrière le résident : trois avis", "Multaqā ahl at-tafsīr (forum, article d'Abū ʿAbd Allāh Muḥammad Muṣṭafā)", "Discussion n° 60817",
             "https://mtafsir.net/threads/60817/",
             "Présente trois avis : compléter ; compléter s'il rattrape une unité ; raccourcir dans tous les cas. Source secondaire, à vérifier."),
        book("Jāmiʿ : la parole de ʿUmar aux gens de La Mecque et ses chaînes", "Ouvrage de takhrīj sur Shamela (livre n° 261)", "Page 6316",
             "https://shamela.ws/book/261/6316",
             "Mālik, al-Muwaṭṭa’ (1/538, n° 1197) : « complétez votre prière, nous sommes des voyageurs » ; parole de ʿUmar, chaîne authentique."),
    ],
    questions=[
        ("Pourquoi l'imam a-t-il été placé ?", ["Pour être suivi", "Pour faire la prière à notre place", "Pour réciter seulement"], 0,
         "Al-Bukhārī n° 722."),
        ("Combien d'unités prie le voyageur seul pour le ʿaṣr ?", ["Deux", "Quatre", "Trois"], 0,
         "Muslim n° 688."),
        ("Selon la plupart des savants, combien d'unités prie le voyageur derrière un imam résident pour le ʿaṣr ?", ["Quatre", "Deux", "Une"], 0,
         "Dorar n° 1472 ; Muslim n° 694."),
        ("Comment Ibn ʿAbbās appela-t-il cette manière de faire ?", ["La sunna d'Abū l-Qāsim", "Une innovation", "Un avis personnel"], 0,
         "Muslim n° 688 ; version d'Aḥmad citée par Dorar."),
        ("Que faisait Ibn ʿUmar à Minā derrière l'imam ?", ["Il priait quatre unités", "Il priait deux unités et partait", "Il ne priait pas"], 0,
         "Muslim n° 694."),
        ("Un résident prie le ẓuhr derrière un imam voyageur. Que fait-il ?", ["Il complète ses quatre unités après le salut de l'imam", "Il salue après deux unités", "Il recommence la prière"], 0,
         "Parole de ʿUmar (al-Muwaṭṭa’) ; Ibn Bāz."),
        ("Que dit ʿUmar aux gens de La Mecque ?", ["Complétez votre prière, nous sommes des voyageurs", "Raccourcissez avec nous", "Priez chez vous"], 0,
         "Mālik, al-Muwaṭṭa’."),
        ("Les savants sont-ils tous d'accord sur le voyageur derrière le résident ?", ["Non, il existe d'autres avis, mais la plupart disent de compléter", "Oui, tous disent de raccourcir", "La question n'a jamais été posée"], 0,
         "Dorar n° 1472 ; Ibn Bāz ; Multaqā ahl at-tafsīr."),
    ],
)
