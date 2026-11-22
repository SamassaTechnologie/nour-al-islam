LESSON = dict(
    position=3,
    slug='les-droits-du-voisin-et-de-l-invite',
    title="Les droits du voisin et de l'invité",
    summary="Le voisin dans le Coran et la Sunna : la recommandation de Jibrīl, la foi de celui dont le voisin n'est pas à l'abri, les petits cadeaux et le partage de la nourriture, le voisin le plus proche ; puis l'hospitalité : honorer l'invité, un jour et une nuit, trois jours, et les devoirs de l'invité.",
    body="""1. Le voisin : une recommandation répétée
Allah ordonne d'être bon envers les parents, les proches, les orphelins, les pauvres, le voisin proche et le voisin éloigné (sourate al-Nisā’, 4:36).
Le Prophète ﷺ a dit :
« {{AR:bukhari:6014|ما زال يوصيني جبريل بالجار|أنه سيورثه}} » (mā zāla yūṣīnī jibrīlu bi-l-jāri ḥattā ẓanantu annahu sa-yuwarrithuh).
Sens : « Jibrīl n'a cessé de me recommander le voisin, au point que j'ai pensé qu'il allait le faire hériter. » (al-Bukhārī n° 6014, d'après ʿĀ’isha ; hadith authentique).

2. Ne pas nuire à son voisin
Le Prophète ﷺ dit trois fois : « Par Allah, il ne croit pas ! » On demanda : qui donc, ô Messager d'Allah ? Il répondit : « Celui dont le voisin n'est pas à l'abri de ses méfaits » (al-Bukhārī n° 6016, d'après Abū Shurayḥ ; hadith authentique). Il a dit aussi : que celui qui croit en Allah et au Jour dernier ne nuise pas à son voisin (al-Bukhārī n° 6018).

3. Faire du bien à son voisin
a) Partager la nourriture : le Prophète ﷺ dit à Abū Dharr :
« {{AR:muslim:6688|يا أبا ذر إذا طبخت مرقة|وتعاهد جيرانك}} » (yā abā dharrin idhā ṭabakhta maraqatan fa-akthir mā’ahā wa taʿāhad jīrānak).
Sens : « Ô Abū Dharr, quand tu prépares une sauce, mets-y beaucoup d'eau et pense à tes voisins. » (Muslim n° 2625 ; hadith authentique).
b) Ne pas mépriser un petit cadeau : il disait aux femmes musulmanes qu'aucune ne méprise un cadeau à sa voisine, fût-ce un sabot de mouton (al-Bukhārī n° 6017, d'après Abū Hurayra).
c) Le plus proche d'abord : ʿĀ’isha demanda auquel de ses deux voisins offrir un cadeau ; il répondit : « À celui dont la porte est la plus proche de toi » (al-Bukhārī n° 6020).

4. L'invité
a) L'honorer : le Prophète ﷺ a dit :
« {{AR:bukhari:6135|فليكرم ضيفه|حتى يحرجه}} » (fal-yukrim ḍayfah, jā’izatuhu yawmun wa laylah, wa ḍ-ḍiyāfatu thalāthatu ayyām, fa-mā baʿda dhālika fa-huwa ṣadaqah, wa lā yaḥillu lahu an yathwiya ʿindahu ḥattā yuḥrijah).
Sens : « (Que celui qui croit en Allah et au Jour dernier) honore son invité : son dû est d'un jour et d'une nuit, et l'hospitalité est de trois jours ; ce qui est au-delà est une aumône. Et il n'est pas permis à l'invité de rester chez lui au point de le mettre dans l'embarras. » (al-Bukhārī n° 6135, d'après Abū Shurayḥ al-Kaʿbī ; hadith authentique). Dans une autre version, le rapporteur précise que le « dû » (jā’iza) est d'un jour et d'une nuit (al-Bukhārī n° 6019).
b) L'exemple d'Ibrāhīm : quand des invités vinrent chez lui, il alla discrètement vers sa famille, apporta un veau gras et le leur présenta (sourate al-Dhāriyāt, 51:24-27).
c) Les devoirs de l'invité : ne pas rester au point de gêner son hôte (al-Bukhārī n° 6135).

5. Ce que l'élève peut retenir
- Jibrīl a tant recommandé le voisin que le Prophète ﷺ a pensé qu'il allait hériter.
- Celui dont le voisin n'est pas à l'abri de ses méfaits n'a pas la foi complète.
- On partage la nourriture et on offre de petits cadeaux, en commençant par la porte la plus proche.
- On honore l'invité ; l'hospitalité est de trois jours ; l'invité ne gêne pas son hôte.

Exercice : choisissez un geste concret pour un voisin cette semaine (un plat, un cadeau, une visite), puis répondez aux questions.""",
    refs=[
        quran(4, 36),
        coll('bukhari', 6014, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Jibrīl n'a cessé de recommander le voisin, d'après ʿĀ’isha",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6016, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Celui dont le voisin n'est pas à l'abri de ses méfaits », d'après Abū Shurayḥ"),
        coll('bukhari', 6018, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Ne pas nuire à son voisin, honorer son invité, d'après Abū Hurayra"),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2625b',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Mets beaucoup d'eau dans ta sauce et pense à tes voisins », d'après Abū Dharr", url='https://sunnah.com/muslim:2625b',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6017, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Ne pas mépriser un cadeau à sa voisine, d'après Abū Hurayra"),
        coll('bukhari', 6020, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le voisin dont la porte est la plus proche, d'après ʿĀ’isha"),
        coll('bukhari', 6135, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Honorer l'invité : un jour et une nuit, trois jours d'hospitalité, d'après Abū Shurayḥ al-Kaʿbī",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6019, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Qu'est-ce que son dû ? Un jour et une nuit », d'après Abū Shurayḥ al-ʿAdawī"),
        quran(51, 24, 27),
    ],
    questions=[
        ("Qui a recommandé le voisin au Prophète ﷺ avec insistance ?", ["Jibrīl", "Abū Bakr", "Personne"], 0,
         "Al-Bukhārī n° 6014."),
        ("Que dit le Prophète ﷺ de celui dont le voisin n'est pas à l'abri de ses méfaits ?", ["Il ne croit pas", "Il est un bon voisin", "Rien"], 0,
         "Al-Bukhārī n° 6016."),
        ("Que conseille le Prophète ﷺ à Abū Dharr quand il prépare une sauce ?", ["Mettre beaucoup d'eau et penser à ses voisins", "La manger seul", "La vendre"], 0,
         "Muslim n° 2625."),
        ("Faut-il mépriser un petit cadeau entre voisines ?", ["Non, même un sabot de mouton", "Oui, s'il est petit", "Seulement le vendredi"], 0,
         "Al-Bukhārī n° 6017."),
        ("À quel voisin offrir d'abord un cadeau ?", ["Celui dont la porte est la plus proche", "Le plus riche", "Le plus éloigné"], 0,
         "Al-Bukhārī n° 6020."),
        ("Combien de jours dure l'hospitalité ?", ["Trois jours", "Un mois", "Une heure"], 0,
         "Al-Bukhārī n° 6135."),
        ("Que doit éviter l'invité ?", ["Rester au point de mettre son hôte dans l'embarras", "Dire merci", "Manger ce qu'on lui offre"], 0,
         "Al-Bukhārī n° 6135."),
        ("Qu'apporta Ibrāhīm à ses invités ?", ["Un veau gras", "De l'eau seulement", "Rien"], 0,
         "Sourate al-Dhāriyāt, 51:26."),
    ],
)
