-- Bonnes manières 19 : la-confiance-en-allah-et-la-gratitude
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-confiance-en-allah-et-la-gratitude$x$, 'lesson', $x$adab$x$, 'fr', 19) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La confiance en Allah (at-tawakkul) et la gratitude (ash-shukr)$x$, $x$Celui qui place sa confiance en Allah, Allah lui suffit ; la confiance en Allah comme l'oiseau qui part le ventre vide et revient rassasié ; prendre les moyens ; les soixante-dix mille qui entrent au Paradis sans compte. « Si vous êtes reconnaissants, J'augmenterai » ; le Prophète ﷺ, serviteur reconnaissant ; louer Allah après le repas ; remercier les gens.$x$, $x$1. La confiance en Allah
Allah dit : celui qui place sa confiance en Allah, Il lui suffit (sourate aṭ-Ṭalāq, 65:3). Et après avoir pris une décision, place ta confiance en Allah : Allah aime ceux qui Lui font confiance (sourate Āl ʿImrān, 3:159).
Le Prophète ﷺ a dit :
« لَوْ أَنَّكُمْ كُنْتُمْ تَوَكَّلُونَ عَلَى اللَّهِ حَقَّ تَوَكُّلِهِ لَرُزِقْتُمْ كَمَا تُرْزَقُ الطَّيْرُ تَغْدُو خِمَاصًا وَتَرُوحُ بِطَانًا » (law annakum kuntum tawakkalūna ʿalā llāhi ḥaqqa tawakkulihi la-ruziqtum kamā turzaqu ṭ-ṭayr, taghdū khimāṣan wa tarūḥu biṭānā).
Sens : « Si vous placiez votre confiance en Allah comme il se doit, vous seriez nourris comme l'oiseau : il part le matin le ventre vide et revient le soir rassasié. » (al-Tirmidhī n° 2344, d'après ʿUmar ibn al-Khaṭṭāb ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir).

2. Prendre les moyens
Un homme demanda : ô Messager d'Allah, dois-je attacher ma chamelle et faire confiance (à Allah), ou la laisser libre et faire confiance ? Il répondit : attache-la et fais confiance (al-Tirmidhī n° 2517, d'après Anas). Degré discuté : al-Tirmidhī le dit « gharīb » et rapporte que Yaḥyā al-Qaṭṭān le jugeait « munkar » ; al-Albānī et Aḥmad Shākir le jugent « ḥasan ».

