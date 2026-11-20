-- Hadith 33 d'an-Nawawī : nawawi-33-la-preuve-incombe-au-demandeur
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-33-la-preuve-incombe-au-demandeur$x$, 'lesson', 'hadith', 'fr', 33) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 33 : la preuve incombe au demandeur$x$, $x$On ne donne rien sur une simple prétention : celui qui réclame doit apporter une preuve, et celui qui nie prête serment.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:33}}

Traduction du sens : D'après Ibn ʿAbbās : le Messager d'Allah ﷺ a dit : « Si l'on donnait aux gens selon leurs simples prétentions, des hommes réclameraient les biens et le sang d'autres personnes. Mais la preuve incombe au demandeur, et le serment à celui qui nie. » An-Nawawī a dit : hadith ḥasan, rapporté ainsi par al-Bayhaqī et d'autres ; une partie se trouve dans les deux Ṣaḥīḥ (al-Bukhārī et Muslim).

2. La phrase à retenir
« {{NAWX:33:189:253}} » (al-bayyinatu ʿalā l-muddaʿī wa l-yamīnu ʿalā man ankar).
Sens : « La preuve incombe au demandeur, et le serment à celui qui nie. »

3. Explication
Si l'on donnait aux gens selon leurs simples réclamations, sans preuve ni indice, certains réclameraient injustement les biens et le sang des autres. C'est pourquoi celui qui réclame doit apporter une preuve claire. S'il n'en a pas, on présente la réclamation à celui qui la nie ; s'il nie, on lui demande de jurer, et il est alors déclaré non redevable (selon HadeethEnc).

4. Ce que l'élève peut retenir
- HadeethEnc cite Ibn Daqīq al-ʿĪd : ce hadith est l'un des fondements des jugements et la grande référence en cas de litige.
- La Loi islamique protège les biens et la vie des gens contre les manipulations.
- Le juge ne tranche pas selon ce qu'il sait personnellement, mais selon les preuves.
- Toute prétention sans preuve est rejetée, qu'elle concerne des droits, des transactions, ou même des questions de croyance et de science.

Exercice : expliquez avec vos mots pourquoi on demande une preuve à celui qui réclame, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$33$x$, $x$Ḥasan (bon) selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$La preuve incombe au demandeur, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/nawawi40:33$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$As-Sunan al-Kubrā$x$, $x$Al-Bayhaqī$x$, $x$Hadith n° 21243, éd. at-Turkī (selon HadeethEnc)$x$, $x$https://hadeethenc.com/fr/browse/hadith/66532$x$, $x$Le texte d'an-Nawawī renvoie à « 10/252 ».$x$),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66532$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66532$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$À qui incombe la preuve ?$x$, array[$x$Au demandeur$x$, $x$À celui qui nie$x$, $x$Au juge$x$]::text[], 0, $x$« La preuve incombe au demandeur. »$x$),
  (2, $x$Que fait celui qui nie, si le demandeur n'a pas de preuve ?$x$, array[$x$Il prête serment$x$, $x$Il paie automatiquement$x$, $x$Il quitte le pays$x$]::text[], 0, $x$« Et le serment à celui qui nie. »$x$),
  (3, $x$Que se passerait-il si l'on donnait aux gens selon leurs simples prétentions ?$x$, array[$x$Certains réclameraient injustement les biens et le sang des autres$x$, $x$Tout le monde serait juste$x$, $x$Il n'y aurait plus de disputes$x$]::text[], 0, $x$C'est la raison donnée au début du hadith.$x$),
  (4, $x$Sur quoi le juge tranche-t-il ?$x$, array[$x$Sur les preuves$x$, $x$Sur ce qu'il sait personnellement$x$, $x$Sur la richesse des parties$x$]::text[], 0, $x$C'est l'un des enseignements relevés par HadeethEnc.$x$),
  (5, $x$Quel grade an-Nawawī donne-t-il à ce hadith ?$x$, array[$x$Ḥasan$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$Et une partie se trouve dans les deux Ṣaḥīḥ.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 33 d'an-Nawawī$x$),
       rv.h = 'f5eb8ff6f802b155f422768efee95b2a' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
