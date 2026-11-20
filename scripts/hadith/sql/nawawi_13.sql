-- Hadith 13 d'an-Nawawī : nawawi-13-aimer-pour-son-frere
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-13-aimer-pour-son-frere$x$, 'lesson', 'hadith', 'fr', 13) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 13 : aimer pour son frère ce que l'on aime pour soi$x$, $x$La foi n'est complète que lorsqu'on aime pour son frère musulman le bien que l'on aime pour soi-même.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:13}}

Traduction du sens : D'après Abū Ḥamza Anas ibn Mālik, serviteur du Messager d'Allah ﷺ : le Prophète ﷺ a dit : « Aucun de vous n'est vraiment croyant tant qu'il n'aime pas pour son frère ce qu'il aime pour lui-même. » Rapporté par al-Bukhārī (n° 13) et Muslim (n° 45). Hadith authentique.

2. La phrase à retenir
« {{NAWX:13:147:218}} » (lā yuʾminu aḥadukum ḥattā yuḥibba li-akhīhi mā yuḥibbu li-nafsih).
Sens : « Aucun de vous n'est vraiment croyant tant qu'il n'aime pas pour son frère ce qu'il aime pour lui-même. »

3. Explication
La foi complète ne se réalise chez le musulman que lorsqu'il aime pour son frère ce qu'il aime pour lui-même — actes d'obéissance et toutes sortes de biens dans la religion et dans ce monde — et qu'il déteste pour lui ce qu'il déteste pour lui-même (selon HadeethEnc).
- S'il voit chez son frère un manque dans sa religion, il s'efforce de l'aider à s'améliorer.
- S'il voit chez lui un bien, il l'encourage, l'aide et le conseille sincèrement, pour sa religion comme pour sa vie.

4. Ce que l'élève peut retenir
- Il est obligatoire d'aimer pour son frère ce que l'on aime pour soi : le Prophète ﷺ a nié la foi complète de celui qui ne le fait pas.
- Tout ce qui s'oppose à cet amour est interdit : la tromperie, la médisance, l'envie, l'hostilité envers le musulman, ses biens ou son honneur.
- Le mot « son frère » éveille la tendresse et pousse à agir.
- La fraternité pour Allah est un lien très fort, dont les droits sont importants (selon HadeethEnc).

Exercice : citez trois comportements qui contredisent ce hadith, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$13$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Aucun de vous n'est vraiment croyant…, d'après Anas$x$, null, null, $x$https://sunnah.com/nawawi40:13$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$13$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/bukhari:13$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$45$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:45a$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66520$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66520$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qui a rapporté ce hadith ?$x$, array[$x$Anas ibn Mālik$x$, $x$Ibn ʿAbbās$x$, $x$Muʿādh ibn Jabal$x$]::text[], 0, $x$Abū Ḥamza Anas ibn Mālik, serviteur du Prophète ﷺ.$x$),
  (2, $x$Que faut-il aimer pour son frère ?$x$, array[$x$Ce que l'on aime pour soi-même$x$, $x$Seulement ce qui ne nous intéresse pas$x$, $x$Rien de particulier$x$]::text[], 0, $x$C'est la condition de la foi complète citée dans le hadith.$x$),
  (3, $x$Que nie le Prophète ﷺ chez celui qui n'aime pas le bien pour son frère ?$x$, array[$x$La foi complète$x$, $x$La prière$x$, $x$La connaissance de l'arabe$x$]::text[], 0, $x$« Aucun de vous n'est vraiment croyant tant que… »$x$),
  (4, $x$Lequel de ces comportements contredit ce hadith ?$x$, array[$x$L'envie$x$, $x$Le bon conseil$x$, $x$L'aide$x$]::text[], 0, $x$L'envie, la tromperie, la médisance et l'hostilité s'opposent à cet amour.$x$),
  (5, $x$Que fait le croyant s'il voit un manque dans la religion de son frère ?$x$, array[$x$Il s'efforce de l'aider à s'améliorer$x$, $x$Il se moque de lui$x$, $x$Il l'ignore$x$]::text[], 0, $x$Il veut pour lui le bien qu'il veut pour lui-même.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 13 d'an-Nawawī$x$),
       rv.h = 'e0ba67e1f766032394070f9160c5e4fe' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
