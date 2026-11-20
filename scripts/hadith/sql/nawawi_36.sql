-- Hadith 36 d'an-Nawawī : nawawi-36-soulager-son-frere
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-36-soulager-son-frere$x$, 'lesson', 'hadith', 'fr', 36) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 36 : soulager son frère, chercher la science$x$, $x$Celui qui soulage, facilite, couvre et aide son frère est récompensé de la même manière par Allah ; celui qui cherche la science voit son chemin vers le Paradis facilité.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:36}}

Traduction du sens : D'après Abū Hurayra : le Prophète ﷺ a dit : « Celui qui soulage un croyant d'une détresse parmi les détresses de ce monde, Allah le soulagera d'une détresse parmi les détresses du Jour de la Résurrection. Celui qui facilite les choses à une personne en difficulté, Allah lui facilitera les choses dans ce monde et dans l'au-delà. Celui qui couvre un musulman, Allah le couvrira dans ce monde et dans l'au-delà. Allah aide le serviteur tant que le serviteur aide son frère. Celui qui emprunte un chemin pour y chercher une science, Allah lui facilite par cela un chemin vers le Paradis. Des gens ne se réunissent pas dans une des maisons d'Allah pour réciter le Livre d'Allah et l'étudier ensemble sans que la sérénité ne descende sur eux, que la miséricorde ne les recouvre, que les anges ne les entourent et qu'Allah ne les mentionne auprès de ceux qui sont auprès de Lui. Et celui que ses œuvres ont retardé, sa lignée ne le fera pas avancer. » Rapporté par Muslim (n° 2699) avec ces mots. Hadith authentique.

2. La phrase à retenir
« {{NAWX:36:362:432}} » (wa llāhu fī ʿawni l-ʿabdi mā kāna l-ʿabdu fī ʿawni akhīh).
Sens : « Allah aide le serviteur tant que le serviteur aide son frère. »

3. Explication
La récompense du musulman auprès d'Allah est de la même nature que ce qu'il fait pour les musulmans (selon HadeethEnc) :
- Celui qui enlève à un croyant une détresse de ce monde, Allah lui enlève une détresse du Jour de la Résurrection.
- Celui qui facilite l'affaire d'une personne en difficulté, Allah lui facilite ses affaires dans ce monde et dans l'au-delà.
- Celui qui couvre un musulman dont il a vu une faute ou un manquement qu'il ne convient pas de montrer, Allah le couvre dans ce monde et dans l'au-delà.
- Allah aide Son serviteur tant que celui-ci aide son frère.

4. Ce que l'élève peut retenir
- HadeethEnc cite Ibn Daqīq al-ʿĪd : c'est un hadith immense qui réunit des sciences, des règles et des bonnes manières ; il montre le mérite de répondre aux besoins des musulmans, selon ses moyens : par la science, l'argent, l'aide, un bon conseil…
- Il encourage à faciliter les choses à celui qui est en difficulté.
- Il pousse à aider son frère : Allah aide celui qui aide.
- Chercher la science est un chemin vers le Paradis.
- La valeur de la personne vient de ses œuvres, et non de sa lignée.

Exercice : choisissez une manière concrète d'aider quelqu'un cette semaine, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$36$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Celui qui soulage un croyant d'une détresse, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:36$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2699$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre du rappel, de l'invocation, du repentir et de la demande de pardon$x$, null, null, $x$https://sunnah.com/muslim:2699a$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4801$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4801$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que fait Allah pour celui qui soulage un croyant d'une détresse ?$x$, array[$x$Il le soulage d'une détresse du Jour de la Résurrection$x$, $x$Rien$x$, $x$Il lui donne de l'argent immédiatement$x$]::text[], 0, $x$La récompense est de la même nature que l'œuvre.$x$),
  (2, $x$Que signifie « wa llāhu fī ʿawni l-ʿabd… » ?$x$, array[$x$Allah aide le serviteur tant qu'il aide son frère$x$, $x$Allah voit tout$x$, $x$Allah est miséricordieux$x$]::text[], 0, $x$« Tant que le serviteur aide son frère. »$x$),
  (3, $x$Que gagne celui qui cherche la science ?$x$, array[$x$Un chemin facilité vers le Paradis$x$, $x$Seulement un diplôme$x$, $x$Rien$x$]::text[], 0, $x$« Allah lui facilite par cela un chemin vers le Paradis. »$x$),
  (4, $x$Que reçoivent ceux qui se réunissent pour réciter et étudier le Coran ?$x$, array[$x$La sérénité, la miséricorde, la présence des anges et la mention d'Allah$x$, $x$De l'argent$x$, $x$Une récompense seulement s'ils sont nombreux$x$]::text[], 0, $x$Le hadith cite ces quatre bienfaits.$x$),
  (5, $x$La lignée peut-elle compenser le manque d'œuvres ?$x$, array[$x$Non$x$, $x$Oui$x$]::text[], 0, $x$« Celui que ses œuvres ont retardé, sa lignée ne le fera pas avancer. »$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 36 d'an-Nawawī$x$),
       rv.h = '74df9d46d4fdda77b5305cea85a8c335' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
