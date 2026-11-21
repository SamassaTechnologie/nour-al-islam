-- Sira 25 : pelerinage-d-adieu
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$pelerinage-d-adieu$x$, 'lesson', 'sira', 'fr', 25) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le pèlerinage d'adieu$x$, $x$L'unique pèlerinage du Prophète ﷺ en la 10e année, son sermon à ʿArafa et le jour du sacrifice, la révélation du verset sur la religion parachevée, et ses dernières recommandations, d'après le Coran, al-Bukhārī et Muslim.$x$, $x$1. Un seul pèlerinage
Jābir ibn ʿAbd Allāh rapporte que le Prophète ﷺ resta neuf ans à Médine sans faire le pèlerinage, puis annonça la dixième année qu'il allait le faire ; une foule immense vint à Médine, chacun voulant le suivre et faire comme lui (en substance ; Muslim n° 1218a ; hadith authentique). Anas rapporte que le Prophète ﷺ ne fit qu'un seul pèlerinage (al-Bukhārī n° 1778). On l'appelle le pèlerinage d'adieu.
Jābir rapporte que le jour du sacrifice, en lançant les cailloux sur sa monture, le Prophète ﷺ dit :
« لِتَأْخُذُوا مَنَاسِكَكُمْ فَإِنِّي لاَ أَدْرِي لَعَلِّي لاَ أَحُجُّ بَعْدَ حَجَّتِي هَذِهِ » (li-ta’khudhū manāsikakum, fa-innī lā adrī laʿallī lā aḥujju baʿda ḥajjatī hādhih).
Sens : « Prenez de moi vos rites, car je ne sais pas ; peut-être ne ferai-je plus de pèlerinage après celui-ci. » (Muslim n° 1297 ; hadith authentique).

2. Le sermon de ʿArafa
D'après Jābir, le Prophète ﷺ fit un sermon à ʿArafa. Il déclara que le sang et les biens des gens sont sacrés comme ce jour, ce mois et ce pays ; que tout ce qui venait de la période d'ignorance (jāhiliyya) était aboli sous ses pieds, à commencer par la vengeance du sang et l'usure, et il commença par abolir ce qui concernait sa propre famille. Il recommanda de craindre Allah au sujet des femmes et rappela les droits réciproques des époux, dont leur droit à la nourriture et au vêtement selon l'usage (en substance ; Muslim n° 1218a). Puis il dit :
« وَقَدْ تَرَكْتُ فِيكُمْ مَا لَنْ تَضِلُّوا بَعْدَهُ إِنِ اعْتَصَمْتُمْ بِهِ كِتَابَ اللَّهِ » (wa qad taraktu fīkum mā lan taḍillū baʿdahu ini ʿtaṣamtum bihi kitāba llāh).
Sens : « Je vous ai laissé ce qui vous empêchera de vous égarer si vous vous y attachez : le Livre d'Allah. » Il leur demanda ce qu'ils diraient de lui ; ils répondirent qu'ils témoignaient qu'il avait transmis le message, accompli sa mission et donné le bon conseil. Il leva l'index vers le ciel puis vers les gens en disant trois fois : ô Allah, sois témoin (Muslim n° 1218a).

3. La religion parachevée
ʿUmar ibn al-Khaṭṭāb rapporte que le verset 3 de la sourate al-Māʾida, où Allah annonce qu'Il a parachevé pour les croyants leur religion, complété Son bienfait et agréé l'islam comme religion, fut révélé alors que le Prophète ﷺ se tenait à ʿArafa, un vendredi (en substance ; al-Bukhārī n° 45 ; hadith authentique).

4. Le sermon du jour du sacrifice
Ibn ʿAbbās rapporte que le jour du sacrifice, le Prophète ﷺ demanda quel jour, quel pays et quel mois c'était ; les gens répondirent qu'ils étaient sacrés. Il dit :
« فَإِنَّ دِمَاءَكُمْ وَأَمْوَالَكُمْ وَأَعْرَاضَكُمْ عَلَيْكُمْ حَرَامٌ، كَحُرْمَةِ يَوْمِكُمْ هَذَا، فِي بَلَدِكُمْ هَذَا فِي شَهْرِكُمْ هَذَا » (fa-inna dimā’akum wa amwālakum wa aʿrāḍakum ʿalaykum ḥarām, ka-ḥurmati yawmikum hādhā, fī baladikum hādhā, fī shahrikum hādhā).
Sens : « Votre sang, vos biens et votre honneur vous sont sacrés, comme est sacré ce jour, dans ce pays, en ce mois. » Il le répéta plusieurs fois, leva la tête et dit : ô Allah, ai-je transmis ? Il demanda que les présents transmettent aux absents, et dit : ne redevenez pas, après moi, des mécréants qui se frappent le cou les uns les autres (al-Bukhārī n° 1739 ; hadith authentique). Abū Bakra rapporte qu'il ajouta : vous rencontrerez votre Seigneur, et Il vous interrogera sur vos actes ; et peut-être que celui à qui l'on transmettra comprendra mieux que celui qui a entendu (en substance ; al-Bukhārī n° 4406 ; hadith authentique).

