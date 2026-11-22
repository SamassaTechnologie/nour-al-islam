-- Bonnes manières 16 : la-sincerite-et-l-intention
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-sincerite-et-l-intention$x$, 'lesson', $x$adab$x$, 'fr', 16) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La sincérité (al-ikhlāṣ) et l'intention$x$, $x$Allah n'accepte que ce qui est fait sincèrement pour Lui ; les actes ne valent que par les intentions. Allah regarde les cœurs et les actes ; Il délaisse l'acte où on Lui associe un autre ; les trois premiers jugés au Jour de la Résurrection ; la récompense de la bonne intention, même sans l'acte.$x$, $x$1. La sincérité, une condition de l'adoration
Allah dit qu'il n'a été ordonné aux gens que de L'adorer en Lui vouant un culte sincère (sourate al-Bayyina, 98:5) ; c'est à Allah qu'appartient la religion pure (sourate az-Zumar, 39:2-3). Que celui qui espère rencontrer son Seigneur fasse de bonnes œuvres et n'associe personne à l'adoration de son Seigneur (sourate al-Kahf, 18:110). Et malheur à ceux qui prient tout en étant négligents et qui agissent pour être vus (sourate al-Māʿūn, 107:4-6).
Le Prophète ﷺ a dit que les actes ne valent que par les intentions, et que chacun n'a que ce qu'il a eu l'intention de faire (al-Bukhārī n° 1 ; voir la leçon sur le hadith 1 des Quarante d'an-Nawawī).

