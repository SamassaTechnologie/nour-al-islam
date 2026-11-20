-- Hadith 25 d'an-Nawawī : nawawi-25-chaque-glorification-est-une-aumone
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-25-chaque-glorification-est-une-aumone$x$, 'lesson', 'hadith', 'fr', 25) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 25 : chaque glorification est une aumône$x$, $x$Les Compagnons pauvres s'inquiètent de ne pas pouvoir donner comme les riches ; le Prophète ﷺ leur montre que les paroles de rappel et le bien accompli sont aussi des aumônes.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:25}}

Traduction du sens : D'après Abū Dharr : des Compagnons du Messager d'Allah ﷺ ont dit au Prophète ﷺ : « Ô Messager d'Allah ! Les gens aisés ont emporté les récompenses : ils prient comme nous prions, jeûnent comme nous jeûnons, et donnent en aumône le surplus de leurs biens. » Il a dit : « Allah ne vous a-t-Il pas donné de quoi faire l'aumône ? Chaque « subḥāna llāh » est une aumône, chaque « allāhu akbar » est une aumône, chaque « al-ḥamdu li-llāh » est une aumône, chaque « lā ilāha illā llāh » est une aumône, ordonner le bien est une aumône, interdire le mal est une aumône, et même dans l'union licite de l'un d'entre vous avec son épouse il y a une aumône. » Ils ont dit : « Ô Messager d'Allah ! L'un de nous satisfait son désir et il en serait récompensé ? » Il a dit : « Que pensez-vous : s'il le faisait dans l'illicite, n'aurait-il pas un péché ? De même, s'il le fait dans le licite, il a une récompense. » Rapporté par Muslim (n° 1006). Hadith authentique.

2. La phrase à retenir
« {{NAWX:25:370:403}} » (inna bi-kulli tasbīḥatin ṣadaqa).
Sens : « Chaque glorification est une aumône. »

3. Explication
Des Compagnons pauvres se sont plaints au Prophète ﷺ de ne pas pouvoir donner en aumône comme leurs frères riches, et donc de ne pas obtenir les mêmes récompenses. Le Prophète ﷺ leur a montré les aumônes qui étaient à leur portée : les paroles de rappel d'Allah, ordonner le bien, interdire le mal… et même les actes permis faits avec une bonne intention (selon HadeethEnc).

4. Ce que l'élève peut retenir
- Les Compagnons rivalisaient dans le bien et recherchaient les grandes récompenses.
- Les portes du bien sont nombreuses : toute œuvre faite avec une bonne intention peut en être une.
- L'islam est une religion facile : chaque musulman y trouve ce qu'il peut faire pour obéir à Allah.
- HadeethEnc cite an-Nawawī : ce hadith montre que les choses permises peuvent devenir des actes d'obéissance lorsqu'elles sont accompagnées d'une intention sincère.

Exercice : citez quatre paroles de rappel qui sont des aumônes, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$25$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Chaque glorification est une aumône, d'après Abū Dharr$x$, null, null, $x$https://sunnah.com/nawawi40:25$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1006$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la zakat$x$, null, null, $x$https://sunnah.com/muslim:1006$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4558$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4558$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$De quoi les Compagnons pauvres se plaignaient-ils ?$x$, array[$x$De ne pas pouvoir donner l'aumône comme les riches$x$, $x$De la chaleur$x$, $x$D'être trop nombreux$x$]::text[], 0, $x$Les riches donnaient le surplus de leurs biens en aumône.$x$),
  (2, $x$Que signifie « bi-kulli tasbīḥatin ṣadaqa » ?$x$, array[$x$Chaque glorification est une aumône$x$, $x$Chaque prière est obligatoire$x$, $x$Chaque jour est une fête$x$]::text[], 0, $x$Dire « subḥāna llāh » est une aumône.$x$),
  (3, $x$Ordonner le bien et interdire le mal sont-ils des aumônes ?$x$, array[$x$Oui$x$, $x$Non$x$]::text[], 0, $x$Le hadith les cite parmi les aumônes.$x$),
  (4, $x$Qu'est-ce qui transforme un acte permis en acte d'obéissance ?$x$, array[$x$Une intention sincère$x$, $x$Le fait de le faire en public$x$, $x$Le fait de le faire vite$x$]::text[], 0, $x$C'est l'explication d'an-Nawawī rapportée par HadeethEnc.$x$),
  (5, $x$Que montre ce hadith sur l'islam ?$x$, array[$x$C'est une religion facile où chacun trouve du bien à faire$x$, $x$Seuls les riches peuvent gagner des récompenses$x$, $x$Les pauvres n'ont pas de récompense$x$]::text[], 0, $x$Chaque musulman trouve ce qu'il peut accomplir pour obéir à Allah.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 25 d'an-Nawawī$x$),
       rv.h = '038cc7c4f6e6a3ba1a6cc3bc35810bd8' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
