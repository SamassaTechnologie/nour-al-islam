LESSON = dict(
    n=5, slug='nawawi-05-innovations-rejetees',
    title="Hadith 5 : toute innovation dans la religion est rejetée",
    summary="Une œuvre religieuse qui n'est pas conforme à ce qu'a enseigné le Prophète ﷺ n'est pas acceptée.",
    body="""1. Le texte du hadith

{{NAW:5}}

Traduction du sens : D'après la mère des croyants, Umm ʿAbd Allāh ʿĀʾisha, qui a dit : le Messager d'Allah ﷺ a dit : « Quiconque introduit dans notre affaire que voici (la religion) ce qui n'en fait pas partie, cela est rejeté. » Rapporté par al-Bukhārī (n° 2697) et Muslim (n° 1718). Dans une version de Muslim : « Quiconque accomplit une œuvre qui n'est pas conforme à notre affaire, elle est rejetée. » Hadith authentique.

2. La phrase à retenir
« {{NAWS:5|من أحدث|فهو رد}} » (man aḥdatha fī amrinā hādhā mā laysa minhu fa-huwa radd).
Sens : « Quiconque introduit dans notre affaire que voici ce qui n'en fait pas partie, cela est rejeté. »

3. Explication
Le Prophète ﷺ explique que celui qui invente quelque chose dans la religion, ou qui accomplit une adoration qui ne repose sur aucune preuve du Coran ou de la Sunna, voit cette œuvre rejetée : elle n'est pas acceptée auprès d'Allah (selon HadeethEnc).
- « Notre affaire » désigne la religion.
- L'innovation (bidʿa) est ce qui a été ajouté à la religion et qui n'existait pas à l'époque du Prophète ﷺ et de ses Compagnons, qu'il s'agisse d'une croyance, d'une parole ou d'un acte.
- Ce hadith est comme une balance des œuvres : de même qu'une œuvre qui ne vise pas le Visage d'Allah n'apporte aucune récompense, une œuvre qui n'est pas conforme à ce qu'a apporté le Messager ﷺ est rejetée (selon HadeethEnc). Le hadith 1 (les intentions) traite du premier point, ce hadith du second.

4. Ce que l'élève peut retenir
- On n'adore Allah que par ce qu'Il a prescrit dans le Coran et la Sunna.
- La religion n'est pas une affaire d'opinion personnelle : elle repose sur le suivi du Messager ﷺ.
- Ce hadith montre que la religion est complète.
- L'interdiction concerne les nouveautés dans la religion, pas les choses de la vie courante (outils, techniques, moyens de transport…).

Exercice : citez une nouveauté de la vie courante qui n'est pas concernée par ce hadith, puis répondez aux questions.""",
    refs=[
        naw(5, 'Authentique (ṣaḥīḥ)', 'Al-Bukhārī et Muslim', "Quiconque introduit dans notre affaire ce qui n'en fait pas partie, d'après ʿĀʾisha"),
        coll('bukhari', 2697, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī", 'Livre de la réconciliation'),
        coll('muslim', 1718, 'Authentique (ṣaḥīḥ)', 'Recueil authentique de Muslim', 'Livre des jugements', url_number='1718a'),
        he(66514),
    ],
    questions=[
        ("Que signifie « fa-huwa radd » ?", ["Cela est rejeté", "Cela est recommandé", "Cela est permis"], 0,
         "L'œuvre inventée dans la religion n'est pas acceptée auprès d'Allah."),
        ("Que désigne « notre affaire » dans ce hadith ?", ["Le commerce", "La religion", "La politique"], 1,
         "« Notre affaire » désigne la religion apportée par le Prophète ﷺ."),
        ("Qu'est-ce que l'innovation (bidʿa) dans la religion ?", ["Ce qui a été ajouté à la religion et n'existait pas à l'époque du Prophète ﷺ et de ses Compagnons", "Toute invention technique", "Toute nouvelle langue apprise"], 0,
         "Il s'agit d'une croyance, d'une parole ou d'un acte ajouté à la religion."),
        ("Les nouveautés de la vie courante (téléphone, voiture…) sont-elles visées par ce hadith ?", ["Oui", "Non, il s'agit des nouveautés dans la religion"], 1,
         "L'interdiction concerne ce qui touche à la religion, et non les affaires de ce monde."),
        ("Quelles sont les deux conditions d'une œuvre acceptée, en réunissant les hadiths 1 et 5 ?", ["La faire pour Allah et selon la voie du Prophète ﷺ", "La faire souvent et en public", "La faire seul et la nuit"], 0,
         "Le hadith 1 parle de l'intention sincère, le hadith 5 de la conformité à la Sunna."),
    ],
)
