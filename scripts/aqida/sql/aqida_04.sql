-- Croyance 4 : le-shirk
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$le-shirk$x$, 'lesson', $x$aqida$x$, 'fr', 4) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le shirk : le contraire du tawḥīd$x$, $x$Ce qu'est l'association (shirk), sa gravité d'après le Coran et la Sunna, la différence entre le shirk majeur et le shirk mineur selon Ibn Bāz, avec des exemples : invoquer les morts, l'ostentation, jurer par autre qu'Allah.$x$, $x$1. Qu'est-ce que le shirk ?
Le shirk (association) est le contraire du tawḥīd étudié dans la leçon précédente : c'est donner à Allah un égal (nidd) dans ce qui n'appartient qu'à Lui. ʿAbd Allāh ibn Masʿūd demanda au Prophète ﷺ quel péché est le plus grand auprès d'Allah. Il répondit :
« أَنْ تَجْعَلَ لِلَّهِ نِدًّا وَهْوَ خَلَقَكَ » (an tajʿala li-llāhi niddan wa huwa khalaqak).
Sens : « Que tu donnes à Allah un égal, alors que c'est Lui qui t'a créé. » (al-Bukhārī n° 4477 ; hadith authentique).

2. Sa gravité
Abū Bakra rapporte que le Prophète ﷺ demanda trois fois : voulez-vous que je vous informe du plus grand des grands péchés ? Puis il dit : associer à Allah, et désobéir aux parents ; puis il mit en garde contre le faux témoignage (en substance ; al-Bukhārī n° 2654 ; hadith authentique).
Le Coran dit qu'Allah ne pardonne pas qu'on Lui associe quoi que ce soit, et qu'Il pardonne ce qui est moindre à qui Il veut (sourate al-Nisā’, 4:48) ; Luqmān dit à son fils que l'association est une injustice immense (sourate Luqmān, 31:13) ; et Allah dit au Prophète ﷺ que s'il associait, ses œuvres seraient perdues (sourate al-Zumar, 39:65).

3. Le shirk majeur
Selon Ibn Bāz, le shirk majeur consiste à vouer l'adoration, ou une partie de l'adoration, à autre qu'Allah : invoquer les morts, leur demander secours, leur faire des vœux, ou faire cela pour les djinns ou les anges. Il fait sortir de l'islam (fatwa n° 14401).

4. Le shirk mineur
Toujours selon Ibn Bāz, le shirk mineur ne fait pas sortir de l'islam, mais c'est un grave péché. Il donne ces exemples :
- jurer par autre qu'Allah (par le Prophète ﷺ, par la confiance, par la tête de quelqu'un) ;
- l'ostentation (riyā’) : réciter ou donner l'aumône pour être vu ;
- dire « ce qu'Allah a voulu et ce qu'untel a voulu », ou « sans Allah et untel ».
Ibn ʿUmar entendit un homme jurer par la Kaʿba ; il lui dit qu'on ne jure pas par autre qu'Allah, car il avait entendu le Prophète ﷺ dire :
« مَنْ حَلَفَ بِغَيْرِ اللَّهِ فَقَدْ كَفَرَ أَوْ أَشْرَكَ » (man ḥalafa bi-ghayri llāhi fa-qad kafara aw ashrak).
Sens : « Celui qui jure par autre qu'Allah a mécru, ou a associé. » (al-Tirmidhī n° 1535 ; jugé ḥasan par al-Tirmidhī et authentique par al-Albānī). Al-Tirmidhī rapporte que certains savants comprennent cette parole comme une mise en garde sévère (taghlīẓ).
Ibn Bāz précise que ce shirk mineur devient majeur si celui qui jure croit que ce par quoi il jure a un pouvoir sur l'univers en dehors d'Allah, peut nuire ou être utile par lui-même, ou mérite d'être adoré et invoqué.
Au sujet de l'ostentation, le Prophète ﷺ rapporte qu'Allah a dit :
« أَنَا أَغْنَى الشُّرَكَاءِ عَنِ الشِّرْكِ مَنْ عَمِلَ عَمَلاً أَشْرَكَ فِيهِ مَعِي غَيْرِي تَرَكْتُهُ وَشِرْكَهُ » (ana aghna sh-shurakā’i ʿani sh-shirk, man ʿamila ʿamalan ashraka fīhi maʿī ghayrī taraktuhu wa shirkah).
Sens : « Je suis Celui qui a le moins besoin d'associés. Celui qui fait une œuvre en M'y associant quelqu'un d'autre, Je le laisse, lui et son association. » (Muslim n° 2985 ; hadith authentique).

