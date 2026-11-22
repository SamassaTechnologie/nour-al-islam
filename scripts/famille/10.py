LESSON = dict(
    position=10,
    slug='l-heritage-exemples-de-calcul',
    title="L'héritage (2) : exemples de calcul",
    summary="Six exemples simples de partage, calculés avec les règles de la leçon précédente et vérifiés par un programme (somme des parts égale à la totalité) : épouse et enfants, parents et fils, mari et fils, fille et père, parents seuls, deux filles et un frère. Les cas complexes sont signalés.",
    body="""1. La méthode
On applique les règles de la leçon « L'héritage (1) » :
1) on règle d'abord le testament (au plus un tiers) et les dettes (4:11-12) ;
2) on donne les parts fixées par le Coran (4:11-12) ;
3) le reste va au plus proche parent homme ; entre fils et filles, le garçon reçoit la part de deux filles (al-Bukhārī n° 6732 ; 4:11).
Chaque exemple ci-dessous a été calculé et vérifié par un programme de NOUR AL-ISLAM : la somme des parts est exactement égale à la totalité, et chaque montant tombe juste. Les sommes en FCFA sont des exemples, après paiement des dettes et du testament.

2. Exemple 1 : l'épouse, un fils et une fille (2 400 000 FCFA)
- L'épouse : un huitième, car le défunt a des enfants (4:12) : 300 000 FCFA.
- Le reste (sept huitièmes) est partagé entre le fils et la fille, le fils recevant deux parts et la fille une (4:11) :
  - le fils : 7/12, soit 1 400 000 FCFA ;
  - la fille : 7/24, soit 700 000 FCFA.

3. Exemple 2 : l'épouse, le père, la mère et un fils (2 400 000 FCFA)
- L'épouse : un huitième (4:12) : 300 000 FCFA.
- Le père : un sixième, et la mère : un sixième, car le défunt a un enfant (4:11) : 400 000 FCFA chacun. As-Saʿdī précise qu'avec un fils, le père ne reçoit pas plus du sixième (tafsir de 4:11).
- Le fils : le reste, 13/24, soit 1 300 000 FCFA.

4. Exemple 3 : le mari et un fils (1 200 000 FCFA)
- Le mari : un quart, car l'épouse a un enfant (4:12) : 300 000 FCFA.
- Le fils : le reste, trois quarts, soit 900 000 FCFA.

5. Exemple 4 : une fille et le père (1 200 000 FCFA)
- La fille unique : la moitié (4:11) : 600 000 FCFA.
- Le père : un sixième comme part fixée (200 000 FCFA), puis le reste (400 000 FCFA), soit 800 000 FCFA au total. As-Saʿdī l'explique ainsi : quand l'enfant est une fille et qu'il reste quelque chose après sa part, le père prend le sixième puis le reste, selon le hadith « donnez les parts fixées à ceux qui y ont droit » (tafsir de 4:11).

6. Exemple 5 : le père et la mère seuls (900 000 FCFA)
Le défunt n'a ni enfant, ni frère ou sœur, ni conjoint.
- La mère : un tiers (4:11) : 300 000 FCFA.
- Le père : le reste, deux tiers : 600 000 FCFA.
Attention : si un conjoint hérite aussi avec les deux parents, le calcul est différent ; ce cas n'est pas traité ici.

7. Exemple 6 : deux filles et un frère germain (1 500 000 FCFA)
Le défunt n'a ni fils ni petit-fils par un fils, ni père ni grand-père paternel.
- Les deux filles ensemble : deux tiers (par accord des savants, comme l'explique as-Saʿdī) : 1 000 000 FCFA, soit 500 000 FCFA chacune.
- Le frère germain, plus proche parent homme : le reste, un tiers : 500 000 FCFA.

8. Les cas complexes
Certains cas demandent des règles que cette leçon ne traite pas : par exemple quand la somme des parts fixées dépasse la totalité, quand il reste une part sans parent homme pour la prendre, ou quand un conjoint hérite avec les deux parents. Ces cas, et ceux où des héritiers en excluent d'autres, doivent être réglés par un savant ou un juge spécialisé dans les successions.

9. Ce que l'élève peut retenir
- On règle d'abord les dettes et le testament, puis les parts fixées, puis le reste.
- La part de l'épouse et du mari dépend de la présence d'enfants.
- Avec un fils, le père reçoit le sixième ; avec seulement une fille, il reçoit le sixième puis le reste.
- Pour un héritage réel, faites toujours vérifier le partage par un savant.

Exercice : une femme meurt en laissant son mari et un fils ; la succession est de 2 000 000 FCFA. Calculez la part de chacun. (Réponse : le mari un quart, 500 000 FCFA ; le fils le reste, 1 500 000 FCFA.) Puis répondez aux questions.""",
    refs=[
        quran(4, 11),
        quran(4, 12),
        coll('bukhari', 6732, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Donnez les parts fixées à ceux qui y ont droit », d'après Ibn ʿAbbās"),
        book("Taysīr al-Karīm ar-Raḥmān (tafsir d'as-Saʿdī), 4:11", "ʿAbd ar-Raḥmān as-Saʿdī", "Texte de QuranEnc (version 1.0.0), verrouillé dans l'application",
             "https://nour-al-islam.vercel.app/coran/4/tafsir?source=saadi",
             "Le père avec un fils : pas plus du sixième ; avec une fille : le sixième puis le reste ; deux filles : deux tiers (accord)."),
        book("Programme de vérification des exemples", "NOUR AL-ISLAM", "scripts/famille/heritage_check.py",
             "https://github.com/SamassaTechnologie/nour-al-islam/blob/main/scripts/famille/heritage_check.py",
             "Calcule chaque exemple en fractions exactes et vérifie que la somme des parts vaut 1."),
    ],
    questions=[
        ("Dans l'exemple 1, quelle est la part de l'épouse ?", ["Un huitième", "Un quart", "La moitié"], 0,
         "Sourate an-Nisā’, 4:12."),
        ("Dans l'exemple 1, combien reçoit le fils par rapport à la fille ?", ["Le double", "La même chose", "La moitié"], 0,
         "Sourate an-Nisā’, 4:11."),
        ("Avec un fils, combien reçoit le père ?", ["Un sixième", "La moitié", "Rien"], 0,
         "Sourate an-Nisā’, 4:11 ; as-Saʿdī."),
        ("Quelle est la part du mari quand l'épouse laisse un enfant ?", ["Un quart", "La moitié", "Un huitième"], 0,
         "Sourate an-Nisā’, 4:12."),
        ("Avec une fille unique, que reçoit le père en plus de son sixième ?", ["Le reste après les parts fixées", "Rien de plus", "La part de la fille"], 0,
         "As-Saʿdī, tafsir de 4:11 ; al-Bukhārī n° 6732."),
        ("Quand les deux parents héritent seuls, quelle est la part de la mère ?", ["Un tiers", "Un sixième", "La moitié"], 0,
         "Sourate an-Nisā’, 4:11."),
        ("Dans l'exemple 6, pourquoi le frère germain reçoit-il le reste ?", ["Il est le plus proche parent homme", "Il est le plus âgé", "Par tirage au sort"], 0,
         "Al-Bukhārī n° 6732."),
        ("Que faire pour un héritage réel ou un cas complexe ?", ["Le faire vérifier par un savant ou un juge spécialisé", "Partager à parts égales", "Laisser l'aîné décider"], 0,
         "Conseil de la leçon."),
    ],
)
