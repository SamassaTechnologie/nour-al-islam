-- Sira 11 : voyage-a-taif
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$voyage-a-taif$x$, 'lesson', 'sira', 'fr', 11) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le voyage à Ṭāʾif$x$, $x$Après la mort d'Abū Ṭālib, le Prophète ﷺ alla appeler à l'islam les gens de Ṭāʾif. Leur refus, l'ange des montagnes, et la miséricorde du Prophète ﷺ envers ceux qui l'avaient rejeté.$x$, $x$1. Pourquoi Ṭāʾif
Après la mort d'Abū Ṭālib, le Prophète ﷺ avait perdu la protection de son oncle, et Quraysh s'en prenait à lui plus durement (voir la leçon 10). Selon les livres de Sira, il partit pour Ṭāʾif, ville de la tribu de Thaqīf, à la fin du mois de Shawwāl de la dixième année de la prophétie, pour appeler ses habitants à l'islam et chercher leur soutien.
Les historiens divergent sur ses compagnons de route : selon Ibn Isḥāq (rapporté par Ibn Hishām), il y alla seul ; selon Ibn Saʿd et al-Balādhurī, Zayd ibn Ḥāritha l'accompagnait. Ils divergent aussi sur la durée de son séjour : dix jours ou un mois (Encyclopédie de Muḥammad, qui cite ces sources).

2. Le refus des gens de Ṭāʾif, d'après les livres de Sira
Les livres de Sira rapportent qu'il rencontra trois frères, chefs de Thaqīf : ʿAbd Yālīl, Masʿūd et Ḥabīb, fils de ʿAmr. Ils refusèrent son appel et se moquèrent de lui, puis lancèrent contre lui des enfants et des gens de la ville, qui lui jetèrent des pierres jusqu'à ce qu'il quitte Ṭāʾif.

3. Le jour le plus dur, d'après un hadith authentique
ʿĀʾisha demanda au Prophète ﷺ s'il avait connu un jour plus dur que celui de la bataille d'Uḥud. Il répondit que le plus dur fut le jour où il s'était présenté à Ibn ʿAbd Yālīl ibn ʿAbd Kulāl, qui ne répondit pas à son appel. Il partit, accablé de tristesse, et ne reprit ses esprits qu'à Qarn al-Thaʿālib. Il leva la tête et vit un nuage qui lui faisait de l'ombre, et dans ce nuage Jibrīl, qui lui dit qu'Allah avait entendu ce que son peuple lui avait dit, et qu'Il lui envoyait l'ange des montagnes pour faire d'eux ce qu'il voudrait. L'ange des montagnes le salua et lui proposa de refermer sur eux les deux montagnes (al-Akhshabān). Le Prophète ﷺ répondit :
« بَلْ أَرْجُو أَنْ يُخْرِجَ اللَّهُ مِنْ أَصْلاَبِهِمْ مَنْ يَعْبُدُ اللَّهَ وَحْدَهُ لاَ يُشْرِكُ بِهِ شَيْئًا » (bal arjū an yukhrija-llāhu min aṣlābihim man yaʿbudu-llāha waḥdahu lā yushriku bihi shayʾā).
Sens : « Non, j'espère plutôt qu'Allah fera sortir de leurs descendants des gens qui adoreront Allah seul, sans rien Lui associer » (en substance pour le récit, texte arabe de la réponse ; al-Bukhārī n° 3231 ; hadith authentique).

4. ʿAddās, d'après les livres de Sira
Les livres de Sira rapportent qu'en quittant Ṭāʾif, le Prophète ﷺ se reposa dans un jardin qui appartenait à ʿUtba et Shayba, fils de Rabīʿa. Ils lui firent porter du raisin par leur serviteur chrétien ʿAddās, qui fut touché par ses paroles et embrassa ses mains. Ce récit vient des livres de Sira, et non des recueils authentiques.

5. L'invocation de Ṭāʾif : une chaîne faible
Une invocation célèbre est attribuée au Prophète ﷺ à son retour de Ṭāʾif ; elle commence par : « Ô Allah, je me plains à Toi de la faiblesse de ma force… ». Al-Albānī l'a jugée faible (al-Silsila al-ḍaʿīfa, n° 2933), ainsi que la Commission permanente, d'après IslamQA ; Ibn Bāz a dit qu'elle est rapportée du Prophète ﷺ mais que sa chaîne est discutable. On la mentionne ici pour signaler qu'elle n'est pas établie.

6. Ce que l'élève peut retenir
- Le Prophète ﷺ alla jusqu'à Ṭāʾif pour transmettre le message, malgré la fatigue et la tristesse.
- Les gens de Ṭāʾif le rejetèrent durement.
- Le Prophète ﷺ dit à ʿĀʾisha que ce jour fut le plus dur qu'il ait connu de son peuple.
- Alors qu'Allah lui offrait de punir ceux qui l'avaient rejeté, il espéra que leurs descendants adoreraient Allah seul : c'est un exemple de patience et de miséricorde.
- L'invocation célèbre de Ṭāʾif n'est pas établie avec une chaîne authentique.

