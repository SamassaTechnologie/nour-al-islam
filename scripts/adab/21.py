LESSON = dict(
    position=21,
    slug='le-bon-usage-du-temps-et-de-la-sante',
    title="Le bon usage du temps et de la santé",
    summary="Par le Temps ! L'homme est en perte, sauf ceux qui croient et font le bien. Deux bienfaits que beaucoup gaspillent : la santé et le temps libre ; on sera interrogé sur sa vie, sa science, ses biens et son corps ; être dans ce monde comme un voyageur ; rechercher ce qui est utile, laisser ce qui ne nous regarde pas ; l'acte régulier même petit.",
    body="""1. Le temps dans le Coran
Allah jure par le Temps : l'homme est en perdition, sauf ceux qui croient, font de bonnes œuvres, s'enjoignent mutuellement la vérité et la patience (sourate al-ʿAṣr, 103:1-3). Pensiez-vous que Nous vous avions créés sans but ? (sourate al-Mu’minūn, 23:115). Et Allah dira aux gens du Feu : ne vous avons-Nous pas donné une vie assez longue pour que celui qui voulait réfléchir réfléchisse ? (sourate Fāṭir, 35:37).

2. Deux bienfaits gaspillés
Le Prophète ﷺ a dit :
« {{AR:bukhari:6412|نعمتان مغبون|الصحة والفراغ}} » (niʿmatāni maghbūnun fīhimā kathīrun mina n-nās : aṣ-ṣiḥḥatu wa l-farāgh).
Sens : « Il y a deux bienfaits que beaucoup de gens gaspillent : la santé et le temps libre. » (al-Bukhārī n° 6412, d'après Ibn ʿAbbās ; hadith authentique).

3. On sera interrogé
Le Prophète ﷺ a dit :
« {{AR:tirmidhi:2417|لا تزول قدما عبد|فيما أبلاه}} » (lā tazūlu qadamā ʿabdin yawma l-qiyāmati ḥattā yus’ala ʿan ʿumrihi fīmā afnāh, wa ʿan ʿilmihi fīmā faʿal, wa ʿan mālihi min ayna ktasabahu wa fīmā anfaqah, wa ʿan jismihi fīmā ablāh).
Sens : « Les pieds du serviteur ne bougeront pas au Jour de la Résurrection avant qu'il soit interrogé sur sa vie, à quoi il l'a passée ; sur sa science, ce qu'il en a fait ; sur ses biens, d'où il les a gagnés et à quoi il les a dépensés ; et sur son corps, à quoi il l'a usé. » (al-Tirmidhī n° 2417, d'après Abū Barza al-Aslamī ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir ; jugé faible par Zubayr ʿAlī Zaʾī).

4. Comme un voyageur
Le Prophète ﷺ prit Ibn ʿUmar par l'épaule et lui dit : sois dans ce monde comme un étranger ou un passant. Ibn ʿUmar disait : le soir, n'attends pas le matin ; le matin, n'attends pas le soir ; prends de ta santé pour ta maladie, et de ta vie pour ta mort (al-Bukhārī n° 6416 ; voir la leçon sur le hadith 40 des Quarante d'an-Nawawī). La dernière partie est une parole d'Ibn ʿUmar.

5. Rechercher l'utile et la régularité
Le Prophète ﷺ a dit : le croyant fort est meilleur et plus aimé d'Allah que le croyant faible, et en chacun il y a du bien ; recherche avec ardeur ce qui t'est utile, demande l'aide d'Allah et ne baisse pas les bras (Muslim n° 2664, d'après Abū Hurayra).
Il a dit aussi : fait partie du bon islam de l'homme le fait de délaisser ce qui ne le concerne pas (al-Tirmidhī n° 2317, d'après Abū Hurayra ; « gharīb » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir, jugé faible par Zubayr ʿAlī Zaʾī ; voir la leçon sur le hadith 12 des Quarante d'an-Nawawī).
Et : l'acte le plus aimé d'Allah est le plus régulier, même s'il est petit (al-Bukhārī n° 6464, d'après ʿĀ’isha).

6. Ce que l'élève peut retenir
- Le temps et la santé sont des bienfaits dont on rendra compte.
- On profite de sa santé avant la maladie et de sa vie avant la mort.
- On recherche ce qui est utile et on laisse ce qui ne nous regarde pas.
- Un petit acte régulier vaut mieux qu'un grand acte abandonné.

Exercice : notez pendant une journée comment vous utilisez votre temps, puis choisissez une petite bonne habitude régulière (par exemple une page de Coran chaque jour), puis répondez aux questions.""",
    refs=[
        quran(103, 1, 3),
        quran(23, 115),
        quran(35, 37),
        coll('bukhari', 6412, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Deux bienfaits gaspillés : la santé et le temps libre, d'après Ibn ʿAbbās",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('tirmidhi', 2417, 'Ḥasan ṣaḥīḥ (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir) ; faible (Zubayr ʿAlī Zaʾī)', "Jugements affichés sur sunnah.com",
             "Les quatre questions du Jour de la Résurrection, d'après Abū Barza al-Aslamī",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6416, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Sois dans ce monde comme un étranger » et la parole d'Ibn ʿUmar"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2664',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Le croyant fort ; « recherche ce qui t'est utile », d'après Abū Hurayra", url='https://sunnah.com/muslim:2664'),
        coll('tirmidhi', 2317, 'Gharīb (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir) ; faible (Zubayr ʿAlī Zaʾī)', "Jugements affichés sur sunnah.com",
             "Délaisser ce qui ne nous concerne pas, d'après Abū Hurayra"),
        coll('bukhari', 6464, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "L'acte le plus aimé d'Allah est le plus régulier, d'après ʿĀ’isha"),
    ],
    questions=[
        ("Qui n'est pas en perdition selon la sourate al-ʿAṣr ?", ["Ceux qui croient, font le bien et s'enjoignent la vérité et la patience", "Les riches", "Tout le monde"], 0,
         "Sourate al-ʿAṣr, 103:1-3."),
        ("Quels sont les deux bienfaits que beaucoup de gens gaspillent ?", ["La santé et le temps libre", "L'argent et la maison", "Le sommeil et la nourriture"], 0,
         "Al-Bukhārī n° 6412."),
        ("Sur quoi le serviteur sera-t-il interrogé selon le hadith d'Abū Barza ?", ["Sa vie, sa science, ses biens et son corps", "Seulement ses biens", "Rien"], 0,
         "Al-Tirmidhī n° 2417."),
        ("Les savants sont-ils d'accord sur le degré de ce hadith d'Abū Barza ?", ["Non : authentique selon al-Albānī, faible selon Zubayr ʿAlī Zaʾī", "Oui, tous le jugent faible", "Il est dans al-Bukhārī"], 0,
         "Al-Tirmidhī n° 2417."),
        ("Comment le Prophète ﷺ conseilla-t-il à Ibn ʿUmar d'être dans ce monde ?", ["Comme un étranger ou un passant", "Comme un roi", "Comme s'il ne devait jamais mourir"], 0,
         "Al-Bukhārī n° 6416."),
        ("Que faut-il rechercher avec ardeur selon le hadith du croyant fort ?", ["Ce qui nous est utile", "Ce qui amuse", "Rien"], 0,
         "Muslim n° 2664."),
        ("Que fait partie du bon islam de l'homme ?", ["Délaisser ce qui ne le concerne pas", "Se mêler de tout", "Parler beaucoup"], 0,
         "Al-Tirmidhī n° 2317."),
        ("Quel acte Allah aime-t-Il le plus ?", ["Le plus régulier, même petit", "Le plus grand fait une seule fois", "Celui qu'on montre aux gens"], 0,
         "Al-Bukhārī n° 6464."),
    ],
)
