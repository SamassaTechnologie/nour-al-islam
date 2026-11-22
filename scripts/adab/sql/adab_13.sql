-- Bonnes manières 13 : la-science-et-son-merite
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-science-et-son-merite$x$, 'lesson', $x$adab$x$, 'fr', 13) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La science religieuse et son mérite$x$, $x$Allah élève les savants et ordonne d'interroger les gens du savoir ; « Seigneur, augmente-moi en science ». Celui à qui Allah veut du bien, Il lui donne la compréhension de la religion ; le chemin de la science mène au Paradis ; transmettre sans mentir sur le Prophète ﷺ ; la disparition de la science et le danger de parler sans savoir.$x$, $x$1. La science dans le Coran
Allah ordonne à Son Prophète ﷺ de dire : Seigneur, augmente-moi en science (sourate Ṭā-Hā, 20:114). Il demande : sont-ils égaux, ceux qui savent et ceux qui ne savent pas ? (sourate az-Zumar, 39:9). Il élève en degrés ceux qui ont cru et ceux qui ont reçu la science (sourate al-Mujādila, 58:11). Il ordonne d'interroger les gens du rappel si l'on ne sait pas (sourate an-Naḥl, 16:43), et de ne pas suivre ce dont on n'a aucune connaissance (sourate al-Isrā’, 17:36).

