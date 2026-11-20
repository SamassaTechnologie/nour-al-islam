LESSON = dict(
    n=41, slug='nawawi-41-que-ses-penchants-suivent-la-revelation',
    title="Hadith 41 : que ses penchants suivent ce qu'a apporté le Prophète ﷺ",
    summary="La foi n'est complète que lorsque les désirs suivent ce qu'a apporté le Prophète ﷺ. Les savants divergent sur l'authenticité de ce hadith, mais son sens est juste.",
    body="""1. Le texte du hadith

{{NAW:41}}

Traduction du sens : D'après Abū Muḥammad ʿAbd Allāh ibn ʿAmr ibn al-ʿĀṣ : le Messager d'Allah ﷺ a dit : « Aucun de vous n'est vraiment croyant tant que ses penchants ne suivent pas ce que j'ai apporté. » An-Nawawī a dit : hadith ḥasan ṣaḥīḥ, que nous avons rapporté dans le livre « al-Ḥujja » avec une chaîne authentique.

2. Le grade de ce hadith : une divergence entre savants
Ce hadith n'est ni dans al-Bukhārī ni dans Muslim, et les savants ne sont pas d'accord sur son authenticité :
- An-Nawawī l'a jugé authentique (ḥasan ṣaḥīḥ), comme on le lit dans son recueil ; HadeethEnc reprend ce jugement.
- Ibn Rajab, dans son explication des Quarante hadiths (Jāmiʿ al-ʿulūm wa l-ḥikam), a dit que le déclarer authentique est « très éloigné », pour plusieurs raisons liées à sa chaîne de transmission.
- Le cheikh Ibn Bāz a répondu à ce sujet : certains l'ont jugé authentique et d'autres faible ; il y a de la faiblesse dans sa chaîne, mais son sens est juste.
Le sens, lui, est confirmé par d'autres textes, comme le verset 65 de la sourate 4 (an-Nisāʾ), qui conditionne la foi au fait d'accepter le jugement du Prophète ﷺ sans réticence.

3. La phrase à retenir
« {{NAWS:41|لا يؤمن|جئت به}} » (lā yuʾminu aḥadukum ḥattā yakūna hawāhu tabaʿan li-mā jiʾtu bih).
Sens : « Aucun de vous n'est vraiment croyant tant que ses penchants ne suivent pas ce que j'ai apporté. »

4. Explication
La foi n'est complète que lorsque les penchants de la personne se conforment à ce qu'a apporté le Prophète ﷺ : elle aime ce qu'il a ordonné et déteste ce qu'il a interdit (selon HadeethEnc).

5. Ce que l'élève peut retenir
- C'est une règle de base de la soumission à la Loi d'Allah.
- Celui qui place sa raison ou ses habitudes au-dessus de ce qu'a apporté le Messager ﷺ n'a pas la foi complète (selon HadeethEnc).
- Il faut prendre la Révélation comme juge en toute chose.
- La foi augmente par l'obéissance et diminue par la désobéissance.
- Quand les savants divergent sur un hadith, on présente honnêtement leurs avis.

Exercice : expliquez pourquoi un hadith peut être discuté dans sa chaîne tout en ayant un sens juste, puis répondez aux questions.""",
    refs=[
        naw(41, 'Ḥasan ṣaḥīḥ selon an-Nawawī ; jugé faible par Ibn Rajab', 'An-Nawawī ; Ibn Rajab',
            "Que ses penchants suivent ce que j'ai apporté, d'après ʿAbd Allāh ibn ʿAmr"),
        dict(kind='book', source_title="Jāmiʿ al-ʿulūm wa l-ḥikam", author='Ibn Rajab al-Ḥanbalī', locator='Explication du hadith 41 (2/393 selon ad-Durar as-Saniyya)',
             url='https://dorar.net/hadith/sharh/113229', note="Ibn Rajab y juge très éloigné de le déclarer authentique, pour plusieurs raisons liées à sa chaîne."),
        dict(kind='book', source_title="Fatwa : le jugement du hadith « lā yuʾminu aḥadukum ḥattā yakūna hawāhu… »", author='Ibn Bāz',
             locator='Fatwa n° 15783 (site officiel)', url='https://binbaz.org.sa/fatwas/15783'),
        quran(4, 65),
        he(66535),
    ],
    questions=[
        ("Que signifie « ḥattā yakūna hawāhu tabaʿan li-mā jiʾtu bih » ?", ["Tant que ses penchants ne suivent pas ce que j'ai apporté", "Tant qu'il ne prie pas la nuit", "Tant qu'il n'est pas riche"], 0,
         "La foi complète demande que les désirs suivent la Révélation."),
        ("Les savants sont-ils d'accord sur l'authenticité de ce hadith ?", ["Non : an-Nawawī l'a jugé authentique, Ibn Rajab l'a jugé faible", "Oui, tous le jugent authentique", "Oui, tous le jugent inventé"], 0,
         "C'est une divergence connue entre savants."),
        ("Qu'a dit le cheikh Ibn Bāz de ce hadith ?", ["Sa chaîne est faible, mais son sens est juste", "Il est inventé et son sens est faux", "Il est dans al-Bukhārī"], 0,
         "Fatwa n° 15783 sur son site officiel."),
        ("Que doit aimer le croyant selon l'explication de HadeethEnc ?", ["Ce que le Prophète ﷺ a ordonné", "Tout ce que veulent ses désirs", "Ce que pensent les gens"], 0,
         "Et détester ce qu'il a interdit."),
        ("Quel verset confirme le sens de ce hadith ?", ["Sourate 4, verset 65", "Sourate 1, verset 1", "Sourate 114, verset 1"], 0,
         "Il conditionne la foi à l'acceptation du jugement du Prophète ﷺ."),
    ],
)
