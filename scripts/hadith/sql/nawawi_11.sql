-- Hadith 11 d'an-Nawawī : nawawi-11-laisser-ce-qui-fait-douter
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-11-laisser-ce-qui-fait-douter$x$, 'lesson', 'hadith', 'fr', 11) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 11 : laisse ce qui te fait douter$x$, $x$Le musulman délaisse ce dont il doute pour ce qui est certain : c'est une source de clarté et de tranquillité.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:11}}

Traduction du sens : D'après Abū Muḥammad al-Ḥasan, fils de ʿAlī ibn Abī Ṭālib, petit-fils du Messager d'Allah ﷺ et objet de sa tendresse, qui a dit : j'ai retenu du Messager d'Allah ﷺ : « Laisse ce qui te fait douter pour ce qui ne te fait pas douter. » Rapporté par at-Tirmidhī (n° 2518 dans la numérotation de sunnah.com) et an-Nasāʾī (n° 5711). At-Tirmidhī a dit : hadith ḥasan ṣaḥīḥ. HadeethEnc le classe authentique.

2. La phrase à retenir
« {{NAWX:11:204:243}} » (daʿ mā yarībuka ilā mā lā yarībuk).
Sens : « Laisse ce qui te fait douter pour ce qui ne te fait pas douter. »

3. Explication
Le Prophète ﷺ ordonne d'abandonner ce dont on doute, qu'on ne sait pas si c'est licite ou illicite, pour ce qui ne laisse aucun doute, c'est-à-dire ce dont le bien et la licéité sont établis (selon HadeethEnc).
Ce hadith rejoint le hadith 6 (le licite est clair, l'illicite est clair) : dans les deux, le croyant se tient à l'écart des choses douteuses.

4. Ce que l'élève peut retenir
- Le musulman construit ses affaires sur la certitude et laisse ce qui est douteux : il avance ainsi avec clairvoyance dans sa religion.
- Il est interdit de se jeter dans les affaires ambiguës.
- Celui qui veut la tranquillité laisse de côté ce qui le fait douter.
- Par miséricorde, Allah a ordonné à Ses serviteurs ce qui apporte le repos de l'âme et du corps, et leur a interdit ce qui cause l'inquiétude et la confusion.

Exercice : donnez un exemple de la vie quotidienne où l'on applique ce hadith, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$11$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Laisse ce qui te fait douter, d'après al-Ḥasan ibn ʿAlī$x$, null, null, $x$https://sunnah.com/nawawi40:11$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2518$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Livre de la description de la Résurrection$x$, null, null, $x$https://sunnah.com/tirmidhi:2518$x$, $x$Le texte d'an-Nawawī indique le n° 2520 (autre numérotation).$x$),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan an-Nasāʾī$x$, $x$Numérotation de sunnah.com$x$, $x$5711$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$HadeethEnc$x$, $x$Livre des boissons$x$, null, null, $x$https://sunnah.com/nasai:5711$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66519$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66519$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « daʿ mā yarībuk » ?$x$, array[$x$Laisse ce qui te fait douter$x$, $x$Fais ce que tu veux$x$, $x$Demande à tes parents$x$]::text[], 0, $x$Il faut laisser ce dont on doute pour ce qui est certain.$x$),
  (2, $x$Qui a rapporté ce hadith ?$x$, array[$x$Al-Ḥasan ibn ʿAlī$x$, $x$ʿUmar ibn al-Khaṭṭāb$x$, $x$Abū Hurayra$x$]::text[], 0, $x$Al-Ḥasan, petit-fils du Prophète ﷺ.$x$),
  (3, $x$Que gagne celui qui laisse ce qui le fait douter ?$x$, array[$x$La tranquillité et la clairvoyance dans sa religion$x$, $x$Plus d'argent$x$, $x$Plus de questions$x$]::text[], 0, $x$HadeethEnc relie ce hadith à la tranquillité de l'âme.$x$),
  (4, $x$Avec quel autre hadith de la leçon ce hadith se rejoint-il ?$x$, array[$x$Le hadith 6 sur le licite et l'illicite$x$, $x$Le hadith 3 sur les cinq piliers$x$, $x$Le hadith 4 sur la création$x$]::text[], 0, $x$Les deux parlent de se tenir à l'écart des choses douteuses.$x$),
  (5, $x$Quel grade at-Tirmidhī a-t-il donné à ce hadith ?$x$, array[$x$Ḥasan ṣaḥīḥ$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$An-Nawawī rapporte qu'at-Tirmidhī l'a jugé ḥasan ṣaḥīḥ.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 11 d'an-Nawawī$x$),
       rv.h = '87c12d908e28a41e643a8af10b6d4baa' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
