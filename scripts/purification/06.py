LESSON = dict(
    position=6,
    slug='les-ablutions-seches-at-tayammum',
    title="Les ablutions sèches (at-tayammum)",
    summary="Quand l'eau manque ou qu'on ne peut pas l'utiliser, on se purifie avec la terre. La terre a été rendue pure pour cette communauté ; le tayammum remplace aussi le grand lavage. La manière enseignée à ʿAmmār : une frappe, le visage et les mains ; la divergence des écoles (une ou deux frappes, mains ou avant-bras).",
    body="""1. Un allègement d'Allah
Allah dit : si vous êtes malades, ou en voyage, ou si l'un de vous revient du lieu d'aisance, ou si vous avez touché les femmes, et que vous ne trouvez pas d'eau, recourez à une terre pure, et passez-en sur vos visages et vos mains ; Allah ne veut pas vous imposer de gêne (sourate al-Mā’ida, 5:6 ; voir aussi an-Nisā’, 4:43).
Le Prophète ﷺ a dit qu'il a reçu cinq choses qu'aucun prophète avant lui n'avait reçues, dont :
« {{AR:bukhari:335|وجعلت لي الأرض|مسجدا وطهورا}} » (wa juʿilat liya l-arḍu masjidan wa ṭahūrā).
Sens : « La terre a été faite pour moi lieu de prière et moyen de purification. » (al-Bukhārī n° 335, d'après Jābir ibn ʿAbd Allāh ; hadith authentique).

2. Quand fait-on le tayammum ?
- Quand on ne trouve pas d'eau (5:6).
- Quand on ne peut pas l'utiliser, par maladie ou par crainte d'un danger (5:6). ʿAmr ibn al-ʿĀṣ, en état d'impureté majeure par une nuit très froide, craignit de mourir s'il se lavait ; il fit le tayammum et dirigea la prière ; le Prophète ﷺ, informé de son explication, sourit et ne dit rien (Abū Dāwūd n° 334 ; authentique selon al-Albānī).
- Il remplace aussi le grand lavage : à un homme en état d'impureté majeure qui n'avait pas d'eau, le Prophète ﷺ dit : prends la terre, cela te suffit (al-Bukhārī n° 344, d'après ʿImrān ibn Ḥuṣayn).

3. La manière enseignée à ʿAmmār
ʿAmmār ibn Yāsir, en état d'impureté majeure sans eau, s'était roulé dans la terre. Le Prophète ﷺ lui dit : « Cela t'aurait suffi ainsi », puis il frappa la terre de ses paumes, souffla dessus, et s'en passa sur le visage et les mains (al-Bukhārī n° 338).
Cheikh Ibn Bāz explique que la manière prescrite est une seule frappe pour le visage et les mains, avec une terre pure, sans essuyer les avant-bras (binbaz.org.sa, fatwas n° 1548 et 12683).

4. La divergence des écoles
- Deux frappes, l'une pour le visage et l'autre pour les mains jusqu'aux coudes : avis des ḥanafites et des shāfiʿites ;
- une seule frappe, et les mains jusqu'aux poignets : avis des mālikites et des ḥanbalites, pour qui aller jusqu'aux coudes est recommandé (d'après fiqh.islamonline.net).
Ibn Ḥajar remarque que seuls les hadiths de ʿAmmār et d'Abū Juhaym sont authentiques sur la manière du tayammum (cité par fiqh.islamonline.net), et ash-Shawkānī juge faibles les hadiths des deux frappes (même source).

5. Ce que le tayammum permet
Selon Ibn Bāz, le tayammum remplace l'eau pour lever l'impureté, selon l'avis le plus juste : on peut prier avec lui les prières obligatoires et surérogatoires tant qu'on n'a pas perdu sa pureté, ou jusqu'à ce qu'on trouve de l'eau, ou qu'on puisse de nouveau l'utiliser (binbaz.org.sa, fatwa n° 1548).

6. Ce que l'élève peut retenir
- Le tayammum se fait quand l'eau manque ou ne peut pas être utilisée.
- Il remplace les ablutions et le grand lavage.
- Selon le hadith de ʿAmmār : une frappe de la terre, puis le visage et les mains.
- Les écoles divergent sur le nombre de frappes et la limite des mains.

Exercice : décrivez le tayammum selon le hadith de ʿAmmār, puis citez les deux avis des écoles, puis répondez aux questions.""",
    refs=[
        quran(5, 6),
        quran(4, 43),
        coll('bukhari', 335, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« La terre a été faite pour moi lieu de prière et moyen de purification », d'après Jābir",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('abudawud', 334, 'Authentique (al-Albānī, Zubayr ʿAlī Zaʾī)', "Jugements affichés sur sunnah.com",
             "ʿAmr ibn al-ʿĀṣ et la nuit froide"),
        coll('bukhari', 344, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Prends la terre, cela te suffit », d'après ʿImrān ibn Ḥuṣayn"),
        coll('bukhari', 338, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le tayammum enseigné à ʿAmmār ibn Yāsir"),
        book("La manière du tayammum", "ʿAbd al-ʿAzīz ibn Bāz", "Fatwas n° 1548 et 12683, binbaz.org.sa",
             "https://binbaz.org.sa/fatwas/1548",
             "Une frappe pour le visage et les mains ; terre pure ; le tayammum remplace l'eau pour lever l'impureté."),
        book("Le tayammum : ses causes et sa manière", "fiqh.islamonline.net", "Article en ligne",
             "https://fiqh.islamonline.net/%d8%a7%d9%84%d8%aa%d9%8a%d9%85%d9%85-%d8%af%d9%88%d8%a7%d8%b9%d9%8a%d9%87-%d9%88%d9%83%d9%8a%d9%81%d9%8a%d8%aa%d9%87/",
             "Deux frappes jusqu'aux coudes (ḥanafites, shāfiʿites) ; une frappe jusqu'aux poignets (mālikites, ḥanbalites) ; remarque d'Ibn Ḥajar."),
        book("La manière correcte du tayammum", "fiqh.islamonline.net (citant ash-Shawkānī, as-Sayl al-jarrār 1/133)", "Article en ligne",
             "https://fiqh.islamonline.net/%D8%A7%D9%84%D9%83%D9%8A%D9%81%D9%8A%D8%A9-%D8%A7%D9%84%D8%B5%D8%AD%D9%8A%D8%AD%D9%8A%D8%A9-%D9%84%D9%84%D8%AA%D9%8A%D9%85%D9%85/",
             "Les hadiths des deux frappes ou jusqu'aux coudes sont faibles selon ash-Shawkānī."),
    ],
    questions=[
        ("Quand peut-on faire le tayammum selon 5:6 ?", ["Quand on ne trouve pas d'eau, ou en cas de maladie", "Quand on est pressé", "Jamais"], 0,
         "Sourate al-Mā’ida, 5:6."),
        ("Qu'a dit le Prophète ﷺ de la terre ?", ["Elle a été faite lieu de prière et moyen de purification", "Elle est impure", "Rien"], 0,
         "Al-Bukhārī n° 335."),
        ("Le tayammum remplace-t-il le grand lavage ?", ["Oui, quand l'eau manque", "Non, jamais", "Seulement le vendredi"], 0,
         "Al-Bukhārī n° 344."),
        ("Pourquoi ʿAmr ibn al-ʿĀṣ fit-il le tayammum malgré la présence d'eau ?", ["Il craignait de mourir de froid", "Il était pressé", "Il n'aimait pas l'eau"], 0,
         "Abū Dāwūd n° 334."),
        ("Combien de frappes dans le hadith de ʿAmmār ?", ["Une", "Deux", "Trois"], 0,
         "Al-Bukhārī n° 338."),
        ("Que essuie-t-on avec la terre selon le hadith de ʿAmmār ?", ["Le visage et les mains", "La tête et les pieds", "Tout le corps"], 0,
         "Al-Bukhārī n° 338."),
        ("Quel est l'avis des ḥanafites et des shāfiʿites ?", ["Deux frappes, les mains jusqu'aux coudes", "Une frappe, les mains jusqu'aux poignets", "Pas de tayammum"], 0,
         "Fiqh.islamonline.net."),
        ("Selon Ibn Bāz, jusqu'à quand le tayammum reste-t-il valable ?", ["Jusqu'à la perte de la pureté ou jusqu'à pouvoir utiliser l'eau", "Une seule prière", "Une heure"], 0,
         "Ibn Bāz, fatwa n° 1548."),
    ],
)
