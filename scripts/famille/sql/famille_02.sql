-- Famille 2 : le-contrat-de-mariage-tuteur-temoins-et-dot
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$le-contrat-de-mariage-tuteur-temoins-et-dot$x$, 'lesson', $x$famille$x$, 'fr', 2) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le contrat de mariage : le tuteur, les témoins et la dot$x$, $x$Le tuteur (al-walī) : condition de validité selon la majorité, non selon les ḥanafites. Les témoins : exigés par la majorité ; l'annonce publique suffit selon Mālik, avis choisi par Ibn Taymiyya. La dot (aṣ-ṣadāq) est un droit de la femme, même modeste ; l'interdiction du shighār ; le repas de noces.$x$, $x$1. Le tuteur (al-walī)
Le Prophète ﷺ a dit :
« لاَ نِكَاحَ إِلاَّ بِوَلِيٍّ » (lā nikāḥa illā bi-walī).
Sens : « Pas de mariage sans tuteur. » (al-Tirmidhī n° 1101, d'après Abū Mūsā al-Ashʿarī ; authentique selon al-Albānī et Aḥmad Shākir).
Et il a dit : toute femme qui se marie sans la permission de son tuteur, son mariage est nul (il le répéta trois fois) ; s'il y a désaccord, le dirigeant est le tuteur de celle qui n'a pas de tuteur (al-Tirmidhī n° 1102, d'après ʿĀ’isha ; « ḥasan » selon al-Tirmidhī).
Les avis des savants :
- le tuteur est une condition de validité du mariage : avis de la majorité ;
- les ḥanafites considèrent valide le mariage sans tuteur (de la femme majeure et saine d'esprit).
D'après IslamQA (n° 132787), qui retient l'avis de la majorité, juge faibles les preuves des ḥanafites, et conseille, pour un mariage déjà conclu sans tuteur dans un pays qui suit l'avis ḥanafite, de ne pas le refaire, tout en rappelant que la présence du tuteur est la meilleure manière de sortir de la divergence. Le tuteur ne doit pas empêcher la femme d'épouser un homme convenable qu'elle a accepté (voir sourate al-Baqara, 2:232).

2. Les témoins
Les avis des savants :
- la majorité exige, pour que le mariage soit valide, deux témoins hommes intègres ;
- selon l'imam Mālik, c'est l'annonce publique du mariage qui est exigée ; Ibn Taymiyya a écrit que le mariage annoncé et connu des gens est valide même sans témoins selon Mālik et une version d'Aḥmad, et que c'est l'avis le plus apparent selon lui (cité par fiqh.islamonline.net, article d'al-Qaraḍāwī ; et Dr Fatḥiyya al-Ḥanafī, professeure de fiqh à al-Azhar, citée par Ṣadā al-Balad).
Ad-Dardīr (mālikite) a indiqué qu'il est recommandé d'annoncer le mariage parmi les gens (cité dans le même article de fiqh.islamonline.net).

3. La dot (aṣ-ṣadāq ou al-mahr)
Allah dit : donnez aux femmes leur dot de bon cœur (sourate an-Nisā’, 4:4). La dot appartient à la femme.
Une femme vint s'offrir en mariage au Prophète ﷺ ; un homme demanda à l'épouser. Le Prophète ﷺ lui demanda s'il avait quelque chose à lui donner en dot ; il n'avait que son pagne. Il lui dit :
« الْتَمِسْ وَلَوْ خَاتَمًا مِنْ حَدِيدِ » (iltamis wa law khātaman min ḥadīd).
Sens : « Cherche, ne serait-ce qu'un anneau de fer. » Il ne trouva rien ; le Prophète ﷺ le maria alors pour ce qu'il savait du Coran (al-Bukhārī n° 5135, d'après Sahl ibn Saʿd ; hadith authentique).
ʿAbd ar-Raḥmān ibn ʿAwf se maria pour le poids d'un noyau d'or ; le Prophète ﷺ lui dit : offre un repas de noces, ne serait-ce qu'avec un mouton (al-Bukhārī n° 5167, d'après Anas).
Le shighār est interdit : marier sa fille à un homme à condition qu'il vous marie la sienne, sans dot entre eux (al-Bukhārī n° 5112, d'après Ibn ʿUmar).

4. Ce que l'élève peut retenir
- Le tuteur : condition selon la majorité ; la présence du tuteur évite la divergence.
- Les témoins : exigés par la majorité ; l'annonce suffit selon Mālik ; il est recommandé d'annoncer le mariage.
- La dot est un droit de la femme, même modeste.
- Le shighār (échange de filles sans dot) est interdit ; le repas de noces est recommandé.
Pour un cas personnel, interrogez un savant de votre pays.

Exercice : citez les deux avis sur le tuteur et les deux avis sur les témoins, avec leurs sources, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1101$x$, $x$Authentique (al-Albānī, Aḥmad Shākir, Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Pas de mariage sans tuteur », d'après Abū Mūsā$x$, null, null, $x$https://sunnah.com/tirmidhi:1101$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1102$x$, $x$Ḥasan (al-Tirmidhī) ; chaîne authentique (Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Son mariage est nul », d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/tirmidhi:1102$x$, null),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 132787 : mariage conclu sans tuteur dans son pays$x$, $x$IslamQA (sous la direction de Muḥammad Ṣāliḥ al-Munajjid)$x$, $x$Réponse n° 132787$x$, $x$https://islamqa.info/ar/answers/132787$x$, $x$Tuteur exigé selon la majorité, non selon les ḥanafites ; ne pas refaire le contrat ; la présence du tuteur sort de la divergence.$x$),
  (4, $x$quran$x$::public.reference_kind, 2::int, 232::int, 232::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le mariage avec des témoins non intègres (fatwa)$x$, $x$fiqh.islamonline.net (citant al-Qaraḍāwī et Ibn Taymiyya)$x$, $x$Article en ligne$x$, $x$https://fiqh.islamonline.net/%D8%A7%D9%84%D8%B2%D9%88%D8%A7%D8%AC-%D8%A8%D8%B4%D9%87%D9%88%D8%AF-%D8%BA%D9%8A%D8%B1-%D8%B9%D8%AF%D9%88%D9%84/$x$, $x$Ibn Taymiyya : mariage annoncé valide même sans témoins selon Mālik et une version d'Aḥmad ; avis jugé le plus apparent.$x$),
  (6, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le jugement du témoignage de la femme dans le contrat de mariage$x$, $x$Fatḥiyya al-Ḥanafī (al-Azhar), citée par Ṣadā al-Balad$x$, $x$Article de presse$x$, $x$https://www.elbalad.news/5530081$x$, $x$La majorité exige deux témoins hommes intègres ; Mālik exige l'annonce ; avis choisi par Ibn Taymiyya.$x$),
  (7, $x$quran$x$::public.reference_kind, 4::int, 4::int, 4::int, null, null, null, null, null, null, null, null, null, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5135$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Cherche, ne serait-ce qu'un anneau de fer », d'après Sahl ibn Saʿd$x$, null, null, $x$https://sunnah.com/bukhari:5135$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5167$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La dot d'ʿAbd ar-Raḥmān ibn ʿAwf et le repas de noces, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:5167$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5112$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'interdiction du shighār, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:5112$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que dit le hadith d'Abū Mūsā sur le tuteur ?$x$, array[$x$Pas de mariage sans tuteur$x$, $x$Le tuteur est inutile$x$, $x$Le tuteur choisit seul$x$]::text[], 0, $x$Al-Tirmidhī n° 1101.$x$),
  (2, $x$Quel est l'avis des ḥanafites sur le tuteur ?$x$, array[$x$Le mariage de la femme majeure sans tuteur est valide$x$, $x$Le tuteur est une condition$x$, $x$Ils n'en parlent pas$x$]::text[], 0, $x$IslamQA n° 132787.$x$),
  (3, $x$Qui est le tuteur de la femme qui n'en a pas ?$x$, array[$x$Le dirigeant (as-sulṭān)$x$, $x$Personne$x$, $x$Son voisin$x$]::text[], 0, $x$Al-Tirmidhī n° 1102.$x$),
  (4, $x$Que demande la majorité des savants pour les témoins ?$x$, array[$x$Deux témoins pour que le mariage soit valide$x$, $x$Aucun témoin$x$, $x$Dix témoins$x$]::text[], 0, $x$Sources citées dans la leçon.$x$),
  (5, $x$Selon l'imam Mālik, qu'est-ce qui est exigé ?$x$, array[$x$L'annonce publique du mariage$x$, $x$Un contrat écrit seulement$x$, $x$Rien$x$]::text[], 0, $x$Ibn Taymiyya cité par fiqh.islamonline.net.$x$),
  (6, $x$À qui appartient la dot ?$x$, array[$x$À la femme$x$, $x$Au père$x$, $x$Au mari$x$]::text[], 0, $x$Sourate an-Nisā’, 4:4.$x$),
  (7, $x$Quelle dot le Prophète ﷺ accepta-t-il pour l'homme qui n'avait rien ?$x$, array[$x$Ce qu'il savait du Coran$x$, $x$Rien du tout$x$, $x$Une grande somme$x$]::text[], 0, $x$Al-Bukhārī n° 5135.$x$),
  (8, $x$Qu'est-ce que le shighār interdit ?$x$, array[$x$Échanger les filles en mariage sans dot$x$, $x$Donner une dot$x$, $x$Faire un repas de noces$x$]::text[], 0, $x$Al-Bukhārī n° 5112.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Famille 2$x$),
       rv.h = '0d12d8ef121ec819ade5ee437008763c' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
