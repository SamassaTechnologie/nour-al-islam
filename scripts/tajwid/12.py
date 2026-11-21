W8 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/8'
W9 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/9'
W10 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/10'

L = dict(
    slug='points-d-articulation', position=12,
    title="Les points d'articulation des lettres (makhārij al-ḥurūf)",
    summary="D'où sort chaque lettre : comment trouver le point d'articulation d'une lettre, les cinq grandes zones et les dix-sept points retenus par al-Wajīz, de la gorge aux lèvres et au nez.",
    body="""Bien prononcer une lettre commence par la faire sortir de son point d'articulation (makhraj). Al-Wajīz fī ʿilm al-tajwīd compare les points d'articulation à des balances qui donnent à chaque lettre sa juste mesure. Les savants les ont rangés en suivant l'air qui monte des poumons vers la bouche.

1. Comment trouver le point d'articulation d'une lettre
On met la lettre avec un sukūn ou une chadda, on la fait précéder d'un alif de liaison, et l'on écoute : l'endroit où la voix s'arrête est le point d'articulation de la lettre. Par exemple : ab, at, ath… (al-Wajīz).

2. Les cinq grandes zones
La cavité (al-jawf), la gorge (al-ḥalq), la langue (al-lisān), les deux lèvres (ash-shafatān) et le nez (al-khayshūm). Al-Wajīz y distingue dix-sept points précis.

3. La cavité (1 point)
1. La cavité de la bouche et de la gorge : les trois lettres de prolongation, l'alif, le wāw sākin après une ḍamma et le yā’ sākin après une kasra.

4. La gorge (3 points)
2. Le fond de la gorge : la hamza (ء) et le hā’ (هـ).
3. Le milieu de la gorge : le ʿayn (ع) puis le ḥā’ (ح).
4. Le haut de la gorge, près de la bouche : le ghayn (غ) puis le khā’ (خ).
Ces six lettres sont appelées les lettres de la gorge (ḥalqiyya).

5. La langue (10 points)
5. L'arrière de la langue avec le palais : le qāf (ق).
6. Un peu plus bas que le qāf : le kāf (ك).
7. Le milieu de la langue : le jīm (ج), le shīn (ش) et le yā’ qui n'est pas de prolongation (ي).
8. Un des bords de la langue : le ḍād (ض) ; le côté gauche est plus facile que le droit.
9. Les deux bords de la langue, vers l'avant : le lām (ل).
10. Le bout de la langue : le nūn (ن).
11. Le bout de la langue avec un peu de son dos : le rā’ (ر). Le lām, le nūn et le rā’ sont appelées lettres de la pointe (dhalaqiyya).
12. Le bout de la langue contre la racine des incisives supérieures : le ṭā’ (ط), le dāl (د) et le tā’ (ت).
13. Le bout de la langue au-dessus des incisives inférieures : le ṣād (ص), le sīn (س) et le zāy (ز).
14. Le bout de la langue contre le bout des incisives supérieures : le ẓā’ (ظ), le dhāl (ذ) et le thā’ (ث).

6. Les lèvres (2 points)
15. L'intérieur de la lèvre inférieure contre le bout des incisives supérieures : le fā’ (ف).
16. Les deux lèvres ensemble : le bā’ (ب), le mīm (م) et le wāw qui n'est pas de prolongation (و). Pour le wāw, les lèvres restent un peu ouvertes ; pour le bā’, elles se ferment plus fort que pour le mīm.

7. Le nez (1 point)
17. Le fond du nez (al-khayshūm) : c'est de là que sort la ghunna (nasalisation) du nūn et du mīm. Pendant l'ikhfā’ et l'idghām avec ghunna, ils passent entièrement par le nez ; avec une chadda, ils sortent de leur point d'origine et du nez ; avec une voyelle ou un sukūn clair, seulement de leur point d'origine (al-Wajīz).

Cette leçon suit la répartition en dix-sept points d'al-Wajīz.

Exercice : pour chacune des lettres ع, ح, غ, خ, ق et ك, faites-la précéder d'un alif de liaison avec un sukūn (aʿ, aḥ, agh, akh, aq, ak) et sentez où la voix s'arrête.""",
    refs=[
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator="Chapitre des points d'articulation : méthode, cinq zones, points 1 à 6", url=W8,
             note="Méthode : sukūn ou chadda précédé d'un alif de liaison ; cinq zones générales ; dix-sept points. Pagination du site, pas de l'édition imprimée."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator="Points 7 à 15", url=W9,
             note="Milieu de la langue (ج ش ي), bord (ض), lām, nūn, rā’, ط د ت, ص س ز, ظ ذ ث, fā’."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator="Points 16 et 17 ; introduction aux caractéristiques", url=W10,
             note="Les deux lèvres (ب م و) ; le khayshūm, lieu de la ghunna du nūn et du mīm selon leur état ; comparaison des points d'articulation à des balances."),
    ],
    questions=[
        ("Comment trouve-t-on le point d'articulation d'une lettre ?", None, ["On la met avec un sukūn après un alif de liaison et l'on écoute où la voix s'arrête", "On la prononce très fort", "On regarde sa forme écrite"], 0,
         "Par exemple : ab, at, aq…"),
        ("Combien de grandes zones d'articulation y a-t-il ?", None, ["Cinq", "Trois", "Dix-sept"], 0,
         "La cavité, la gorge, la langue, les lèvres et le nez."),
        ("Combien de points précis al-Wajīz retient-il ?", None, ["Dix-sept", "Cinq", "Vingt-huit"], 0,
         "Al-Wajīz retient dix-sept points précis, regroupés en cinq zones."),
        ("Quelles lettres sortent de la cavité (al-jawf) ?", None, ["Les trois lettres de prolongation", "La hamza et le hā’", "Le bā’ et le mīm"], 0,
         "L'alif, le wāw sākin après une ḍamma et le yā’ sākin après une kasra."),
        ("D'où sortent le ʿayn et le ḥā’ ?", None, ["Du milieu de la gorge", "Du fond de la gorge", "Des lèvres"], 0,
         "Le fond de la gorge donne la hamza et le hā’ ; le haut, le ghayn et le khā’."),
        ("Quelle lettre sort d'un des bords de la langue ?", None, ["Le ḍād", "Le dāl", "Le ẓā’"], 0,
         "Le côté gauche est plus facile que le droit, selon al-Wajīz."),
        ("Quelles lettres sortent des deux lèvres ensemble ?", None, ["Le bā’, le mīm et le wāw non prolongé", "Le fā’ seul", "Le nūn et le lām"], 0,
         "Le fā’ sort de la lèvre inférieure avec les incisives supérieures."),
        ("D'où sort la ghunna du nūn et du mīm ?", None, ["Du fond du nez (al-khayshūm)", "Du milieu de la gorge", "Du bout de la langue"], 0,
         "Al-khayshūm est le dix-septième point."),
    ],
)
