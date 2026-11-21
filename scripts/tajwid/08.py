WAJIZ_25 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/25'
WAJIZ_26 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/26'
WAJIZ_27 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/27'

L = dict(
    slug='lettres-semblables-proches', position=8,
    title="Deux lettres qui se rencontrent : semblables, proches et de même origine",
    summary="Quand une lettre sākin rencontre la lettre suivante : l'idghām obligatoire des lettres semblables, et les cas précis où l'on fait l'idghām des lettres proches ou de même point d'articulation, dans la lecture de Ḥafṣ.",
    body="""Quand deux lettres se rencontrent dans l'écriture, al-Wajīz les classe selon leur point d'articulation (makhraj) et leurs caractéristiques (ṣifāt) :
- semblables (mutamāthilān) : même point d'articulation et mêmes caractéristiques, comme deux bā’ ;
- proches (mutaqāribān) : points d'articulation ou caractéristiques proches, comme le lām et le rā’ ;
- de même origine (mutajānisān) : même point d'articulation mais caractéristiques différentes, comme le dāl et le tā’.
Quand la première des deux lettres est sākin, on parle de cas « petit » (ṣaghīr) : c'est le cas étudié dans cette leçon. L'idghām consiste à faire entrer la première lettre dans la seconde, qui se prononce alors avec une chadda.

1. Deux lettres semblables : idghām obligatoire
Quand la première est sākin, l'idghām est obligatoire pour tous les lecteurs : « {{Q:27:28:1}} {{Q:27:28:2}} » (idh-hab bi-kitābī), sourate 27, verset 28.
Exception : si la première lettre est une lettre de prolongation, on ne fait pas l'idghām, pour ne pas perdre la prolongation : « {{Q:103:3:3}} {{Q:103:3:4}} » (āmanū wa ʿamilū), sourate 103, verset 3.

2. Deux lettres proches : en général sans idghām
La règle générale est de prononcer clairement la première lettre (iẓhār) : « {{Q:58:1:1}} {{Q:58:1:2}} » (qad samiʿa), sourate 58, verset 1.
Deux exceptions :
- Le lām sākin entre dans le rā’ : « {{Q:23:118:1}} {{Q:23:118:2}} » (wa qur rabbi), sourate 23, verset 118 ; « {{Q:4:158:1}} {{Q:4:158:2}} » (bar rafaʿahu), sourate 4, verset 158.
- Le qāf entre dans le kāf dans « {{Q:77:20:2}} » (nakhlukkum), sourate 77, verset 20. Les savants ont divergé : idghām complet, où l'on prononce un kāf doublé, ou idghām incomplet, où l'on garde l'élévation du qāf. Al-Wajīz juge l'idghām complet plus correct.

3. Deux lettres de même origine : en général sans idghām
La règle générale est aussi l'iẓhār, avec ces exceptions où l'on fait l'idghām :
- le dāl dans le tā’ : « {{Q:2:256:6}} {{Q:2:256:7}} » (qat tabayyana), sourate 2, verset 256 ;
- le tā’ dans le dāl : « {{Q:10:89:3}} {{Q:10:89:4}} » (ujībad daʿwatukumā), sourate 10, verset 89 ;
- le tā’ dans le ṭā’ : « {{Q:61:14:24}} {{Q:61:14:25}} » (fa-āmanaṭ ṭā’ifah), sourate 61, verset 14 ;
- le dhāl dans le ẓā’ : « {{Q:4:64:12}} {{Q:4:64:13}} » (iẓ ẓalamū), sourate 4, verset 64 ;
- le bā’ dans le mīm : « {{Q:11:42:14}} {{Q:11:42:15}} » (irkam maʿanā), sourate 11, verset 42 ;
- le thā’ dans le dhāl, à un seul endroit : sourate 7, verset 176 (yalhadh dhālik).
La chadda écrite sur la seconde lettre, dans le Mushaf de Médine, signale ces idghām.

Exercice : lisez lentement chaque exemple, d'abord en séparant les deux mots, puis en les liant avec l'idghām, et répondez aux questions.""",
    refs=[
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Chapitre des lettres semblables, proches, de même origine et éloignées : définitions', url=WAJIZ_25,
             note="Définitions avec les exemples idh-hab bi-kitābī, wa qul rabbi, qad samiʿa, qad tabayyana. Pagination du site, pas de l'édition imprimée."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Règle des lettres semblables', url=WAJIZ_26,
             note="Cas petit : idghām obligatoire pour tous, sauf si la première lettre est une lettre de prolongation (āmanū wa ʿamilū) ou le hā’ de pause."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Règles des lettres proches et de même origine', url=WAJIZ_27,
             note="Proches : iẓhār sauf lām dans rā’ et qāf dans kāf (nakhlukkum, idghām complet plus correct) ; de même origine : iẓhār sauf dāl dans tā’, dhāl dans ẓā’, thā’ dans dhāl (7:176), bā’ dans mīm (11:42), tā’ dans dāl et dans ṭā’."),
        dict(kind='quran', surah=2, ayah_from=256, ayah_to=256),
        dict(kind='quran', surah=4, ayah_from=64, ayah_to=64),
        dict(kind='quran', surah=4, ayah_from=158, ayah_to=158),
        dict(kind='quran', surah=7, ayah_from=176, ayah_to=176),
        dict(kind='quran', surah=10, ayah_from=89, ayah_to=89),
        dict(kind='quran', surah=11, ayah_from=42, ayah_to=42),
        dict(kind='quran', surah=23, ayah_from=118, ayah_to=118),
        dict(kind='quran', surah=27, ayah_from=28, ayah_to=28),
        dict(kind='quran', surah=58, ayah_from=1, ayah_to=1),
        dict(kind='quran', surah=61, ayah_from=14, ayah_to=14),
        dict(kind='quran', surah=77, ayah_from=20, ayah_to=20),
        dict(kind='quran', surah=103, ayah_from=3, ayah_to=3),
    ],
    questions=[
        ("Que sont deux lettres « semblables » (mutamāthilān) ?", None, ["Deux lettres de même point d'articulation et de mêmes caractéristiques", "Deux lettres de points d'articulation éloignés", "Une lettre et une voyelle"], 0,
         "Par exemple deux bā’ ou deux lām."),
        ("Quand la première de deux lettres semblables est sākin, que fait-on ?", None, ["L'idghām, obligatoire pour tous", "L'iẓhār", "Une pause"], 0,
         "Sauf si la première est une lettre de prolongation."),
        ("Pourquoi ne fait-on pas l'idghām dans āmanū wa ʿamilū ?", None, ["Le premier wāw est une lettre de prolongation", "Les deux lettres sont différentes", "Il y a un arrêt obligatoire"], 0,
         "L'idghām ferait disparaître la prolongation."),
        ("Que fait-on dans cet extrait ?", (58, 1, 1, 2), ["L'iẓhār : le dāl est prononcé clairement", "L'idghām du dāl dans le sīn"], 0,
         "Qad samiʿa : dāl et sīn sont proches, et la règle générale des lettres proches est l'iẓhār."),
        ("Que fait-on dans cet extrait ?", (23, 118, 1, 2), ["L'idghām du lām dans le rā’", "L'iẓhār du lām"], 0,
         "Wa qur rabbi : le lām sākin entre dans le rā’, l'une des deux exceptions des lettres proches."),
        ("Quelle manière al-Wajīz juge-t-il la plus correcte dans ce mot ?", (77, 20, 2, 2), ["L'idghām complet : un kāf doublé", "L'idghām incomplet en gardant l'élévation du qāf", "L'iẓhār du qāf"], 0,
         "Les savants ont divergé ; al-Wajīz juge l'idghām complet plus correct."),
        ("Quelle lettre entre dans quelle lettre dans cet extrait ?", (2, 256, 6, 7), ["Le dāl dans le tā’", "Le tā’ dans le dāl", "Le qāf dans le kāf"], 0,
         "Qat tabayyana : dāl et tā’ ont le même point d'articulation."),
        ("Quelle lettre entre dans quelle lettre dans cet extrait ?", (11, 42, 14, 15), ["Le bā’ dans le mīm", "Le mīm dans le bā’", "Le rā’ dans le kāf"], 0,
         "Irkam maʿanā : le bā’ sākin entre dans le mīm, une exception des lettres de même origine."),
    ],
)
