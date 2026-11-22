-- Bonnes manières 10 : l-honnetete-dans-le-commerce-et-le-respect-des-engagements
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$l-honnetete-dans-le-commerce-et-le-respect-des-engagements$x$, 'lesson', $x$adab$x$, 'fr', 10) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$L'honnêteté dans le commerce et le respect des engagements$x$, $x$Allah ordonne de respecter les engagements et de rendre les dépôts. Les signes de l'hypocrite ; la bénédiction de la vente honnête et la perte de celle qui cache ; « celui qui trompe n'est pas des miens » ; le serment qui fait vendre et efface la bénédiction ; la tolérance dans la vente, et les dettes.$x$, $x$1. Respecter ses engagements et rendre les dépôts
Allah ordonne aux croyants de remplir leurs engagements (sourate al-Mā’ida, 5:1) et de tenir leur promesse, car on en sera interrogé (sourate al-Isrā’, 17:34). Il ordonne de rendre les dépôts à leurs ayants droit (sourate an-Nisā’, 4:58). Et Il menace ceux qui trichent sur la mesure et le poids (sourate al-Muṭaffifīn, 83:1-3).

2. Les signes de l'hypocrite
Le Prophète ﷺ a dit :
« آيَةُ الْمُنَافِقِ ثَلاَثٌ إِذَا حَدَّثَ كَذَبَ، وَإِذَا وَعَدَ أَخْلَفَ، وَإِذَا اؤْتُمِنَ خَانَ » (āyatu l-munāfiqi thalāth : idhā ḥaddatha kadhab, wa idhā waʿada akhlaf, wa idhā u’tumina khān).
Sens : « Les signes de l'hypocrite sont trois : quand il parle, il ment ; quand il promet, il ne tient pas ; et quand on lui confie un dépôt, il trahit. » (al-Bukhārī n° 33, d'après Abū Hurayra ; hadith authentique).