5. Ce que l'élève peut retenir
- Le shirk est le plus grand des péchés ; Allah ne le pardonne pas à celui qui meurt sans s'en être repenti (4:48).
- Le shirk majeur fait sortir de l'islam ; le shirk mineur non, mais il est très grave.
- On jure seulement par Allah ; on fait ses œuvres pour Allah seul, sans chercher à être vu.

Exercice : expliquez la différence entre le shirk majeur et le shirk mineur avec un exemple de chacun, et répondez aux questions. Pour une situation personnelle, interrogez un savant qualifié.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4477$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Que tu donnes à Allah un égal alors qu'Il t'a créé », d'après Ibn Masʿūd$x$, null, null, $x$https://sunnah.com/bukhari:4477$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2654$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le plus grand des grands péchés, d'après Abū Bakra$x$, null, null, $x$https://sunnah.com/bukhari:2654$x$, null),
  (3, $x$quran$x$::public.reference_kind, 4::int, 48::int, 48::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 31::int, 13::int, 13::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$quran$x$::public.reference_kind, 39::int, 65::int, 65::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 14401 : « Bayān anwāʿ al-shirk » (les sortes de shirk)$x$, $x$Ibn Bāz$x$, $x$Émission Nūr ʿalā al-darb, site officiel du cheikh$x$, $x$https://binbaz.org.sa/fatwas/14401/$x$, $x$Shirk majeur : vouer l'adoration ou une partie à autre qu'Allah ; shirk mineur : jurer par autre qu'Allah, ostentation, « ce qu'Allah a voulu et untel » ; il devient majeur avec une croyance de pouvoir ou d'adoration.$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1535$x$, $x$Bon (ḥasan) ; authentique selon al-Albānī$x$, $x$Al-Tirmidhī ; al-Albānī (jugement affiché sur sunnah.com)$x$, $x$Jurer par autre qu'Allah, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/tirmidhi:1535$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api). Al-Tirmidhī rapporte l'explication de certains savants : une mise en garde sévère.$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2985$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Je suis Celui qui a le moins besoin d'associés », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2985$x$, $x$Hadith qudsī copié tel quel de l'édition de sunnah.com (base hadith-api).$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quel est le plus grand péché auprès d'Allah selon le hadith d'Ibn Masʿūd ?$x$, array[$x$Donner à Allah un égal alors qu'Il nous a créés$x$, $x$Mentir$x$, $x$Manquer une prière$x$]::text[], 0, $x$Al-Bukhārī n° 4477.$x$),
  (2, $x$Que dit la sourate al-Nisā’ (4:48) du shirk ?$x$, array[$x$Allah ne pardonne pas qu'on Lui associe, et pardonne ce qui est moindre à qui Il veut$x$, $x$Il est pardonné à tous$x$, $x$Ce n'est pas un péché$x$]::text[], 0, $x$Il s'agit de celui qui meurt sans s'être repenti.$x$),
  (3, $x$Comment Ibn Bāz définit-il le shirk majeur ?$x$, array[$x$Vouer l'adoration, ou une partie, à autre qu'Allah$x$, $x$Oublier une invocation$x$, $x$Mal prononcer une lettre$x$]::text[], 0, $x$Par exemple invoquer les morts ou leur faire des vœux.$x$),
  (4, $x$Le shirk mineur fait-il sortir de l'islam selon Ibn Bāz ?$x$, array[$x$Non, mais c'est un grave péché$x$, $x$Oui, toujours$x$, $x$Ce n'est pas un péché$x$]::text[], 0, $x$Il peut devenir majeur avec une croyance de pouvoir ou d'adoration.$x$),
  (5, $x$Lequel de ces exemples est du shirk mineur ?$x$, array[$x$Jurer par la tête de quelqu'un, sans croyance particulière$x$, $x$Invoquer un mort pour obtenir un enfant$x$, $x$Faire un vœu à une tombe$x$]::text[], 0, $x$Les deux autres exemples sont du shirk majeur selon Ibn Bāz.$x$),
  (6, $x$Que fait Allah de l'œuvre faite pour Lui et pour un autre, selon le hadith qudsī ?$x$, array[$x$Il la laisse, avec son association$x$, $x$Il l'accepte$x$, $x$Il la double$x$]::text[], 0, $x$Muslim n° 2985.$x$),
  (7, $x$Comment certains savants comprennent-ils « a mécru ou a associé » dans le hadith sur le serment ?$x$, array[$x$Comme une mise en garde sévère$x$, $x$Comme une sortie de l'islam dans tous les cas$x$, $x$Comme une permission$x$]::text[], 0, $x$Al-Tirmidhī le rapporte après le hadith n° 1535 ; Ibn Bāz classe ce serment dans le shirk mineur, sauf croyance particulière.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Croyance 4$x$),
       rv.h = '731fcdb98d12d222378120339d3e2825' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
