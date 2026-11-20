-- Hadith 22 d'an-Nawawī : nawawi-22-les-obligations-menent-au-paradis
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-22-les-obligations-menent-au-paradis$x$, 'lesson', 'hadith', 'fr', 22) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 22 : accomplir les obligations mène au Paradis$x$, $x$Un homme demande s'il entrera au Paradis en accomplissant les obligations et en respectant le licite et l'illicite ; le Prophète ﷺ répond : oui.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:22}}

Traduction du sens : D'après Abū ʿAbd Allāh Jābir ibn ʿAbd Allāh al-Anṣārī : un homme a interrogé le Messager d'Allah ﷺ en disant : « Que penses-tu : si j'accomplis les prières prescrites, que je jeûne le Ramaḍān, que je considère comme licite ce qui est licite et comme illicite ce qui est illicite, sans rien ajouter à cela, entrerai-je au Paradis ? » Il a répondu : « Oui. » Rapporté par Muslim (n° 15). Hadith authentique.

2. La phrase à retenir
« {{NAWX:22:305:341}} » (a-adkhulu l-janna? qāla: naʿam).
Sens : « Entrerai-je au Paradis ? Il a répondu : oui. »

3. Explication
Celui qui accomplit les cinq prières obligatoires, même sans y ajouter de prières surérogatoires, qui jeûne le Ramaḍān, même sans autres jeûnes volontaires, qui croit que le licite est licite et le pratique, et qui croit que l'illicite est illicite et s'en écarte, entrera au Paradis (selon HadeethEnc).
- « Considérer le licite comme licite » : le croire permis et le pratiquer.
- « Considérer l'illicite comme illicite » : le croire interdit et s'en éloigner.

4. Ce que l'élève peut retenir
- Le musulman tient à accomplir les obligations et à laisser les interdits, avec pour objectif d'entrer au Paradis.
- Il est important de faire le licite en croyant qu'il est permis, et de s'interdire l'illicite en croyant qu'il est interdit.
- Accomplir les obligations et laisser les interdits est une cause d'entrée au Paradis.

Exercice : citez les quatre choses mentionnées par l'homme dans sa question, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$22$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Entrerai-je au Paradis ? Oui, d'après Jābir ibn ʿAbd Allāh$x$, null, null, $x$https://sunnah.com/nawawi40:22$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$15$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:15a$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66525$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66525$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quelle a été la réponse du Prophète ﷺ à l'homme ?$x$, array[$x$Oui$x$, $x$Non$x$, $x$Je ne sais pas$x$]::text[], 0, $x$« Il a répondu : oui. »$x$),
  (2, $x$Quel jeûne l'homme a-t-il cité ?$x$, array[$x$Le jeûne du Ramaḍān$x$, $x$Le jeûne du lundi$x$, $x$Le jeûne de ʿĀshūrāʾ$x$]::text[], 0, $x$« Que je jeûne le Ramaḍān. »$x$),
  (3, $x$Que signifie « considérer l'illicite comme illicite » ?$x$, array[$x$Le croire interdit et s'en éloigner$x$, $x$Le faire en secret$x$, $x$Ne pas s'en soucier$x$]::text[], 0, $x$C'est l'explication donnée par HadeethEnc.$x$),
  (4, $x$Qui a rapporté ce hadith ?$x$, array[$x$Jābir ibn ʿAbd Allāh$x$, $x$Abū Hurayra$x$, $x$ʿĀʾisha$x$]::text[], 0, $x$Abū ʿAbd Allāh Jābir ibn ʿAbd Allāh al-Anṣārī.$x$),
  (5, $x$Qu'est-ce qui est une cause d'entrée au Paradis selon ce hadith ?$x$, array[$x$Accomplir les obligations et laisser les interdits$x$, $x$Être riche$x$, $x$Avoir beaucoup d'amis$x$]::text[], 0, $x$C'est l'un des enseignements relevés par HadeethEnc.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 22 d'an-Nawawī$x$),
       rv.h = '5c1e0b1cf91c3d095cdbabcc97bef50c' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
