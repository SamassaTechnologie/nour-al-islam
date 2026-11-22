LESSON = dict(
    position=4,
    slug='l-education-des-enfants',
    title="L'éducation des enfants",
    summary="Préservez-vous et vos familles du Feu ; chacun est un berger responsable de son troupeau. L'enfant naît sur la fiṭra ; enseigner la prière dès sept ans ; la justice entre les enfants ; la miséricorde envers eux ; les conseils de Luqmān ; l'invocation pour une descendance pieuse.",
    body="""1. Une responsabilité
Allah dit : ô vous qui croyez, préservez-vous, vous et vos familles, d'un Feu dont le combustible est les hommes et les pierres (sourate at-Taḥrīm, 66:6). Ordonne la prière à ta famille et sois-y constant (sourate Ṭā-Hā, 20:132).
Le Prophète ﷺ a dit : chacun de vous est un berger, et chacun est responsable de son troupeau ; l'homme est un berger dans sa famille et il en est responsable ; la femme est une bergère dans la maison de son mari et elle en est responsable (al-Bukhārī n° 893, d'après Ibn ʿUmar).

2. La fiṭra
Le Prophète ﷺ a dit :
« {{AR:bukhari:1385|كل مولود يولد على الفطرة|أو يمجسانه}} » (kullu mawlūdin yūladu ʿalā l-fiṭra, fa-abawāhu yuhawwidānihi aw yunaṣṣirānihi aw yumajjisānih).
Sens : « Tout enfant naît sur la nature saine (al-fiṭra) ; ce sont ses parents qui en font un juif, un chrétien ou un mazdéen. » (al-Bukhārī n° 1385, d'après Abū Hurayra ; hadith authentique).

3. La prière dès l'enfance
Le Prophète ﷺ a dit :
« {{AR:abudawud:495|مروا أولادكم|في المضاجع}} » (murū awlādakum bi-ṣ-ṣalāti wa hum abnā’u sabʿi sinīn, wa ḍribūhum ʿalayhā wa hum abnā’u ʿashri sinīn, wa farriqū baynahum fī l-maḍājiʿ).
Sens : « Ordonnez la prière à vos enfants quand ils ont sept ans, corrigez-les (litt. frappez-les) pour elle quand ils ont dix ans, et séparez-les dans leurs couches. » (Abū Dāwūd n° 495, d'après ʿAmr ibn Shuʿayb, de son père, de son grand-père ; « ḥasan ṣaḥīḥ » selon al-Albānī). La manière et les limites de cette correction sont expliquées par les savants : on les leur demande, et on se rappelle que le Prophète ﷺ n'a jamais rien frappé de sa main, ni femme ni serviteur, sauf en combattant dans le sentier d'Allah (Muslim n° 2328, d'après ʿĀ’isha).

4. La justice entre les enfants
Le père d'an-Nuʿmān ibn Bashīr fit un don à son fils et voulut prendre le Prophète ﷺ à témoin. Celui-ci demanda : as-tu donné la même chose à tous tes enfants ? Il répondit non. Il dit :
« {{AR:bukhari:2587|فاتقوا الله|بين أولادكم}} » (fa-ttaqū llāha wa ʿdilū bayna awlādikum).
Sens : « Craignez Allah et soyez justes entre vos enfants. » Il reprit alors son don (al-Bukhārī n° 2587 ; hadith authentique).

5. La miséricorde et l'enseignement
Le Prophète ﷺ embrassait ses petits-enfants et disait : celui qui ne fait pas miséricorde, on ne lui fera pas miséricorde (al-Bukhārī n° 5997). Il enseignait aux enfants avec douceur : « ô garçon, dis Bismillāh, mange de ta main droite et mange de ce qui est devant toi » (al-Bukhārī n° 5376, à ʿUmar ibn Abī Salama ; voir la leçon « Le salut et les manières de la table »).
Luqmān conseilla son fils : ne pas associer à Allah, être bon envers ses parents, savoir qu'Allah voit tout, accomplir la prière, ordonner le bien et interdire le mal, être patient, ne pas être arrogant, et baisser la voix (sourate Luqmān, 31:13-19).
L'enfant pieux qui invoque pour ses parents fait partie des œuvres qui continuent après la mort (Muslim n° 1631).

6. L'invocation
Allah rapporte l'invocation des serviteurs du Tout Miséricordieux : Seigneur, donne-nous, en nos épouses et nos descendants, la joie de nos yeux, et fais de nous un modèle pour les pieux (sourate al-Furqān, 25:74).

7. Ce que l'élève peut retenir
- Les parents sont responsables de l'éducation religieuse de leurs enfants.
- On enseigne la prière dès sept ans, avec patience.
- On est juste entre ses enfants, même dans les cadeaux.
- On éduque avec miséricorde et douceur, à l'exemple du Prophète ﷺ et de Luqmān.
- On invoque Allah pour une descendance pieuse.

Exercice : choisissez un conseil de Luqmān (31:13-19) et expliquez-le à un enfant de votre famille cette semaine, puis répondez aux questions.""",
    refs=[
        quran(66, 6),
        quran(20, 132),
        coll('bukhari', 893, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Chacun de vous est un berger », d'après Ibn ʿUmar"),
        coll('bukhari', 1385, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Tout enfant naît sur la fiṭra, d'après Abū Hurayra",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('abudawud', 495, 'Ḥasan ṣaḥīḥ (al-Albānī) ; authentique (Zubayr ʿAlī Zaʾī)', "Jugements affichés sur sunnah.com",
             "Ordonner la prière aux enfants à sept ans, d'après ʿAmr ibn Shuʿayb",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2328',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Le Prophète ﷺ n'a jamais frappé de sa main ni femme ni serviteur, d'après ʿĀ’isha", url='https://sunnah.com/muslim:2328'),
        coll('bukhari', 2587, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Soyez justes entre vos enfants », d'après an-Nuʿmān ibn Bashīr",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 5997, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le baiser à al-Ḥasan, d'après Abū Hurayra"),
        coll('bukhari', 5376, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Ô garçon, dis Bismillāh », d'après ʿUmar ibn Abī Salama"),
        quran(31, 13, 19),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='1631',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Les œuvres qui continuent après la mort, d'après Abū Hurayra", url='https://sunnah.com/muslim:1631'),
        quran(25, 74),
    ],
    questions=[
        ("Que demande Allah aux croyants envers leurs familles en 66:6 ?", ["De les préserver du Feu", "De les laisser faire", "Rien"], 0,
         "Sourate at-Taḥrīm, 66:6."),
        ("Que dit le hadith « chacun de vous est un berger » ?", ["Chacun est responsable de ceux dont il a la charge", "Il faut élever des moutons", "Personne n'est responsable"], 0,
         "Al-Bukhārī n° 893."),
        ("Sur quoi naît tout enfant ?", ["Sur la fiṭra (la nature saine)", "Sur l'ignorance", "Sur le mal"], 0,
         "Al-Bukhārī n° 1385."),
        ("À quel âge ordonne-t-on la prière à l'enfant selon le hadith ?", ["Sept ans", "Quinze ans", "Trois ans"], 0,
         "Abū Dāwūd n° 495."),
        ("Que dit ʿĀ’isha du Prophète ﷺ ?", ["Il n'a jamais frappé de sa main ni femme ni serviteur", "Il frappait souvent", "Elle n'en parle pas"], 0,
         "Muslim n° 2328."),
        ("Que dit le Prophète ﷺ au père qui avait donné un cadeau à un seul de ses enfants ?", ["Soyez justes entre vos enfants", "C'est permis", "Donne-lui encore plus"], 0,
         "Al-Bukhārī n° 2587."),
        ("Lequel de ces conseils Luqmān donna-t-il à son fils ?", ["Accomplir la prière et être patient", "Élever la voix", "Être arrogant"], 0,
         "Sourate Luqmān, 31:13-19."),
        ("Que demandent les serviteurs du Tout Miséricordieux pour leurs familles ?", ["Que leurs épouses et descendants soient la joie de leurs yeux", "La richesse seulement", "Rien"], 0,
         "Sourate al-Furqān, 25:74."),
    ],
)
