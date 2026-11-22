LESSON = dict(
    position=1,
    slug='le-mariage-sa-place-et-le-choix-du-conjoint',
    title="Le mariage : sa place en islam et le choix du conjoint",
    summary="Le mariage est un signe d'Allah, fait d'affection et de miséricorde, et une sunna du Prophète ﷺ. L'encouragement aux jeunes qui en ont les moyens, et le jeûne pour les autres ; choisir la personne pieuse ; la meilleure jouissance de ce monde ; le consentement de la femme ; accepter celui dont on agrée la religion et le caractère.",
    body="""1. Un signe d'Allah
Allah dit que parmi Ses signes, Il a créé pour vous, de vous-mêmes, des épouses pour que vous viviez en tranquillité auprès d'elles, et Il a mis entre vous affection et miséricorde (sourate ar-Rūm, 30:21). Il ordonne de marier ceux d'entre vous qui sont seuls (sourate an-Nūr, 24:32), et interdit d'épouser les associatrices et de marier les associateurs tant qu'ils n'ont pas cru (sourate al-Baqara, 2:221).

2. Une sunna du Prophète ﷺ
Trois hommes vinrent s'informer de l'adoration du Prophète ﷺ ; ils la trouvèrent peu de chose. L'un dit : je prierai toute la nuit, toujours ; un autre : je jeûnerai toujours ; un autre : je me tiendrai à l'écart des femmes et ne me marierai jamais. Le Prophète ﷺ dit : je suis celui d'entre vous qui craint le plus Allah, mais je jeûne et je romps le jeûne, je prie et je dors, et j'épouse des femmes ; celui qui se détourne de ma sunna n'est pas des miens (al-Bukhārī n° 5063, d'après Anas).

3. L'encouragement aux jeunes
Le Prophète ﷺ a dit :
« {{AR:bukhari:5065|يا معشر الشباب|له وجاء}} » (yā maʿshara sh-shabāb, mani staṭāʿa minkumu l-bā’ata fa-l-yatazawwaj, wa man lam yastaṭiʿ fa-ʿalayhi bi-ṣ-ṣawmi fa-innahu lahu wijā’).
Sens : « Ô assemblée de jeunes ! Que celui d'entre vous qui en a les moyens se marie ; et celui qui ne le peut pas, qu'il jeûne, car cela le protège. » (al-Bukhārī n° 5065, d'après ʿAbd Allāh ibn Masʿūd ; hadith authentique).

4. Choisir la personne pieuse
Le Prophète ﷺ a dit :
« {{AR:bukhari:5090|تنكح المرأة لأربع|تربت يداك}} » (tunkaḥu l-mar’atu li-arbaʿ : li-mālihā wa li-ḥasabihā wa jamālihā wa li-dīnihā, fa-ẓfar bi-dhāti d-dīni taribat yadāk).
Sens : « On épouse une femme pour quatre choses : sa fortune, sa noblesse, sa beauté et sa religion. Choisis celle qui a la religion, sinon tes mains seront couvertes de poussière. » (al-Bukhārī n° 5090, d'après Abū Hurayra ; hadith authentique).
Et il a dit :
« {{AR:muslim:3643|الدنيا متاع|المرأة الصالحة}} » (ad-dunyā matāʿ, wa khayru matāʿi d-dunyā al-mar’atu ṣ-ṣāliḥa).
Sens : « Ce monde est une jouissance, et la meilleure jouissance de ce monde est la femme vertueuse. » (Muslim n° 1467, d'après ʿAbd Allāh ibn ʿAmr ; hadith authentique).
Du côté de la femme : le Prophète ﷺ a dit que si quelqu'un dont vous agréez la religion et le caractère vient demander (votre fille) en mariage, mariez-le ; sinon il y aura sur terre une épreuve et une grande corruption (al-Tirmidhī n° 1084, d'après Abū Hurayra). Degré discuté : al-Tirmidhī rapporte qu'al-Bukhārī jugeait plus juste la version mursal (sans le Compagnon) ; al-Albānī et Aḥmad Shākir le jugent « ḥasan », Zubayr ʿAlī Zaʾī faible.

5. Le consentement de la femme
Le Prophète ﷺ a dit : on ne marie pas la femme déjà mariée auparavant sans la consulter, ni la vierge sans lui demander sa permission. On demanda : comment se donne sa permission ? Il répondit : par son silence (al-Bukhārī n° 5136, d'après Abū Hurayra).
Les conditions du contrat de mariage (tuteur, témoins, dot) seront étudiées dans une leçon suivante.

6. Ce que l'élève peut retenir
- Le mariage est un signe d'Allah et une sunna du Prophète ﷺ.
- Celui qui en a les moyens se marie ; les autres jeûnent.
- On choisit en premier la religion et le caractère.
- On ne marie pas une femme sans son consentement.

Exercice : citez les quatre raisons pour lesquelles on épouse une femme selon le hadith, et dites laquelle le Prophète ﷺ recommande, puis répondez aux questions.""",
    refs=[
        quran(30, 21),
        quran(24, 32),
        quran(2, 221),
        coll('bukhari', 5063, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Les trois hommes et « celui qui se détourne de ma sunna », d'après Anas"),
        coll('bukhari', 5065, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Ô assemblée de jeunes ! », d'après Ibn Masʿūd",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 5090, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« On épouse une femme pour quatre choses », d'après Abū Hurayra",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='1467',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« La meilleure jouissance de ce monde est la femme vertueuse », d'après ʿAbd Allāh ibn ʿAmr", url='https://sunnah.com/muslim:1467',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('tirmidhi', 1084, 'Ḥasan (al-Albānī, Aḥmad Shākir) ; faible (Zubayr ʿAlī Zaʾī)', "Jugements affichés sur sunnah.com",
             "« Si quelqu'un dont vous agréez la religion et le caractère… », d'après Abū Hurayra",
             "Al-Tirmidhī rapporte qu'al-Bukhārī jugeait plus juste la version mursal."),
        coll('bukhari', 5136, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le consentement de la femme, d'après Abū Hurayra"),
    ],
    questions=[
        ("Qu'Allah a-t-Il mis entre les époux selon 30:21 ?", ["Affection et miséricorde", "Rivalité", "Rien"], 0,
         "Sourate ar-Rūm, 30:21."),
        ("Que dit le Prophète ﷺ de celui qui se détourne de sa sunna, comme celui qui refuse de se marier pour adorer ?", ["Il n'est pas des miens", "Il est le meilleur", "C'est recommandé"], 0,
         "Al-Bukhārī n° 5063."),
        ("Que conseille le Prophète ﷺ au jeune qui n'a pas les moyens de se marier ?", ["Le jeûne", "Rien", "Abandonner la prière"], 0,
         "Al-Bukhārī n° 5065."),
        ("Que recommande le Prophète ﷺ parmi les quatre raisons d'épouser une femme ?", ["Sa religion", "Sa fortune", "Sa beauté"], 0,
         "Al-Bukhārī n° 5090."),
        ("Quelle est la meilleure jouissance de ce monde selon le hadith ?", ["La femme vertueuse", "L'or", "Les maisons"], 0,
         "Muslim n° 1467."),
        ("Que faut-il regarder chez celui qui demande une femme en mariage, selon al-Tirmidhī n° 1084 ?", ["Sa religion et son caractère", "Sa richesse seulement", "Sa tribu seulement"], 0,
         "Al-Tirmidhī n° 1084."),
        ("Peut-on marier une femme sans son consentement ?", ["Non", "Oui", "Seulement si elle est jeune"], 0,
         "Al-Bukhārī n° 5136."),
        ("Comment la vierge donne-t-elle sa permission selon le hadith ?", ["Par son silence", "Par écrit seulement", "Elle n'a pas à la donner"], 0,
         "Al-Bukhārī n° 5136."),
    ],
)
