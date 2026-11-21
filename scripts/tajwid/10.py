WAJIZ_57 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/57'
WAJIZ_58 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/58'

L = dict(
    slug='commencer-par-hamzat-al-wasl', position=10,
    title="Commencer la lecture par un alif de liaison (hamzat al-waṣl)",
    summary="Quelle voyelle donner à l'alif de liaison quand on commence par lui : dans les verbes selon la troisième lettre, dans les noms, dans l'article « al », et le cas particulier de bi’sa l-ismu.",
    body="""La leçon « L'alif de liaison et l'article « al » » (rubrique Lire l'arabe) a montré que cet alif, marqué ٱ dans le Mushaf de Médine, disparaît en lecture continue. Cette leçon explique comment le prononcer quand on commence la lecture par lui, par exemple après un arrêt.

1. Où trouve-t-on l'alif de liaison ?
D'après al-Wajīz fī ʿilm al-tajwīd, on le trouve : dans certains verbes (le passé et l'impératif des verbes de cinq et six lettres, et l'impératif des verbes de trois lettres), jamais dans le présent ; dans les noms d'action de ces verbes ; dans dix noms, parmi lesquels ism (nom), ibn (fils), ibna (fille), imru’ et imra’a (homme et femme), ithnān et ithnatān (deux) ; et, parmi les particules, seulement dans l'article « al ».

2. Dans les verbes : on regarde la troisième lettre
- Si la troisième lettre du verbe porte une ḍamma d'origine, on commence par « u » : « {{Q:16:125:1}} » se lit au début udʿu, sourate 16, verset 125.
- Si la troisième lettre porte une kasra ou une fatḥa, on commence par « i » : « {{Q:20:24:1}} » se lit idh-hab, sourate 20, verset 24 ; « {{Q:77:29:1}} » se lit inṭaliqū, sourate 77, verset 29.
- Attention aux verbes où la ḍamma de la troisième lettre n'est pas d'origine : on commence alors par « i ». Al-Wajīz cite notamment : « {{Q:10:71:31}} » (iqḍū), sourate 10, verset 71 ; « {{Q:38:6:5}} » (imshū), sourate 38, verset 6 ; « {{Q:46:4:19}} » (i’tūnī), sourate 46, verset 4. À l'origine, la troisième lettre de ces verbes portait une kasra ; elle a pris une ḍamma à cause du wāw qui suit.

3. Dans les noms : on commence par « i »
« {{Q:2:207:6}} » se lit au début ibtighā’a, sourate 2, verset 207 ; « {{Q:61:14:10}} » se lit ibnu, sourate 61, verset 14.

4. Dans l'article « al » : on commence par « a »
« {{Q:1:2:1}} » se lit al-ḥamdu, sourate 1, verset 2.

5. Un cas particulier : bi’sa l-ismu
Dans « {{Q:49:11:31}} {{Q:49:11:32}} », sourate 49, verset 11, si l'on commence par le deuxième mot, al-Wajīz permet deux manières : commencer par l'alif de liaison de l'article (al-ismu) ou directement par le lām (l-ismu).

Exercice : pour chaque exemple de la leçon, lisez le mot d'abord en commençant par lui, puis lié au mot qui le précède dans le verset, et comparez.""",
    refs=[
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator="Chapitre de l'alif de liaison (hamzat al-waṣl) : définition et emplacements", url=WAJIZ_57,
             note="Tombe en lecture continue, se prononce au début ; dans les verbes de cinq et six lettres et l'impératif des verbes de trois lettres, jamais au présent ; dix noms ; parmi les particules, seulement « al ». Pagination du site, pas de l'édition imprimée."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator="Commencer par l'alif de liaison : verbes, article, noms", url=WAJIZ_58,
             note="Verbes : ḍamma non d'origine → kasra (iqḍū 10:71, ibnū 18:21, imshū 38:6, i’tūnī 46:4) ; kasra ou fatḥa → kasra ; article : fatḥa ; bi’sa l-ismu (49:11) : commencer par la hamza ou par le lām ; noms d'action : kasra."),
        dict(kind='quran', surah=1, ayah_from=2, ayah_to=2),
        dict(kind='quran', surah=2, ayah_from=207, ayah_to=207),
        dict(kind='quran', surah=10, ayah_from=71, ayah_to=71),
        dict(kind='quran', surah=16, ayah_from=125, ayah_to=125),
        dict(kind='quran', surah=20, ayah_from=24, ayah_to=24),
        dict(kind='quran', surah=38, ayah_from=6, ayah_to=6),
        dict(kind='quran', surah=46, ayah_from=4, ayah_to=4),
        dict(kind='quran', surah=49, ayah_from=11, ayah_to=11),
        dict(kind='quran', surah=61, ayah_from=14, ayah_to=14),
        dict(kind='quran', surah=77, ayah_from=29, ayah_to=29),
    ],
    questions=[
        ("Quand prononce-t-on l'alif de liaison ?", None, ["Seulement quand on commence la lecture par ce mot", "Toujours", "Seulement à la fin d'un verset"], 0,
         "En lecture continue, il disparaît."),
        ("Par quelle voyelle commence-t-on l'article « al » ?", None, ["Fatḥa : « a »", "Kasra : « i »", "Ḍamma : « u »"], 0,
         "Al-ḥamdu, al-arḍ…"),
        ("Dans un verbe, quelle lettre regarde-t-on pour choisir la voyelle de l'alif de liaison ?", None, ["La troisième lettre", "La dernière lettre", "La lettre du mot suivant"], 0,
         "Ḍamma d'origine sur la troisième lettre : « u » ; sinon : « i »."),
        ("Comment commence-t-on ce mot ?", (16, 125, 1, 1), ["Udʿu : la troisième lettre porte une ḍamma d'origine", "Idʿu", "Adʿu"], 0,
         "Le ʿayn porte une ḍamma d'origine : on commence par « u »."),
        ("Comment commence-t-on ce mot ?", (20, 24, 1, 1), ["Idh-hab : la troisième lettre porte une fatḥa", "Udh-hab", "Adh-hab"], 0,
         "Le hā’ porte une fatḥa : on commence par « i »."),
        ("Comment commence-t-on ce mot ?", (38, 6, 5, 5), ["Imshū : la ḍamma du shīn n'est pas d'origine", "Umshū", "Amshū"], 0,
         "Al-Wajīz cite ce verbe parmi ceux dont la ḍamma vient du wāw qui suit."),
        ("Par quelle voyelle commence-t-on les noms comme ibn ou ibtighā’ ?", None, ["Kasra : « i »", "Fatḥa : « a »", "Ḍamma : « u »"], 0,
         "Dans les noms, l'alif de liaison se prononce avec une kasra."),
        ("Si l'on commence par le deuxième mot de cet extrait, quelles manières sont permises ?", (49, 11, 31, 32), ["Commencer par al-ismu ou par l-ismu", "Seulement par ismu", "On ne peut pas commencer par ce mot"], 0,
         "Al-Wajīz permet de commencer par l'alif de liaison ou par le lām."),
    ],
)
