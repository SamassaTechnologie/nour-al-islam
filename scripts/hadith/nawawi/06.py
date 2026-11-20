LESSON = dict(
    n=6, slug='nawawi-06-licite-illicite-et-douteux',
    title="Hadith 6 : le licite est clair, l'illicite est clair",
    summary="Entre le licite et l'illicite se trouvent des choses douteuses : les éviter protège la religion et l'honneur.",
    body="""1. Le texte du hadith

{{NAW:6}}

Traduction du sens : D'après Abū ʿAbd Allāh an-Nuʿmān ibn Bashīr, qui a dit : j'ai entendu le Messager d'Allah ﷺ dire : « Le licite est clair et l'illicite est clair. Entre les deux se trouvent des choses douteuses que beaucoup de gens ne connaissent pas. Celui qui se garde des choses douteuses préserve sa religion et son honneur ; et celui qui tombe dans les choses douteuses tombe dans l'illicite, comme le berger qui fait paître autour d'un domaine réservé et qui est sur le point d'y faire paître. Certes, chaque roi a un domaine réservé, et le domaine réservé d'Allah, ce sont Ses interdits. Certes, il y a dans le corps un morceau de chair : s'il est sain, tout le corps est sain, et s'il est corrompu, tout le corps est corrompu. Certes, c'est le cœur. » Rapporté par al-Bukhārī (n° 52) et Muslim (n° 1599). Hadith authentique.

2. La phrase à retenir
« {{NAWS:6|إن الحلال|الحرام بين}} » (inna l-ḥalāla bayyinun wa inna l-ḥarāma bayyin).
Sens : « Le licite est clair et l'illicite est clair. »

3. Explication
Le Prophète ﷺ donne une règle générale : selon la Loi, les choses se divisent en trois (selon HadeethEnc) :
- ce qui est clairement licite ;
- ce qui est clairement illicite ;
- des choses douteuses, dont le statut n'est pas clair et que beaucoup de gens ignorent.
Celui qui laisse les choses douteuses protège sa religion, car il s'éloigne de l'illicite, et protège son honneur des critiques des gens. Celui qui ne les évite pas s'expose à tomber dans l'illicite.
- L'exemple du berger : celui qui fait paître son troupeau tout près d'un terrain protégé finit presque par y entrer. De même, celui qui fréquente les choses douteuses se rapproche de l'interdit.
- Le hadith se termine par le cœur : s'il est sain, le corps tout entier est sain ; s'il est corrompu, le corps tout entier est corrompu.

4. Ce que l'élève peut retenir
- Le hadith pose une règle pour se garder des choses douteuses (shubuhāt).
- Il encourage fortement à laisser ce dont le statut n'est pas clair.
- La réforme du cœur est la base de la réforme des actes.

Exercice : expliquez l'exemple du berger avec vos propres mots, puis répondez aux questions.""",
    refs=[
        naw(6, 'Authentique (ṣaḥīḥ)', 'Al-Bukhārī et Muslim', "Le licite est clair et l'illicite est clair, d'après an-Nuʿmān ibn Bashīr"),
        coll('bukhari', 52, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī", 'Livre de la foi'),
        coll('muslim', 1599, 'Authentique (ṣaḥīḥ)', 'Recueil authentique de Muslim', 'Livre de la vente (musāqāt)', url_number='1599a'),
        he(66515),
    ],
    questions=[
        ("En combien de catégories ce hadith divise-t-il les choses ?", ["Deux", "Trois", "Cinq"], 1,
         "Le licite clair, l'illicite clair, et les choses douteuses entre les deux."),
        ("Que protège celui qui évite les choses douteuses ?", ["Sa religion et son honneur", "Seulement son argent", "Seulement sa santé"], 0,
         "Il s'éloigne de l'illicite et se protège des critiques des gens."),
        ("Que représente le « domaine réservé » d'Allah ?", ["La Mecque", "Ses interdits", "Le Paradis"], 1,
         "Le hadith le dit : le domaine réservé d'Allah, ce sont Ses interdits."),
        ("Quel est le morceau de chair dont dépend tout le corps ?", ["Le foie", "Le cœur", "La langue"], 1,
         "S'il est sain, tout le corps est sain ; s'il est corrompu, tout le corps est corrompu."),
        ("Que nous apprend l'exemple du berger ?", ["Celui qui s'approche du douteux risque de tomber dans l'interdit", "Il faut élever des moutons", "Les rois sont injustes"], 0,
         "Comme le troupeau qui broute au bord d'un terrain protégé finit par y entrer."),
    ],
)