3. La vente honnête est bénie
Le Prophète ﷺ a dit que l'acheteur et le vendeur ont le choix (de garder ou d'annuler la vente) tant qu'ils ne se sont pas séparés, puis :
« فَإِنْ صَدَقَا وَبَيَّنَا بُورِكَ لَهُمَا فِي بَيْعِهِمَا، وَإِنْ كَتَمَا وَكَذَبَا مُحِقَتْ بَرَكَةُ بَيْعِهِمَا » (fa-in ṣadaqā wa bayyanā būrika lahumā fī bayʿihimā, wa in katamā wa kadhabā muḥiqat barakatu bayʿihimā).
Sens : « S'ils disent la vérité et montrent (les défauts), leur vente est bénie ; et s'ils cachent et mentent, la bénédiction de leur vente est effacée. » (al-Bukhārī n° 2079, d'après Ḥakīm ibn Ḥizām ; hadith authentique).
Le serment : le Prophète ﷺ a dit que le serment fait vendre la marchandise mais efface la bénédiction (al-Bukhārī n° 2087, d'après Abū Hurayra).

4. « Celui qui trompe n'est pas des miens »
Le Prophète ﷺ passa près d'un tas de nourriture ; il y plongea la main et ses doigts touchèrent de l'humidité. Il demanda : qu'est-ce que cela, ô vendeur ? L'homme répondit : la pluie l'a touché, ô Messager d'Allah. Il dit :
« أَفَلاَ جَعَلْتَهُ فَوْقَ الطَّعَامِ كَىْ يَرَاهُ النَّاسُ مَنْ غَشَّ فَلَيْسَ مِنِّي » (a-fa-lā jaʿaltahu fawqa ṭ-ṭaʿāmi kay yarāhu n-nās, man ghashsha fa-laysa minnī).
Sens : « Pourquoi ne l'as-tu pas mis au-dessus de la nourriture, pour que les gens le voient ? Celui qui trompe n'est pas des miens. » (Muslim n° 102, d'après Abū Hurayra ; hadith authentique).

5. La tolérance et les dettes
Le Prophète ﷺ a dit : qu'Allah fasse miséricorde à un homme tolérant quand il vend, quand il achète et quand il réclame son dû (al-Bukhārī n° 2076, d'après Jābir ibn ʿAbd Allāh).
Il a dit aussi : celui qui prend l'argent des gens avec l'intention de le rendre, Allah le rendra pour lui ; et celui qui le prend avec l'intention de le perdre, Allah le perdra (al-Bukhārī n° 2387, d'après Abū Hurayra). Et : le retard du riche à payer (sa dette) est une injustice (al-Bukhārī n° 2400, d'après Abū Hurayra).

6. Ce que l'élève peut retenir
- On respecte ses engagements, on tient ses promesses et on rend les dépôts.
- Mentir, manquer à sa promesse et trahir la confiance sont des signes de l'hypocrite.
- Le commerçant honnête montre les défauts de sa marchandise ; sa vente est bénie.
- Tromper n'est pas le comportement du musulman ; le serment pour vendre efface la bénédiction.
- On est tolérant dans les affaires, et on rembourse ses dettes sans retard quand on le peut.

Exercice : pensez à une promesse ou à une dette que vous n'avez pas encore réglée et fixez-vous une date pour la régler, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 5::int, 1::int, 1::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 17::int, 34::int, 34::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 4::int, 58::int, 58::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 83::int, 1::int, 3::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$33$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les trois signes de l'hypocrite, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:33$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2079$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La vente honnête est bénie, d'après Ḥakīm ibn Ḥizām$x$, null, null, $x$https://sunnah.com/bukhari:2079$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2087$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le serment qui fait vendre et efface la bénédiction, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:2087$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$102$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Celui qui trompe n'est pas des miens », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:102$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2076$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La tolérance dans la vente et l'achat, d'après Jābir$x$, null, null, $x$https://sunnah.com/bukhari:2076$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2387$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Prendre l'argent des gens avec l'intention de le rendre, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:2387$x$, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2400$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le retard du riche à payer est une injustice, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:2400$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que doit-on faire des dépôts qu'on nous confie ?$x$, array[$x$Les rendre à leurs ayants droit$x$, $x$Les garder$x$, $x$Les dépenser$x$]::text[], 0, $x$Sourate an-Nisā’, 4:58.$x$),
  (2, $x$Lequel de ces actes est un signe de l'hypocrite ?$x$, array[$x$Ne pas tenir sa promesse$x$, $x$Rendre un dépôt$x$, $x$Dire la vérité$x$]::text[], 0, $x$Al-Bukhārī n° 33.$x$),
  (3, $x$Quand la vente est-elle bénie selon le hadith de Ḥakīm ibn Ḥizām ?$x$, array[$x$Quand les deux disent la vérité et montrent les défauts$x$, $x$Quand le vendeur cache les défauts$x$, $x$Quand le prix est élevé$x$]::text[], 0, $x$Al-Bukhārī n° 2079.$x$),
  (4, $x$Que fait le serment pour vendre une marchandise ?$x$, array[$x$Il fait vendre mais efface la bénédiction$x$, $x$Il augmente la bénédiction$x$, $x$Il est recommandé$x$]::text[], 0, $x$Al-Bukhārī n° 2087.$x$),
  (5, $x$Qu'a dit le Prophète ﷺ au vendeur qui cachait la nourriture mouillée ?$x$, array[$x$Celui qui trompe n'est pas des miens$x$, $x$C'est permis$x$, $x$Vends-la plus cher$x$]::text[], 0, $x$Muslim n° 102.$x$),
  (6, $x$Pour qui le Prophète ﷺ a-t-il demandé la miséricorde d'Allah ?$x$, array[$x$L'homme tolérant quand il vend, achète et réclame son dû$x$, $x$L'homme dur en affaires$x$, $x$Celui qui ne vend jamais$x$]::text[], 0, $x$Al-Bukhārī n° 2076.$x$),
  (7, $x$Que fait Allah pour celui qui emprunte avec l'intention de rendre ?$x$, array[$x$Il le rend pour lui$x$, $x$Rien$x$, $x$Il le punit$x$]::text[], 0, $x$Al-Bukhārī n° 2387.$x$),
  (8, $x$Comment le hadith qualifie-t-il le retard du riche à payer sa dette ?$x$, array[$x$Une injustice$x$, $x$Une bonne chose$x$, $x$Une prudence$x$]::text[], 0, $x$Al-Bukhārī n° 2400.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 10$x$),
       rv.h = '4fb0e664282e247669069f2295f037af' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
