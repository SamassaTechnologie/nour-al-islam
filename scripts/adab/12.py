LESSON = dict(
    position=12,
    slug='les-manieres-de-la-mosquee',
    title="Les manières de la mosquée",
    summary="Les mosquées appartiennent à Allah. Venir à la prière avec calme, prier deux unités avant de s'asseoir, ne pas venir avec l'odeur de l'ail, ne pas passer devant celui qui prie, garder la mosquée propre, ne pas y chercher un objet perdu ; le mérite de construire une mosquée et d'y attendre la prière ; les femmes à la mosquée ; la douceur envers celui qui ignore.",
    body="""1. Les mosquées appartiennent à Allah
Allah dit que les mosquées sont à Allah : n'invoquez donc personne avec Lui (sourate al-Jinn, 72:18). Il loue les hommes qui, dans les maisons qu'Allah a permis d'élever, Le glorifient matin et soir, sans que le commerce les détourne de Son rappel ni de la prière (sourate an-Nūr, 24:36-37).
Construire une mosquée : ʿUthmān ibn ʿAffān rapporta que le Prophète ﷺ a dit : celui qui construit une mosquée en recherchant le visage d'Allah, Allah lui construit son équivalent au Paradis (al-Bukhārī n° 450).

2. Venir avec calme
Le Prophète ﷺ a dit :
« {{AR:bukhari:636|إذا سمعتم الإقامة|وما فاتكم فأتموا}} » (idhā samiʿtumu l-iqāmata fa-mshū ilā ṣ-ṣalāh, wa ʿalaykum bi-s-sakīnati wa l-waqār, wa lā tusriʿū, fa-mā adraktum fa-ṣallū, wa mā fātakum fa-atimmū).
Sens : « Quand vous entendez l'iqāma, marchez vers la prière avec calme et dignité, et ne vous précipitez pas : priez ce que vous rattrapez, et complétez ce que vous avez manqué. » (al-Bukhārī n° 636, d'après Abū Hurayra ; hadith authentique).
Pour l'invocation en entrant et en sortant de la mosquée, voir la page des invocations (Muslim n° 713).

3. Deux unités avant de s'asseoir
Le Prophète ﷺ a dit :
« {{AR:bukhari:444|إذا دخل أحدكم المسجد|قبل أن يجلس}} » (idhā dakhala aḥadukumu l-masjida fa-l-yarkaʿ rakʿatayni qabla an yajlis).
Sens : « Quand l'un de vous entre dans la mosquée, qu'il prie deux unités avant de s'asseoir. » (al-Bukhārī n° 444, d'après Abū Qatāda ; hadith authentique).

4. Respecter la mosquée et ceux qui y prient
- L'odeur : le Prophète ﷺ a dit, à propos de l'ail : celui qui en a mangé, qu'il ne s'approche pas de notre mosquée (al-Bukhārī n° 853, d'après Ibn ʿUmar).
- La propreté : cracher dans la mosquée est une faute, et son expiation est de l'enterrer (al-Bukhārī n° 415, d'après Anas).
- L'objet perdu : celui qui entend un homme réclamer à voix haute un objet perdu dans la mosquée, qu'il dise : qu'Allah ne te le rende pas, car les mosquées n'ont pas été construites pour cela (Muslim n° 568, d'après Abū Hurayra).
- Passer devant celui qui prie : si celui qui passe devant celui qui prie savait ce qu'il encourt, il lui serait meilleur d'attendre quarante plutôt que de passer devant lui ; le rapporteur Abū n-Naḍr ne savait plus s'il avait dit quarante jours, mois ou années (al-Bukhārī n° 510, d'après Abū Juhaym).

5. Le mérite d'y rester
Le Prophète ﷺ a dit que les anges prient pour l'un de vous tant qu'il reste à l'endroit où il a prié sans perdre ses ablutions, en disant : ô Allah, pardonne-lui ; ô Allah, fais-lui miséricorde (al-Bukhārī n° 445, d'après Abū Hurayra).

6. Les femmes à la mosquée
Le Prophète ﷺ a dit : n'empêchez pas les servantes d'Allah (d'aller) aux mosquées d'Allah (al-Bukhārī n° 900, d'après Ibn ʿUmar). Et il a dit aux femmes : quand l'une de vous se rend à la mosquée, qu'elle ne se parfume pas (Muslim n° 443, d'après Zaynab, épouse d'Ibn Masʿūd).

7. La douceur envers celui qui ignore
Un bédouin urina dans la mosquée ; les gens se levèrent contre lui. Le Prophète ﷺ dit : laissez-le, et versez sur son urine un seau d'eau ; vous avez été envoyés pour faciliter, et non pour rendre les choses difficiles (al-Bukhārī n° 220, d'après Abū Hurayra).

8. Ce que l'élève peut retenir
- On vient à la mosquée avec calme, sans courir.
- On prie deux unités avant de s'asseoir.
- On n'y vient pas avec une mauvaise odeur, on la garde propre, on n'y réclame pas un objet perdu, on ne passe pas devant celui qui prie.
- Les anges prient pour celui qui reste à sa place après la prière.
- On enseigne avec douceur à celui qui ne sait pas.

Exercice : la prochaine fois que vous entrez dans une mosquée, appliquez ces manières (calme, deux unités, propreté), puis répondez aux questions.""",
    refs=[
        quran(72, 18),
        quran(24, 36, 37),
        coll('bukhari', 450, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Construire une mosquée, d'après ʿUthmān ibn ʿAffān"),
        coll('bukhari', 636, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Venir à la prière avec calme et dignité, d'après Abū Hurayra",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='713a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Invocation en entrant et en sortant de la mosquée", url='https://sunnah.com/muslim:713a'),
        coll('bukhari', 444, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Deux unités avant de s'asseoir, d'après Abū Qatāda",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 853, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Celui qui a mangé de l'ail, d'après Ibn ʿUmar"),
        coll('bukhari', 415, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Cracher dans la mosquée, d'après Anas"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='568a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Réclamer un objet perdu dans la mosquée, d'après Abū Hurayra", url='https://sunnah.com/muslim:568a'),
        coll('bukhari', 510, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Passer devant celui qui prie, d'après Abū Juhaym"),
        coll('bukhari', 445, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Les anges prient pour celui qui reste à sa place, d'après Abū Hurayra"),
        coll('bukhari', 900, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« N'empêchez pas les servantes d'Allah… », d'après Ibn ʿUmar"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='443b',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="La femme qui se rend à la mosquée ne se parfume pas, d'après Zaynab", url='https://sunnah.com/muslim:443b'),
        coll('bukhari', 220, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le bédouin dans la mosquée : « vous avez été envoyés pour faciliter », d'après Abū Hurayra"),
    ],
    questions=[
        ("Comment doit-on marcher vers la prière quand on entend l'iqāma ?", ["Avec calme et dignité, sans se précipiter", "En courant", "Lentement pour arriver après"], 0,
         "Al-Bukhārī n° 636."),
        ("Que fait-on en entrant dans la mosquée, avant de s'asseoir ?", ["On prie deux unités", "On s'allonge", "On parle fort"], 0,
         "Al-Bukhārī n° 444."),
        ("Que dit le Prophète ﷺ à celui qui a mangé de l'ail ?", ["Qu'il ne s'approche pas de notre mosquée", "Qu'il vienne au premier rang", "Rien"], 0,
         "Al-Bukhārī n° 853."),
        ("Quelle est l'expiation du crachat dans la mosquée ?", ["L'enterrer", "Rien", "Jeûner un jour"], 0,
         "Al-Bukhārī n° 415."),
        ("Que dit-on à celui qui réclame un objet perdu dans la mosquée ?", ["Qu'Allah ne te le rende pas", "Je vais t'aider", "Rien"], 0,
         "Muslim n° 568."),
        ("Que font les anges pour celui qui reste à sa place après la prière ?", ["Ils demandent pardon et miséricorde pour lui", "Rien", "Ils le blâment"], 0,
         "Al-Bukhārī n° 445."),
        ("Que dit le hadith sur les femmes et la mosquée ?", ["N'empêchez pas les servantes d'Allah d'aller aux mosquées", "Elles n'y vont jamais", "Elles y vont parfumées"], 0,
         "Al-Bukhārī n° 900 ; Muslim n° 443."),
        ("Comment le Prophète ﷺ réagit-il au bédouin qui urina dans la mosquée ?", ["Avec douceur : laissez-le et versez de l'eau", "Il le chassa", "Il le frappa"], 0,
         "Al-Bukhārī n° 220."),
    ],
)
