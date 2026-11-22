LESSON = dict(
    position=13,
    slug='la-science-et-son-merite',
    title="La science religieuse et son mérite",
    summary="Allah élève les savants et ordonne d'interroger les gens du savoir ; « Seigneur, augmente-moi en science ». Celui à qui Allah veut du bien, Il lui donne la compréhension de la religion ; le chemin de la science mène au Paradis ; transmettre sans mentir sur le Prophète ﷺ ; la disparition de la science et le danger de parler sans savoir.",
    body="""1. La science dans le Coran
Allah ordonne à Son Prophète ﷺ de dire : Seigneur, augmente-moi en science (sourate Ṭā-Hā, 20:114). Il demande : sont-ils égaux, ceux qui savent et ceux qui ne savent pas ? (sourate az-Zumar, 39:9). Il élève en degrés ceux qui ont cru et ceux qui ont reçu la science (sourate al-Mujādila, 58:11). Il ordonne d'interroger les gens du rappel si l'on ne sait pas (sourate an-Naḥl, 16:43), et de ne pas suivre ce dont on n'a aucune connaissance (sourate al-Isrā’, 17:36).

2. La compréhension de la religion est un bien
Le Prophète ﷺ a dit :
« {{AR:bukhari:71|من يرد الله به خيرا|يفقهه في الدين}} » (man yuridi llāhu bihi khayran yufaqqihhu fī d-dīn).
Sens : « Celui à qui Allah veut du bien, Il lui donne la compréhension de la religion. » (al-Bukhārī n° 71, d'après Muʿāwiya ; hadith authentique).

3. Le chemin de la science
Le Prophète ﷺ a dit :
« {{AR:muslim:6853|من سلك طريقا|إلى الجنة}} » (man salaka ṭarīqan yaltamisu fīhi ʿilman sahhala llāhu lahu bihi ṭarīqan ilā l-janna).
Sens : « Celui qui emprunte un chemin pour y chercher une science, Allah lui facilite par là un chemin vers le Paradis. » (Muslim n° 2699, d'après Abū Hurayra ; hadith authentique ; voir la leçon sur le hadith 36 des Quarante d'an-Nawawī).
Il a dit aussi : le meilleur d'entre vous est celui qui apprend le Coran et l'enseigne (al-Bukhārī n° 5027, d'après ʿUthmān). Et : on ne peut envier que deux personnes : un homme à qui Allah a donné des biens et qui les dépense dans le vrai, et un homme à qui Allah a donné la sagesse, qui juge par elle et l'enseigne (al-Bukhārī n° 73, d'après Ibn Masʿūd). Et quand l'homme meurt, ses œuvres s'arrêtent sauf trois, dont une science dont on tire profit (Muslim n° 1631, d'après Abū Hurayra).

4. Transmettre avec honnêteté
Le Prophète ﷺ a dit : transmettez de ma part, ne serait-ce qu'un verset ; et celui qui ment sur moi délibérément, qu'il prenne sa place dans le Feu (al-Bukhārī n° 3461, d'après ʿAbd Allāh ibn ʿAmr). C'est pourquoi NOUR AL-ISLAM ne cite que des textes vérifiés, avec leurs références.

5. La disparition de la science
Le Prophète ﷺ a dit :
« {{AR:bukhari:100|إن الله لا يقبض العلم|فضلوا وأضلوا}} » (inna llāha lā yaqbiḍu l-ʿilma ntizāʿan yantaziʿuhu mina l-ʿibād, wa lākin yaqbiḍu l-ʿilma bi-qabḍi l-ʿulamā’, ḥattā idhā lam yubqi ʿāliman ittakhadha n-nāsu ru’ūsan juhhālan fa-su’ilū fa-aftaw bi-ghayri ʿilmin fa-ḍallū wa aḍallū).
Sens : « Allah n'enlève pas la science en l'arrachant aux gens, mais Il l'enlève en reprenant les savants ; quand il ne reste plus de savant, les gens prennent pour chefs des ignorants : on les interroge, ils répondent sans science, ils s'égarent et égarent les autres. » (al-Bukhārī n° 100, d'après ʿAbd Allāh ibn ʿAmr ibn al-ʿĀṣ ; hadith authentique).

6. Ce que l'élève peut retenir
- On demande à Allah d'augmenter notre science.
- Comprendre la religion est un signe du bien qu'Allah veut pour quelqu'un.
- Chercher la science est un chemin vers le Paradis ; la science utile continue de profiter après la mort.
- On transmet ce qu'on sait, sans jamais attribuer au Prophète ﷺ ce qu'il n'a pas dit.
- On ne parle pas de la religion sans science : on interroge les savants.

Exercice : choisissez une leçon de NOUR AL-ISLAM que vous n'avez pas encore étudiée, apprenez-la cette semaine et expliquez-la à un proche, puis répondez aux questions.""",
    refs=[
        quran(20, 114),
        quran(39, 9),
        quran(58, 11),
        quran(16, 43),
        quran(17, 36),
        coll('bukhari', 71, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Celui à qui Allah veut du bien… », d'après Muʿāwiya",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2699a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Le chemin de la science mène au Paradis, d'après Abū Hurayra", url='https://sunnah.com/muslim:2699a',
             note="Passage copié tel quel de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 5027, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Le meilleur d'entre vous est celui qui apprend le Coran et l'enseigne », d'après ʿUthmān"),
        coll('bukhari', 73, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "On n'envie que deux personnes, d'après Ibn Masʿūd"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='1631',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Les trois œuvres qui continuent après la mort, d'après Abū Hurayra", url='https://sunnah.com/muslim:1631'),
        coll('bukhari', 3461, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Transmettez de ma part, ne serait-ce qu'un verset », d'après ʿAbd Allāh ibn ʿAmr"),
        coll('bukhari', 100, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "La science enlevée par la mort des savants, d'après ʿAbd Allāh ibn ʿAmr ibn al-ʿĀṣ",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
    ],
    questions=[
        ("Quelle invocation Allah a-t-Il enseignée à Son Prophète ﷺ dans la sourate Ṭā-Hā ?", ["Seigneur, augmente-moi en science", "Seigneur, donne-moi la richesse", "Seigneur, rends-moi célèbre"], 0,
         "Sourate Ṭā-Hā, 20:114."),
        ("Que doit faire celui qui ne sait pas ?", ["Interroger les gens du savoir", "Répondre selon son avis", "Se taire pour toujours"], 0,
         "Sourate an-Naḥl, 16:43."),
        ("Que donne Allah à celui à qui Il veut du bien ?", ["La compréhension de la religion", "La richesse seulement", "La célébrité"], 0,
         "Al-Bukhārī n° 71."),
        ("Où mène le chemin de celui qui cherche la science ?", ["Vers le Paradis", "Nulle part", "Vers la richesse"], 0,
         "Muslim n° 2699."),
        ("Qui est le meilleur d'entre nous selon le hadith de ʿUthmān ?", ["Celui qui apprend le Coran et l'enseigne", "Le plus riche", "Le plus fort"], 0,
         "Al-Bukhārī n° 5027."),
        ("Quelle science continue de profiter après la mort ?", ["La science dont on tire profit", "Aucune", "Celle qu'on garde pour soi"], 0,
         "Muslim n° 1631."),
        ("Quelle est la menace pour celui qui ment délibérément sur le Prophète ﷺ ?", ["Qu'il prenne sa place dans le Feu", "Aucune", "Une petite faute"], 0,
         "Al-Bukhārī n° 3461."),
        ("Comment Allah enlève-t-Il la science selon le hadith ?", ["En reprenant les savants", "En l'arrachant des cœurs d'un coup", "En brûlant les livres"], 0,
         "Al-Bukhārī n° 100."),
    ],
)
