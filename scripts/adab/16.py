LESSON = dict(
    position=16,
    slug='la-sincerite-et-l-intention',
    title="La sincérité (al-ikhlāṣ) et l'intention",
    summary="Allah n'accepte que ce qui est fait sincèrement pour Lui ; les actes ne valent que par les intentions. Allah regarde les cœurs et les actes ; Il délaisse l'acte où on Lui associe un autre ; les trois premiers jugés au Jour de la Résurrection ; la récompense de la bonne intention, même sans l'acte.",
    body="""1. La sincérité, une condition de l'adoration
Allah dit qu'il n'a été ordonné aux gens que de L'adorer en Lui vouant un culte sincère (sourate al-Bayyina, 98:5) ; c'est à Allah qu'appartient la religion pure (sourate az-Zumar, 39:2-3). Que celui qui espère rencontrer son Seigneur fasse de bonnes œuvres et n'associe personne à l'adoration de son Seigneur (sourate al-Kahf, 18:110). Et malheur à ceux qui prient tout en étant négligents et qui agissent pour être vus (sourate al-Māʿūn, 107:4-6).
Le Prophète ﷺ a dit que les actes ne valent que par les intentions, et que chacun n'a que ce qu'il a eu l'intention de faire (al-Bukhārī n° 1 ; voir la leçon sur le hadith 1 des Quarante d'an-Nawawī).

2. Allah regarde les cœurs
Le Prophète ﷺ a dit :
« {{AR:muslim:6543|إن الله لا ينظر|قلوبكم وأعمالكم}} » (inna llāha lā yanẓuru ilā ṣuwarikum wa amwālikum wa lākin yanẓuru ilā qulūbikum wa aʿmālikum).
Sens : « Allah ne regarde pas vos apparences ni vos biens, mais Il regarde vos cœurs et vos actes. » (Muslim n° 2564, d'après Abū Hurayra ; hadith authentique).

3. Allah n'a pas besoin d'associé
Le Prophète ﷺ a rapporté qu'Allah dit :
« {{AR:muslim:7475|أنا أغنى الشركاء|تركته وشركه}} » (anā aghnā sh-shurakā’i ʿani sh-shirk, man ʿamila ʿamalan ashraka fīhi maʿī ghayrī taraktuhu wa shirkah).
Sens : « Je suis Celui qui se passe le plus d'associés ; celui qui accomplit un acte en M'y associant un autre, Je le délaisse, lui et son association. » (Muslim n° 2985, d'après Abū Hurayra ; hadith authentique ; voir aussi la leçon « Le shirk » sur l'ostentation).

4. Les trois premiers jugés
Le Prophète ﷺ a dit que les premiers jugés au Jour de la Résurrection seront : un homme tombé en combattant, qui avait combattu pour qu'on dise qu'il est courageux ; un homme qui avait appris et enseigné la science et lu le Coran pour qu'on dise qu'il est savant et lecteur ; et un homme à qui Allah avait donné des biens et qui les avait dépensés pour qu'on dise qu'il est généreux. Il leur sera dit : cela a été dit, et ils seront jetés dans le Feu (Muslim n° 1905, d'après Abū Hurayra, récit résumé).

5. La récompense de la bonne intention
Le Prophète ﷺ a rapporté qu'Allah a écrit les bonnes et les mauvaises actions : celui qui a l'intention d'une bonne action sans la faire, Allah la lui écrit comme une bonne action complète ; s'il la fait, Il lui écrit de dix à sept cents fois, et plus encore. Celui qui a l'intention d'une mauvaise action et ne la fait pas, Allah lui écrit une bonne action complète ; s'il la fait, une seule mauvaise action (al-Bukhārī n° 6491, d'après Ibn ʿAbbās).
Et quand le serviteur tombe malade ou voyage, on lui écrit l'équivalent de ce qu'il faisait quand il était chez lui et en bonne santé (al-Bukhārī n° 2996, d'après Abū Mūsā).

6. Ce que l'élève peut retenir
- On agit pour Allah seul, et non pour être vu ou loué.
- Allah regarde les cœurs et les actes, pas les apparences ni les biens.
- Un acte fait pour les gens n'est pas accepté, même s'il paraît grand.
- La bonne intention est déjà récompensée ; on renouvelle son intention avant chaque acte.

Exercice : avant chaque prière et chaque bonne action de cette semaine, arrêtez-vous un instant pour renouveler votre intention pour Allah seul, puis répondez aux questions.""",
    refs=[
        quran(98, 5),
        quran(39, 2, 3),
        quran(18, 110),
        quran(107, 4, 6),
        coll('bukhari', 1, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Les actes ne valent que par les intentions », d'après ʿUmar"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2564c',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Allah regarde les cœurs et les actes, d'après Abū Hurayra", url='https://sunnah.com/muslim:2564c',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2985',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Je suis Celui qui se passe le plus d'associés », d'après Abū Hurayra", url='https://sunnah.com/muslim:2985',
             note="Parole copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='1905a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Les trois premiers jugés au Jour de la Résurrection, d'après Abū Hurayra", url='https://sunnah.com/muslim:1905a'),
        coll('bukhari', 6491, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "L'intention d'une bonne ou d'une mauvaise action, d'après Ibn ʿAbbās"),
        coll('bukhari', 2996, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le malade et le voyageur, d'après Abū Mūsā"),
    ],
    questions=[
        ("Comment Allah a-t-Il ordonné de L'adorer ?", ["En Lui vouant un culte sincère", "Pour être vu des gens", "Comme on veut"], 0,
         "Sourate al-Bayyina, 98:5."),
        ("Par quoi les actes valent-ils selon le premier hadith d'al-Bukhārī ?", ["Par les intentions", "Par leur taille", "Par l'avis des gens"], 0,
         "Al-Bukhārī n° 1."),
        ("Que regarde Allah selon le hadith ?", ["Les cœurs et les actes", "Les apparences", "Les biens"], 0,
         "Muslim n° 2564."),
        ("Que fait Allah de l'acte où on Lui associe un autre ?", ["Il le délaisse", "Il l'accepte", "Il le double"], 0,
         "Muslim n° 2985."),
        ("Pourquoi le savant du hadith des trois premiers jugés est-il puni ?", ["Il a appris pour qu'on dise qu'il est savant", "Il n'a rien appris", "Il a appris pour Allah"], 0,
         "Muslim n° 1905."),
        ("Que reçoit celui qui a l'intention d'une bonne action sans pouvoir la faire ?", ["Une bonne action complète", "Rien", "Un péché"], 0,
         "Al-Bukhārī n° 6491."),
        ("Que reçoit celui qui renonce à une mauvaise action qu'il voulait faire ?", ["Une bonne action complète", "Un péché", "Rien"], 0,
         "Al-Bukhārī n° 6491."),
        ("Que reçoit le malade qui ne peut plus faire ses bonnes habitudes ?", ["L'équivalent de ce qu'il faisait en bonne santé", "Rien", "La moitié"], 0,
         "Al-Bukhārī n° 2996."),
    ],
)
