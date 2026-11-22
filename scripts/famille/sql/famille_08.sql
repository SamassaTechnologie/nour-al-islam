-- Famille 8 : la-garde-des-enfants-al-hadana
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-garde-des-enfants-al-hadana$x$, 'lesson', $x$famille$x$, 'fr', 8) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La garde des enfants après la séparation (al-ḥaḍāna)$x$, $x$Le but de la garde est de protéger l'enfant. La mère est prioritaire tant qu'elle ne se remarie pas ; la tante maternelle est comme la mère ; si la mère se remarie : deux avis ; le choix de l'enfant et ses âges selon les écoles ; l'entretien reste dû par le père ; s'accorder, sinon le juge.$x$, $x$1. Le but de la garde
La garde (al-ḥaḍāna) consiste à protéger l'enfant de ce qui lui nuit et à s'occuper de ses intérêts. D'après IslamQA (n° 239473), les savants disent qu'on ne laisse pas l'enfant chez celui qui ne le protège pas et ne l'éduque pas bien, même s'il l'a choisi, car le but de la garde est la protection de l'enfant.

2. La mère est prioritaire
Une femme dit : ô Messager d'Allah, mon ventre a été pour mon fils un récipient, mon sein une gourde, mes genoux un abri ; son père m'a divorcée et veut me l'enlever. Le Prophète ﷺ lui dit :
« أَنْتِ أَحَقُّ بِهِ مَا لَمْ تَنْكِحِي » (anti aḥaqqu bihi mā lam tankiḥī).
Sens : « Tu y as plus droit que lui, tant que tu ne te remaries pas. » (Abū Dāwūd n° 2276, d'après ʿAbd Allāh ibn ʿAmr ; « ḥasan » selon al-Albānī et Shuʿayb al-Arnaʾūṭ).
Ibn al-Mundhir rapporte l'accord de tous les savants qu'il connaît : quand les époux se séparent et ont un jeune enfant, la mère y a plus droit tant qu'elle ne se remarie pas (d'après l'encyclopédie de fiqh de Dorar, n° 5163).

3. La tante maternelle est comme la mère
Quand le Prophète ﷺ quitta La Mecque, la fille de Ḥamza les suivit, et ʿAlī, Jaʿfar et Zayd se disputèrent sa garde. Le Prophète ﷺ la confia à sa tante maternelle, l'épouse de Jaʿfar, et dit :
« الْخَالَةُ بِمَنْزِلَةِ الأُمِّ » (al-khālatu bi-manzilati l-umm).
Sens : « La tante maternelle a le rang de la mère. » (al-Bukhārī n° 2699, d'après al-Barā’ ibn ʿĀzib ; hadith authentique).

4. Si la mère se remarie
D'après IslamQA (n° 171456), la garde passe à une autre personne, et les savants divergent :
- elle passe à la grand-mère maternelle : avis de la majorité des quatre écoles ;
- elle passe au père : avis choisi par Ibn Taymiyya et Ibn al-Qayyim.
D'après fiqh.islamonline.net, si le père accepte que les enfants restent avec leur mère parce qu'il y voit leur intérêt, il n'y a pas de mal.

5. Le choix de l'enfant
Une femme vint se plaindre que son mari voulait lui prendre son fils. Le Prophète ﷺ dit à l'enfant :
« هَذَا أَبُوكَ وَهَذِهِ أُمُّكَ فَخُذْ بِيَدِ أَيِّهِمَا شِئْتَ » (hādhā abūka wa hādhihi ummuk, fa-khudh bi-yadi ayyihimā shi’t).
Sens : « Voici ton père et voici ta mère : prends la main de celui que tu veux. » Il prit la main de sa mère (Abū Dāwūd n° 2277, d'après Abū Hurayra ; authentique selon al-Albānī).
Les écoles divergent (d'après Ibn Qudāma, al-Mughnī, cité par fiqh.islamonline.net, et IslamQA n° 171456) :
- le garçon de sept ans, sain d'esprit, choisit entre ses parents : avis d'Aḥmad et d'ash-Shāfiʿī, jugement rapporté de ʿUmar et de ʿAlī ;
- pas de choix avant la puberté : avis de Mālik et d'Abū Ḥanīfa ; pour Abū Ḥanīfa, le père a plus droit au garçon quand il se débrouille seul (manger, s'habiller, se laver) ; pour Mālik, la mère y a plus droit jusqu'à ce que ses dents de lait tombent ;
- pour la fille : la mère jusqu'à son mariage ou ses premières règles (Abū Ḥanīfa), jusqu'à son mariage consommé (Mālik), le père (Aḥmad).

6. L'entretien et le règlement des désaccords
Allah dit : les mères allaitent leurs enfants deux années complètes, et il incombe au père de les nourrir et de les vêtir selon le convenable (sourate al-Baqara, 2:233 ; voir aussi aṭ-Ṭalāq, 65:6).
D'après fiqh.islamonline.net, si les parents s'accordent, c'est le mieux pour eux et pour les enfants ; sinon, la décision revient au juge.

7. Ce que l'élève peut retenir
- La garde a pour but la protection et l'éducation de l'enfant.
- La mère est prioritaire tant qu'elle ne se remarie pas ; la tante maternelle a le rang de la mère.
- Si la mère se remarie : la grand-mère maternelle selon la majorité, le père selon Ibn Taymiyya et Ibn al-Qayyim.
- Le choix de l'enfant et les âges diffèrent selon les écoles.
- Le père reste tenu de l'entretien ; on cherche l'accord, sinon le juge tranche.
Pour un cas réel, adressez-vous à un savant ou au juge de votre pays.

Exercice : citez les deux avis sur la garde quand la mère se remarie, avec leurs sources, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 239473 : pourquoi la garde de la mère cesse si elle se remarie$x$, $x$IslamQA (sous la direction de Muḥammad Ṣāliḥ al-Munajjid)$x$, $x$Réponse n° 239473$x$, $x$https://islamqa.info/ar/answers/239473$x$, $x$On ne laisse pas l'enfant chez qui ne le protège pas, même s'il l'a choisi : le but est sa protection.$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$2276$x$, $x$Ḥasan (al-Albānī, Shuʿayb al-Arnaʾūṭ, Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Tu y as plus droit, tant que tu ne te remaries pas », d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/abudawud:2276$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie de fiqh : la mère a plus droit à la garde$x$, $x$Dorar (ad-Durar as-Saniyya)$x$, $x$Section n° 5163$x$, $x$https://dorar.net/feqhia/5163$x$, $x$Accord rapporté par Ibn al-Mundhir, al-Khaṭṭābī et Ibn al-Qayyim : la mère tant qu'elle ne se remarie pas.$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2699$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« La tante maternelle a le rang de la mère », d'après al-Barā’ ibn ʿĀzib$x$, null, null, $x$https://sunnah.com/bukhari:2699$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (5, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 171456 : à qui revient la garde de la fille si la divorcée se remarie ?$x$, $x$IslamQA (sous la direction de Muḥammad Ṣāliḥ al-Munajjid)$x$, $x$Réponse n° 171456$x$, $x$https://islamqa.info/ar/answers/171456$x$, $x$Grand-mère maternelle selon la majorité ; père selon Ibn Taymiyya et Ibn al-Qayyim ; avis des écoles sur la fille.$x$),
  (6, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le choix de l'enfant dans la garde$x$, $x$fiqh.islamonline.net (citant Ibn Qudāma, al-Mughnī)$x$, $x$Article en ligne$x$, $x$https://fiqh.islamonline.net/%D8%AA%D8%AE%D9%8A%D9%8A%D8%B1-%D8%A7%D9%84%D8%B7%D9%81%D9%84-%D9%81%D9%8A-%D8%A7%D9%84%D8%AD%D8%B6%D8%A7%D9%86%D8%A9/$x$, $x$Choix à sept ans (Aḥmad, ash-Shāfiʿī) ; pas de choix (Mālik, Abū Ḥanīfa) ; accord des parents, sinon le juge.$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$2277$x$, $x$Authentique (al-Albānī) ; ḥasan ṣaḥīḥ (Shuʿayb al-Arnaʾūṭ)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Prends la main de celui que tu veux », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/abudawud:2277$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$quran$x$::public.reference_kind, 2::int, 233::int, 233::int, null, null, null, null, null, null, null, null, null, null),
  (9, $x$quran$x$::public.reference_kind, 65::int, 6::int, 6::int, null, null, null, null, null, null, null, null, null, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quel est le but de la garde de l'enfant ?$x$, array[$x$Le protéger et s'occuper de ses intérêts$x$, $x$Punir l'un des parents$x$, $x$Rien$x$]::text[], 0, $x$IslamQA n° 239473.$x$),
  (2, $x$Jusqu'à quand la mère a-t-elle priorité selon le hadith ?$x$, array[$x$Tant qu'elle ne se remarie pas$x$, $x$Pour toujours$x$, $x$Un an$x$]::text[], 0, $x$Abū Dāwūd n° 2276.$x$),
  (3, $x$Qui rapporte l'accord des savants sur la priorité de la mère ?$x$, array[$x$Ibn al-Mundhir$x$, $x$Personne$x$, $x$Uniquement les ḥanafites$x$]::text[], 0, $x$Dorar, n° 5163.$x$),
  (4, $x$Quel rang le Prophète ﷺ donna-t-il à la tante maternelle ?$x$, array[$x$Le rang de la mère$x$, $x$Aucun$x$, $x$Le rang du père$x$]::text[], 0, $x$Al-Bukhārī n° 2699.$x$),
  (5, $x$Selon la majorité, à qui passe la garde si la mère se remarie ?$x$, array[$x$À la grand-mère maternelle$x$, $x$Au voisin$x$, $x$À l'État$x$]::text[], 0, $x$IslamQA n° 171456.$x$),
  (6, $x$Quel avis ont choisi Ibn Taymiyya et Ibn al-Qayyim ?$x$, array[$x$La garde passe au père$x$, $x$La garde reste à la mère$x$, $x$L'enfant décide seul$x$]::text[], 0, $x$IslamQA n° 171456.$x$),
  (7, $x$Que fit le Prophète ﷺ quand le père et la mère se disputèrent leur fils ?$x$, array[$x$Il laissa l'enfant choisir$x$, $x$Il le donna au plus riche$x$, $x$Il le confia à un étranger$x$]::text[], 0, $x$Abū Dāwūd n° 2277.$x$),
  (8, $x$Qui doit nourrir et vêtir l'enfant selon 2:233 ?$x$, array[$x$Le père, selon le convenable$x$, $x$La mère seule$x$, $x$Personne$x$]::text[], 0, $x$Sourate al-Baqara, 2:233.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Famille 8$x$),
       rv.h = '25d7a3d9d01e379f009526e30511636b' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
