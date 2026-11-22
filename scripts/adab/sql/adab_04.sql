-- Bonnes manières 4 : le-salut-et-les-manieres-de-la-table
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$le-salut-et-les-manieres-de-la-table$x$, 'lesson', $x$adab$x$, 'fr', 4) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le salut (salām) et les manières de la table$x$, $x$Répandre le salut, qui salue en premier, rendre un salut meilleur, les droits du musulman sur le musulman ; puis les manières de la table d'après la Sunna : dire « Bismillāh », manger de la main droite et devant soi, ne pas critiquer la nourriture, ne pas souffler dans le récipient, la modération et la louange à la fin.$x$, $x$1. Répandre le salut
Le Prophète ﷺ a dit :
« لاَ تَدْخُلُونَ الْجَنَّةَ حَتَّى تُؤْمِنُوا وَلاَ تُؤْمِنُوا حَتَّى تَحَابُّوا ‏.‏ أَوَلاَ أَدُلُّكُمْ عَلَى شَىْءٍ إِذَا فَعَلْتُمُوهُ تَحَابَبْتُمْ أَفْشُوا السَّلاَمَ بَيْنَكُمْ » (lā tadkhulūna l-jannata ḥattā tu’minū, wa lā tu’minū ḥattā taḥābbū, a-wa lā adullukum ʿalā shay’in idhā faʿaltumūhu taḥābabtum ? afshu s-salāma baynakum).
Sens : « Vous n'entrerez pas au Paradis tant que vous ne croirez pas, et vous ne croirez pas tant que vous ne vous aimerez pas. Voulez-vous que je vous indique une chose qui, si vous la faites, vous fera vous aimer ? Répandez le salut entre vous. » (Muslim n° 54, d'après Abū Hurayra ; hadith authentique).
Un homme demanda quel islam est le meilleur ; il répondit : nourrir les gens, et saluer celui que tu connais et celui que tu ne connais pas (al-Bukhārī n° 12, d'après ʿAbd Allāh ibn ʿAmr).

2. Qui salue en premier, et comment répondre
Le Prophète ﷺ a dit : le petit salue le grand, celui qui passe salue celui qui est assis, et le petit nombre salue le grand nombre (al-Bukhārī n° 6231, d'après Abū Hurayra).
Allah dit : quand on vous salue, saluez d'une manière meilleure, ou rendez-le (sourate al-Nisā’, 4:86).

3. Les droits du musulman sur le musulman
Le Prophète ﷺ a dit que le musulman a six droits sur le musulman : quand tu le rencontres, salue-le ; quand il t'invite, réponds-lui ; quand il te demande conseil, conseille-le ; quand il éternue et loue Allah, dis-lui « yarḥamuka llāh » ; quand il est malade, rends-lui visite ; et quand il meurt, suis son convoi (Muslim n° 2162, d'après Abū Hurayra ; hadith authentique).

4. Les manières de la table
a) Le Prophète ﷺ dit à ʿUmar ibn Abī Salama, encore enfant, dont la main allait partout dans le plat :
« يَا غُلاَمُ سَمِّ اللَّهَ، وَكُلْ بِيَمِينِكَ وَكُلْ مِمَّا يَلِيكَ » (yā ghulāmu sammi llāha wa kul bi-yamīnika wa kul mimmā yalīk).
Sens : « Ô garçon, dis « Bismillāh », mange de ta main droite et mange de ce qui est devant toi. » (al-Bukhārī n° 5376 ; hadith authentique). Celui qui a oublié de dire « Bismillāh » au début le dit quand il s'en souvient (voir les invocations du repas).
b) La main droite : le Prophète ﷺ a dit de manger et de boire de la main droite, car le diable mange et boit de la gauche (Muslim n° 2020, d'après Ibn ʿUmar).
c) Ne pas critiquer la nourriture : Abū Hurayra dit que le Prophète ﷺ n'a jamais critiqué un plat ; s'il en avait envie, il le mangeait, sinon il le laissait (al-Bukhārī n° 5409).
d) Ne pas souffler dans le récipient : il a dit que celui qui boit ne doit pas respirer dans le récipient (al-Bukhārī n° 5630).
e) La modération : il a dit que l'homme ne remplit pas de récipient pire que son ventre ; quelques bouchées qui lui tiennent le dos droit lui suffisent ; s'il doit en prendre plus, un tiers pour sa nourriture, un tiers pour sa boisson et un tiers pour sa respiration (al-Tirmidhī n° 2380, d'après al-Miqdām ibn Maʿdīkarib ; authentique selon al-Albānī et Aḥmad Shākir).
f) Louer Allah à la fin : voir la louange de fin de repas dans les invocations (al-Bukhārī n° 5458).

