LESSON = dict(
    position=17,
    slug='la-priere-pour-demander-la-pluie-salat-al-istisqa',
    title="La prière pour demander la pluie (ṣalāt al-istisqā’)",
    summary="Quand la pluie manque : sortir humblement vers le lieu de prière, invoquer en levant les mains, retourner son manteau, prier deux unités à voix haute. Son jugement (sunna selon la majorité ; invocation seulement selon Abū Ḥanīfa), les takbīr (deux avis), l'invocation pendant le sermon du vendredi et ce que l'on dit quand il pleut.",
    body="""1. Son jugement
La prière pour la pluie est une sunna : avis de la majorité (malikites, shafiʿites, hanbalites, et Abū Yūsuf et Muḥammad, élèves d'Abū Ḥanīfa) ; son caractère légal est rapporté comme un accord. Abū Ḥanīfa disait qu'il n'y a pas de prière propre à la demande de pluie, mais seulement l'invocation ; an-Nawawī et ash-Shawkānī disent que lui seul a tenu cet avis (Dorar, n° 1844).

2. Sortir humblement
Ibn ʿAbbās dit que le Prophète ﷺ sortit en habits simples, avec humilité et en suppliant, jusqu'au lieu de prière ; il ne cessa d'invoquer, de supplier et de dire « Allāhu akbar », puis il pria deux unités comme il prie à l'Aïd (Abū Dāwūd n° 1165 ; ḥasan selon al-Albānī).

3. La manière
ʿAbd Allāh ibn Zayd dit que le Prophète ﷺ :
« {{AR:bukhari:1012|خرج إلى المصلى|وصلى ركعتين}} » (kharaja ilā l-muṣallā fa-stasqā, fa-staqbala l-qiblata, wa qalaba ridā’ahu, wa ṣallā rakʿatayn).
Sens : « sortit vers le lieu de prière, demanda la pluie, se tourna vers la qibla, retourna son manteau et pria deux unités. » (al-Bukhārī n° 1012 ; hadith authentique).
Il récita à voix haute dans ces deux unités (al-Bukhārī n° 1024).
En levant les mains pour demander la pluie, il tourna le dos de ses mains vers le ciel (Muslim n° 895).
Les takbīr supplémentaires : deux avis.
- comme à l'Aïd (sept et cinq) : avis d'ash-Shāfiʿī (al-Alūka, « Ṣalāt al-istisqā’ ») ; c'est aussi la manière décrite par Ibn Bāz (Dorar, n° 1743, citant Fatāwā Nūr ʿalā d-darb) ;
- comme dans les autres prières, sans takbīr supplémentaires : avis de Mālik (al-Alūka, même article).
Le sermon : il est rapporté avant la prière et après ; les deux sont de la sunna (ar-Rawḍa an-nadiyya de Ṣiddīq Ḥasan Khān).

4. Demander la pluie pendant le sermon du vendredi
Un homme entra pendant que le Prophète ﷺ faisait le sermon du vendredi et dit que les troupeaux périssaient et que les chemins étaient coupés. Le Prophète ﷺ leva les mains et dit, trois fois :
« {{AR:bukhari:1014|اللهم|أغثنا}} » (allāhumma aghithnā).
Sens : « Ô Allah, secours-nous ! » (al-Bukhārī n° 1014 ; hadith authentique).
Anas dit qu'il n'y avait aucun nuage ; un nuage apparut, s'étendit et il plut. Le vendredi suivant, on lui demanda d'arrêter la pluie, et il demanda qu'elle tombe autour d'eux et non sur eux (même référence).

5. Quand il pleut
Quand il voyait la pluie, il disait :
« {{AR:bukhari:1032|صيبا|نافعا}} » (ṣayyiban nāfiʿā).
Sens : « Une pluie abondante et utile ! » (al-Bukhārī n° 1032 ; hadith authentique).

6. Ce que l'élève peut retenir
- Demander la pluie est une sunna ; la prière, selon la majorité.
- Sortir humblement, invoquer, se tourner vers la qibla, retourner son manteau.
- Deux unités à voix haute ; takbīr comme à l'Aïd selon ash-Shāfiʿī, sans selon Mālik.
- On peut aussi demander la pluie pendant le sermon du vendredi.
- Quand il pleut : « ṣayyiban nāfiʿā ».

Exercice : apprenez par cœur « allāhumma aghithnā » et « ṣayyiban nāfiʿā ». Puis répondez aux questions.""",
    refs=[
        book("Encyclopédie de fiqh : le jugement de la prière pour la pluie", "Dorar (ad-Durar as-Saniyya)", "Section n° 1844",
             "https://dorar.net/feqhia/1844",
             "Sunna selon la majorité ; Abū Ḥanīfa : invocation sans prière (an-Nawawī, Sharḥ Muslim 6/187 ; ash-Shawkānī, Nayl al-awṭār 4/9)."),
        coll('abudawud', 1165, 'Ḥasan (al-Albānī) ; ḥasan ṣaḥīḥ (Shuʿayb al-Arnaʾūṭ)', "Jugements affichés sur sunnah.com",
             "Sortir humblement et prier comme à l'Aïd, d'après Ibn ʿAbbās"),
        coll('bukhari', 1012, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Se tourner vers la qibla, retourner le manteau, prier deux unités, d'après ʿAbd Allāh ibn Zayd",
             "Texte copié tel quel de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 1024, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "La récitation à voix haute, d'après ʿAbd Allāh ibn Zayd"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='895b',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Le dos des mains vers le ciel, d'après Anas", url='https://sunnah.com/muslim:895b'),
        book("Ṣalāt al-istisqā'", "al-Alūka", "Article n° 74835",
             "https://www.alukah.net/zoulghina/11718/74835/",
             "Récitation à voix haute par accord ; takbīr comme à l'Aïd selon ash-Shāfiʿī, comme les autres prières selon Mālik."),
        book("Encyclopédie de fiqh : les takbīr supplémentaires", "Dorar (ad-Durar as-Saniyya)", "Section n° 1743",
             "https://dorar.net/feqhia/1743",
             "Ibn Bāz (Fatāwā Nūr ʿalā d-darb 13/399) : la prière de la pluie comme celle de l'Aïd, sept et cinq takbīr."),
        book("ar-Rawḍa an-nadiyya : la prière pour la pluie", "Ṣiddīq Ḥasan Khān (commentaire d'ad-Durar al-bahiyya d'ash-Shawkānī)",
             "Livre de la prière (Wikisource arabe)",
             "https://ar.wikisource.org/wiki/الروضة_الندية_شرح_الدرر_البهية/كتاب_الصلاة/باب_صلاة_الإستسقاء",
             "Sunna en cas de sécheresse ; sermon rapporté avant et après la prière."),
        coll('bukhari', 1014, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Allāhumma aghithnā » pendant le sermon du vendredi, d'après Anas",
             "Invocation copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 1032, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Ṣayyiban nāfiʿā » quand il pleut, d'après ʿĀ'isha",
             "Invocation copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
    ],
    questions=[
        ("Selon la majorité, quel est le jugement de la prière pour la pluie ?", ["Une sunna", "Une obligation pour chacun", "Une innovation"], 0,
         "Dorar n° 1844."),
        ("Que disait Abū Ḥanīfa ?", ["On demande la pluie par l'invocation, sans prière propre", "Elle est obligatoire", "Elle se prie quatre unités"], 0,
         "Dorar n° 1844."),
        ("Comment le Prophète ﷺ sortit-il pour demander la pluie ?", ["En habits simples, avec humilité", "En habits de fête", "À cheval avec une armée"], 0,
         "Abū Dāwūd n° 1165."),
        ("Que fit-il de son manteau ?", ["Il le retourna", "Il le jeta", "Il le donna"], 0,
         "Al-Bukhārī n° 1012."),
        ("Combien d'unités, et comment est la récitation ?", ["Deux unités, à voix haute", "Quatre unités, à voix basse", "Une unité, sans récitation"], 0,
         "Al-Bukhārī n° 1012 et 1024."),
        ("Que dit-il pendant le sermon du vendredi pour la pluie ?", ["Allāhumma aghithnā, trois fois", "Ghufrānak", "Subḥāna llāh"], 0,
         "Al-Bukhārī n° 1014."),
        ("Que dit-on quand il pleut ?", ["Ṣayyiban nāfiʿā", "Astaghfiru llāh", "Rien"], 0,
         "Al-Bukhārī n° 1032."),
        ("Y a-t-il des takbīr comme à l'Aïd ?", ["Deux avis : oui selon ash-Shāfiʿī, non selon Mālik", "Tous disent oui", "Tous disent non"], 0,
         "Al-Alūka, « Ṣalāt al-istisqā’ »."),
    ],
)
