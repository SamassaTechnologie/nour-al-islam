LESSON = dict(
    n=33, slug='nawawi-33-la-preuve-incombe-au-demandeur',
    title="Hadith 33 : la preuve incombe au demandeur",
    summary="On ne donne rien sur une simple prétention : celui qui réclame doit apporter une preuve, et celui qui nie prête serment.",
    body="""1. Le texte du hadith

{{NAW:33}}

Traduction du sens : D'après Ibn ʿAbbās : le Messager d'Allah ﷺ a dit : « Si l'on donnait aux gens selon leurs simples prétentions, des hommes réclameraient les biens et le sang d'autres personnes. Mais la preuve incombe au demandeur, et le serment à celui qui nie. » An-Nawawī a dit : hadith ḥasan, rapporté ainsi par al-Bayhaqī et d'autres ; une partie se trouve dans les deux Ṣaḥīḥ (al-Bukhārī et Muslim).

2. La phrase à retenir
« {{NAWS:33|البينة|أنكر}} » (al-bayyinatu ʿalā l-muddaʿī wa l-yamīnu ʿalā man ankar).
Sens : « La preuve incombe au demandeur, et le serment à celui qui nie. »

3. Explication
Si l'on donnait aux gens selon leurs simples réclamations, sans preuve ni indice, certains réclameraient injustement les biens et le sang des autres. C'est pourquoi celui qui réclame doit apporter une preuve claire. S'il n'en a pas, on présente la réclamation à celui qui la nie ; s'il nie, on lui demande de jurer, et il est alors déclaré non redevable (selon HadeethEnc).

4. Ce que l'élève peut retenir
- HadeethEnc cite Ibn Daqīq al-ʿĪd : ce hadith est l'un des fondements des jugements et la grande référence en cas de litige.
- La Loi islamique protège les biens et la vie des gens contre les manipulations.
- Le juge ne tranche pas selon ce qu'il sait personnellement, mais selon les preuves.
- Toute prétention sans preuve est rejetée, qu'elle concerne des droits, des transactions, ou même des questions de croyance et de science.

Exercice : expliquez avec vos mots pourquoi on demande une preuve à celui qui réclame, puis répondez aux questions.""",
    refs=[
        naw(33, 'Ḥasan (bon) selon an-Nawawī', 'An-Nawawī', "La preuve incombe au demandeur, d'après Ibn ʿAbbās"),
        dict(kind='book', source_title='As-Sunan al-Kubrā', author='Al-Bayhaqī', locator='Hadith n° 21243, éd. at-Turkī (selon HadeethEnc)',
             url='https://hadeethenc.com/fr/browse/hadith/66532', note="Le texte d'an-Nawawī renvoie à « 10/252 »."),
        he(66532),
    ],
    questions=[
        ("À qui incombe la preuve ?", ["Au demandeur", "À celui qui nie", "Au juge"], 0,
         "« La preuve incombe au demandeur. »"),
        ("Que fait celui qui nie, si le demandeur n'a pas de preuve ?", ["Il prête serment", "Il paie automatiquement", "Il quitte le pays"], 0,
         "« Et le serment à celui qui nie. »"),
        ("Que se passerait-il si l'on donnait aux gens selon leurs simples prétentions ?", ["Certains réclameraient injustement les biens et le sang des autres", "Tout le monde serait juste", "Il n'y aurait plus de disputes"], 0,
         "C'est la raison donnée au début du hadith."),
        ("Sur quoi le juge tranche-t-il ?", ["Sur les preuves", "Sur ce qu'il sait personnellement", "Sur la richesse des parties"], 0,
         "C'est l'un des enseignements relevés par HadeethEnc."),
        ("Quel grade an-Nawawī donne-t-il à ce hadith ?", ["Ḥasan", "Faible", "Inventé"], 0,
         "Et une partie se trouve dans les deux Ṣaḥīḥ."),
    ],
)
