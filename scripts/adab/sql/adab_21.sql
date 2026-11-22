-- Bonnes manières 21 : le-bon-usage-du-temps-et-de-la-sante
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$le-bon-usage-du-temps-et-de-la-sante$x$, 'lesson', $x$adab$x$, 'fr', 21) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le bon usage du temps et de la santé$x$, $x$Par le Temps ! L'homme est en perte, sauf ceux qui croient et font le bien. Deux bienfaits que beaucoup gaspillent : la santé et le temps libre ; on sera interrogé sur sa vie, sa science, ses biens et son corps ; être dans ce monde comme un voyageur ; rechercher ce qui est utile, laisser ce qui ne nous regarde pas ; l'acte régulier même petit.$x$, $x$1. Le temps dans le Coran
Allah jure par le Temps : l'homme est en perdition, sauf ceux qui croient, font de bonnes œuvres, s'enjoignent mutuellement la vérité et la patience (sourate al-ʿAṣr, 103:1-3). Pensiez-vous que Nous vous avions créés sans but ? (sourate al-Mu’minūn, 23:115). Et Allah dira aux gens du Feu : ne vous avons-Nous pas donné une vie assez longue pour que celui qui voulait réfléchir réfléchisse ? (sourate Fāṭir, 35:37).

2. Deux bienfaits gaspillés
Le Prophète ﷺ a dit :
« نِعْمَتَانِ مَغْبُونٌ فِيهِمَا كَثِيرٌ مِنَ النَّاسِ، الصِّحَّةُ وَالْفَرَاغُ » (niʿmatāni maghbūnun fīhimā kathīrun mina n-nās : aṣ-ṣiḥḥatu wa l-farāgh).
Sens : « Il y a deux bienfaits que beaucoup de gens gaspillent : la santé et le temps libre. » (al-Bukhārī n° 6412, d'après Ibn ʿAbbās ; hadith authentique).

3. On sera interrogé
Le Prophète ﷺ a dit :
« لاَ تَزُولُ قَدَمَا عَبْدٍ يَوْمَ الْقِيَامَةِ حَتَّى يُسْأَلَ عَنْ عُمْرِهِ فِيمَا أَفْنَاهُ وَعَنْ عِلْمِهِ فِيمَا فَعَلَ وَعَنْ مَالِهِ مِنْ أَيْنَ اكْتَسَبَهُ وَفِيمَا أَنْفَقَهُ وَعَنْ جِسْمِهِ فِيمَا أَبْلاَهُ » (lā tazūlu qadamā ʿabdin yawma l-qiyāmati ḥattā yus’ala ʿan ʿumrihi fīmā afnāh, wa ʿan ʿilmihi fīmā faʿal, wa ʿan mālihi min ayna ktasabahu wa fīmā anfaqah, wa ʿan jismihi fīmā ablāh).
Sens : « Les pieds du serviteur ne bougeront pas au Jour de la Résurrection avant qu'il soit interrogé sur sa vie, à quoi il l'a passée ; sur sa science, ce qu'il en a fait ; sur ses biens, d'où il les a gagnés et à quoi il les a dépensés ; et sur son corps, à quoi il l'a usé. » (al-Tirmidhī n° 2417, d'après Abū Barza al-Aslamī ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir ; jugé faible par Zubayr ʿAlī Zaʾī).

4. Comme un voyageur
Le Prophète ﷺ prit Ibn ʿUmar par l'épaule et lui dit : sois dans ce monde comme un étranger ou un passant. Ibn ʿUmar disait : le soir, n'attends pas le matin ; le matin, n'attends pas le soir ; prends de ta santé pour ta maladie, et de ta vie pour ta mort (al-Bukhārī n° 6416 ; voir la leçon sur le hadith 40 des Quarante d'an-Nawawī). La dernière partie est une parole d'Ibn ʿUmar.

5. Rechercher l'utile et la régularité
Le Prophète ﷺ a dit : le croyant fort est meilleur et plus aimé d'Allah que le croyant faible, et en chacun il y a du bien ; recherche avec ardeur ce qui t'est utile, demande l'aide d'Allah et ne baisse pas les bras (Muslim n° 2664, d'après Abū Hurayra).
Il a dit aussi : fait partie du bon islam de l'homme le fait de délaisser ce qui ne le concerne pas (al-Tirmidhī n° 2317, d'après Abū Hurayra ; « gharīb » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir, jugé faible par Zubayr ʿAlī Zaʾī ; voir la leçon sur le hadith 12 des Quarante d'an-Nawawī).
Et : l'acte le plus aimé d'Allah est le plus régulier, même s'il est petit (al-Bukhārī n° 6464, d'après ʿĀ’isha).