2. La compréhension de la religion est un bien
Le Prophète ﷺ a dit :
« مَنْ يُرِدِ اللَّهُ بِهِ خَيْرًا يُفَقِّهْهُ فِي الدِّينِ » (man yuridi llāhu bihi khayran yufaqqihhu fī d-dīn).
Sens : « Celui à qui Allah veut du bien, Il lui donne la compréhension de la religion. » (al-Bukhārī n° 71, d'après Muʿāwiya ; hadith authentique).

3. Le chemin de la science
Le Prophète ﷺ a dit :
« مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ بِهِ طَرِيقًا إِلَى الْجَنَّةِ » (man salaka ṭarīqan yaltamisu fīhi ʿilman sahhala llāhu lahu bihi ṭarīqan ilā l-janna).
Sens : « Celui qui emprunte un chemin pour y chercher une science, Allah lui facilite par là un chemin vers le Paradis. » (Muslim n° 2699, d'après Abū Hurayra ; hadith authentique ; voir la leçon sur le hadith 36 des Quarante d'an-Nawawī).
Il a dit aussi : le meilleur d'entre vous est celui qui apprend le Coran et l'enseigne (al-Bukhārī n° 5027, d'après ʿUthmān). Et : on ne peut envier que deux personnes : un homme à qui Allah a donné des biens et qui les dépense dans le vrai, et un homme à qui Allah a donné la sagesse, qui juge par elle et l'enseigne (al-Bukhārī n° 73, d'après Ibn Masʿūd). Et quand l'homme meurt, ses œuvres s'arrêtent sauf trois, dont une science dont on tire profit (Muslim n° 1631, d'après Abū Hurayra).

4. Transmettre avec honnêteté
Le Prophète ﷺ a dit : transmettez de ma part, ne serait-ce qu'un verset ; et celui qui ment sur moi délibérément, qu'il prenne sa place dans le Feu (al-Bukhārī n° 3461, d'après ʿAbd Allāh ibn ʿAmr). C'est pourquoi NOUR AL-ISLAM ne cite que des textes vérifiés, avec leurs références.

5. La disparition de la science
Le Prophète ﷺ a dit :
« إِنَّ اللَّهَ لاَ يَقْبِضُ الْعِلْمَ انْتِزَاعًا، يَنْتَزِعُهُ مِنَ الْعِبَادِ، وَلَكِنْ يَقْبِضُ الْعِلْمَ بِقَبْضِ الْعُلَمَاءِ، حَتَّى إِذَا لَمْ يُبْقِ عَالِمًا، اتَّخَذَ النَّاسُ رُءُوسًا جُهَّالاً فَسُئِلُوا، فَأَفْتَوْا بِغَيْرِ عِلْمٍ، فَضَلُّوا وَأَضَلُّوا » (inna llāha lā yaqbiḍu l-ʿilma ntizāʿan yantaziʿuhu mina l-ʿibād, wa lākin yaqbiḍu l-ʿilma bi-qabḍi l-ʿulamā’, ḥattā idhā lam yubqi ʿāliman ittakhadha n-nāsu ru’ūsan juhhālan fa-su’ilū fa-aftaw bi-ghayri ʿilmin fa-ḍallū wa aḍallū).
Sens : « Allah n'enlève pas la science en l'arrachant aux gens, mais Il l'enlève en reprenant les savants ; quand il ne reste plus de savant, les gens prennent pour chefs des ignorants : on les interroge, ils répondent sans science, ils s'égarent et égarent les autres. » (al-Bukhārī n° 100, d'après ʿAbd Allāh ibn ʿAmr ibn al-ʿĀṣ ; hadith authentique).

6. Ce que l'élève peut retenir
- On demande à Allah d'augmenter notre science.
- Comprendre la religion est un signe du bien qu'Allah veut pour quelqu'un.
- Chercher la science est un chemin vers le Paradis ; la science utile continue de profiter après la mort.
- On transmet ce qu'on sait, sans jamais attribuer au Prophète ﷺ ce qu'il n'a pas dit.
- On ne parle pas de la religion sans science : on interroge les savants.

Exercice : choisissez une leçon de NOUR AL-ISLAM que vous n'avez pas encore étudiée, apprenez-la cette semaine et expliquez-la à un proche, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 20::int, 114::int, 114::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 39::int, 9::int, 9::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 58::int, 11::int, 11::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 16::int, 43::int, 43::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$quran$x$::public.reference_kind, 17::int, 36::int, 36::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$71$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Celui à qui Allah veut du bien… », d'après Muʿāwiya$x$, null, null, $x$https://sunnah.com/bukhari:71$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2699a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Le chemin de la science mène au Paradis, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2699a$x$, $x$Passage copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5027$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Le meilleur d'entre vous est celui qui apprend le Coran et l'enseigne », d'après ʿUthmān$x$, null, null, $x$https://sunnah.com/bukhari:5027$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$73$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$On n'envie que deux personnes, d'après Ibn Masʿūd$x$, null, null, $x$https://sunnah.com/bukhari:73$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1631$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Les trois œuvres qui continuent après la mort, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:1631$x$, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$3461$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Transmettez de ma part, ne serait-ce qu'un verset », d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/bukhari:3461$x$, null),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$100$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La science enlevée par la mort des savants, d'après ʿAbd Allāh ibn ʿAmr ibn al-ʿĀṣ$x$, null, null, $x$https://sunnah.com/bukhari:100$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quelle invocation Allah a-t-Il enseignée à Son Prophète ﷺ dans la sourate Ṭā-Hā ?$x$, array[$x$Seigneur, augmente-moi en science$x$, $x$Seigneur, donne-moi la richesse$x$, $x$Seigneur, rends-moi célèbre$x$]::text[], 0, $x$Sourate Ṭā-Hā, 20:114.$x$),
  (2, $x$Que doit faire celui qui ne sait pas ?$x$, array[$x$Interroger les gens du savoir$x$, $x$Répondre selon son avis$x$, $x$Se taire pour toujours$x$]::text[], 0, $x$Sourate an-Naḥl, 16:43.$x$),
  (3, $x$Que donne Allah à celui à qui Il veut du bien ?$x$, array[$x$La compréhension de la religion$x$, $x$La richesse seulement$x$, $x$La célébrité$x$]::text[], 0, $x$Al-Bukhārī n° 71.$x$),
  (4, $x$Où mène le chemin de celui qui cherche la science ?$x$, array[$x$Vers le Paradis$x$, $x$Nulle part$x$, $x$Vers la richesse$x$]::text[], 0, $x$Muslim n° 2699.$x$),
  (5, $x$Qui est le meilleur d'entre nous selon le hadith de ʿUthmān ?$x$, array[$x$Celui qui apprend le Coran et l'enseigne$x$, $x$Le plus riche$x$, $x$Le plus fort$x$]::text[], 0, $x$Al-Bukhārī n° 5027.$x$),
  (6, $x$Quelle science continue de profiter après la mort ?$x$, array[$x$La science dont on tire profit$x$, $x$Aucune$x$, $x$Celle qu'on garde pour soi$x$]::text[], 0, $x$Muslim n° 1631.$x$),
  (7, $x$Quelle est la menace pour celui qui ment délibérément sur le Prophète ﷺ ?$x$, array[$x$Qu'il prenne sa place dans le Feu$x$, $x$Aucune$x$, $x$Une petite faute$x$]::text[], 0, $x$Al-Bukhārī n° 3461.$x$),
  (8, $x$Comment Allah enlève-t-Il la science selon le hadith ?$x$, array[$x$En reprenant les savants$x$, $x$En l'arrachant des cœurs d'un coup$x$, $x$En brûlant les livres$x$]::text[], 0, $x$Al-Bukhārī n° 100.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 13$x$),
       rv.h = '88a9a22cd4aaa43ebe970b4be0441c82' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
