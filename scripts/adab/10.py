LESSON = dict(
    position=10,
    slug='l-honnetete-dans-le-commerce-et-le-respect-des-engagements',
    title="L'honnêteté dans le commerce et le respect des engagements",
    summary="Allah ordonne de respecter les engagements et de rendre les dépôts. Les signes de l'hypocrite ; la bénédiction de la vente honnête et la perte de celle qui cache ; « celui qui trompe n'est pas des miens » ; le serment qui fait vendre et efface la bénédiction ; la tolérance dans la vente, et les dettes.",
    body="""1. Respecter ses engagements et rendre les dépôts
Allah ordonne aux croyants de remplir leurs engagements (sourate al-Mā’ida, 5:1) et de tenir leur promesse, car on en sera interrogé (sourate al-Isrā’, 17:34). Il ordonne de rendre les dépôts à leurs ayants droit (sourate an-Nisā’, 4:58). Et Il menace ceux qui trichent sur la mesure et le poids (sourate al-Muṭaffifīn, 83:1-3).

2. Les signes de l'hypocrite
Le Prophète ﷺ a dit :
« {{AR:bukhari:33|آية المنافق|اؤتمن خان}} » (āyatu l-munāfiqi thalāth : idhā ḥaddatha kadhab, wa idhā waʿada akhlaf, wa idhā u’tumina khān).
Sens : « Les signes de l'hypocrite sont trois : quand il parle, il ment ; quand il promet, il ne tient pas ; et quand on lui confie un dépôt, il trahit. » (al-Bukhārī n° 33, d'après Abū Hurayra ; hadith authentique).

3. La vente honnête est bénie
Le Prophète ﷺ a dit que l'acheteur et le vendeur ont le choix (de garder ou d'annuler la vente) tant qu'ils ne se sont pas séparés, puis :
« {{AR:bukhari:2079|فإن صدقا|بركة بيعهما}} » (fa-in ṣadaqā wa bayyanā būrika lahumā fī bayʿihimā, wa in katamā wa kadhabā muḥiqat barakatu bayʿihimā).
Sens : « S'ils disent la vérité et montrent (les défauts), leur vente est bénie ; et s'ils cachent et mentent, la bénédiction de leur vente est effacée. » (al-Bukhārī n° 2079, d'après Ḥakīm ibn Ḥizām ; hadith authentique).
Le serment : le Prophète ﷺ a dit que le serment fait vendre la marchandise mais efface la bénédiction (al-Bukhārī n° 2087, d'après Abū Hurayra).

4. « Celui qui trompe n'est pas des miens »
Le Prophète ﷺ passa près d'un tas de nourriture ; il y plongea la main et ses doigts touchèrent de l'humidité. Il demanda : qu'est-ce que cela, ô vendeur ? L'homme répondit : la pluie l'a touché, ô Messager d'Allah. Il dit :
« {{AR:muslim:284|أفلا جعلته|فليس مني}} » (a-fa-lā jaʿaltahu fawqa ṭ-ṭaʿāmi kay yarāhu n-nās, man ghashsha fa-laysa minnī).
Sens : « Pourquoi ne l'as-tu pas mis au-dessus de la nourriture, pour que les gens le voient ? Celui qui trompe n'est pas des miens. » (Muslim n° 102, d'après Abū Hurayra ; hadith authentique).

5. La tolérance et les dettes
Le Prophète ﷺ a dit : qu'Allah fasse miséricorde à un homme tolérant quand il vend, quand il achète et quand il réclame son dû (al-Bukhārī n° 2076, d'après Jābir ibn ʿAbd Allāh).
Il a dit aussi : celui qui prend l'argent des gens avec l'intention de le rendre, Allah le rendra pour lui ; et celui qui le prend avec l'intention de le perdre, Allah le perdra (al-Bukhārī n° 2387, d'après Abū Hurayra). Et : le retard du riche à payer (sa dette) est une injustice (al-Bukhārī n° 2400, d'après Abū Hurayra).

6. Ce que l'élève peut retenir
- On respecte ses engagements, on tient ses promesses et on rend les dépôts.
- Mentir, manquer à sa promesse et trahir la confiance sont des signes de l'hypocrite.
- Le commerçant honnête montre les défauts de sa marchandise ; sa vente est bénie.
- Tromper n'est pas le comportement du musulman ; le serment pour vendre efface la bénédiction.
- On est tolérant dans les affaires, et on rembourse ses dettes sans retard quand on le peut.

Exercice : pensez à une promesse ou à une dette que vous n'avez pas encore réglée et fixez-vous une date pour la régler, puis répondez aux questions.""",
    refs=[
        quran(5, 1),
        quran(17, 34),
        quran(4, 58),
        quran(83, 1, 3),
        coll('bukhari', 33, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Les trois signes de l'hypocrite, d'après Abū Hurayra",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 2079, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "La vente honnête est bénie, d'après Ḥakīm ibn Ḥizām",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 2087, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le serment qui fait vendre et efface la bénédiction, d'après Abū Hurayra"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='102',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Celui qui trompe n'est pas des miens », d'après Abū Hurayra", url='https://sunnah.com/muslim:102',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 2076, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "La tolérance dans la vente et l'achat, d'après Jābir"),
        coll('bukhari', 2387, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Prendre l'argent des gens avec l'intention de le rendre, d'après Abū Hurayra"),
        coll('bukhari', 2400, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le retard du riche à payer est une injustice, d'après Abū Hurayra"),
    ],
    questions=[
        ("Que doit-on faire des dépôts qu'on nous confie ?", ["Les rendre à leurs ayants droit", "Les garder", "Les dépenser"], 0,
         "Sourate an-Nisā’, 4:58."),
        ("Lequel de ces actes est un signe de l'hypocrite ?", ["Ne pas tenir sa promesse", "Rendre un dépôt", "Dire la vérité"], 0,
         "Al-Bukhārī n° 33."),
        ("Quand la vente est-elle bénie selon le hadith de Ḥakīm ibn Ḥizām ?", ["Quand les deux disent la vérité et montrent les défauts", "Quand le vendeur cache les défauts", "Quand le prix est élevé"], 0,
         "Al-Bukhārī n° 2079."),
        ("Que fait le serment pour vendre une marchandise ?", ["Il fait vendre mais efface la bénédiction", "Il augmente la bénédiction", "Il est recommandé"], 0,
         "Al-Bukhārī n° 2087."),
        ("Qu'a dit le Prophète ﷺ au vendeur qui cachait la nourriture mouillée ?", ["Celui qui trompe n'est pas des miens", "C'est permis", "Vends-la plus cher"], 0,
         "Muslim n° 102."),
        ("Pour qui le Prophète ﷺ a-t-il demandé la miséricorde d'Allah ?", ["L'homme tolérant quand il vend, achète et réclame son dû", "L'homme dur en affaires", "Celui qui ne vend jamais"], 0,
         "Al-Bukhārī n° 2076."),
        ("Que fait Allah pour celui qui emprunte avec l'intention de rendre ?", ["Il le rend pour lui", "Rien", "Il le punit"], 0,
         "Al-Bukhārī n° 2387."),
        ("Comment le hadith qualifie-t-il le retard du riche à payer sa dette ?", ["Une injustice", "Une bonne chose", "Une prudence"], 0,
         "Al-Bukhārī n° 2400."),
    ],
)
