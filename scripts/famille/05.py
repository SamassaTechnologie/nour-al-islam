LESSON = dict(
    position=5,
    slug='les-parents-ages-et-le-respect-des-aines',
    title="La bonté envers les parents âgés et le respect des aînés",
    summary="Quand l'un d'eux ou les deux atteignent la vieillesse, ne leur dis pas « ouf ». Malheur à celui qui a connu ses parents âgés sans entrer au Paradis ; servir ses parents est un combat ; après leur mort : l'invocation, l'aumône, et la bonté envers leurs amis ; respecter les aînés.",
    body="""1. La vieillesse des parents
Allah dit : ton Seigneur a décrété que vous n'adoriez que Lui et que vous soyez bons envers les parents ; si l'un d'eux ou les deux atteignent la vieillesse auprès de toi, ne leur dis pas « ouf », ne les brusque pas, et adresse-leur des paroles respectueuses ; abaisse pour eux l'aile de l'humilité par miséricorde, et dis : Seigneur, fais-leur miséricorde comme ils m'ont élevé tout petit (sourate al-Isrā’, 17:23-24). Allah rappelle aussi que la mère a porté l'enfant avec peine et l'a mis au monde avec peine (sourate al-Aḥqāf, 46:15).

2. Une occasion d'entrer au Paradis
Le Prophète ﷺ dit trois fois : que son nez soit dans la poussière ! On demanda : qui, ô Messager d'Allah ? Il répondit :
« {{AR:muslim:6510|من أدرك أبويه|فلم يدخل الجنة}} » (man adraka abawayhi ʿinda l-kibari aḥadahumā aw kilayhimā fa-lam yadkhuli l-janna).
Sens : « Celui qui a connu ses parents dans leur vieillesse, l'un d'eux ou les deux, et qui n'est pas entré au Paradis. » (Muslim n° 2551, d'après Abū Hurayra ; hadith authentique).

3. Servir ses parents est un combat
Un homme vint demander au Prophète ﷺ la permission de partir au combat. Il lui demanda : tes parents sont-ils vivants ? Il répondit oui. Il dit :
« {{AR:bukhari:3004|ففيهما|فجاهد}} » (fa-fīhimā fa-jāhid).
Sens : « Alors c'est pour eux que tu dois lutter. » (al-Bukhārī n° 3004, d'après ʿAbd Allāh ibn ʿAmr ; hadith authentique).

4. Après leur mort
- L'invocation : quand l'homme meurt, ses œuvres s'arrêtent sauf trois, dont un enfant pieux qui invoque pour lui (Muslim n° 1631). Nūḥ invoqua : Seigneur, pardonne-moi ainsi qu'à mes parents (sourate Nūḥ, 71:28).
- L'aumône : un homme dit que sa mère était morte soudainement et qu'il pensait qu'elle aurait fait une aumône si elle avait pu parler ; il demanda s'il pouvait faire l'aumône pour elle ; le Prophète ﷺ répondit : oui, fais l'aumône pour elle (al-Bukhārī n° 2760, d'après ʿĀ’isha).
- La bonté envers leurs amis : le Prophète ﷺ a dit :
« {{AR:muslim:6514|أبر البر|ود أبيه}} » (abarru l-birri an yaṣila r-rajulu wudda abīh).
Sens : « La plus grande des bontés est que l'homme garde le lien avec ceux que son père aimait. » (Muslim n° 2552, d'après Ibn ʿUmar ; hadith authentique). Ibn ʿUmar donna son âne et son turban à un bédouin dont le père était un ami de ʿUmar, en citant ce hadith (même référence).

5. Respecter les aînés
Le Prophète ﷺ a dit : n'est pas des nôtres celui qui ne fait pas miséricorde à nos petits et ne reconnaît pas l'honneur de nos aînés (al-Tirmidhī n° 1920, d'après ʿAmr ibn Shuʿayb, de son père, de son grand-père ; authentique selon al-Albānī et Aḥmad Shākir).

6. Ce que l'élève peut retenir
- La vieillesse des parents est une occasion d'entrer au Paradis.
- On leur parle avec respect et douceur, sans même dire « ouf ».
- Servir ses parents est une forme de lutte dans le sentier d'Allah.
- Après leur mort, on invoque pour eux, on fait l'aumône pour eux et on honore leurs amis.
- On respecte les aînés et on fait miséricorde aux petits.

Exercice : rendez visite ou téléphonez cette semaine à une personne âgée de votre famille, et récitez l'invocation de 17:24 pour vos parents, puis répondez aux questions.""",
    refs=[
        quran(17, 23, 24),
        quran(46, 15),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2551a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Celui qui a connu ses parents âgés sans entrer au Paradis, d'après Abū Hurayra", url='https://sunnah.com/muslim:2551a',
             note="Paroles du Prophète ﷺ copiées telles quelles de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 3004, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« C'est pour eux que tu dois lutter », d'après ʿAbd Allāh ibn ʿAmr",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='1631',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Les œuvres qui continuent après la mort, d'après Abū Hurayra", url='https://sunnah.com/muslim:1631'),
        quran(71, 28),
        coll('bukhari', 2760, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "L'aumône pour la mère décédée, d'après ʿĀ’isha"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2552b',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« La plus grande des bontés… », d'après Ibn ʿUmar", url='https://sunnah.com/muslim:2552b',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api) ; le récit du bédouin est en Muslim 2552a et c."),
        coll('tirmidhi', 1920, 'Authentique (al-Albānī, Aḥmad Shākir) ; ḥasan (Zubayr ʿAlī Zaʾī)', "Jugements affichés sur sunnah.com",
             "Faire miséricorde aux petits et honorer les aînés, d'après ʿAmr ibn Shuʿayb"),
    ],
    questions=[
        ("Que ne doit-on pas dire à ses parents âgés selon 17:23 ?", ["« Ouf »", "« Merci »", "« Salām »"], 0,
         "Sourate al-Isrā’, 17:23."),
        ("Quelle invocation pour les parents se trouve en 17:24 ?", ["Seigneur, fais-leur miséricorde comme ils m'ont élevé tout petit", "Seigneur, enrichis-moi", "Aucune"], 0,
         "Sourate al-Isrā’, 17:24."),
        ("Qui est blâmé trois fois dans le hadith d'Abū Hurayra ?", ["Celui qui a connu ses parents âgés sans entrer au Paradis", "Celui qui voyage", "Celui qui dort"], 0,
         "Muslim n° 2551."),
        ("Que dit le Prophète ﷺ à l'homme dont les parents étaient vivants et qui voulait partir au combat ?", ["C'est pour eux que tu dois lutter", "Pars tout de suite", "Abandonne-les"], 0,
         "Al-Bukhārī n° 3004."),
        ("Peut-on faire l'aumône pour un parent décédé ?", ["Oui", "Non", "Seulement le vendredi"], 0,
         "Al-Bukhārī n° 2760."),
        ("Quelle est la plus grande des bontés selon le hadith d'Ibn ʿUmar ?", ["Garder le lien avec ceux que son père aimait", "Donner beaucoup d'argent", "Voyager"], 0,
         "Muslim n° 2552."),
        ("Que dit le hadith de celui qui ne reconnaît pas l'honneur des aînés ?", ["Il n'est pas des nôtres", "Il est respecté", "Rien"], 0,
         "Al-Tirmidhī n° 1920."),
        ("Quelle œuvre du fils pieux profite à ses parents après leur mort selon Muslim n° 1631 ?", ["Son invocation pour eux", "Rien", "Seulement son travail"], 0,
         "Muslim n° 1631."),
    ],
)
