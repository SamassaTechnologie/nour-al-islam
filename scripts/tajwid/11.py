MUKHT_9 = 'https://usul.ai/hi/t/the-concise-guide-to-tajweed-rulings/9'
WAJIZ_28 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/28'
WAJIZ_34 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/34'

L = dict(
    slug='alif-et-ta-devant-ta', position=11,
    title="L'alif épais ou fin, et le ṭā’ devant le tā’",
    summary="Deux compléments : l'alif se prononce épais après une lettre d'élévation et fin sinon ; le ṭā’ sākin entre dans le tā’ en gardant son adhérence (basaṭta, aḥaṭtu, farraṭtu).",
    body="""Cette leçon complète deux leçons précédentes : « Les lettres épaisses et fines » et « Deux lettres qui se rencontrent ».

1. L'alif : épais ou fin selon la lettre d'avant
L'alif ne porte jamais de voyelle : il est toujours sākin, précédé d'une fatḥa (al-Wajīz fī ʿilm al-tajwīd). Il n'a pas d'épaisseur propre. Al-Mukhtaṣar al-mufīd le range parmi les lettres qui sont tantôt épaisses, tantôt fines : il est épais quand une lettre d'élévation le précède, et fin sinon.
- Épais : « {{Q:79:34:3}} » (aṭ-ṭāmmah), sourate 79, verset 34 ; « {{Q:80:33:3}} » (aṣ-ṣākhkhah), sourate 80, verset 33. Le ṭā’ et le ṣād sont des lettres d'élévation.
- Fin : « {{Q:1:4:1}} » (māliki), sourate 1, verset 4 : le mīm n'est pas une lettre d'élévation.
Rappel : al-Wajīz place la lettre d'élévation suivie d'un alif au plus haut degré de l'épaisseur.

2. Le ṭā’ sākin devant le tā’ : un idghām incomplet
Quand un ṭā’ sākin est suivi d'un tā’, le ṭā’ entre dans le tā’, mais on garde l'adhérence (iṭbāq) du ṭā’ : c'est un idghām incomplet (nāqiṣ). On prononce donc un tā’ doublé, mais la langue garde la position épaisse du ṭā’ au début (al-Wajīz).
Exemples : « {{Q:5:28:2}} » (basaṭta), sourate 5, verset 28 ; « {{Q:27:22:5}} » (aḥaṭtu), sourate 27, verset 22 ; « {{Q:39:56:7}} » (farraṭtu), sourate 39, verset 56.
On peut observer dans le texte du Mushaf de Médine que, dans ces mots, le ṭā’ ne porte pas de sukūn et le tā’ ne porte pas de chadda.

Exercice : lisez « basaṭta » lentement, une fois en faisant entendre un ṭā’ complet (faute), puis correctement, en gardant seulement l'adhérence du ṭā’ avant le tā’ doublé ; demandez à votre enseignant de vous écouter.""",
    refs=[
        dict(kind='book', source_title='al-Mukhtaṣar al-mufīd fī aḥkām al-tajwīd', author='Muḥammad Ḥasan al-Ḥimṣī',
             locator='Le tafkhīm et le tarqīq : les lettres variables', url=MUKHT_9,
             note="L'alif, le lām et le rā’ varient ; l'alif est épais après une lettre d'élévation (aṭ-ṭāmmah, aṣ-ṣākhkhah) et fin sinon."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator="Fin du chapitre des lettres de même origine ; début du chapitre de la prolongation", url=WAJIZ_28,
             note="Le ṭā’ entre dans le tā’ par un idghām incomplet en gardant l'adhérence : basaṭta, aḥaṭtu, farraṭtu ; l'alif est toujours sākin et précédé d'une fatḥa. Pagination du site, pas de l'édition imprimée."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Le tafkhīm et le tarqīq : les degrés', url=WAJIZ_34,
             note="Plus haut degré d'épaisseur : lettre d'élévation avec fatḥa suivie d'un alif."),
        dict(kind='quran', surah=1, ayah_from=4, ayah_to=4),
        dict(kind='quran', surah=5, ayah_from=28, ayah_to=28),
        dict(kind='quran', surah=27, ayah_from=22, ayah_to=22),
        dict(kind='quran', surah=39, ayah_from=56, ayah_to=56),
        dict(kind='quran', surah=79, ayah_from=34, ayah_to=34),
        dict(kind='quran', surah=80, ayah_from=33, ayah_to=33),
    ],
    questions=[
        ("Quand l'alif est-il épais selon al-Mukhtaṣar al-mufīd ?", None, ["Quand une lettre d'élévation le précède", "Toujours", "Jamais"], 0,
         "Sinon, il est fin."),
        ("L'alif de ce mot est-il épais ou fin ?", (79, 34, 3, 3), ["Épais : il vient après le ṭā’", "Fin : il vient après une lettre fine"], 0,
         "Aṭ-ṭāmmah : le ṭā’ est une lettre d'élévation."),
        ("L'alif de ce mot est-il épais ou fin ?", (1, 4, 1, 1), ["Épais", "Fin : il vient après le mīm"], 1,
         "Māliki : le mīm n'est pas une lettre d'élévation, l'alif est fin."),
        ("Que se passe-t-il quand un ṭā’ sākin est suivi d'un tā’ ?", None, ["Idghām incomplet : on garde l'adhérence du ṭā’", "Iẓhār complet des deux lettres", "Le tā’ disparaît"], 0,
         "Basaṭta, aḥaṭtu, farraṭtu."),
        ("Quel idghām se trouve dans ce mot ?", (5, 28, 2, 2), ["Le ṭā’ dans le tā’, incomplet", "Le nūn dans le bā’", "Aucun"], 0,
         "Basaṭta : on garde l'adhérence du ṭā’ avant le tā’."),
        ("Dans l'idghām incomplet du ṭā’ dans le tā’, que garde-t-on du ṭā’ ?", None, ["Son adhérence (iṭbāq)", "Sa voyelle", "Rien du tout"], 0,
         "Al-Wajīz : l'idghām est incomplet car l'adhérence du ṭā’ est conservée."),
    ],
)
