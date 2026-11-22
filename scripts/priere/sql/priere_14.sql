-- Prière 14 : le-voyageur-derriere-un-imam-resident-et-le-resident-derriere-un-voyageur
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$le-voyageur-derriere-un-imam-resident-et-le-resident-derriere-un-voyageur$x$, 'lesson', $x$priere$x$, 'fr', 14) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le voyageur qui prie derrière un imam résident, et le résident derrière un voyageur$x$, $x$Le voyageur qui prie derrière un imam résident suit l'imam et prie quatre unités (Ibn ʿAbbās : « la sunna d'Abū l-Qāsim » ; Ibn ʿUmar à Minā). Le résident derrière un imam voyageur complète sa prière après le salut de l'imam (ʿUmar à La Mecque). Avec les avis des savants.$x$, $x$Rappel : la leçon « Raccourcir la prière en voyage » explique que le voyageur prie deux unités au lieu de quatre pour le ẓuhr, le ʿaṣr et le ʿishā’. Cette leçon traite le cas de la prière en groupe.

1. Le principe : suivre l'imam
Le Prophète ﷺ dit :
« إِنَّمَا جُعِلَ الإِمَامُ لِيُؤْتَمَّ بِهِ فَلاَ تَخْتَلِفُوا عَلَيْهِ » (innamā juʿila l-imāmu li-yu’tamma bihi fa-lā takhtalifū ʿalayh).
Sens : « L'imam n'a été placé que pour être suivi ; ne vous opposez donc pas à lui. » (al-Bukhārī n° 722 ; hadith authentique).