Exercice : racontez ce que l'ange des montagnes proposa au Prophète ﷺ, répétez sa réponse avec son sens, et répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$3231$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le jour le plus dur et l'ange des montagnes, d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:3231$x$, $x$Réponse du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le voyage du Prophète ﷺ à Ṭāʾif$x$, $x$Encyclopédie de Muḥammad (muhammadencyclopedia.com)$x$, $x$Article (anglais), avec renvois à Ibn Hishām, Ibn Saʿd, al-Balādhurī et al-Zurqānī$x$, $x$https://muhammadencyclopedia.com/article/6313146f4e36d70626f56229$x$, $x$Shawwāl de la 10e année ; seul selon Ibn Isḥāq, avec Zayd ibn Ḥāritha selon Ibn Saʿd et al-Balādhurī ; séjour de dix jours ou d'un mois ; chefs : ʿAbd Yālīl, Masʿūd et Ḥabīb.$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La dixième année de la prophétie (Ṭāʾif et ʿAddās)$x$, $x$Osman Nuri Topbaş$x$, $x$Article (anglais)$x$, $x$https://www.osmannuritopbas.com/en/the-tenth-year-of-prophethood$x$, $x$Récit de ʿAddās dans le jardin des fils de Rabīʿa, tel que le rapportent les livres de Sira.$x$),
  (4, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 148943 : « Le hadith “Ô Allah, je me plains à Toi de la faiblesse de ma force” est-il établi ? »$x$, $x$IslamQA (dir. Muḥammad Ṣāliḥ al-Munajjid)$x$, $x$Réponse en arabe$x$, $x$https://islamqa.info/ar/answers/148943$x$, $x$Jugé faible par la Commission permanente et par al-Albānī (al-Silsila al-ḍaʿīfa, n° 2933).$x$),
  (5, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$« Quelle est l'authenticité de l'invocation : Je me plains à Toi de la faiblesse de ma force ? »$x$, $x$Ibn Bāz$x$, $x$Réponse orale publiée sur le site officiel du cheikh$x$, $x$https://binbaz.org.sa/fatwas/23164/$x$, $x$Rapportée du Prophète ﷺ à son retour de Ṭāʾif, mais « sa chaîne est discutable ».$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Après la mort de qui le Prophète ﷺ partit-il pour Ṭāʾif ?$x$, array[$x$Abū Ṭālib$x$, $x$Abū Jahl$x$, $x$ʿUmar ibn al-Khaṭṭāb$x$]::text[], 0, $x$Il avait perdu la protection de son oncle Abū Ṭālib et chercha du soutien hors de La Mecque.$x$),
  (2, $x$Quelle tribu habitait Ṭāʾif ?$x$, array[$x$Thaqīf$x$, $x$Quraysh$x$, $x$Aws$x$]::text[], 0, $x$Ṭāʾif était la ville de la tribu de Thaqīf.$x$),
  (3, $x$Selon le hadith rapporté par ʿĀʾisha, quel fut le jour le plus dur que le Prophète ﷺ connut de son peuple ?$x$, array[$x$Le jour où il se présenta à Ibn ʿAbd Yālīl, qui refusa son appel$x$, $x$Le jour de la bataille de Badr$x$, $x$Le jour de la conquête de La Mecque$x$]::text[], 0, $x$Al-Bukhārī n° 3231.$x$),
  (4, $x$Que proposa l'ange des montagnes au Prophète ﷺ ?$x$, array[$x$De refermer sur eux les deux montagnes$x$, $x$De le porter à Médine$x$, $x$De lui donner des richesses$x$]::text[], 0, $x$Il lui proposa de refermer sur eux al-Akhshabān, les deux montagnes.$x$),
  (5, $x$Que répondit le Prophète ﷺ ?$x$, array[$x$Il espéra qu'Allah ferait sortir de leurs descendants des gens qui adoreraient Allah seul$x$, $x$Il accepta qu'ils soient punis$x$, $x$Il demanda à quitter l'Arabie$x$]::text[], 0, $x$« Non, j'espère plutôt qu'Allah fera sortir de leurs descendants des gens qui adoreront Allah seul, sans rien Lui associer. »$x$),
  (6, $x$D'où vient le récit de ʿAddās ?$x$, array[$x$Des livres de Sira$x$, $x$De Ṣaḥīḥ al-Bukhārī$x$, $x$Du Coran$x$]::text[], 0, $x$Il est rapporté par les livres de Sira, et non par les recueils authentiques.$x$),
  (7, $x$Que disent les savants de l'invocation « Ô Allah, je me plains à Toi de la faiblesse de ma force… » ?$x$, array[$x$Sa chaîne est faible$x$, $x$Elle est dans al-Bukhārī$x$, $x$Elle fait l'objet d'un consensus sur son authenticité$x$]::text[], 0, $x$Al-Albānī l'a jugée faible (al-Silsila al-ḍaʿīfa n° 2933), et Ibn Bāz a dit que sa chaîne est discutable.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Sira 11$x$),
       rv.h = '83a155005a70cbb78288133cff1b975b' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
