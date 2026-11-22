LESSON = dict(
    position=11,
    slug='l-humilite-et-la-modestie',
    title="L'humilité et la modestie",
    summary="Les serviteurs du Tout Miséricordieux marchent humblement ; Luqman et la démarche ; « celui qui s'humilie pour Allah, Allah l'élève » ; Allah a révélé : soyez humbles, que nul ne se vante ; l'humilité du Prophète ﷺ dans sa maison et son refus d'être exagérément louangé ; la fin de l'homme orgueilleux.",
    body="""1. L'humilité dans le Coran
Allah décrit les serviteurs du Tout Miséricordieux : ils marchent sur la terre avec humilité, et quand les ignorants leur adressent la parole, ils répondent par la paix (sourate al-Furqān, 25:63). Luqmān conseilla à son fils de ne pas détourner son visage des gens par orgueil, de ne pas marcher sur terre avec arrogance, d'être mesuré dans sa démarche et de baisser la voix (sourate Luqmān, 31:18-19). Allah dit aussi : ne marche pas sur terre avec arrogance, tu ne fendras pas la terre et n'atteindras pas la hauteur des montagnes (sourate al-Isrā’, 17:37). Et la demeure de l'au-delà est pour ceux qui ne cherchent ni à s'élever sur terre ni à y semer le désordre (sourate al-Qaṣaṣ, 28:83).

2. Celui qui s'humilie pour Allah est élevé
Le Prophète ﷺ a dit :
« {{AR:muslim:6592|ما نقصت صدقة|إلا رفعه الله}} » (mā naqaṣat ṣadaqatun min māl, wa mā zāda llāhu ʿabdan bi-ʿafwin illā ʿizzā, wa mā tawāḍaʿa aḥadun li-llāhi illā rafaʿahu llāh).
Sens : « Une aumône ne diminue en rien un bien ; Allah n'augmente le serviteur qui pardonne qu'en honneur ; et nul ne s'humilie pour Allah sans qu'Allah l'élève. » (Muslim n° 2588, d'après Abū Hurayra ; hadith authentique).

3. Que nul ne se vante
Dans un sermon, le Prophète ﷺ a dit qu'Allah lui a révélé :
« {{AR:muslim:7210|أن تواضعوا|يبغي أحد على أحد}} » (an tawāḍaʿū ḥattā lā yafkhara aḥadun ʿalā aḥad, wa lā yabghī aḥadun ʿalā aḥad).
Sens : « Soyez humbles, afin que nul ne se vante devant un autre et que nul ne soit injuste envers un autre. » (Muslim n° 2865, d'après ʿIyāḍ ibn Ḥimār ; hadith authentique).
Rappel : l'orgueil, c'est rejeter la vérité et mépriser les gens (Muslim n° 91 ; voir la leçon « La propreté, la tenue et l'humilité dans l'habit »).

4. L'humilité du Prophète ﷺ
On demanda à ʿĀ’isha ce que faisait le Prophète ﷺ chez lui ; elle répondit qu'il était au service de sa famille, et que lorsque venait l'heure de la prière, il sortait pour prier (al-Bukhārī n° 676).
Il a dit : ne m'exagérez pas dans la louange comme les chrétiens l'ont fait pour le fils de Maryam ; je ne suis que Son serviteur : dites « le serviteur d'Allah et Son Messager » (al-Bukhārī n° 3445, d'après ʿUmar).

5. La fin de l'orgueilleux
Le Prophète ﷺ raconta qu'un homme marchait dans un bel habit, admiratif de lui-même, les cheveux bien peignés, quand Allah le fit engloutir par la terre ; il s'y enfonce jusqu'au Jour de la Résurrection (al-Bukhārī n° 5789, d'après Abū Hurayra).

6. Ce que l'élève peut retenir
- Le croyant marche avec humilité et répond à l'ignorant par la paix.
- Celui qui s'humilie pour Allah, Allah l'élève.
- Nul ne se vante devant les autres ni n'est injuste envers eux.
- Le Prophète ﷺ aidait sa famille et refusait l'exagération dans sa louange.
- L'admiration de soi et l'orgueil mènent à la perte.

Exercice : cette semaine, rendez un service à la maison sans qu'on vous le demande, et saluez le premier ceux que vous rencontrez, puis répondez aux questions.""",
    refs=[
        quran(25, 63),
        quran(31, 18, 19),
        quran(17, 37),
        quran(28, 83),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2588',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Nul ne s'humilie pour Allah sans qu'Allah l'élève », d'après Abū Hurayra", url='https://sunnah.com/muslim:2588',
             note="Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2865d',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="« Soyez humbles, afin que nul ne se vante », d'après ʿIyāḍ ibn Ḥimār", url='https://sunnah.com/muslim:2865d',
             note="Passage copié tel quel de l'édition de sunnah.com (base hadith-api) ; cette phrase figure dans cette voie du hadith."),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='91a',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="La définition de l'orgueil, d'après Ibn Masʿūd", url='https://sunnah.com/muslim:91a'),
        coll('bukhari', 676, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le Prophète ﷺ au service de sa famille, d'après ʿĀ’isha"),
        coll('bukhari', 3445, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Ne m'exagérez pas dans la louange », d'après ʿUmar"),
        coll('bukhari', 5789, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "L'homme admiratif de lui-même englouti par la terre, d'après Abū Hurayra"),
    ],
    questions=[
        ("Comment marchent les serviteurs du Tout Miséricordieux ?", ["Avec humilité", "Avec arrogance", "En se pressant"], 0,
         "Sourate al-Furqān, 25:63."),
        ("Que conseilla Luqmān à son fils ?", ["De ne pas marcher avec arrogance et de baisser la voix", "De crier pour se faire entendre", "De se détourner des gens"], 0,
         "Sourate Luqmān, 31:18-19."),
        ("Que fait Allah pour celui qui s'humilie pour Lui ?", ["Il l'élève", "Il l'abaisse", "Rien"], 0,
         "Muslim n° 2588."),
        ("L'aumône diminue-t-elle le bien selon le hadith ?", ["Non", "Oui, toujours", "Seulement le vendredi"], 0,
         "Muslim n° 2588."),
        ("Pourquoi Allah a-t-il ordonné l'humilité dans le hadith de ʿIyāḍ ibn Ḥimār ?", ["Pour que nul ne se vante ni ne soit injuste envers un autre", "Pour s'enrichir", "Pour être célèbre"], 0,
         "Muslim n° 2865."),
        ("Que faisait le Prophète ﷺ dans sa maison selon ʿĀ’isha ?", ["Il était au service de sa famille", "Il se faisait tout servir", "Il dormait"], 0,
         "Al-Bukhārī n° 676."),
        ("Comment le Prophète ﷺ a-t-il demandé qu'on l'appelle ?", ["Le serviteur d'Allah et Son Messager", "Le fils d'Allah", "Un ange"], 0,
         "Al-Bukhārī n° 3445."),
        ("Qu'arriva-t-il à l'homme admiratif de lui-même dans le hadith ?", ["La terre l'engloutit", "Il devint roi", "Rien"], 0,
         "Al-Bukhārī n° 5789."),
    ],
)