2. Le voyageur derrière un imam résident
Mūsā ibn Salama demanda à Ibn ʿAbbās comment prier à La Mecque quand il ne priait pas avec l'imam ; il répondit :
« رَكْعَتَيْنِ سُنَّةَ أَبِي الْقَاسِمِ » (rakʿatayn, sunnata abī l-qāsim).
Sens : « Deux unités : la sunna d'Abū l-Qāsim (le Prophète ﷺ). » (Muslim n° 688 ; hadith authentique).
Dans une autre version, Mūsā ibn Salama dit : quand nous sommes avec vous, nous prions quatre unités, et quand nous revenons à nos tentes, deux. Ibn ʿAbbās répondit : c'est la sunna d'Abū l-Qāsim ﷺ (rapportée par Aḥmad ; citée par Dorar, n° 1472).
Ibn ʿUmar, quand il priait à Minā avec l'imam, priait quatre unités, et quand il priait seul, deux (Muslim n° 694 ; hadith authentique).
Les avis :
- il complète quatre unités : Ibn ʿAbd al-Barr rapporte l'accord des savants qu'il complète s'il rattrape une unité avec l'imam, et la plupart disent qu'il complète dès qu'il entre dans la prière avant le salut de l'imam (Dorar, n° 1472). Ibn Bāz juge que c'est le plus juste des deux avis (fiqh.islamonline.net, « L'imam résident pour le voyageur et le voyageur pour le résident »).
- d'autres avis existent : selon certains, il ne complète que s'il rattrape au moins une unité ; selon d'autres, il raccourcit dans tous les cas (présentation des avis sur le forum Multaqā ahl at-tafsīr, à vérifier dans les ouvrages de fiqh).

3. Le résident derrière un imam voyageur
ʿUmar ibn al-Khaṭṭāb pria deux unités avec les gens de La Mecque, puis dit : « Ô gens de La Mecque, complétez votre prière, car nous sommes des voyageurs. » (Mālik, al-Muwaṭṭa’ ; parole de ʿUmar, chaîne authentique d'après les spécialistes cités sur Shamela).
Ibn Bāz : le résident qui prie le ẓuhr, le ʿaṣr ou le ʿishā’ derrière un voyageur prie quatre unités ; il complète sa prière après le salut de l'imam voyageur (fiqh.islamonline.net, même article).

4. Ce que l'élève peut retenir
- On suit l'imam.
- Voyageur derrière un imam résident : il prie quatre unités, selon la plupart des savants.
- Voyageur seul ou avec d'autres voyageurs : deux unités.
- Résident derrière un imam voyageur : l'imam salue après deux unités, et le résident complète seul.

Exercice : vous êtes en voyage et vous priez le ʿaṣr derrière l'imam de la mosquée du village. Combien d'unités priez-vous ? Et si l'imam est en voyage et vous non ? Puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$722$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« L'imam n'a été placé que pour être suivi », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:722$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$688a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Deux unités, la sunna d'Abū l-Qāsim », d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/muslim:688a$x$, $x$Réponse d'Ibn ʿAbbās copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie de fiqh : le voyageur qui prie derrière un résident complète$x$, $x$Dorar (ad-Durar as-Saniyya)$x$, $x$Section n° 1472$x$, $x$https://dorar.net/feqhia/1472$x$, $x$Version d'Aḥmad (quatre avec l'imam, deux seul) ; accord rapporté par Ibn ʿAbd al-Barr (at-Tamhīd 16/315) ; an-Nawawī (al-Majmūʿ 4/341).$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$694c$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Ibn ʿUmar à Minā : quatre avec l'imam, deux seul$x$, null, null, $x$https://sunnah.com/muslim:694c$x$, null),
  (5, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$L'imam résident pour le voyageur et le voyageur pour le résident$x$, $x$fiqh.islamonline.net (citant Ibn Bāz et Aḥmad Huraydī)$x$, $x$Article en ligne$x$, $x$https://fiqh.islamonline.net/إمامة-المقيم-للمسافر-والمسافر-للمقيم/$x$, $x$Ibn Bāz : le voyageur derrière le résident complète, selon le plus juste des deux avis ; le résident derrière le voyageur complète après son salut.$x$),
  (6, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La prière du voyageur derrière le résident : trois avis$x$, $x$Multaqā ahl at-tafsīr (forum, article d'Abū ʿAbd Allāh Muḥammad Muṣṭafā)$x$, $x$Discussion n° 60817$x$, $x$https://mtafsir.net/threads/60817/$x$, $x$Présente trois avis : compléter ; compléter s'il rattrape une unité ; raccourcir dans tous les cas. Source secondaire, à vérifier.$x$),
  (7, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Jāmiʿ : la parole de ʿUmar aux gens de La Mecque et ses chaînes$x$, $x$Ouvrage de takhrīj sur Shamela (livre n° 261)$x$, $x$Page 6316$x$, $x$https://shamela.ws/book/261/6316$x$, $x$Mālik, al-Muwaṭṭa’ (1/538, n° 1197) : « complétez votre prière, nous sommes des voyageurs » ; parole de ʿUmar, chaîne authentique.$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Pourquoi l'imam a-t-il été placé ?$x$, array[$x$Pour être suivi$x$, $x$Pour faire la prière à notre place$x$, $x$Pour réciter seulement$x$]::text[], 0, $x$Al-Bukhārī n° 722.$x$),
  (2, $x$Combien d'unités prie le voyageur seul pour le ʿaṣr ?$x$, array[$x$Deux$x$, $x$Quatre$x$, $x$Trois$x$]::text[], 0, $x$Muslim n° 688.$x$),
  (3, $x$Selon la plupart des savants, combien d'unités prie le voyageur derrière un imam résident pour le ʿaṣr ?$x$, array[$x$Quatre$x$, $x$Deux$x$, $x$Une$x$]::text[], 0, $x$Dorar n° 1472 ; Muslim n° 694.$x$),
  (4, $x$Comment Ibn ʿAbbās appela-t-il cette manière de faire ?$x$, array[$x$La sunna d'Abū l-Qāsim$x$, $x$Une innovation$x$, $x$Un avis personnel$x$]::text[], 0, $x$Muslim n° 688 ; version d'Aḥmad citée par Dorar.$x$),
  (5, $x$Que faisait Ibn ʿUmar à Minā derrière l'imam ?$x$, array[$x$Il priait quatre unités$x$, $x$Il priait deux unités et partait$x$, $x$Il ne priait pas$x$]::text[], 0, $x$Muslim n° 694.$x$),
  (6, $x$Un résident prie le ẓuhr derrière un imam voyageur. Que fait-il ?$x$, array[$x$Il complète ses quatre unités après le salut de l'imam$x$, $x$Il salue après deux unités$x$, $x$Il recommence la prière$x$]::text[], 0, $x$Parole de ʿUmar (al-Muwaṭṭa’) ; Ibn Bāz.$x$),
  (7, $x$Que dit ʿUmar aux gens de La Mecque ?$x$, array[$x$Complétez votre prière, nous sommes des voyageurs$x$, $x$Raccourcissez avec nous$x$, $x$Priez chez vous$x$]::text[], 0, $x$Mālik, al-Muwaṭṭa’.$x$),
  (8, $x$Les savants sont-ils tous d'accord sur le voyageur derrière le résident ?$x$, array[$x$Non, il existe d'autres avis, mais la plupart disent de compléter$x$, $x$Oui, tous disent de raccourcir$x$, $x$La question n'a jamais été posée$x$]::text[], 0, $x$Dorar n° 1472 ; Ibn Bāz ; Multaqā ahl at-tafsīr.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Prière 14$x$),
       rv.h = '9e8d16325939b3b03003520f80b401cb' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
