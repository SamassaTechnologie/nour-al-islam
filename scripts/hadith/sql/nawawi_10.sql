-- Hadith 10 d'an-Nawawī : nawawi-10-allah-n-accepte-que-ce-qui-est-bon
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-10-allah-n-accepte-que-ce-qui-est-bon$x$, 'lesson', 'hadith', 'fr', 10) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 10 : Allah est bon et n'accepte que ce qui est bon$x$, $x$Allah n'accepte que les œuvres pures ; manger le licite fait partie des causes de l'acceptation des invocations, et l'illicite les empêche.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:10}}

Traduction du sens : D'après Abū Hurayra : le Messager d'Allah ﷺ a dit : « Allah est bon (ṭayyib) et n'accepte que ce qui est bon. Allah a ordonné aux croyants ce qu'Il a ordonné aux messagers. » Il a ensuite cité la parole d'Allah ordonnant aux messagers de manger de ce qui est bon et de faire de bonnes œuvres (sourate 23, verset 51), et Sa parole ordonnant aux croyants de manger des bonnes choses qu'Il leur a attribuées (sourate 2, verset 172). Puis il a mentionné l'homme qui prolonge son voyage, les cheveux en désordre et couvert de poussière, qui tend les mains vers le ciel en disant : « Ô Seigneur ! Ô Seigneur ! », alors que sa nourriture est illicite, sa boisson est illicite, son vêtement est illicite et qu'il a été nourri d'illicite : « Comment serait-il exaucé ? » Rapporté par Muslim (n° 1015). Hadith authentique.

2. La phrase à retenir
« {{NAWX:10:92:140}} » (inna llāha ṭayyibun lā yaqbalu illā ṭayyibā).
Sens : « Allah est bon et n'accepte que ce qui est bon. »

3. Explication
Allah est bon et pur, exempt de tout défaut, et décrit par des attributs de perfection. Il n'accepte que les œuvres, les paroles et les croyances bonnes, c'est-à-dire celles qui sont faites sincèrement pour Lui et conformément à la guidée du Prophète ﷺ (selon HadeethEnc).
- L'un des plus grands moyens pour que les œuvres du croyant soient bonnes est que sa nourriture soit bonne et licite. C'est pourquoi Allah a ordonné aux croyants ce qu'Il a ordonné aux messagers : manger le licite et faire de bonnes œuvres.
- Le Prophète ﷺ met ensuite en garde contre l'illicite, qui empêche l'acceptation, même lorsque des causes d'exaucement sont réunies.
- HadeethEnc relève, d'après ce hadith, des causes de l'exaucement de l'invocation : le long voyage avec ses difficultés, l'état de grand besoin, le fait de lever les mains vers le ciel, l'insistance en répétant « Ô Seigneur », et le fait de manger et boire ce qui est licite et pur.

4. Ce que l'élève peut retenir
- Allah est parfait dans Son essence, Ses attributs, Ses actes et Ses décrets.
- Une œuvre est bonne lorsqu'elle est sincère pour Allah et conforme à la Sunna.
- Savoir que cet ordre a d'abord été donné aux messagers encourage le croyant à l'appliquer.
- Manger l'illicite fait partie de ce qui empêche l'exaucement des invocations.

Exercice : citez trois causes de l'exaucement de l'invocation mentionnées dans la leçon, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, ord, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, (select coalesce(max(ord), 0) from public.content_references) + v.k, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$10$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Allah est bon et n'accepte que ce qui est bon, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:10$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1015$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la zakat$x$, null, null, $x$https://sunnah.com/muslim:1015$x$, null),
  (3, $x$quran$x$::reference_kind, 23::int, 51::int, 51::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::reference_kind, 2::int, 172::int, 172::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66518$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66518$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) returning 1),
qq as (insert into public.content_questions (revision_id, ord, prompt, options, answer, explanation)
       select rv.id, (select coalesce(max(ord), 0) from public.content_questions) + v.k, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « inna llāha ṭayyib » ?$x$, array[$x$Allah est bon$x$, $x$Allah est proche$x$, $x$Allah est puissant$x$]::text[], 0, $x$Allah est bon et pur, exempt de tout défaut.$x$),
  (2, $x$Qu'est-ce qu'Allah a ordonné à la fois aux messagers et aux croyants ?$x$, array[$x$Manger de ce qui est bon et faire le bien$x$, $x$Voyager souvent$x$, $x$Jeûner chaque jour$x$]::text[], 0, $x$Sourate 23, verset 51 et sourate 2, verset 172.$x$),
  (3, $x$Pourquoi l'homme du hadith n'est-il pas exaucé ?$x$, array[$x$Sa nourriture, sa boisson et son vêtement sont illicites$x$, $x$Il n'a pas levé les mains$x$, $x$Il n'a pas voyagé assez longtemps$x$]::text[], 0, $x$L'illicite empêche l'exaucement, même si d'autres causes sont réunies.$x$),
  (4, $x$Laquelle de ces choses est une cause d'exaucement de l'invocation citée dans la leçon ?$x$, array[$x$Lever les mains vers le ciel$x$, $x$Crier très fort$x$, $x$Invoquer en se plaignant d'Allah$x$]::text[], 0, $x$Lever les mains vers le ciel fait partie des causes relevées par HadeethEnc.$x$),
  (5, $x$Quelles œuvres Allah accepte-t-Il ?$x$, array[$x$Celles faites sincèrement pour Lui et conformes à la Sunna$x$, $x$Toutes les œuvres sans exception$x$, $x$Seulement les œuvres difficiles$x$]::text[], 0, $x$C'est le sens de « n'accepte que ce qui est bon ».$x$)) v(k, p, o, a, e) returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 10 d'an-Nawawī$x$),
       rv.h = '8bacb2c5ff3339dd8fadfc6258b51084' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
