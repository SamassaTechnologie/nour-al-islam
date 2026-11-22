LESSON = dict(
    position=5,
    slug='le-grand-lavage-al-ghusl',
    title="Le grand lavage (al-ghusl) : quand et comment",
    summary="Ce qui rend le grand lavage obligatoire : l'émission de sperme, le rapport conjugal même sans émission, la fin des règles. Le lavage suffisant (l'intention et l'eau sur tout le corps) et le lavage complet décrit par ʿĀ’isha et Maymūna ; la divergence sur le rinçage de la bouche et du nez.",
    body="""1. Un ordre du Coran
Allah dit : si vous êtes en état d'impureté majeure (junub), purifiez-vous (sourate al-Mā’ida, 5:6) ; et n'approchez pas la prière en état d'impureté majeure avant de vous être lavés (sourate an-Nisā’, 4:43). Il dit aussi, à propos des femmes en règles : quand elles se seront purifiées, vous pourrez aller à elles (sourate al-Baqara, 2:222).

2. Ce qui rend le grand lavage obligatoire
- La sortie du sperme (al-janāba), y compris pendant le sommeil. Umm Sulaym demanda si la femme doit se laver quand elle a un rêve ; le Prophète ﷺ répondit :
« {{AR:bukhari:282|نعم إذا|رأت الماء}} » (naʿam, idhā ra’ati l-mā’).
Sens : « Oui, si elle voit le liquide. » (al-Bukhārī n° 282, d'après Umm Salama ; hadith authentique).
- Le rapport conjugal, même sans émission. Le Prophète ﷺ a dit :
« {{AR:muslim:783|إذا جلس بين شعبها الأربع|وجب عليه الغسل}} » (idhā jalasa bayna shuʿabihā l-arbaʿi thumma jahadahā faqad wajaba ʿalayhi l-ghusl).
Sens : « Quand il s'assoit entre ses quatre membres puis s'unit à elle, le grand lavage lui est obligatoire. » Dans la version de Maṭar, il est ajouté : « même s'il n'y a pas d'émission » (Muslim n° 348, d'après Abū Hurayra ; hadith authentique).
- La fin des règles : le Prophète ﷺ dit à Fāṭima bint Abī Ḥubaysh : quand les règles arrivent, laisse la prière ; quand elles s'en vont, lave-toi et prie (al-Bukhārī n° 320, d'après ʿĀ’isha).
Le bain du vendredi a été étudié dans la leçon « La propreté et la tenue » (deux avis).

3. Le lavage suffisant
D'après un article d'al-Alūka sur la description du lavage, la majorité des savants (ḥanafites, mālikites, shāfiʿites et ḥanbalites) considèrent que le lavage est suffisant avec l'intention et l'eau qui atteint tout le corps et les cheveux une fois. Cheikh Ibn Bāz explique que le lavage suffisant consiste, après s'être nettoyé les parties intimes, à faire couler l'eau sur la tête et tout le corps avec l'intention de lever les deux impuretés (majeure et mineure), et que le Prophète ﷺ a fait tantôt le lavage suffisant, tantôt le lavage complet (binbaz.org.sa, audio n° 331).
La bouche et le nez : divergence.
- Le rinçage de la bouche et du nez est obligatoire dans le grand lavage : avis des ḥanafites et des ḥanbalites ; c'est l'avis jugé le plus fort par IslamQA (n° 83172) ;
- il n'est pas obligatoire : avis de Mālik et d'ash-Shāfiʿī (d'après une leçon de fiqh publiée par IslamWeb, audio n° 356748).

4. Le lavage complet (selon la Sunna)
ʿĀ’isha a décrit le lavage du Prophète ﷺ :
« {{AR:bukhari:248|كان إذا اغتسل من الجنابة|على جلده كله}} » (kāna idhā ghtasala mina l-janābati bada’a fa-ghasala yadayh, thumma yatawaḍḍa’u kamā yatawaḍḍa’u li-ṣ-ṣalāh, thumma yudkhilu aṣābiʿahu fī l-mā’i fa-yukhallilu bihā uṣūla shaʿarih, thumma yaṣubbu ʿalā ra’sihi thalātha ghurafin bi-yadayh, thumma yufīḍu l-mā’a ʿalā jildihi kullih).
Sens : « Quand il se lavait de l'impureté majeure, il commençait par se laver les mains, puis faisait les ablutions comme pour la prière, puis plongeait ses doigts dans l'eau et les passait à la racine de ses cheveux, puis versait sur sa tête trois poignées d'eau avec ses mains, puis faisait couler l'eau sur toute sa peau. » (al-Bukhārī n° 248 ; hadith authentique).
Maymūna rapporte qu'il fit ses ablutions sauf les pieds, lava ses parties intimes et ce qui l'avait souillé, versa l'eau sur lui, puis se déplaça et se lava les pieds (al-Bukhārī n° 249).
D'après IslamQA (n° 514048), celui qui a fait ces ablutions au début du lavage n'a pas besoin de les refaire après.

5. Ce que l'élève peut retenir
- Le grand lavage est obligatoire après la sortie du sperme, après le rapport conjugal même sans émission, et à la fin des règles (pour les lochies, interrogez un savant).
- Le lavage suffisant : l'intention et l'eau sur tout le corps (avec la bouche et le nez selon une partie des savants).
- Le lavage complet suit la description de ʿĀ’isha et de Maymūna.

Exercice : décrivez dans l'ordre les étapes du lavage complet selon ʿĀ’isha, puis répondez aux questions.""",
    refs=[
        quran(5, 6),
        quran(4, 43),
        quran(2, 222),
        coll('bukhari', 282, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Oui, si elle voit le liquide », d'après Umm Salama",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='348a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Le rapport conjugal rend le lavage obligatoire, d'après Abū Hurayra", url='https://sunnah.com/muslim:348a',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api) ; « même sans émission » dans la version de Maṭar."),
        coll('bukhari', 320, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Quand elles s'en vont, lave-toi et prie », d'après ʿĀ’isha"),
        book("La description du lavage et ses deux formes", "al-Alūka (alukah.net)", "Article en ligne",
             "https://www.alukah.net/sharia/1001/152955/",
             "Lavage suffisant selon la majorité des quatre écoles : intention et eau sur tout le corps et les cheveux une fois."),
        book("Chapitre de la description du lavage (audio)", "ʿAbd al-ʿAzīz ibn Bāz", "Audio n° 331, binbaz.org.sa",
             "https://binbaz.org.sa/audios/331",
             "Lavage suffisant et lavage complet ; le Prophète ﷺ a fait l'un et l'autre."),
        book("Fatwa n° 83172 : le lavage suffisant et le lavage complet", "IslamQA (sous la direction de Muḥammad Ṣāliḥ al-Munajjid)", "Réponse n° 83172",
             "https://islamqa.info/ar/answers/83172",
             "Rinçage de la bouche et du nez obligatoire selon les ḥanafites et les ḥanbalites ; avis jugé le plus fort."),
        book("Leçon de fiqh : la description du lavage", "IslamWeb (audio n° 356748)", "Transcription en ligne",
             "https://audio.islamweb.net/audio/Fulltxt.php?audioid=356748",
             "Mālik et ash-Shāfiʿī ne rendent obligatoire ni le rinçage de la bouche ni celui du nez."),
        coll('bukhari', 248, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le lavage du Prophète ﷺ décrit par ʿĀ’isha",
             "Paroles de ʿĀ’isha copiées telles quelles de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 249, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le lavage du Prophète ﷺ décrit par Maymūna"),
        book("Fatwa n° 514048 : faut-il refaire les ablutions après le grand lavage ?", "IslamQA (sous la direction de Muḥammad Ṣāliḥ al-Munajjid)", "Réponse n° 514048",
             "https://islamqa.info/ar/answers/514048",
             "Ce qui a été fait au début du lavage n'a pas à être refait."),
    ],
    questions=[
        ("Le rêve qui provoque une émission rend-il le grand lavage obligatoire pour la femme ?", ["Oui, si elle voit le liquide", "Non, jamais", "Seulement le vendredi"], 0,
         "Al-Bukhārī n° 282."),
        ("Le rapport conjugal sans émission rend-il le grand lavage obligatoire ?", ["Oui", "Non", "Seulement le jour"], 0,
         "Muslim n° 348."),
        ("Que doit faire la femme à la fin de ses règles avant de prier ?", ["Le grand lavage", "Rien", "Seulement les ablutions"], 0,
         "Al-Bukhārī n° 320."),
        ("Qu'est-ce que le lavage suffisant selon la majorité ?", ["L'intention et l'eau sur tout le corps une fois", "Laver seulement la tête", "Les ablutions seules"], 0,
         "Al-Alūka ; Ibn Bāz, audio n° 331."),
        ("Le rinçage de la bouche et du nez est-il obligatoire dans le grand lavage ?", ["Il y a divergence entre les écoles", "Tous disent oui", "Tous disent non"], 0,
         "IslamQA n° 83172 ; IslamWeb."),
        ("Par quoi commençait le Prophète ﷺ son lavage selon ʿĀ’isha ?", ["Se laver les mains", "Verser l'eau sur la tête", "Laver les pieds"], 0,
         "Al-Bukhārī n° 248."),
        ("Combien de poignées d'eau versait-il sur sa tête ?", ["Trois", "Une", "Sept"], 0,
         "Al-Bukhārī n° 248."),
        ("Selon Maymūna, quand se lavait-il les pieds ?", ["À la fin, après s'être déplacé", "Au début", "Jamais"], 0,
         "Al-Bukhārī n° 249."),
    ],
)