6. Ce que l'élève peut retenir
- Le temps et la santé sont des bienfaits dont on rendra compte.
- On profite de sa santé avant la maladie et de sa vie avant la mort.
- On recherche ce qui est utile et on laisse ce qui ne nous regarde pas.
- Un petit acte régulier vaut mieux qu'un grand acte abandonné.

Exercice : notez pendant une journée comment vous utilisez votre temps, puis choisissez une petite bonne habitude régulière (par exemple une page de Coran chaque jour), puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 103::int, 1::int, 3::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 23::int, 115::int, 115::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 35::int, 37::int, 37::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6412$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Deux bienfaits gaspillés : la santé et le temps libre, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/bukhari:6412$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2417$x$, $x$Ḥasan ṣaḥīḥ (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir) ; faible (Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Les quatre questions du Jour de la Résurrection, d'après Abū Barza al-Aslamī$x$, null, null, $x$https://sunnah.com/tirmidhi:2417$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6416$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Sois dans ce monde comme un étranger » et la parole d'Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:6416$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2664$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Le croyant fort ; « recherche ce qui t'est utile », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2664$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2317$x$, $x$Gharīb (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir) ; faible (Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Délaisser ce qui ne nous concerne pas, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/tirmidhi:2317$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6464$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'acte le plus aimé d'Allah est le plus régulier, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/bukhari:6464$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qui n'est pas en perdition selon la sourate al-ʿAṣr ?$x$, array[$x$Ceux qui croient, font le bien et s'enjoignent la vérité et la patience$x$, $x$Les riches$x$, $x$Tout le monde$x$]::text[], 0, $x$Sourate al-ʿAṣr, 103:1-3.$x$),
  (2, $x$Quels sont les deux bienfaits que beaucoup de gens gaspillent ?$x$, array[$x$La santé et le temps libre$x$, $x$L'argent et la maison$x$, $x$Le sommeil et la nourriture$x$]::text[], 0, $x$Al-Bukhārī n° 6412.$x$),
  (3, $x$Sur quoi le serviteur sera-t-il interrogé selon le hadith d'Abū Barza ?$x$, array[$x$Sa vie, sa science, ses biens et son corps$x$, $x$Seulement ses biens$x$, $x$Rien$x$]::text[], 0, $x$Al-Tirmidhī n° 2417.$x$),
  (4, $x$Les savants sont-ils d'accord sur le degré de ce hadith d'Abū Barza ?$x$, array[$x$Non : authentique selon al-Albānī, faible selon Zubayr ʿAlī Zaʾī$x$, $x$Oui, tous le jugent faible$x$, $x$Il est dans al-Bukhārī$x$]::text[], 0, $x$Al-Tirmidhī n° 2417.$x$),
  (5, $x$Comment le Prophète ﷺ conseilla-t-il à Ibn ʿUmar d'être dans ce monde ?$x$, array[$x$Comme un étranger ou un passant$x$, $x$Comme un roi$x$, $x$Comme s'il ne devait jamais mourir$x$]::text[], 0, $x$Al-Bukhārī n° 6416.$x$),
  (6, $x$Que faut-il rechercher avec ardeur selon le hadith du croyant fort ?$x$, array[$x$Ce qui nous est utile$x$, $x$Ce qui amuse$x$, $x$Rien$x$]::text[], 0, $x$Muslim n° 2664.$x$),
  (7, $x$Que fait partie du bon islam de l'homme ?$x$, array[$x$Délaisser ce qui ne le concerne pas$x$, $x$Se mêler de tout$x$, $x$Parler beaucoup$x$]::text[], 0, $x$Al-Tirmidhī n° 2317.$x$),
  (8, $x$Quel acte Allah aime-t-Il le plus ?$x$, array[$x$Le plus régulier, même petit$x$, $x$Le plus grand fait une seule fois$x$, $x$Celui qu'on montre aux gens$x$]::text[], 0, $x$Al-Bukhārī n° 6464.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 21$x$),
       rv.h = '99db9d422806fe71b6f7eb1d41dc8b33' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
