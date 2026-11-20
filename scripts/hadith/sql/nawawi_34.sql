-- Hadith 34 d'an-Nawawī : nawawi-34-changer-le-mal
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-34-changer-le-mal$x$, 'lesson', 'hadith', 'fr', 34) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 34 : changer le mal selon sa capacité$x$, $x$Celui qui voit un mal le change par la main, sinon par la parole, sinon par le cœur — selon sa capacité, avec science, et sans provoquer un mal plus grand.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:34}}

Traduction du sens : D'après Abū Saʿīd al-Khudrī, qui a dit : j'ai entendu le Messager d'Allah ﷺ dire : « Que celui d'entre vous qui voit un mal le change par sa main ; s'il ne le peut pas, alors par sa langue ; s'il ne le peut pas, alors par son cœur, et c'est là le plus faible degré de la foi. » Rapporté par Muslim (n° 49). Hadith authentique.

2. La phrase à retenir
« {{NAWX:34:110:164}} » (man raʾā minkum munkaran fal-yughayyirhu bi-yadih).
Sens : « Que celui d'entre vous qui voit un mal le change par sa main. »

3. Explication
Le Prophète ﷺ ordonne de changer le mal — tout ce qu'Allah et Son Messager ont interdit — selon sa capacité (selon HadeethEnc) :
- Par la main, pour celui qui en a la capacité.
- Sinon, par la langue : interdire ce mal à celui qui le commet, lui en expliquer le danger et l'orienter vers le bien.
- Sinon, par le cœur : détester ce mal, avec la ferme intention de le changer si l'on en avait la capacité. Se contenter du cœur est le plus faible degré de la foi.

Conditions importantes rappelées par HadeethEnc :
- Il faut d'abord savoir avec certitude que la chose est un mal.
- Changer le mal ne doit pas entraîner un mal plus grand.
- Cela demande de la science, de la clairvoyance, une bonne manière et des conditions que le musulman doit apprendre.
- Chacun agit selon sa capacité, et toujours dans le respect de ces conditions.

4. Ce que l'élève peut retenir
- Ce hadith explique les degrés du changement du mal, du plus fort au plus faible.
- Personne n'en est totalement dispensé : chacun est responsable selon sa capacité.
- Ordonner le bien et interdire le mal font partie des marques de la foi, qui augmente et diminue.
- Ne pas même détester le mal dans son cœur montre une faiblesse de la foi.

Exercice : donnez un exemple de mal que l'on peut changer par une parole douce, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$34$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Que celui qui voit un mal le change, d'après Abū Saʿīd al-Khudrī$x$, null, null, $x$https://sunnah.com/nawawi40:34$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$49$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:49a$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 65001$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/65001$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quels sont les trois degrés pour changer un mal ?$x$, array[$x$La main, la langue, le cœur$x$, $x$Crier, frapper, fuir$x$, $x$Ignorer, oublier, laisser$x$]::text[], 0, $x$Chacun selon sa capacité.$x$),
  (2, $x$Quel est le plus faible degré de la foi selon ce hadith ?$x$, array[$x$Détester le mal dans son cœur$x$, $x$Changer le mal par la main$x$, $x$Conseiller par la parole$x$]::text[], 0, $x$« Et c'est là le plus faible degré de la foi. »$x$),
  (3, $x$Peut-on chercher à changer un mal si cela entraîne un mal plus grand ?$x$, array[$x$Non$x$, $x$Oui$x$]::text[], 0, $x$HadeethEnc rappelle cette condition importante.$x$),
  (4, $x$Que faut-il savoir avant d'interdire une chose ?$x$, array[$x$Qu'elle est vraiment un mal$x$, $x$Qui l'a faite$x$, $x$Combien elle coûte$x$]::text[], 0, $x$Interdire le mal demande de la science.$x$),
  (5, $x$Comment changer un mal par la langue ?$x$, array[$x$En l'interdisant, en expliquant son danger et en orientant vers le bien$x$, $x$En insultant la personne$x$, $x$En se moquant d'elle$x$]::text[], 0, $x$C'est l'explication donnée par HadeethEnc.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 34 d'an-Nawawī$x$),
       rv.h = '3cffac4f4b2d31b2de25434daf90260b' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
