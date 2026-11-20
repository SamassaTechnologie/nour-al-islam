LESSON = dict(
    n=12, slug='nawawi-12-delaisser-ce-qui-ne-nous-regarde-pas',
    title="Hadith 12 : délaisser ce qui ne nous regarde pas",
    summary="Fait partie du bon islam de la personne qu'elle laisse ce qui ne la concerne pas, en paroles comme en actes.",
    body="""1. Le texte du hadith

{{NAW:12}}

Traduction du sens : D'après Abū Hurayra : le Messager d'Allah ﷺ a dit : « Fait partie du bon islam de la personne qu'elle délaisse ce qui ne la regarde pas. » An-Nawawī a dit : hadith ḥasan (bon). Rapporté par at-Tirmidhī (n° 2317 dans la numérotation de sunnah.com) et Ibn Mājah (n° 3976).

2. La phrase à retenir
« {{NAWS:12|من حسن|يعنيه}} » (min ḥusni islāmi l-marʾi tarkuhu mā lā yaʿnīh).
Sens : « Fait partie du bon islam de la personne qu'elle délaisse ce qui ne la regarde pas. »

3. Explication
Parmi les plus belles qualités de l'islam du musulman, il y a le fait de laisser ce qui ne le concerne pas, en paroles comme en actes, dans les affaires religieuses comme dans celles de ce monde. S'occuper de ce qui ne nous regarde pas détourne souvent de ce qui nous regarde, ou entraîne vers le mal ; et chacun sera interrogé sur ses actes le Jour de la Résurrection (selon HadeethEnc).
HadeethEnc rapporte aussi le commentaire d'Ibn al-Qayyim : selon lui, le Prophète ﷺ a résumé en une seule parole la voie du bien et du salut, et elle englobe ce que l'on dit, regarde, écoute, fait, et même ce à quoi l'on pense.

4. Ce que l'élève peut retenir
- Les gens n'ont pas tous le même niveau d'islam : sa beauté augmente par certaines œuvres.
- Laisser le futile et le superflu, en paroles et en actes, est un signe de bon islam.
- À l'inverse, s'occuper de ce qui nous concerne, dans la religion et dans la vie, fait aussi partie de la beauté de l'islam.

Exercice : citez deux exemples de choses « qui ne nous regardent pas » et que l'on peut laisser, puis répondez aux questions.""",
    refs=[
        naw(12, 'Ḥasan (bon)', 'An-Nawawī', "Fait partie du bon islam de la personne…, d'après Abū Hurayra"),
        coll('tirmidhi', 2317, 'Ḥasan selon an-Nawawī', 'An-Nawawī', "Livre de l'ascèse",
             note="Le texte d'an-Nawawī indique le n° 2318 (autre numérotation)."),
        coll('ibnmajah', 3976, 'Ḥasan selon an-Nawawī', 'An-Nawawī', 'Livre des épreuves'),
        he(65255),
    ],
    questions=[
        ("Que signifie « tarkuhu mā lā yaʿnīh » ?", ["Délaisser ce qui ne le regarde pas", "Faire ce qui lui plaît", "Parler de tout"], 0,
         "C'est un signe du bon islam de la personne."),
        ("Quel grade an-Nawawī a-t-il donné à ce hadith ?", ["Ḥasan (bon)", "Faible", "Inventé"], 0,
         "An-Nawawī a dit : hadith ḥasan."),
        ("Ce hadith concerne-t-il seulement les paroles ?", ["Oui, uniquement les paroles", "Non, les paroles et les actes"], 1,
         "HadeethEnc précise : en paroles comme en actes."),
        ("Pourquoi s'occuper de ce qui ne nous regarde pas est-il dangereux ?", ["Cela détourne de ce qui nous regarde et peut mener au mal", "Cela fatigue les yeux", "Cela coûte de l'argent"], 0,
         "Et chacun sera interrogé sur ses actes."),
        ("Selon Ibn al-Qayyim, cité par HadeethEnc, que résume ce hadith ?", ["La voie du bien et du salut", "Les règles de la prière", "L'histoire des prophètes"], 0,
         "Il englobe la parole, le regard, l'écoute, les gestes et les pensées."),
    ],
)