5. Ce que l'élève peut retenir
- Le Prophète ﷺ fit un seul pèlerinage, la dixième année ; il demanda qu'on prenne de lui les rites.
- Il proclama le caractère sacré du sang, des biens et de l'honneur.
- Il laissa le Livre d'Allah comme protection contre l'égarement.
- Le verset 5:3 sur la religion parachevée fut révélé à ʿArafa.
- Chacun doit transmettre ce qu'il a appris.

Exercice : répétez la parole du Prophète ﷺ sur le sang, les biens et l'honneur avec son sens, et répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1218a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Le long récit du pèlerinage du Prophète ﷺ, d'après Jābir ibn ʿAbd Allāh$x$, null, null, $x$https://sunnah.com/muslim:1218a$x$, $x$Passage du sermon de ʿArafa copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1778$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Un seul pèlerinage, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:1778$x$, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1297$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Prenez de moi vos rites », d'après Jābir$x$, null, null, $x$https://sunnah.com/muslim:1297$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$45$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La révélation du verset 5:3 à ʿArafa un vendredi, d'après ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:45$x$, null),
  (5, $x$quran$x$::public.reference_kind, 5::int, 3::int, 3::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1739$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le sermon du jour du sacrifice, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/bukhari:1739$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4406$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le sermon du jour du sacrifice, d'après Abū Bakra$x$, null, null, $x$https://sunnah.com/bukhari:4406$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Combien de pèlerinages le Prophète ﷺ a-t-il faits ?$x$, array[$x$Un seul$x$, $x$Trois$x$, $x$Dix$x$]::text[], 0, $x$Al-Bukhārī n° 1778.$x$),
  (2, $x$En quelle année eut lieu le pèlerinage d'adieu selon Jābir ?$x$, array[$x$La dixième année après l'émigration$x$, $x$La deuxième année$x$, $x$La sixième année$x$]::text[], 0, $x$Muslim n° 1218a : il resta neuf ans sans faire le pèlerinage, puis l'annonça la dixième année.$x$),
  (3, $x$Pourquoi le Prophète ﷺ dit-il « Prenez de moi vos rites » ?$x$, array[$x$Parce qu'il ne savait pas s'il ferait encore le pèlerinage$x$, $x$Parce que c'était la dernière ʿumra$x$, $x$Parce que les rites allaient changer$x$]::text[], 0, $x$Muslim n° 1297.$x$),
  (4, $x$Qu'a laissé le Prophète ﷺ pour protéger de l'égarement selon le sermon de ʿArafa ?$x$, array[$x$Le Livre d'Allah$x$, $x$Des richesses$x$, $x$Un royaume$x$]::text[], 0, $x$Muslim n° 1218a.$x$),
  (5, $x$Quel verset fut révélé à ʿArafa un vendredi ?$x$, array[$x$Al-Māʾida, 5:3$x$, $x$Al-Fātiḥa, 1:1$x$, $x$Al-Ikhlāṣ, 112:1$x$]::text[], 0, $x$Al-Bukhārī n° 45.$x$),
  (6, $x$Que déclara-t-il sacré comme ce jour, ce pays et ce mois ?$x$, array[$x$Le sang, les biens et l'honneur$x$, $x$Les chameaux$x$, $x$Les maisons de La Mecque$x$]::text[], 0, $x$Al-Bukhārī n° 1739.$x$),
  (7, $x$Que demanda-t-il aux présents ?$x$, array[$x$De transmettre aux absents$x$, $x$De garder le secret$x$, $x$De rentrer chez eux$x$]::text[], 0, $x$Al-Bukhārī n° 1739 et 4406.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Sira 25$x$),
       rv.h = '964968c238bfcdcf6d77cc58f122f70f' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
