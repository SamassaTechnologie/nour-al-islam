LESSON = dict(
    position=4,
    slug='le-shirk',
    title="Le shirk : le contraire du tawḥīd",
    summary="Ce qu'est l'association (shirk), sa gravité d'après le Coran et la Sunna, la différence entre le shirk majeur et le shirk mineur selon Ibn Bāz, avec des exemples : invoquer les morts, l'ostentation, jurer par autre qu'Allah.",
    body="""1. Qu'est-ce que le shirk ?
Le shirk (association) est le contraire du tawḥīd étudié dans la leçon précédente : c'est donner à Allah un égal (nidd) dans ce qui n'appartient qu'à Lui. ʿAbd Allāh ibn Masʿūd demanda au Prophète ﷺ quel péché est le plus grand auprès d'Allah. Il répondit :
« {{AR:bukhari:4477|ان تجعل|خلقك}} » (an tajʿala li-llāhi niddan wa huwa khalaqak).
Sens : « Que tu donnes à Allah un égal, alors que c'est Lui qui t'a créé. » (al-Bukhārī n° 4477 ; hadith authentique).

2. Sa gravité
Abū Bakra rapporte que le Prophète ﷺ demanda trois fois : voulez-vous que je vous informe du plus grand des grands péchés ? Puis il dit : associer à Allah, et désobéir aux parents ; puis il mit en garde contre le faux témoignage (en substance ; al-Bukhārī n° 2654 ; hadith authentique).
Le Coran dit qu'Allah ne pardonne pas qu'on Lui associe quoi que ce soit, et qu'Il pardonne ce qui est moindre à qui Il veut (sourate al-Nisā’, 4:48) ; Luqmān dit à son fils que l'association est une injustice immense (sourate Luqmān, 31:13) ; et Allah dit au Prophète ﷺ que s'il associait, ses œuvres seraient perdues (sourate al-Zumar, 39:65).

3. Le shirk majeur
Selon Ibn Bāz, le shirk majeur consiste à vouer l'adoration, ou une partie de l'adoration, à autre qu'Allah : invoquer les morts, leur demander secours, leur faire des vœux, ou faire cela pour les djinns ou les anges. Il fait sortir de l'islam (fatwa n° 14401).

4. Le shirk mineur
Toujours selon Ibn Bāz, le shirk mineur ne fait pas sortir de l'islam, mais c'est un grave péché. Il donne ces exemples :
- jurer par autre qu'Allah (par le Prophète ﷺ, par la confiance, par la tête de quelqu'un) ;
- l'ostentation (riyā’) : réciter ou donner l'aumône pour être vu ;
- dire « ce qu'Allah a voulu et ce qu'untel a voulu », ou « sans Allah et untel ».
Ibn ʿUmar entendit un homme jurer par la Kaʿba ; il lui dit qu'on ne jure pas par autre qu'Allah, car il avait entendu le Prophète ﷺ dire :
« {{AR:tirmidhi:1535|من حلف بغير الله|او اشرك}} » (man ḥalafa bi-ghayri llāhi fa-qad kafara aw ashrak).
Sens : « Celui qui jure par autre qu'Allah a mécru, ou a associé. » (al-Tirmidhī n° 1535 ; jugé ḥasan par al-Tirmidhī et authentique par al-Albānī). Al-Tirmidhī rapporte que certains savants comprennent cette parole comme une mise en garde sévère (taghlīẓ).
Ibn Bāz précise que ce shirk mineur devient majeur si celui qui jure croit que ce par quoi il jure a un pouvoir sur l'univers en dehors d'Allah, peut nuire ou être utile par lui-même, ou mérite d'être adoré et invoqué.
Au sujet de l'ostentation, le Prophète ﷺ rapporte qu'Allah a dit :
« {{AR:muslim:7475|انا اغني الشركاء|تركته وشركه}} » (ana aghna sh-shurakā’i ʿani sh-shirk, man ʿamila ʿamalan ashraka fīhi maʿī ghayrī taraktuhu wa shirkah).
Sens : « Je suis Celui qui a le moins besoin d'associés. Celui qui fait une œuvre en M'y associant quelqu'un d'autre, Je le laisse, lui et son association. » (Muslim n° 2985 ; hadith authentique).

5. Ce que l'élève peut retenir
- Le shirk est le plus grand des péchés ; Allah ne le pardonne pas à celui qui meurt sans s'en être repenti (4:48).
- Le shirk majeur fait sortir de l'islam ; le shirk mineur non, mais il est très grave.
- On jure seulement par Allah ; on fait ses œuvres pour Allah seul, sans chercher à être vu.

Exercice : expliquez la différence entre le shirk majeur et le shirk mineur avec un exemple de chacun, et répondez aux questions. Pour une situation personnelle, interrogez un savant qualifié.""",
    refs=[
        coll('bukhari', 4477, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Que tu donnes à Allah un égal alors qu'Il t'a créé », d'après Ibn Masʿūd",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 2654, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le plus grand des grands péchés, d'après Abū Bakra"),
        quran(4, 48),
        quran(31, 13),
        quran(39, 65),
        book("Fatwa n° 14401 : « Bayān anwāʿ al-shirk » (les sortes de shirk)", "Ibn Bāz", "Émission Nūr ʿalā al-darb, site officiel du cheikh",
             "https://binbaz.org.sa/fatwas/14401/",
             "Shirk majeur : vouer l'adoration ou une partie à autre qu'Allah ; shirk mineur : jurer par autre qu'Allah, ostentation, « ce qu'Allah a voulu et untel » ; il devient majeur avec une croyance de pouvoir ou d'adoration."),
        coll('tirmidhi', 1535, 'Bon (ḥasan) ; authentique selon al-Albānī', "Al-Tirmidhī ; al-Albānī (jugement affiché sur sunnah.com)",
             "Jurer par autre qu'Allah, d'après Ibn ʿUmar",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api). Al-Tirmidhī rapporte l'explication de certains savants : une mise en garde sévère."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2985',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Je suis Celui qui a le moins besoin d'associés », d'après Abū Hurayra", url='https://sunnah.com/muslim:2985',
             note="Hadith qudsī copié tel quel de l'édition de sunnah.com (base hadith-api)."),
    ],
    questions=[
        ("Quel est le plus grand péché auprès d'Allah selon le hadith d'Ibn Masʿūd ?", ["Donner à Allah un égal alors qu'Il nous a créés", "Mentir", "Manquer une prière"], 0,
         "Al-Bukhārī n° 4477."),
        ("Que dit la sourate al-Nisā’ (4:48) du shirk ?", ["Allah ne pardonne pas qu'on Lui associe, et pardonne ce qui est moindre à qui Il veut", "Il est pardonné à tous", "Ce n'est pas un péché"], 0,
         "Il s'agit de celui qui meurt sans s'être repenti."),
        ("Comment Ibn Bāz définit-il le shirk majeur ?", ["Vouer l'adoration, ou une partie, à autre qu'Allah", "Oublier une invocation", "Mal prononcer une lettre"], 0,
         "Par exemple invoquer les morts ou leur faire des vœux."),
        ("Le shirk mineur fait-il sortir de l'islam selon Ibn Bāz ?", ["Non, mais c'est un grave péché", "Oui, toujours", "Ce n'est pas un péché"], 0,
         "Il peut devenir majeur avec une croyance de pouvoir ou d'adoration."),
        ("Lequel de ces exemples est du shirk mineur ?", ["Jurer par la tête de quelqu'un, sans croyance particulière", "Invoquer un mort pour obtenir un enfant", "Faire un vœu à une tombe"], 0,
         "Les deux autres exemples sont du shirk majeur selon Ibn Bāz."),
        ("Que fait Allah de l'œuvre faite pour Lui et pour un autre, selon le hadith qudsī ?", ["Il la laisse, avec son association", "Il l'accepte", "Il la double"], 0,
         "Muslim n° 2985."),
        ("Comment certains savants comprennent-ils « a mécru ou a associé » dans le hadith sur le serment ?", ["Comme une mise en garde sévère", "Comme une sortie de l'islam dans tous les cas", "Comme une permission"], 0,
         "Al-Tirmidhī le rapporte après le hadith n° 1535 ; Ibn Bāz classe ce serment dans le shirk mineur, sauf croyance particulière."),
    ],
)
