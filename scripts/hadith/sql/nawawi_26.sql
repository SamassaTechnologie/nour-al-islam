-- Hadith 26 d'an-Nawawī : nawawi-26-une-aumone-pour-chaque-articulation
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-26-une-aumone-pour-chaque-articulation$x$, 'lesson', 'hadith', 'fr', 26) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 26 : une aumône pour chaque articulation$x$, $x$Chaque jour, une aumône est due pour chaque articulation du corps ; toute bonne œuvre en est une : réconcilier, aider, bien parler, marcher vers la prière, ôter un obstacle.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:26}}

Traduction du sens : D'après Abū Hurayra : le Messager d'Allah ﷺ a dit : « Chaque articulation des gens doit une aumône, chaque jour où le soleil se lève : être juste entre deux personnes est une aumône ; aider un homme avec sa monture, en le faisant monter dessus ou en y chargeant ses bagages, est une aumône ; la bonne parole est une aumône ; chaque pas que tu fais vers la prière est une aumône ; et ôter du chemin ce qui gêne est une aumône. » Rapporté par al-Bukhārī (n° 2989) et Muslim (n° 1009). Hadith authentique.

2. La phrase à retenir
« {{NAWX:26:320:355}} » (wa l-kalimatu ṭ-ṭayyibatu ṣadaqa).
Sens : « La bonne parole est une aumône. »

3. Explication
Chaque jour, le musulman doit à Allah une aumône pour chacune de ses articulations, pour Le remercier de les avoir préservées et de lui permettre de plier et de tendre ses membres. Cette aumône ne se limite pas à l'argent : toute œuvre de bien en fait partie (selon HadeethEnc). Par exemple :
- réconcilier avec justice deux personnes en conflit ;
- aider quelqu'un qui ne peut pas monter seul sur sa monture, ou y charger ses bagages ;
- dire une bonne parole : un rappel d'Allah, une invocation, une salutation… ;
- chaque pas fait vers la mosquée pour la prière ;
- enlever du chemin ce qui peut nuire aux gens.

4. Ce que l'élève peut retenir
- Le corps humain et sa bonne santé font partie des plus grands bienfaits d'Allah.
- Il faut renouveler chaque jour sa gratitude, pour que ces bienfaits durent.
- Ce hadith encourage les aumônes et les œuvres volontaires au quotidien.
- Réconcilier les gens a un grand mérite.
- Aider son prochain est une aumône.

Exercice : choisissez trois aumônes de ce hadith que vous pouvez faire aujourd'hui, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$26$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Chaque articulation doit une aumône, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:26$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2989$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre du combat (jihād)$x$, null, null, $x$https://sunnah.com/bukhari:2989$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1009$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la zakat$x$, null, null, $x$https://sunnah.com/muslim:1009$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66527$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66527$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Combien de fois l'aumône des articulations est-elle due ?$x$, array[$x$Chaque jour où le soleil se lève$x$, $x$Une fois par an$x$, $x$Une fois dans la vie$x$]::text[], 0, $x$« Chaque jour où le soleil se lève. »$x$),
  (2, $x$L'aumône dont parle ce hadith est-elle seulement de l'argent ?$x$, array[$x$Oui$x$, $x$Non, toute œuvre de bien en fait partie$x$]::text[], 1, $x$Une bonne parole, un pas vers la prière, ôter un obstacle… sont des aumônes.$x$),
  (3, $x$Que signifie « al-kalimatu ṭ-ṭayyibatu ṣadaqa » ?$x$, array[$x$La bonne parole est une aumône$x$, $x$La prière est une lumière$x$, $x$Le silence est d'or$x$]::text[], 0, $x$Rappel d'Allah, invocation, salutation : autant de bonnes paroles.$x$),
  (4, $x$Pourquoi doit-on une aumône pour ses articulations ?$x$, array[$x$Pour remercier Allah de les avoir préservées$x$, $x$Pour payer un médecin$x$, $x$Sans raison$x$]::text[], 0, $x$C'est un remerciement pour ce bienfait.$x$),
  (5, $x$Lequel de ces actes est cité comme aumône ?$x$, array[$x$Ôter du chemin ce qui gêne$x$, $x$Jeter ses déchets dans la rue$x$, $x$Se moquer des passants$x$]::text[], 0, $x$« Ôter du chemin ce qui gêne est une aumône. »$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 26 d'an-Nawawī$x$),
       rv.h = '9708b1aa7a98e16b31209a390af965e9' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