2. Allah regarde les cœurs
Le Prophète ﷺ a dit :
« إِنَّ اللَّهَ لاَ يَنْظُرُ إِلَى صُوَرِكُمْ وَأَمْوَالِكُمْ وَلَكِنْ يَنْظُرُ إِلَى قُلُوبِكُمْ وَأَعْمَالِكُمْ » (inna llāha lā yanẓuru ilā ṣuwarikum wa amwālikum wa lākin yanẓuru ilā qulūbikum wa aʿmālikum).
Sens : « Allah ne regarde pas vos apparences ni vos biens, mais Il regarde vos cœurs et vos actes. » (Muslim n° 2564, d'après Abū Hurayra ; hadith authentique).

3. Allah n'a pas besoin d'associé
Le Prophète ﷺ a rapporté qu'Allah dit :
« أَنَا أَغْنَى الشُّرَكَاءِ عَنِ الشِّرْكِ مَنْ عَمِلَ عَمَلاً أَشْرَكَ فِيهِ مَعِي غَيْرِي تَرَكْتُهُ وَشِرْكَهُ » (anā aghnā sh-shurakā’i ʿani sh-shirk, man ʿamila ʿamalan ashraka fīhi maʿī ghayrī taraktuhu wa shirkah).
Sens : « Je suis Celui qui se passe le plus d'associés ; celui qui accomplit un acte en M'y associant un autre, Je le délaisse, lui et son association. » (Muslim n° 2985, d'après Abū Hurayra ; hadith authentique ; voir aussi la leçon « Le shirk » sur l'ostentation).

4. Les trois premiers jugés
Le Prophète ﷺ a dit que les premiers jugés au Jour de la Résurrection seront : un homme tombé en combattant, qui avait combattu pour qu'on dise qu'il est courageux ; un homme qui avait appris et enseigné la science et lu le Coran pour qu'on dise qu'il est savant et lecteur ; et un homme à qui Allah avait donné des biens et qui les avait dépensés pour qu'on dise qu'il est généreux. Il leur sera dit : cela a été dit, et ils seront jetés dans le Feu (Muslim n° 1905, d'après Abū Hurayra, récit résumé).

5. La récompense de la bonne intention
Le Prophète ﷺ a rapporté qu'Allah a écrit les bonnes et les mauvaises actions : celui qui a l'intention d'une bonne action sans la faire, Allah la lui écrit comme une bonne action complète ; s'il la fait, Il lui écrit de dix à sept cents fois, et plus encore. Celui qui a l'intention d'une mauvaise action et ne la fait pas, Allah lui écrit une bonne action complète ; s'il la fait, une seule mauvaise action (al-Bukhārī n° 6491, d'après Ibn ʿAbbās).
Et quand le serviteur tombe malade ou voyage, on lui écrit l'équivalent de ce qu'il faisait quand il était chez lui et en bonne santé (al-Bukhārī n° 2996, d'après Abū Mūsā).

6. Ce que l'élève peut retenir
- On agit pour Allah seul, et non pour être vu ou loué.
- Allah regarde les cœurs et les actes, pas les apparences ni les biens.
- Un acte fait pour les gens n'est pas accepté, même s'il paraît grand.
- La bonne intention est déjà récompensée ; on renouvelle son intention avant chaque acte.

Exercice : avant chaque prière et chaque bonne action de cette semaine, arrêtez-vous un instant pour renouveler votre intention pour Allah seul, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 98::int, 5::int, 5::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 39::int, 2::int, 3::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 18::int, 110::int, 110::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 107::int, 4::int, 6::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Les actes ne valent que par les intentions », d'après ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:1$x$, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2564c$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Allah regarde les cœurs et les actes, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2564c$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2985$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Je suis Celui qui se passe le plus d'associés », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2985$x$, $x$Parole copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1905a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Les trois premiers jugés au Jour de la Résurrection, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:1905a$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6491$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'intention d'une bonne ou d'une mauvaise action, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/bukhari:6491$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2996$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le malade et le voyageur, d'après Abū Mūsā$x$, null, null, $x$https://sunnah.com/bukhari:2996$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Comment Allah a-t-Il ordonné de L'adorer ?$x$, array[$x$En Lui vouant un culte sincère$x$, $x$Pour être vu des gens$x$, $x$Comme on veut$x$]::text[], 0, $x$Sourate al-Bayyina, 98:5.$x$),
  (2, $x$Par quoi les actes valent-ils selon le premier hadith d'al-Bukhārī ?$x$, array[$x$Par les intentions$x$, $x$Par leur taille$x$, $x$Par l'avis des gens$x$]::text[], 0, $x$Al-Bukhārī n° 1.$x$),
  (3, $x$Que regarde Allah selon le hadith ?$x$, array[$x$Les cœurs et les actes$x$, $x$Les apparences$x$, $x$Les biens$x$]::text[], 0, $x$Muslim n° 2564.$x$),
  (4, $x$Que fait Allah de l'acte où on Lui associe un autre ?$x$, array[$x$Il le délaisse$x$, $x$Il l'accepte$x$, $x$Il le double$x$]::text[], 0, $x$Muslim n° 2985.$x$),
  (5, $x$Pourquoi le savant du hadith des trois premiers jugés est-il puni ?$x$, array[$x$Il a appris pour qu'on dise qu'il est savant$x$, $x$Il n'a rien appris$x$, $x$Il a appris pour Allah$x$]::text[], 0, $x$Muslim n° 1905.$x$),
  (6, $x$Que reçoit celui qui a l'intention d'une bonne action sans pouvoir la faire ?$x$, array[$x$Une bonne action complète$x$, $x$Rien$x$, $x$Un péché$x$]::text[], 0, $x$Al-Bukhārī n° 6491.$x$),
  (7, $x$Que reçoit celui qui renonce à une mauvaise action qu'il voulait faire ?$x$, array[$x$Une bonne action complète$x$, $x$Un péché$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 6491.$x$),
  (8, $x$Que reçoit le malade qui ne peut plus faire ses bonnes habitudes ?$x$, array[$x$L'équivalent de ce qu'il faisait en bonne santé$x$, $x$Rien$x$, $x$La moitié$x$]::text[], 0, $x$Al-Bukhārī n° 2996.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 16$x$),
       rv.h = '7c769ecc4104720d4142c4d7fbf58cb8' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
