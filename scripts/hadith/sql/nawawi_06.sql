-- Hadith 6 d'an-Nawawī : nawawi-06-licite-illicite-et-douteux
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-06-licite-illicite-et-douteux$x$, 'lesson', 'hadith', 'fr', 6) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 6 : le licite est clair, l'illicite est clair$x$, $x$Entre le licite et l'illicite se trouvent des choses douteuses : les éviter protège la religion et l'honneur.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:6}}

Traduction du sens : D'après Abū ʿAbd Allāh an-Nuʿmān ibn Bashīr, qui a dit : j'ai entendu le Messager d'Allah ﷺ dire : « Le licite est clair et l'illicite est clair. Entre les deux se trouvent des choses douteuses que beaucoup de gens ne connaissent pas. Celui qui se garde des choses douteuses préserve sa religion et son honneur ; et celui qui tombe dans les choses douteuses tombe dans l'illicite, comme le berger qui fait paître autour d'un domaine réservé et qui est sur le point d'y faire paître. Certes, chaque roi a un domaine réservé, et le domaine réservé d'Allah, ce sont Ses interdits. Certes, il y a dans le corps un morceau de chair : s'il est sain, tout le corps est sain, et s'il est corrompu, tout le corps est corrompu. Certes, c'est le cœur. » Rapporté par al-Bukhārī (n° 52) et Muslim (n° 1599). Hadith authentique.

2. La phrase à retenir
« {{NAWX:6:138:189}} » (inna l-ḥalāla bayyinun wa inna l-ḥarāma bayyin).
Sens : « Le licite est clair et l'illicite est clair. »

3. Explication
Le Prophète ﷺ donne une règle générale : selon la Loi, les choses se divisent en trois (selon HadeethEnc) :
- ce qui est clairement licite ;
- ce qui est clairement illicite ;
- des choses douteuses, dont le statut n'est pas clair et que beaucoup de gens ignorent.
Celui qui laisse les choses douteuses protège sa religion, car il s'éloigne de l'illicite, et protège son honneur des critiques des gens. Celui qui ne les évite pas s'expose à tomber dans l'illicite.
- L'exemple du berger : celui qui fait paître son troupeau tout près d'un terrain protégé finit presque par y entrer. De même, celui qui fréquente les choses douteuses se rapproche de l'interdit.
- Le hadith se termine par le cœur : s'il est sain, le corps tout entier est sain ; s'il est corrompu, le corps tout entier est corrompu.

4. Ce que l'élève peut retenir
- Le hadith pose une règle pour se garder des choses douteuses (shubuhāt).
- Il encourage fortement à laisser ce dont le statut n'est pas clair.
- La réforme du cœur est la base de la réforme des actes.

Exercice : expliquez l'exemple du berger avec vos propres mots, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$6$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Le licite est clair et l'illicite est clair, d'après an-Nuʿmān ibn Bashīr$x$, null, null, $x$https://sunnah.com/nawawi40:6$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$52$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/bukhari:52$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1599$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la vente (musāqāt)$x$, null, null, $x$https://sunnah.com/muslim:1599a$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66515$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66515$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$En combien de catégories ce hadith divise-t-il les choses ?$x$, array[$x$Deux$x$, $x$Trois$x$, $x$Cinq$x$]::text[], 1, $x$Le licite clair, l'illicite clair, et les choses douteuses entre les deux.$x$),
  (2, $x$Que protège celui qui évite les choses douteuses ?$x$, array[$x$Sa religion et son honneur$x$, $x$Seulement son argent$x$, $x$Seulement sa santé$x$]::text[], 0, $x$Il s'éloigne de l'illicite et se protège des critiques des gens.$x$),
  (3, $x$Que représente le « domaine réservé » d'Allah ?$x$, array[$x$La Mecque$x$, $x$Ses interdits$x$, $x$Le Paradis$x$]::text[], 1, $x$Le hadith le dit : le domaine réservé d'Allah, ce sont Ses interdits.$x$),
  (4, $x$Quel est le morceau de chair dont dépend tout le corps ?$x$, array[$x$Le foie$x$, $x$Le cœur$x$, $x$La langue$x$]::text[], 1, $x$S'il est sain, tout le corps est sain ; s'il est corrompu, tout le corps est corrompu.$x$),
  (5, $x$Que nous apprend l'exemple du berger ?$x$, array[$x$Celui qui s'approche du douteux risque de tomber dans l'interdit$x$, $x$Il faut élever des moutons$x$, $x$Les rois sont injustes$x$]::text[], 0, $x$Comme le troupeau qui broute au bord d'un terrain protégé finit par y entrer.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 6 d'an-Nawawī$x$),
       rv.h = '5541caed9dbb1555eac871f087cda997' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
