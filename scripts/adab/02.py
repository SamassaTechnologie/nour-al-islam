LESSON = dict(
    position=2,
    slug='les-dangers-de-la-langue',
    title="Les dangers de la langue : dire du bien ou se taire, la médisance, la calomnie et le mensonge",
    summary="Préserver sa langue d'après le Coran et la Sunna authentique : dire du bien ou se taire, le musulman dont les autres sont à l'abri de sa langue, la médisance (ghība) et la calomnie (buhtān), le colportage (namīma), le mensonge et la véracité, et le poids d'une seule parole.",
    body="""1. Dire du bien ou se taire
Le Prophète ﷺ a dit :
« {{AR:bukhari:6018|ومن كان يؤمن بالله واليوم الآخر فليقل خيرا|أو ليصمت}} » (wa man kāna yu’minu bi-llāhi wa l-yawmi l-ākhiri fal-yaqul khayran aw li-yaṣmut).
Sens : « Que celui qui croit en Allah et au Jour dernier dise du bien ou se taise. » (al-Bukhārī n° 6018, d'après Abū Hurayra ; hadith authentique).
Il a dit aussi : le musulman est celui dont les musulmans sont à l'abri de sa langue et de sa main (al-Bukhārī n° 10, d'après ʿAbd Allāh ibn ʿAmr). Et : celui qui me garantit ce qui est entre ses deux mâchoires et ce qui est entre ses deux jambes, je lui garantis le Paradis (al-Bukhārī n° 6474, d'après Sahl ibn Saʿd).
Allah rappelle que chaque parole est notée : l'homme ne prononce pas une parole sans qu'il y ait auprès de lui un observateur prêt à l'écrire (sourate Qāf, 50:18).

2. La médisance (ghība) et la calomnie (buhtān)
Le Prophète ﷺ demanda :
« {{AR:muslim:6593|أتدرون ما الغيبة|فقد بهته}} » (a-tadrūna ma l-ghība ? qālū : allāhu wa rasūluhu aʿlam. qāla : dhikruka akhāka bimā yakrah. qīla : a-fa-ra’ayta in kāna fī akhī mā aqūl ? qāla : in kāna fīhi mā taqūlu fa-qadi ghtabtah, wa in lam yakun fīhi fa-qad bahattah).
Sens : « Savez-vous ce qu'est la médisance ? » Ils dirent : « Allah et Son Messager savent mieux. » Il dit : « C'est que tu parles de ton frère d'une manière qui lui déplaît. » On demanda : « Et si ce que je dis est vrai de lui ? » Il dit : « Si c'est vrai, tu as médit de lui ; et si ce n'est pas vrai, tu l'as calomnié. » (Muslim n° 2589, d'après Abū Hurayra ; hadith authentique).
Allah dit : ne médisez pas les uns des autres ; l'un de vous aimerait-il manger la chair de son frère mort ? Vous en auriez horreur (sourate al-Ḥujurāt, 49:12).

3. Le colportage (namīma)
Ḥudhayfa apprit qu'un homme rapportait les propos des gens au calife ; il dit avoir entendu le Prophète ﷺ dire : « N'entrera pas au Paradis un colporteur (qattāt) » (al-Bukhārī n° 6056 ; hadith authentique).
Allah dit aussi : si un pervers vous apporte une nouvelle, vérifiez-la, de peur de nuire à des gens par ignorance (sourate al-Ḥujurāt, 49:6).

4. La véracité et le mensonge
Le Prophète ﷺ a dit :
« {{AR:bukhari:6094|إن الصدق يهدي إلى البر|حتى يكتب عند الله كذابا}} » (inna ṣ-ṣidqa yahdī ila l-birr, wa inna l-birra yahdī ila l-janna, wa inna r-rajula la-yaṣduqu ḥattā yakūna ṣiddīqā, wa inna l-kadhiba yahdī ila l-fujūr, wa inna l-fujūra yahdī ila n-nār, wa inna r-rajula la-yakdhibu ḥattā yuktaba ʿinda llāhi kadhdhābā).
Sens : « La véracité mène à la bonté, et la bonté mène au Paradis ; l'homme dit la vérité jusqu'à devenir très véridique. Le mensonge mène à la perversité, et la perversité mène au Feu ; l'homme ment jusqu'à être inscrit auprès d'Allah comme grand menteur. » (al-Bukhārī n° 6094, d'après Ibn Masʿūd ; hadith authentique).

5. Le poids d'une seule parole
Le Prophète ﷺ a dit que le serviteur peut prononcer une parole sans en mesurer la portée, qui le fait glisser dans le Feu plus loin que la distance entre l'orient (et l'occident) (al-Bukhārī n° 6477, d'après Abū Hurayra ; hadith authentique, en substance).

6. Ce que l'élève peut retenir
- Dire du bien ou se taire.
- La médisance : dire de son frère ce qui lui déplaît, même si c'est vrai ; si c'est faux, c'est une calomnie.
- Le colporteur n'entrera pas au Paradis ; on vérifie les nouvelles avant de les répéter.
- La véracité mène au Paradis, le mensonge au Feu.
Les cas où il est permis de parler d'une personne absente (par exemple pour demander justice ou un conseil) sont détaillés par les savants ; interrogez un savant pour un cas précis.

Exercice : pendant une journée, avant chaque parole sur une personne absente, demandez-vous si elle lui déplairait ; puis répondez aux questions.""",
    refs=[
        coll('bukhari', 6018, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« Qu'il dise du bien ou se taise », d'après Abū Hurayra",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 10, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Le musulman est celui dont les musulmans sont à l'abri de sa langue et de sa main, d'après ʿAbd Allāh ibn ʿAmr"),
        coll('bukhari', 6474, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Garantir ce qui est entre ses mâchoires et ses jambes, d'après Sahl ibn Saʿd"),
        quran(50, 18),
        dict(kind='hadith', collection='Ṣaḥīḥ Muslim', edition='Numérotation de sunnah.com', hadith_number='2589',
             grade='Authentique (ṣaḥīḥ)', graded_by='Recueil authentique de Muslim',
             source_title="Définition de la médisance et de la calomnie, d'après Abū Hurayra", url='https://sunnah.com/muslim:2589',
             note="Dialogue copié tel quel de l'édition de sunnah.com (base hadith-api)."),
        quran(49, 12),
        coll('bukhari', 6056, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "« N'entrera pas au Paradis un colporteur », d'après Ḥudhayfa"),
        quran(49, 6),
        coll('bukhari', 6094, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "La véracité mène au Paradis, le mensonge au Feu, d'après Ibn Masʿūd",
             "Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api)."),
        coll('bukhari', 6477, 'Authentique (ṣaḥīḥ)', "Recueil authentique d'al-Bukhārī",
             "Une parole dite sans réfléchir peut faire glisser dans le Feu, d'après Abū Hurayra"),
    ],
    questions=[
        ("Que doit faire celui qui croit en Allah et au Jour dernier, selon al-Bukhārī n° 6018 ?", ["Dire du bien ou se taire", "Parler de tout", "Ne jamais parler"], 0,
         "Al-Bukhārī n° 6018."),
        ("Qui est le musulman, d'après al-Bukhārī n° 10 ?", ["Celui dont les musulmans sont à l'abri de sa langue et de sa main", "Celui qui parle beaucoup", "Celui qui est riche"], 0,
         "Al-Bukhārī n° 10."),
        ("Qu'est-ce que la médisance (ghība) ?", ["Parler de son frère d'une manière qui lui déplaît", "Le saluer", "Lui donner un conseil en privé"], 0,
         "Muslim n° 2589."),
        ("Si ce que l'on dit de son frère est faux, c'est :", ["Une calomnie (buhtān)", "Une médisance permise", "Un conseil"], 0,
         "Muslim n° 2589."),
        ("À quoi le Coran compare-t-il la médisance ?", ["Manger la chair de son frère mort", "Boire de l'eau", "Faire du commerce"], 0,
         "Sourate al-Ḥujurāt, 49:12."),
        ("Que dit le Prophète ﷺ du colporteur (qattāt) ?", ["Il n'entrera pas au Paradis", "Il est récompensé", "Rien"], 0,
         "Al-Bukhārī n° 6056."),
        ("Que faire quand on reçoit une nouvelle d'une personne peu fiable ?", ["La vérifier", "La répéter tout de suite", "L'écrire partout"], 0,
         "Sourate al-Ḥujurāt, 49:6."),
        ("À quoi mène la véracité ?", ["À la bonté, puis au Paradis", "Au Feu", "À rien"], 0,
         "Al-Bukhārī n° 6094."),
    ],
)
