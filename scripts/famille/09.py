LESSON = dict(
    position=9,
    slug='l-heritage-les-principes-et-les-parts-fixees-par-le-coran',
    title="L'héritage (1) : les principes et les parts fixées par le Coran",
    summary="Allah a fixé Lui-même les parts d'héritage. Le testament limité au tiers et jamais pour un héritier ; pas d'héritage entre musulman et non-musulman ; les parts des enfants, des parents, des époux et des frères et sœurs (4:11, 4:12, 4:176) ; le reste au plus proche parent homme.",
    body="""1. Des parts fixées par Allah
Allah dit : Allah vous recommande, au sujet de vos enfants… ces parts sont obligatoires de la part d'Allah, Il est Omniscient et Sage (sourate an-Nisā’, 4:11) ; ce sont les limites d'Allah (4:13-14). Les parts ne sont donc pas choisies par la famille.
Le Prophète ﷺ a dit :
« {{AR:bukhari:6732|ألحقوا الفرائض|لأولى رجل ذكر}} » (alḥiqū l-farā’iḍa bi-ahlihā, fa-mā baqiya fahwa li-awlā rajulin dhakar).
Sens : « Donnez les parts fixées à ceux qui y ont droit, et ce qui reste revient au plus proche parent de sexe masculin. » (al-Bukhārī n° 6732, d'après Ibn ʿAbbās ; hadith authentique).

2. Avant le partage : le testament et les dettes
Le Coran précise que le partage se fait après l'exécution du testament et le paiement des dettes (sourate an-Nisā’, 4:11-12).
Le testament est limité au tiers : Saʿd ibn Abī Waqqāṣ voulut léguer tous ses biens, puis la moitié ; le Prophète ﷺ refusa et dit : le tiers, et le tiers c'est beaucoup ; laisser tes héritiers riches vaut mieux que les laisser dans le besoin, à tendre la main aux gens (al-Bukhārī n° 2742).
Pas de testament pour un héritier :
« {{AR:abudawud:2870|إن الله قد أعطى|فلا وصية لوارث}} » (inna llāha qad aʿṭā kulla dhī ḥaqqin ḥaqqah, fa-lā waṣiyyata li-wārith).
Sens : « Allah a donné à chaque ayant droit son droit : pas de testament pour un héritier. » (Abū Dāwūd n° 2870, d'après Abū Umāma ; « ḥasan ṣaḥīḥ » selon al-Albānī).

3. Pas d'héritage entre musulman et non-musulman
Le Prophète ﷺ a dit :
« {{AR:bukhari:6764|لا يرث المسلم|ولا الكافر المسلم}} » (lā yarithu l-muslimu l-kāfir, wa lā l-kāfiru l-muslim).
Sens : « Le musulman n'hérite pas du mécréant, ni le mécréant du musulman. » (al-Bukhārī n° 6764, d'après Usāma ibn Zayd ; hadith authentique).

4. Les parts fixées par le Coran
Les enfants (4:11) :
- fils et filles ensemble : au garçon, l'équivalent de la part de deux filles ;
- seulement des filles : plus de deux, les deux tiers ; une seule, la moitié ; pour deux filles, les deux tiers aussi, par accord des savants, comme l'explique as-Saʿdī.
Les parents (4:11) :
- si le défunt a un enfant : un sixième au père et un sixième à la mère ;
- s'il n'a pas d'enfant et que ses parents héritent : un tiers à la mère ; s'il a des frères, un sixième à la mère.
Les époux (4:12) :
- le mari : la moitié si l'épouse n'a pas d'enfant, le quart si elle en a ;
- l'épouse (ou les épouses ensemble) : le quart si le mari n'a pas d'enfant, le huitième s'il en a.
Les frères et sœurs utérins (même mère seulement) quand il n'y a ni ascendant ni descendant (al-kalāla) (4:12) : un sixième pour un seul ; s'ils sont plusieurs, ils partagent un tiers.
Les frères et sœurs germains ou consanguins dans la kalāla (4:176) : une sœur, la moitié ; deux sœurs ou plus, les deux tiers ; frères et sœurs ensemble, au frère la part de deux sœurs.
Précisions d'as-Saʿdī (tafsir de 4:11-12, consultable dans l'application) : les filles du fils prennent la place des filles en leur absence ; l'« enfant » dont l'existence change les parts comprend les enfants du fils, mais pas les enfants de la fille, par accord des savants ; les frères et sœurs de 4:12 sont, par accord des savants, ceux de même mère ; et la kalāla est le cas où le défunt ne laisse ni ascendant ni descendant, comme l'a expliqué Abū Bakr.

5. Ce que l'élève peut retenir
- Les parts d'héritage sont fixées par Allah, pas par la famille.
- On exécute d'abord le testament (au plus un tiers, jamais pour un héritier) et on paie les dettes.
- Pas d'héritage entre musulman et non-musulman.
- On donne d'abord les parts fixées, puis le reste au plus proche parent homme.
La leçon suivante donnera des exemples de calcul. Pour un héritage réel, adressez-vous à un savant ou à un juge spécialisé.

Exercice : un homme meurt en laissant son épouse, un fils et une fille. Selon le verset 4:12, quelle est la part de l'épouse ? (Réponse : le huitième, car il a des enfants.) Puis répondez aux questions.""",
    refs=[
        quran(4, 11),
        quran(4, 12),
        quran(4, 13, 14),
        quran(4, 176),
        coll('bukhari', 6732, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Donnez les parts fixées à ceux qui y ont droit », d'après Ibn ʿAbbās",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 2742, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le testament limité au tiers, d'après Saʿd ibn Abī Waqqāṣ"),
        coll('abudawud', 2870, 'Ḥasan ṣaḥīḥ (al-Albānī) ; ḥasan (Shuʿayb al-Arnaʾūṭ)', "Jugements affichés sur sunnah.com",
             "« Pas de testament pour un héritier », d'après Abū Umāma",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6764, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Pas d'héritage entre musulman et mécréant, d'après Usāma ibn Zayd",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        book("Taysīr al-Karīm ar-Raḥmān (tafsir d'as-Saʿdī), 4:11-12", "ʿAbd ar-Raḥmān as-Saʿdī", "Texte de QuranEnc (version 1.0.0), verrouillé dans l'application",
             "https://nour-al-islam.vercel.app/coran/4/tafsir?source=saadi",
             "Deux filles : deux tiers (accord) ; l'enfant comprend les enfants du fils, pas ceux de la fille (accord) ; frères et sœurs utérins en 4:12 (accord) ; définition de la kalāla par Abū Bakr."),
    ],
    questions=[
        ("Qui a fixé les parts d'héritage ?", ["Allah, dans le Coran", "La famille", "Le plus âgé"], 0,
         "Sourate an-Nisā’, 4:11."),
        ("Quelle est la limite du testament ?", ["Le tiers", "La moitié", "Tout le bien"], 0,
         "Al-Bukhārī n° 2742."),
        ("Peut-on faire un testament pour un héritier ?", ["Non", "Oui", "Seulement pour le fils aîné"], 0,
         "Abū Dāwūd n° 2870."),
        ("Le musulman hérite-t-il du non-musulman ?", ["Non", "Oui", "Seulement de ses parents"], 0,
         "Al-Bukhārī n° 6764."),
        ("Quand il y a des fils et des filles, quelle est la part du garçon ?", ["Celle de deux filles", "La même que la fille", "Tout l'héritage"], 0,
         "Sourate an-Nisā’, 4:11."),
        ("Quelle est la part de la fille unique sans frère ?", ["La moitié", "Le tiers", "Le quart"], 0,
         "Sourate an-Nisā’, 4:11."),
        ("Quelle est la part de l'épouse si le mari a des enfants ?", ["Le huitième", "Le quart", "La moitié"], 0,
         "Sourate an-Nisā’, 4:12."),
        ("À qui revient le reste après les parts fixées ?", ["Au plus proche parent homme", "À l'État", "À la mère toujours"], 0,
         "Al-Bukhārī n° 6732."),
    ],
)