5. Ce que l'élève peut retenir
- Répandre le salut fait naître l'amour entre les croyants.
- Le petit salue le grand, celui qui passe salue celui qui est assis ; on rend un salut meilleur ou égal.
- À table : « Bismillāh », la main droite, ce qui est devant soi, pas de critique, pas de souffle dans le verre, la modération, la louange à la fin.

Exercice : pendant une semaine, saluez en premier les personnes que vous rencontrez, et appliquez les manières de la table à chaque repas ; puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$54a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Répandez le salut entre vous », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:54a$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$12$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Nourrir les gens et saluer qui l'on connaît et qui l'on ne connaît pas, d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/bukhari:12$x$, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6231$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Qui salue en premier, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:6231$x$, null),
  (4, $x$quran$x$::public.reference_kind, 4::int, 86::int, 86::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2162b$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Les six droits du musulman sur le musulman, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2162b$x$, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5376$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ô garçon, dis Bismillāh, mange de ta main droite », d'après ʿUmar ibn Abī Salama$x$, null, null, $x$https://sunnah.com/bukhari:5376$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2020a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Manger et boire de la main droite, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/muslim:2020a$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5409$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le Prophète ﷺ n'a jamais critiqué un plat, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5409$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5630$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Ne pas respirer dans le récipient, d'après Abū Qatāda$x$, null, null, $x$https://sunnah.com/bukhari:5630$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2380$x$, $x$Authentique (al-Albānī, Aḥmad Shākir) ; ḥasan ṣaḥīḥ (Bashshār ʿAwwād)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Un tiers pour la nourriture, un tiers pour la boisson, un tiers pour la respiration, d'après al-Miqdām ibn Maʿdīkarib$x$, null, null, $x$https://sunnah.com/tirmidhi:2380$x$, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5458$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La louange à la fin du repas, d'après Abū Umāma$x$, null, null, $x$https://sunnah.com/bukhari:5458$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que conseille le Prophète ﷺ pour que les croyants s'aiment ?$x$, array[$x$Répandre le salut$x$, $x$Se taire$x$, $x$Éviter les gens$x$]::text[], 0, $x$Muslim n° 54.$x$),
  (2, $x$Qui doit saluer en premier entre celui qui passe et celui qui est assis ?$x$, array[$x$Celui qui passe$x$, $x$Celui qui est assis$x$, $x$Aucun$x$]::text[], 0, $x$Al-Bukhārī n° 6231.$x$),
  (3, $x$Comment répondre à un salut, selon 4:86 ?$x$, array[$x$D'une manière meilleure, ou pareille$x$, $x$Ne pas répondre$x$, $x$Seulement d'un geste$x$]::text[], 0, $x$Sourate al-Nisā’, 4:86.$x$),
  (4, $x$Lequel de ces droits fait partie des six droits du musulman ?$x$, array[$x$Lui rendre visite quand il est malade$x$, $x$Lui prêter toujours de l'argent$x$, $x$L'appeler chaque jour$x$]::text[], 0, $x$Muslim n° 2162.$x$),
  (5, $x$Que dire avant de manger ?$x$, array[$x$Bismillāh$x$, $x$Rien$x$, $x$Āmīn$x$]::text[], 0, $x$Al-Bukhārī n° 5376.$x$),
  (6, $x$De quelle main mange-t-on ?$x$, array[$x$La main droite$x$, $x$La main gauche$x$, $x$Peu importe$x$]::text[], 0, $x$Muslim n° 2020.$x$),
  (7, $x$Que faisait le Prophète ﷺ d'un plat qu'il n'aimait pas ?$x$, array[$x$Il le laissait sans le critiquer$x$, $x$Il le critiquait$x$, $x$Il le jetait$x$]::text[], 0, $x$Al-Bukhārī n° 5409.$x$),
  (8, $x$Comment partager son ventre, selon al-Tirmidhī n° 2380 ?$x$, array[$x$Un tiers nourriture, un tiers boisson, un tiers respiration$x$, $x$Tout pour la nourriture$x$, $x$Moitié nourriture, moitié boisson$x$]::text[], 0, $x$Al-Tirmidhī n° 2380.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 4$x$),
       rv.h = '66d51662237be2d998f167ea5ccb8471' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
