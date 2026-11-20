LESSON = dict(
    n=30, slug='nawawi-30-obligations-limites-interdits',
    title="Hadith 30 : les obligations, les limites et les interdits d'Allah",
    summary="Allah a prescrit des obligations, fixé des limites, interdit des choses, et S'est tu sur d'autres par miséricorde : ce sur quoi Il S'est tu reste permis.",
    body="""1. Le texte du hadith

{{NAW:30}}

Traduction du sens : D'après Abū Thaʿlaba al-Khushanī, Jurthūm ibn Nāshir : le Messager d'Allah ﷺ a dit : « Allah, le Très-Haut, a prescrit des obligations : ne les négligez pas. Il a fixé des limites : ne les dépassez pas. Il a interdit des choses : ne les violez pas. Et Il S'est tu sur d'autres choses, par miséricorde pour vous et non par oubli : ne cherchez donc pas à leur sujet. » An-Nawawī a dit : hadith ḥasan (bon), rapporté par ad-Dāraquṭnī dans ses Sunan et par d'autres.

2. La phrase à retenir
« {{NAWS:30|إن الله تعالى فرض|تضيعوها}} » (inna llāha taʿālā faraḍa farāʾiḍa fa-lā tuḍayyiʿūhā).
Sens : « Allah a prescrit des obligations : ne les négligez pas. »

3. Explication
Allah a rendu certaines choses obligatoires, a fixé des limites et a interdit d'autres choses. Ce sur quoi Il S'est tu, par miséricorde pour Ses serviteurs, reste sur le principe de la permission : il ne faut pas aller fouiller à son sujet (selon HadeethEnc).

4. Ce que l'élève peut retenir
- Allah est le Législateur : c'est à Lui qu'appartient le commandement.
- Le hadith réunit les grandes catégories de règles : ce qui est demandé (obligatoire ou recommandé), ce qui est interdit (illicite ou déconseillé) et ce qui est permis.
- Ce sur quoi Allah S'est tu — sans l'imposer, sans le limiter, sans l'interdire — est permis.
- Il faut préserver les obligations d'Allah et ne pas dépasser Ses limites.

Exercice : classez trois exemples dans les catégories « obligation », « interdit » et « permis », puis répondez aux questions.""",
    refs=[
        naw(30, 'Ḥasan (bon) selon an-Nawawī', 'An-Nawawī', "Allah a prescrit des obligations…, d'après Abū Thaʿlaba al-Khushanī"),
        dict(kind='book', source_title='Sunan ad-Dāraquṭnī', author='Ad-Dāraquṭnī', locator='Hadith n° 4396 (selon HadeethEnc)',
             url='https://hadeethenc.com/fr/browse/hadith/66510',
             note="Référence relevée par HadeethEnc ; le texte d'an-Nawawī renvoie à « 4/184 »."),
        he(66510),
    ],
    questions=[
        ("Que faut-il faire des obligations prescrites par Allah ?", ["Ne pas les négliger", "Les oublier", "Les changer"], 0,
         "« Il a prescrit des obligations : ne les négligez pas. »"),
        ("Pourquoi Allah S'est-Il tu sur certaines choses ?", ["Par miséricorde, et non par oubli", "Par oubli", "Sans raison"], 0,
         "« Par miséricorde pour vous et non par oubli. »"),
        ("Quel est le statut de ce sur quoi Allah S'est tu ?", ["C'est permis", "C'est interdit", "C'est obligatoire"], 0,
         "Cela reste sur le principe de la permission."),
        ("Quel grade an-Nawawī a-t-il donné à ce hadith ?", ["Ḥasan (bon)", "Inventé", "Mutawātir"], 0,
         "An-Nawawī a dit : hadith ḥasan."),
        ("À qui appartient le droit de légiférer selon ce hadith ?", ["À Allah", "À chaque personne", "Aux coutumes"], 0,
         "Allah est le Législateur."),
    ],
)
