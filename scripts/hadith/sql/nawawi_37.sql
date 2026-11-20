-- Hadith 37 d'an-Nawawī : nawawi-37-la-generosite-d-allah-envers-les-intentions
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-37-la-generosite-d-allah-envers-les-intentions$x$, 'lesson', 'hadith', 'fr', 37) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 37 : Allah a écrit les bonnes et les mauvaises actions$x$, $x$Une bonne intention est comptée comme une bonne action ; une bonne action est multipliée ; une mauvaise action abandonnée pour Allah devient une bonne action.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:37}}

Traduction du sens : D'après Ibn ʿAbbās, le Messager d'Allah ﷺ rapporte de son Seigneur : « Allah a écrit les bonnes et les mauvaises actions, puis Il a expliqué cela : celui qui a l'intention d'une bonne action et ne la fait pas, Allah la lui inscrit auprès de Lui comme une bonne action complète ; s'il en a l'intention et la fait, Allah la lui inscrit auprès de Lui comme dix bonnes actions, jusqu'à sept cents fois, et jusqu'à bien plus encore. Et celui qui a l'intention d'une mauvaise action et ne la fait pas, Allah la lui inscrit auprès de Lui comme une bonne action complète ; s'il en a l'intention et la fait, Allah la lui inscrit comme une seule mauvaise action. » Rapporté par al-Bukhārī (n° 6491) et Muslim (n° 131) avec ces mots. Hadith authentique.

2. La phrase à retenir
« {{NAWX:37:146:194}} » (inna llāha kataba l-ḥasanāti wa s-sayyiʾāt).
Sens : « Allah a écrit les bonnes et les mauvaises actions. »

3. Explication
Allah a déterminé les bonnes et les mauvaises actions, puis Il a expliqué aux deux anges comment les écrire (selon HadeethEnc) :
- Celui qui est résolu à faire une bonne action reçoit une bonne action, même s'il ne la fait pas ; s'il la fait, elle est multipliée de dix à sept cents fois et plus. Cette multiplication dépend de la sincérité du cœur, du bien apporté, et d'autres choses semblables.
- Celui qui est résolu à faire une mauvaise action puis la laisse pour Allah reçoit une bonne action. S'il la commet, une seule mauvaise action est inscrite.

4. Ce que l'élève peut retenir
- La grâce d'Allah envers cette communauté est immense : les bonnes actions sont multipliées, les mauvaises ne le sont pas.
- L'intention a une grande importance dans les œuvres.
- Allah inscrit une bonne action à celui qui a voulu faire le bien sans pouvoir le faire.

Exercice : expliquez pourquoi la sincérité augmente la récompense, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$37$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Allah a écrit les bonnes et les mauvaises actions, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/nawawi40:37$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6491$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre des choses qui attendrissent les cœurs$x$, null, null, $x$https://sunnah.com/bukhari:6491$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$131$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:131a$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66533$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66533$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que reçoit celui qui a l'intention d'une bonne action sans pouvoir la faire ?$x$, array[$x$Une bonne action complète$x$, $x$Rien$x$, $x$Une mauvaise action$x$]::text[], 0, $x$Allah la lui inscrit comme une bonne action complète.$x$),
  (2, $x$Combien de fois une bonne action accomplie peut-elle être multipliée ?$x$, array[$x$De dix à sept cents fois, et plus$x$, $x$Une seule fois$x$, $x$Deux fois$x$]::text[], 0, $x$« Dix bonnes actions, jusqu'à sept cents fois, et bien plus encore. »$x$),
  (3, $x$Que reçoit celui qui laisse une mauvaise action pour Allah ?$x$, array[$x$Une bonne action$x$, $x$Une mauvaise action$x$, $x$Rien$x$]::text[], 0, $x$HadeethEnc précise : s'il la laisse pour Allah.$x$),
  (4, $x$Combien de mauvaises actions sont inscrites pour une mauvaise action commise ?$x$, array[$x$Une seule$x$, $x$Dix$x$, $x$Sept cents$x$]::text[], 0, $x$Les mauvaises actions ne sont pas multipliées.$x$),
  (5, $x$De quoi dépend la multiplication des récompenses selon HadeethEnc ?$x$, array[$x$De la sincérité du cœur et du bien apporté$x$, $x$De l'heure de la journée$x$, $x$Du nombre de personnes présentes$x$]::text[], 0, $x$La sincérité est essentielle.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 37 d'an-Nawawī$x$),
       rv.h = 'd9ebcdafa7f3506164088686419fcb7a' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
