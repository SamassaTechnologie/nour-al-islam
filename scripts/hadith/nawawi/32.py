LESSON = dict(
    n=32, slug='nawawi-32-pas-de-prejudice',
    title="Hadith 32 : ni préjudice, ni riposte préjudiciable",
    summary="Il est interdit de nuire à soi-même ou aux autres, et de répondre au tort par un tort excessif : un grand principe de la Loi islamique.",
    body="""1. Le texte du hadith

{{NAW:32}}

Traduction du sens : D'après Abū Saʿīd Saʿd ibn Mālik ibn Sinān al-Khudrī : le Messager d'Allah ﷺ a dit : « Pas de préjudice, ni de riposte préjudiciable. » An-Nawawī a dit : hadith ḥasan, rapporté avec une chaîne remontant au Prophète ﷺ par Ibn Mājah, ad-Dāraquṭnī et d'autres ; Mālik l'a rapporté dans le Muwaṭṭaʾ de manière mursal (sans mentionner Abū Saʿīd), et il a plusieurs voies qui se renforcent les unes les autres.

2. La phrase à retenir
« {{NAWS:32|لا ضرر|ضرار}} » (lā ḍarara wa lā ḍirār).
Sens : « Pas de préjudice, ni de riposte préjudiciable. »

3. Explication
Il faut écarter le tort, envers soi-même comme envers les autres : il n'est permis ni de se nuire ni de nuire à autrui, de quelque manière que ce soit. Il n'est pas non plus permis de répondre au tort par un tort, sauf dans le cadre du talion, sans excès (selon HadeethEnc).

4. Ce que l'élève peut retenir
- Il est interdit de dépasser la mesure lorsqu'on rend la pareille.
- Allah n'a rien ordonné à Ses serviteurs qui leur cause du tort.
- Ce hadith pose un principe : le tort est interdit, en paroles, en actes ou par négligence.
- Parmi les règles de la Loi islamique : « le préjudice doit être écarté ».

Exercice : donnez un exemple de « riposte préjudiciable » à éviter dans une dispute, puis répondez aux questions.""",
    refs=[
        naw(32, 'Ḥasan (bon) selon an-Nawawī', 'An-Nawawī', "Pas de préjudice, ni de riposte préjudiciable, d'après Abū Saʿīd al-Khudrī"),
        dict(kind='book', source_title='Sunan ad-Dāraquṭnī', author='Ad-Dāraquṭnī', locator='Hadith n° 3079 (selon HadeethEnc)',
             url='https://hadeethenc.com/fr/browse/hadith/66531'),
        coll('ibnmajah', 2341, 'Ḥasan selon an-Nawawī', 'An-Nawawī', 'Livre des jugements',
             note="An-Nawawī renvoie à ce numéro (« voir n° 2341 ») ; à cet endroit, le hadith est rapporté par une autre voie."),
        he(66531),
    ],
    questions=[
        ("Que signifie « lā ḍarara wa lā ḍirār » ?", ["Pas de préjudice, ni de riposte préjudiciable", "Pas de prière sans ablutions", "Pas de commerce le vendredi"], 0,
         "Il est interdit de nuire et de répondre au tort par un tort."),
        ("Est-il permis de se nuire à soi-même ?", ["Non", "Oui"], 0,
         "Il n'est permis de nuire ni à soi-même ni aux autres."),
        ("Quel grade an-Nawawī donne-t-il à ce hadith ?", ["Ḥasan", "Faible", "Inventé"], 0,
         "Il ajoute que ses différentes voies se renforcent les unes les autres."),
        ("Quelle règle de la Loi islamique découle de ce hadith ?", ["Le préjudice doit être écarté", "Chacun fait ce qu'il veut", "Le plus fort a toujours raison"], 0,
         "C'est une règle citée par HadeethEnc."),
        ("Allah a-t-Il ordonné quelque chose qui nuit à Ses serviteurs ?", ["Non", "Oui"], 0,
         "C'est l'un des enseignements du hadith."),
    ],
)
