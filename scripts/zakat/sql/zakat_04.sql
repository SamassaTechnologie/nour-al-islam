-- Zakāt 4 : zakat-des-recoltes-et-du-betail
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$zakat-des-recoltes-et-du-betail$x$, 'lesson', $x$zakat$x$, 'fr', 4) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La zakāt des récoltes et du bétail$x$, $x$La zakāt des céréales et des fruits (lesquels, le seuil de cinq awsuq, le dixième ou le demi-dixième selon l'arrosage, le moment de la récolte), puis celle des moutons et des chèvres, des chameaux et des bovins qui paissent librement, d'après la lettre d'Abū Bakr et les fatwas d'Ibn Bāz.$x$, $x$1. Les récoltes : l'ordre d'Allah
Allah dit : mangez de leurs fruits quand ils mûrissent, et donnez-en le dû le jour de la récolte (sourate al-Anʿām, 6:141) ; et : ô vous qui croyez, dépensez des bonnes choses que vous avez gagnées et de ce que Nous avons fait sortir pour vous de la terre (sourate al-Baqara, 2:267).
Ibn Bāz explique que le verset 6:141 indique le moment : le jour de la récolte, quand le grain est battu et vanné et qu'il atteint le seuil (fatwa n° 5736). Il n'y a donc pas d'année à attendre.

2. Quelles récoltes ?
Selon Ibn Bāz, la zakāt est due sur les céréales et les fruits qui se mesurent au volume et se conservent : par exemple le blé, l'orge, le riz, le maïs (dhura), le mil (dukhn), les pois chiches, les lentilles, les dattes et les raisins secs. Il ajoute qu'aucun texte ne la prescrit sur les légumes ni sur les fruits qui se mangent frais et ne se conservent pas, comme la pastèque, et que la zakāt est une adoration qui ne s'établit pas par l'opinion (fatwa n° 5736 et réponses classées sur son site). C'est l'avis présenté ici ; d'autres savants ont des avis plus larges ou plus étroits, non détaillés dans cette leçon.

3. Le seuil : cinq awsuq
Le Prophète ﷺ a dit qu'en dessous de cinq awsuq, il n'y a pas de zakāt (al-Bukhārī n° 1405, vu dans la leçon 1). Ibn Bāz explique qu'un wasq vaut soixante ṣāʿ, donc le seuil est de trois cents ṣāʿ du Prophète ﷺ ; un ṣāʿ correspond à quatre poignées de deux mains moyennes bien remplies (fatwa n° 8129). IslamQA en donne l'équivalent approximatif de 612 kg (réponse n° 149115).

4. Le taux : le dixième ou le demi-dixième
Le Prophète ﷺ a dit :
« فِيمَا سَقَتِ السَّمَاءُ وَالْعُيُونُ أَوْ كَانَ عَثَرِيًّا الْعُشْرُ، وَمَا سُقِيَ بِالنَّضْحِ نِصْفُ الْعُشْرِ » (fīmā saqati s-samā’u wa l-ʿuyūnu aw kāna ʿathariyyan al-ʿushr, wa mā suqiya bi-n-naḍḥi niṣfu l-ʿushr).
Sens : « Sur ce qu'arrosent la pluie et les sources, ou ce qui boit par ses racines, le dixième ; et sur ce qui est arrosé par puisage, la moitié du dixième. » (al-Bukhārī n° 1483, d'après Ibn ʿUmar ; hadith authentique).
Ibn Bāz explique : arrosé par la pluie ou les rivières, 10 % (cent ṣāʿ sur mille) ; arrosé par des machines ou par l'eau puisée, 5 % (cinquante sur mille) (fatwa n° 8129).
Exemple : un paysan récolte 2 000 kg de mil arrosé par la pluie ; il dépasse le seuil, il doit 200 kg. Si le champ était arrosé par une motopompe, il doit 100 kg.

5. Le bétail (moutons, chèvres, chameaux, bovins)
a) La condition : la lettre d'Abū Bakr parle des moutons « en pâturage » (sā’ima), c'est-à-dire qui paissent librement (al-Bukhārī n° 1454). Les détails de cette condition se demandent à un savant.
b) Les moutons et les chèvres : d'après la même lettre, de 40 à 120 têtes, un mouton ; de 121 à 200, deux ; de 201 à 300, trois ; au-delà, un mouton par centaine. En dessous de 40, rien, sauf si le propriétaire le veut.
c) Les chameaux : de 5 à 24 chameaux, un mouton pour chaque groupe de cinq ; à partir de 25, une jeune chamelle, selon un barème détaillé dans la même lettre (al-Bukhārī n° 1454).
d) Les bovins : Muʿādh dit que le Prophète ﷺ lui ordonna de prendre, pour chaque trentaine de bovins, un veau ou une génisse d'un an (tabīʿ), et pour chaque quarantaine, une vache de deux ans (musinna) (al-Tirmidhī n° 623 ; « ḥasan » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir, faible selon Zubayr ʿAlī Zaʾī ; al-Tirmidhī juge la version mursal plus sûre).
Pour le bétail acheté afin d'être revendu, voir aussi la leçon 3 sur les marchandises. Les barèmes complets et les cas mélangés s'étudient avec un savant.