3. Ceux qui entrent au Paradis sans compte
Le Prophète ﷺ a dit que soixante-dix mille de sa communauté entreront au Paradis sans compte : ceux qui ne demandent pas la ruqya, ne tirent pas de mauvais présages, et placent leur confiance en leur Seigneur (al-Bukhārī n° 6472, d'après Ibn ʿAbbās).

4. La gratitude
Allah dit : si vous êtes reconnaissants, J'augmenterai (Mes bienfaits) pour vous (sourate Ibrāhīm, 14:7). Soyez-Moi reconnaissants et ne soyez pas ingrats envers Moi (sourate al-Baqara, 2:152). Si vous comptiez les bienfaits d'Allah, vous ne sauriez les dénombrer (sourate an-Naḥl, 16:18). Et peu de Mes serviteurs sont reconnaissants (sourate Saba’, 34:13).
Le Prophète ﷺ priait la nuit jusqu'à ce que ses pieds enflent. On lui dit : Allah t'a pardonné tes péchés passés et futurs. Il répondit :
« أَفَلاَ أَكُونُ عَبْدًا شَكُورًا » (a-fa-lā akūnu ʿabdan shakūrā).
Sens : « Ne serais-je donc pas un serviteur reconnaissant ? » (al-Bukhārī n° 4836, d'après al-Mughīra ibn Shuʿba ; hadith authentique).

5. Louer Allah pour la nourriture, remercier les gens
Le Prophète ﷺ a dit :
« إِنَّ اللَّهَ لَيَرْضَى عَنِ الْعَبْدِ أَنْ يَأْكُلَ الأَكْلَةَ فَيَحْمَدَهُ عَلَيْهَا أَوْ يَشْرَبَ الشَّرْبَةَ فَيَحْمَدَهُ عَلَيْهَا » (inna llāha la-yarḍā ʿani l-ʿabdi an ya’kula l-aklata fa-yaḥmadahu ʿalayhā aw yashraba sh-sharbata fa-yaḥmadahu ʿalayhā).
Sens : « Allah est satisfait du serviteur qui mange un repas et L'en loue, ou qui boit une gorgée et L'en loue. » (Muslim n° 2734, d'après Anas ibn Mālik ; hadith authentique).
Et il a dit : celui qui ne remercie pas les gens ne remercie pas Allah (al-Tirmidhī n° 1954, d'après Abū Hurayra ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī, authentique selon al-Albānī).
Rappel : le croyant remercie dans l'aisance et patiente dans l'épreuve (Muslim n° 2999 ; voir la leçon « La pudeur, la colère et la patience »).

6. Ce que l'élève peut retenir
- On place sa confiance en Allah tout en prenant les moyens.
- Allah suffit à celui qui Lui fait confiance.
- La gratitude augmente les bienfaits ; le Prophète ﷺ était un serviteur reconnaissant.
- On loue Allah après chaque repas et on remercie ceux qui nous font du bien.

Exercice : chaque soir de cette semaine, notez trois bienfaits d'Allah reçus dans la journée et remerciez une personne qui vous a aidé, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 65::int, 3::int, 3::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 3::int, 159::int, 159::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2344$x$, $x$Ḥasan ṣaḥīḥ (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$La confiance en Allah comme l'oiseau, d'après ʿUmar ibn al-Khaṭṭāb$x$, null, null, $x$https://sunnah.com/tirmidhi:2344$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2517$x$, $x$Ḥasan (al-Albānī, Aḥmad Shākir) ; gharīb (al-Tirmidhī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Attache-la et fais confiance », d'après Anas$x$, null, null, $x$https://sunnah.com/tirmidhi:2517$x$, $x$Al-Tirmidhī rapporte que Yaḥyā al-Qaṭṭān jugeait ce hadith « munkar ».$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6472$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les soixante-dix mille sans compte, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/bukhari:6472$x$, null),
  (6, $x$quran$x$::public.reference_kind, 14::int, 7::int, 7::int, null, null, null, null, null, null, null, null, null, null),
  (7, $x$quran$x$::public.reference_kind, 2::int, 152::int, 152::int, null, null, null, null, null, null, null, null, null, null),
  (8, $x$quran$x$::public.reference_kind, 16::int, 18::int, 18::int, null, null, null, null, null, null, null, null, null, null),
  (9, $x$quran$x$::public.reference_kind, 34::int, 13::int, 13::int, null, null, null, null, null, null, null, null, null, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4836$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ne serais-je donc pas un serviteur reconnaissant ? », d'après al-Mughīra$x$, null, null, $x$https://sunnah.com/bukhari:4836$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2734a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Louer Allah après avoir mangé ou bu, d'après Anas$x$, null, null, $x$https://sunnah.com/muslim:2734a$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1954$x$, $x$Ḥasan ṣaḥīḥ (al-Tirmidhī) ; authentique (al-Albānī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Celui qui ne remercie pas les gens ne remercie pas Allah », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/tirmidhi:1954$x$, null),
  (13, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2999$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Étonnant est l'état du croyant », d'après Ṣuhayb$x$, null, null, $x$https://sunnah.com/muslim:2999$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que fait Allah pour celui qui place sa confiance en Lui ?$x$, array[$x$Il lui suffit$x$, $x$Rien$x$, $x$Il l'abandonne$x$]::text[], 0, $x$Sourate aṭ-Ṭalāq, 65:3.$x$),
  (2, $x$À quoi le Prophète ﷺ compare-t-il celui qui a une vraie confiance en Allah ?$x$, array[$x$À l'oiseau qui part le ventre vide et revient rassasié$x$, $x$À un arbre$x$, $x$À une pierre$x$]::text[], 0, $x$Al-Tirmidhī n° 2344.$x$),
  (3, $x$La confiance en Allah empêche-t-elle de prendre les moyens ?$x$, array[$x$Non : attache ta chamelle et fais confiance$x$, $x$Oui, il ne faut rien faire$x$, $x$Seulement le vendredi$x$]::text[], 0, $x$Al-Tirmidhī n° 2517.$x$),
  (4, $x$Que disent les savants du degré du hadith « attache-la et fais confiance » ?$x$, array[$x$Ils divergent : ḥasan pour al-Albānī, munkar pour Yaḥyā al-Qaṭṭān$x$, $x$Tous le disent faible$x$, $x$Tous le disent dans al-Bukhārī$x$]::text[], 0, $x$Al-Tirmidhī n° 2517.$x$),
  (5, $x$Que promet Allah à ceux qui sont reconnaissants ?$x$, array[$x$Il augmentera Ses bienfaits$x$, $x$Rien$x$, $x$Il les éprouvera$x$]::text[], 0, $x$Sourate Ibrāhīm, 14:7.$x$),
  (6, $x$Pourquoi le Prophète ﷺ priait-il jusqu'à ce que ses pieds enflent ?$x$, array[$x$Pour être un serviteur reconnaissant$x$, $x$Parce qu'il avait des péchés à effacer$x$, $x$Pour être vu$x$]::text[], 0, $x$Al-Bukhārī n° 4836.$x$),
  (7, $x$De quoi Allah est-Il satisfait selon le hadith d'Anas ?$x$, array[$x$Du serviteur qui Le loue après avoir mangé ou bu$x$, $x$Du serviteur qui mange beaucoup$x$, $x$De rien$x$]::text[], 0, $x$Muslim n° 2734.$x$),
  (8, $x$Que dit le hadith de celui qui ne remercie pas les gens ?$x$, array[$x$Il ne remercie pas Allah$x$, $x$Il est humble$x$, $x$Rien$x$]::text[], 0, $x$Al-Tirmidhī n° 1954.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 19$x$),
       rv.h = 'f602b01095d0329dd406a1d4a385e84e' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
