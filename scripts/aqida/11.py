LESSON = dict(
    position=11,
    slug='les-annulatifs-de-l-islam',
    title="Les dix annulatifs de l'islam",
    summary="Les dix choses qui font sortir de l'islam, citées par Muḥammad ibn ʿAbd al-Wahhāb et expliquées par Ibn Bāz, apprises pour s'en préserver soi-même ; avec la mise en garde contre le fait de juger les gens soi-même.",
    body="""1. Pourquoi apprendre cette leçon ?
Ibn Bāz explique qu'Allah a obligé tous les hommes à entrer dans l'islam, à s'y attacher et à se garder de ce qui le contredit. Les savants ont mentionné qu'un musulman peut sortir de sa religion par de nombreux annulatifs (nawāqiḍ) ; parmi les plus graves et les plus fréquents, il y en a dix, cités par Muḥammad ibn ʿAbd al-Wahhāb et d'autres savants. Ibn Bāz dit qu'il les présente pour que le musulman s'en garde et en préserve les autres, en espérant le salut. Le but de cette leçon est donc de se protéger soi-même, pas de juger les gens.

2. Les dix annulatifs (d'après Ibn Bāz)
1) Le shirk dans l'adoration d'Allah : par exemple invoquer les morts, leur demander secours, leur faire des vœux ou leur sacrifier des bêtes (4:48 ; 5:72 ; voir la leçon sur le shirk).
2) Mettre entre soi et Allah des intermédiaires qu'on invoque, à qui on demande l'intercession et sur qui on s'appuie. Ibn Bāz rapporte que c'est de la mécréance par consensus des savants.
3) Ne pas considérer comme mécréants les polythéistes, douter de leur mécréance, ou juger leur croyance correcte.
4) Croire qu'une autre guidance est plus parfaite que celle du Prophète ﷺ, ou qu'un autre jugement est meilleur que le sien.
5) Détester une chose que le Messager ﷺ a apportée, même si on la pratique (sourate Muḥammad, 47:9).
6) Se moquer d'une chose de la religion du Messager ﷺ, de sa récompense ou de son châtiment (sourate al-Tawba, 9:65-66).
7) La sorcellerie : la pratiquer ou l'accepter (sourate al-Baqara, 2:102).
8) Soutenir les polythéistes et les aider contre les musulmans (sourate al-Māʾida, 5:51).
9) Croire que certaines personnes peuvent se passer de la législation de Muḥammad ﷺ (sourate Āl ʿImrān, 3:85).
10) Se détourner de la religion d'Allah : ne pas l'apprendre et ne pas la pratiquer (sourate al-Sajda, 32:22).
Ibn Bāz ajoute qu'il n'y a pas de différence, pour ces annulatifs, entre celui qui plaisante, celui qui est sérieux et celui qui a peur, sauf celui qui est contraint (voir sourate al-Naḥl, 16:106). Il conclut que le musulman doit s'en garder et les craindre pour lui-même.

3. Ne pas se presser de juger les autres
a) Le Prophète ﷺ a dit :
« {{AR:bukhari:6104|أيما رجل قال لأخيه|باء بها أحدهما}} » (ayyumā rajulin qāla li-akhīhi : yā kāfir, fa-qad bā’a bihā aḥaduhumā).
Sens : « Quiconque dit à son frère : « Ô mécréant ! », l'un des deux en porte la charge. » (al-Bukhārī n° 6104, d'après Ibn ʿUmar ; hadith authentique).
b) Ibn Taymiyya a écrit qu'une parole peut être de la mécréance, et qu'on dit d'une manière générale : celui qui dit cela est mécréant ; mais que la personne précise n'est pas jugée mécréante tant que l'argument (al-ḥujja) ne lui a pas été établi. Interrogé sur cette parole, Ibn Bāz a répondu que c'est la position correcte, en précisant qu'on explique d'abord à celui qui ignore, par exemple s'il vit loin des musulmans (fatwa n° 17382).
c) Les savants ont étudié en détail quand l'ignorance excuse et quand elle n'excuse pas. Ibn Bāz, par exemple, considère que celui qui vit parmi les musulmans et a entendu le Coran n'est pas excusé dans les questions du tawḥīd (fatwa n° 2351). C'est une question délicate. Juger une personne précise et en tirer les conséquences relève des savants, des juges et des autorités légitimes, comme le dit Ibn Bāz dans cette même fatwa, et non de l'élève ni du simple musulman.

4. Ce que l'élève peut retenir
- On apprend les dix annulatifs pour s'en préserver soi-même et protéger les autres.
- Plaisanterie, sérieux ou peur ne changent rien, sauf la contrainte.
- On ne dit pas à un musulman « mécréant » : l'un des deux en porterait la charge.
- Juger une personne précise relève des savants et des autorités légitimes.

Exercice : citez les dix annulatifs avec la preuve de ceux qui en ont une, puis répondez aux questions. Pour toute situation précise, interrogez un savant qualifié.""",
    refs=[
        dict(kind='book', source_title="Nawāqiḍ al-islām (les annulatifs de l'islam), avec explications", author="Ibn Bāz, d'après Muḥammad ibn ʿAbd al-Wahhāb",
             locator="Article n° 20 du site officiel du cheikh Ibn Bāz",
             url="https://binbaz.org.sa/articles/20/نواقض-الاسلام",
             note="Les dix annulatifs avec leurs preuves ; pas de différence entre plaisanterie, sérieux et peur, sauf la contrainte ; ce sont parmi les plus graves et les plus fréquents ; le musulman doit s'en garder et les craindre pour lui-même."),
        quran(4, 48),
        quran(5, 72),
        quran(47, 9),
        quran(9, 65, 66),
        quran(2, 102),
        quran(5, 51),
        quran(3, 85),
        quran(32, 22),
        quran(16, 106),
        coll('bukhari', 6104, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Quiconque dit à son frère : ô mécréant », d'après Ibn ʿUmar",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        book("Fatwa n° 17382 : « Ḥukm man irtakaba amran jāhilan yukaffaru fāʿiluh » (celui qui commet par ignorance un acte de mécréance)", "Ibn Bāz", "Site officiel du cheikh, émission Nūr ʿalā al-darb",
             "https://binbaz.org.sa/fatwas/17382/",
             "Approuve la parole d'Ibn Taymiyya : une parole peut être de la mécréance, mais la personne précise n'est jugée mécréante qu'une fois l'argument établi ; on explique d'abord à celui qui ignore."),
        book("Fatwa n° 2351 : « Umūr al-tawḥīd… lā ʿudhra fīhā » (les questions du tawḥīd, sans excuse)", "Ibn Bāz", "Site officiel du cheikh",
             "https://binbaz.org.sa/fatwas/2351/",
             "Celui qui vit parmi les musulmans et a entendu le Coran n'est pas excusé dans les questions du tawḥīd ; celui qui vit loin des musulmans relève du jugement d'Allah ; les conséquences relèvent des autorités légitimes."),
    ],
    questions=[
        ("Pourquoi apprend-on les annulatifs de l'islam, selon Ibn Bāz ?", ["Pour s'en garder soi-même et en préserver les autres", "Pour juger les gens", "Pour polémiquer"], 0,
         "Introduction d'Ibn Bāz."),
        ("Quel est le premier des dix annulatifs ?", ["Le shirk dans l'adoration d'Allah", "Oublier une prière", "Manger en Ramaḍān par oubli"], 0,
         "Sourate al-Nisā’, 4:48."),
        ("Se moquer d'une chose de la religion, est-ce grave ?", ["Oui, c'est un annulatif de l'islam", "Non, si c'est pour rire", "Seulement en public"], 0,
         "Sourate al-Tawba, 9:65-66 ; la plaisanterie ne change rien."),
        ("Qui n'est pas concerné, selon Ibn Bāz, quand il prononce une parole de mécréance ?", ["Celui qui est contraint", "Celui qui plaisante", "Celui qui a peur d'être critiqué"], 0,
         "Voir sourate al-Naḥl, 16:106."),
        ("Que dit le hadith d'al-Bukhārī n° 6104 ?", ["Celui qui dit à son frère « ô mécréant », l'un des deux en porte la charge", "On peut traiter quelqu'un de mécréant librement", "Rien sur ce sujet"], 0,
         "D'après Ibn ʿUmar."),
        ("Selon Ibn Taymiyya, approuvé par Ibn Bāz, quand juge-t-on une personne précise mécréante ?", ["Après que l'argument lui a été établi", "Dès qu'on la soupçonne", "Jamais, quoi qu'elle fasse"], 0,
         "Fatwa n° 17382 d'Ibn Bāz."),
        ("Qui juge une personne précise et en tire les conséquences ?", ["Les savants, les juges et les autorités légitimes", "N'importe quel musulman", "Les réseaux sociaux"], 0,
         "Ibn Bāz, fatwa n° 2351."),
        ("Se détourner de la religion sans l'apprendre ni la pratiquer est :", ["Le dixième annulatif", "Une chose sans importance", "Un acte recommandé"], 0,
         "Sourate al-Sajda, 32:22."),
    ],
)
