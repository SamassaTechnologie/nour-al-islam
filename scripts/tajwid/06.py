WAJIZ_12 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/12'
WAJIZ_34 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/34'
WAJIZ_35 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/35'
MUKHT_9 = 'https://usul.ai/hi/t/the-concise-guide-to-tajweed-rulings/9'

L = dict(
    slug='tafkhim-et-tarqiq', position=6,
    title="Les lettres épaisses et fines (tafkhīm et tarqīq), le lām du nom d'Allah et le rā’",
    summary="Quelles lettres se prononcent toujours épaisses, leurs degrés, quand le lām du nom « Allah » est épais ou fin, et les règles du rā’ en lecture continue.",
    body="""1. Épais et fin
Le tafkhīm (épaississement) est un renforcement du son de la lettre : la bouche se remplit de son écho. Le tarqīq (affinement) est l'inverse : le son de la lettre est léger et ne remplit pas la bouche (al-Wajīz fī ʿilm al-tajwīd).

2. Les sept lettres toujours épaisses
Ce sont les lettres d'élévation (istiʿlā’), pendant lesquelles l'arrière de la langue s'élève vers le palais. Elles sont réunies dans l'expression « خص ضغط قظ » (khuṣṣa ḍaghṭin qiẓ) : khā’, ṣād, ḍād, ghayn, ṭā’, qāf et ẓā’. Elles sont toujours épaisses, sans exception. Parmi elles, quatre sont encore plus épaisses car la langue se colle au palais (iṭbāq) : ṣād, ḍād, ṭā’ et ẓā’ (al-Wajīz).
Les autres lettres sont fines, sauf le lām et le rā’ dans certains cas, et sauf l'alif (al-Wajīz).

3. Les degrés de l'épaisseur
Al-Wajīz donne cinq degrés, du plus fort au plus faible, avec la lettre ṭā’ :
- avec une fatḥa suivie d'un alif : « {{Q:41:11:16}} » (ṭā’iʿīn), sourate 41, verset 11 ;
- avec une fatḥa sans alif après ;
- avec une ḍamma ;
- avec un sukūn : « {{Q:106:4:2}} » (aṭʿamahum), sourate 106, verset 4 ;
- avec une kasra, le degré le plus faible : « {{Q:39:73:19}} » (ṭibtum), sourate 39, verset 73.
Même au degré le plus faible, ces lettres restent épaisses.

4. Le lām du nom « Allah »
Le lām du nom « Allah » est épais quand il vient après une fatḥa ou une ḍamma, et fin quand il vient après une kasra (al-Wajīz ; al-Mukhtaṣar al-mufīd).
- Après une ḍamma, épais : « {{Q:110:1:3}} {{Q:110:1:4}} » (naṣru llāh), sourate 110, verset 1.
- Après une fatḥa, épais : « {{Q:2:9:1}} {{Q:2:9:2}} » (yukhādiʿūna llāh), sourate 2, verset 9.
- Après une kasra, fin : « {{Q:110:2:5}} {{Q:110:2:6}} » (dīni llāh), sourate 110, verset 2.
Les autres lām sont fins.

5. Le rā’ en lecture continue
D'après al-Wajīz :
- Le rā’ avec une kasra est fin, toujours : « {{Q:24:37:1}} » (rijāl), sourate 24, verset 37.
- Le rā’ avec une fatḥa ou une ḍamma est épais : « {{Q:2:201:4}} » (rabbanā), sourate 2, verset 201.
- Le rā’ avec un sukūn est fin s'il vient après une kasra d'origine, dans le même mot, et s'il n'est pas suivi d'une lettre d'élévation dans le même mot : « {{Q:20:24:3}} » (firʿawn), sourate 20, verset 24.
- Le rā’ avec un sukūn est épais s'il vient après une fatḥa ou une ḍamma : « {{Q:9:129:16}} » (al-ʿarsh), sourate 9, verset 129.
Les règles du rā’ quand on s'arrête sur lui feront l'objet d'une autre leçon.

Exercice : récitez la sourate al-Naṣr (110) et repérez le lām épais du verset 1 et le lām fin du verset 2 ; puis cherchez dans la Fātiḥa un rā’ épais.""",
    refs=[
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Les caractéristiques des lettres : l’élévation (istiʿlā’) et l’adhérence (iṭbāq)', url=WAJIZ_12,
             note="Lettres d'élévation réunies dans « خص ضغط قظ » ; lettres d'adhérence : ṣād, ḍād, ṭā’, ẓā’. Pagination du site, pas de l'édition imprimée."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Le tafkhīm et le tarqīq', url=WAJIZ_34,
             note="Définitions ; lettres d'élévation épaisses sans exception ; autres lettres fines sauf le lām et le rā’ dans certains cas, et l'alif ; cinq degrés avec les exemples ṭā’iʿīn, ṭalaban, yasṭurūn, aṭʿamahum, ṭibtum."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Le lām du nom « Allah » et le rā’', url=WAJIZ_35,
             note="Lām du nom « Allah » épais après fatḥa ou ḍamma, fin après kasra ; rā’ en lecture continue : fin avec kasra, ou sākin après une kasra d'origine sans lettre d'élévation après ; épais sinon."),
        dict(kind='book', source_title='al-Mukhtaṣar al-mufīd fī aḥkām al-tajwīd', author='Muḥammad Ḥasan al-Ḥimṣī',
             locator='Le lām du nom « Allah »', url=MUKHT_9,
             note="Fin après une kasra d'origine ou accidentelle ; épais après une fatḥa ou une ḍamma."),
        dict(kind='quran', surah=2, ayah_from=9, ayah_to=9),
        dict(kind='quran', surah=2, ayah_from=201, ayah_to=201),
        dict(kind='quran', surah=9, ayah_from=129, ayah_to=129),
        dict(kind='quran', surah=20, ayah_from=24, ayah_to=24),
        dict(kind='quran', surah=24, ayah_from=37, ayah_to=37),
        dict(kind='quran', surah=39, ayah_from=73, ayah_to=73),
        dict(kind='quran', surah=41, ayah_from=11, ayah_to=11),
        dict(kind='quran', surah=106, ayah_from=4, ayah_to=4),
        dict(kind='quran', surah=110, ayah_from=1, ayah_to=2),
    ],
    questions=[
        ("Combien y a-t-il de lettres toujours épaisses (lettres d'élévation) ?", None, ["Sept", "Quatre", "Vingt-huit"], 0,
         "Elles sont réunies dans l'expression « khuṣṣa ḍaghṭin qiẓ »."),
        ("Lequel de ces groupes contient seulement des lettres toujours épaisses ?", None, ["ṣād, ḍād, ṭā’, ẓā’", "bā’, tā’, thā’, jīm", "lām, mīm, nūn"], 0,
         "Ce sont les lettres d'adhérence (iṭbāq), les plus épaisses."),
        ("Quel est le degré le plus faible de l'épaisseur ?", None, ["La lettre avec une kasra", "La lettre avec une fatḥa suivie d'un alif", "La lettre avec une ḍamma"], 0,
         "Même avec une kasra, la lettre d'élévation reste épaisse, mais au degré le plus faible."),
        ("Quand le lām du nom « Allah » est-il fin ?", None, ["Après une kasra", "Après une fatḥa", "Après une ḍamma"], 0,
         "Après une kasra il est fin ; après une fatḥa ou une ḍamma il est épais."),
        ("Le lām du nom « Allah » dans cet extrait est-il épais ou fin ?", (110, 1, 3, 4), ["Épais : il vient après une ḍamma", "Fin : il vient après une kasra"], 0,
         "Naṣru llāh : le rā’ de naṣru porte une ḍamma, le lām du nom « Allah » est donc épais."),
        ("Le lām du nom « Allah » dans cet extrait est-il épais ou fin ?", (110, 2, 5, 6), ["Épais : il vient après une fatḥa", "Fin : il vient après une kasra"], 1,
         "Dīni llāh : le nūn de dīni porte une kasra, le lām du nom « Allah » est donc fin."),
        ("Le rā’ de ce mot est-il épais ou fin ?", (24, 37, 1, 1), ["Fin : il porte une kasra", "Épais : il porte une fatḥa"], 0,
         "Rijāl : le rā’ porte une kasra, il est fin."),
        ("Le rā’ de ce mot est-il épais ou fin ?", (20, 24, 3, 3), ["Fin : rā’ sākin après une kasra d'origine dans le même mot", "Épais : rā’ sākin après une fatḥa"], 0,
         "Firʿawn : le rā’ sākin vient après la kasra du fā’, et aucune lettre d'élévation ne le suit : il est fin."),
        ("Le rā’ de ce mot est-il épais ou fin ?", (9, 129, 16, 16), ["Fin : rā’ sākin après une kasra", "Épais : rā’ sākin après une fatḥa"], 1,
         "Al-ʿarsh : le rā’ sākin vient après la fatḥa du ʿayn : il est épais."),
    ],
)