6. Ce que l'élève peut retenir
- Récoltes : céréales et fruits qui se mesurent et se conservent ; seuil de 300 ṣāʿ (environ 612 kg) ; 10 % si arrosé par la pluie, 5 % si arrosé avec effort ; à donner à la récolte.
- Pas de zakāt sur les légumes et les fruits frais, selon Ibn Bāz.
- Moutons en pâturage libre : un mouton de 40 à 120 têtes.

Exercice : calculez la zakāt d'une récolte de riz ou de mil, avec les deux modes d'arrosage, puis répondez aux questions. Pour un élevage ou une exploitation, interrogez un savant qualifié.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 6::int, 141::int, 141::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 2::int, 267::int, 267::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 5736 : la zakāt est due sur les céréales et fruits qui se mesurent, se conservent et sont utiles$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh (Majmūʿ fatāwā 14/68)$x$, $x$https://binbaz.org.sa/fatwas/5736/$x$, $x$Moment : le jour de la récolte ; pas de zakāt sur les légumes ni les fruits frais (sauf le raisin, comme la datte) ; la zakāt est une adoration qui ne s'établit pas par l'opinion.$x$),
  (4, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Zakāt al-ḥubūb wa l-thimār (la zakāt des céréales et des fruits), fatwas classées$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh, rubrique de fiqh n° 71$x$, $x$https://binbaz.org.sa/categories/fiqhi/71$x$, $x$Tout produit mesuré et consommé : pois chiches, lentilles, maïs, orge, mil, riz ; seuil de 300 ṣāʿ.$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1405$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Pas de zakāt en dessous de cinq awsuq, d'après Abū Saʿīd$x$, null, null, $x$https://sunnah.com/bukhari:1405$x$, null),
  (6, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 8129 : le seuil de la zakāt des récoltes$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh, émission Nūr ʿalā al-darb$x$, $x$https://binbaz.org.sa/fatwas/8129/$x$, $x$Cinq awsuq, le wasq valant soixante ṣāʿ : 300 ṣāʿ ; le ṣāʿ : quatre poignées de deux mains moyennes ; 10 % pour l'arrosage par la pluie et les rivières, 5 % par les machines ou l'eau puisée.$x$),
  (7, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le seuil des récoltes et la quantité de leur zakāt, réponse n° 149115$x$, $x$IslamQA, d'après Ibn Bāz$x$, $x$Site IslamQA, en arabe$x$, $x$https://islamqa.info/ar/answers/149115$x$, $x$Reprend la fatwa d'Ibn Bāz et ajoute l'équivalent approximatif de 612 kg.$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1483$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le dixième ou le demi-dixième selon l'arrosage, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:1483$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1454$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La lettre d'Abū Bakr sur la zakāt des chameaux et des moutons, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:1454$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$623$x$, $x$Ḥasan (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir) ; faible (Zubayr ʿAlī Zaʾī)$x$, $x$Al-Tirmidhī ; jugements affichés sur sunnah.com$x$, $x$La zakāt des bovins, d'après Muʿādh ibn Jabal$x$, null, null, $x$https://sunnah.com/tirmidhi:623$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quand donne-t-on la zakāt d'une récolte ?$x$, array[$x$Le jour de la récolte$x$, $x$Après une année$x$, $x$Au Ramaḍān suivant$x$]::text[], 0, $x$Sourate al-Anʿām, 6:141 ; Ibn Bāz.$x$),
  (2, $x$Sur quelles récoltes Ibn Bāz dit-il que la zakāt est due ?$x$, array[$x$Les céréales et fruits qui se mesurent et se conservent$x$, $x$Tous les légumes$x$, $x$Les fleurs$x$]::text[], 0, $x$Fatwa n° 5736.$x$),
  (3, $x$Le mil (dukhn) est-il concerné selon Ibn Bāz ?$x$, array[$x$Oui, c'est une céréale mesurée et consommée$x$, $x$Non, jamais$x$, $x$Seulement au Mali$x$]::text[], 0, $x$Fatwas classées d'Ibn Bāz sur les céréales et les fruits.$x$),
  (4, $x$Quel est le seuil des récoltes ?$x$, array[$x$Cinq awsuq, soit 300 ṣāʿ (environ 612 kg)$x$, $x$Un seul ṣāʿ$x$, $x$Mille kg$x$]::text[], 0, $x$Al-Bukhārī n° 1405 ; Ibn Bāz, fatwa n° 8129 ; IslamQA n° 149115.$x$),
  (5, $x$Quel taux pour un champ arrosé par la pluie ?$x$, array[$x$10 %$x$, $x$2,5 %$x$, $x$50 %$x$]::text[], 0, $x$Al-Bukhārī n° 1483.$x$),
  (6, $x$Quel taux pour un champ arrosé par une motopompe ?$x$, array[$x$5 %$x$, $x$10 %$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 1483 ; Ibn Bāz, fatwa n° 8129.$x$),
  (7, $x$Combien doit le propriétaire de 60 moutons en pâturage libre ?$x$, array[$x$Un mouton$x$, $x$Deux moutons$x$, $x$Rien$x$]::text[], 0, $x$De 40 à 120 : un mouton (al-Bukhārī n° 1454).$x$),
  (8, $x$Que prend-on pour trente bovins selon le hadith de Muʿādh ?$x$, array[$x$Un veau ou une génisse d'un an$x$, $x$Une vache de deux ans$x$, $x$Rien$x$]::text[], 0, $x$Al-Tirmidhī n° 623.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Zakāt 4$x$),
       rv.h = '1010333d4e716087007e436795700c8a' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
