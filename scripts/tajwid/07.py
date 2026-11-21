WAJIZ_35 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/35'
WAJIZ_36 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/36'

L = dict(
    slug='ra-a-l-arret', position=7,
    title="Le rā’ quand on s'arrête sur lui",
    summary="À l'arrêt, le rā’ final devient sākin : trois cas où il est fin, épais dans les autres cas, ce qui change avec le rawm, et le mot firq où deux manières sont admises.",
    body="""La leçon précédente donnait les règles du rā’ en lecture continue. Quand on s'arrête sur un mot terminé par un rā’, ce rā’ prend un sukūn dû à l'arrêt, et c'est alors la lettre qui le précède qui décide (al-Wajīz fī ʿilm al-tajwīd).

1. Les trois cas où le rā’ est fin à l'arrêt
- Une kasra juste avant le rā’ : « {{Q:54:7:8}} » (muntashir), sourate 54, verset 7.
- Une kasra avant le rā’, séparée de lui par une lettre sākin qui n'est pas une lettre d'élévation : « {{Q:54:2:6}} » (siḥr), sourate 54, verset 2, si l'on s'arrête sur ce mot.
- Un yā’ sākin juste avant le rā’ : « {{Q:2:20:28}} » (qadīr), sourate 2, verset 20.

2. Dans tous les autres cas, le rā’ est épais à l'arrêt
- Après une fatḥa : « {{Q:54:1:4}} » (al-qamar), sourate 54, verset 1.
- Après une ḍamma : « {{Q:54:5:6}} » (an-nudhur), sourate 54, verset 5.
- Après une lettre sākin précédée d'une fatḥa : « {{Q:89:1:1}} » (wa l-fajr), sourate 89, verset 1. En lecture continue, ce rā’ porte une kasra et il est fin ; à l'arrêt, il devient épais.

3. L'arrêt avec le rawm
Ces règles valent quand on s'arrête avec un sukūn simple, et aussi avec l'ishmām (arrondir les lèvres sans voix). Si l'on s'arrête avec le rawm (prononcer une partie de la voyelle), le rā’ suit les règles de la lecture continue, car sa voyelle est encore en partie prononcée (al-Wajīz).

4. Un cas où deux manières sont admises : firq
Dans « {{Q:26:63:12}} » (firq), sourate 26, verset 63, le rā’ sākin vient après une kasra mais il est suivi d'une lettre d'élévation, le qāf, qui porte une kasra. Les savants ont divergé : certains l'épaississent à cause du qāf, d'autres l'affinent à cause de la kasra. Al-Wajīz explique que la kasra du qāf affaiblit son épaisseur, et que l'affinement est préféré. L'élève suit la manière de son enseignant.

Exercice : récitez le début de la sourate al-Qamar (54:1-7) en vous arrêtant à la fin de chaque verset, et dites pour chaque rā’ final s'il est épais ou fin.""",
    refs=[
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Le rā’ en lecture continue', url=WAJIZ_35,
             note="Règles du rā’ en lecture continue, rappelées en introduction. Pagination du site, pas de l'édition imprimée."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Le rā’ à l’arrêt ; le mot firq', url=WAJIZ_36,
             note="Fin à l'arrêt : kasra directe, kasra séparée par une lettre sākin non élevée, yā’ sākin ; épais sinon ; même règle avec l'ishmām ; avec le rawm, règles de la lecture continue ; firq : divergence, affinement préféré par l'auteur."),
        dict(kind='quran', surah=2, ayah_from=20, ayah_to=20),
        dict(kind='quran', surah=26, ayah_from=63, ayah_to=63),
        dict(kind='quran', surah=54, ayah_from=1, ayah_to=7),
        dict(kind='quran', surah=89, ayah_from=1, ayah_to=1),
    ],
    questions=[
        ("Quand on s'arrête sur un rā’ final, qu'est-ce qui décide s'il est épais ou fin ?", None, ["La lettre ou la voyelle qui le précède", "La lettre du mot suivant", "La longueur du verset"], 0,
         "À l'arrêt, le rā’ prend un sukūn : on regarde ce qui vient avant lui."),
        ("Dans lequel de ces cas le rā’ est-il fin à l'arrêt ?", None, ["Un yā’ sākin juste avant lui", "Une fatḥa juste avant lui", "Une ḍamma juste avant lui"], 0,
         "Les trois cas fins : kasra directe, kasra séparée par une lettre sākin non élevée, yā’ sākin."),
        ("Si l'on s'arrête avec le rawm, quelles règles suit le rā’ ?", None, ["Celles de la lecture continue", "Il est toujours épais", "Il est toujours fin"], 0,
         "Avec le rawm, une partie de la voyelle est prononcée : le rā’ suit les règles de la lecture continue."),
        ("Le rā’ final de ce mot est-il épais ou fin à l'arrêt ?", (54, 7, 8, 8), ["Fin : une kasra juste avant", "Épais : une fatḥa juste avant"], 0,
         "Muntashir : le shīn porte une kasra juste avant le rā’."),
        ("Le rā’ final de ce mot est-il épais ou fin à l'arrêt ?", (2, 20, 28, 28), ["Fin : un yā’ sākin juste avant", "Épais : une ḍamma juste avant"], 0,
         "Qadīr : un yā’ sākin vient juste avant le rā’."),
        ("Le rā’ final de ce mot est-il épais ou fin à l'arrêt ?", (54, 1, 4, 4), ["Fin : une kasra juste avant", "Épais : une fatḥa juste avant"], 1,
         "Al-qamar : le mīm porte une fatḥa, le rā’ est épais à l'arrêt."),
        ("Le rā’ final de ce mot est-il épais ou fin à l'arrêt ?", (89, 1, 1, 1), ["Fin, comme en lecture continue", "Épais : la lettre sākin avant lui est précédée d'une fatḥa"], 1,
         "Wa l-fajr : en lecture continue le rā’ porte une kasra et il est fin ; à l'arrêt il devient épais."),
        ("Que dit al-Wajīz du rā’ de ce mot ?", (26, 63, 12, 12), ["Les savants ont divergé ; l'affinement est préféré", "Il est toujours épais sans divergence", "Il n'y a pas de rā’ dans ce mot"], 0,
         "Firq : le qāf qui suit est une lettre d'élévation, mais sa kasra affaiblit son épaisseur."),
    ],
)
