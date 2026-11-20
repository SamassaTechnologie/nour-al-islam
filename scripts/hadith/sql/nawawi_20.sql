-- Hadith 20 d'an-Nawawī : nawawi-20-la-pudeur
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-20-la-pudeur$x$, 'lesson', 'hadith', 'fr', 20) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 20 : la pudeur (al-ḥayāʾ)$x$, $x$Une parole héritée des prophètes précédents : si tu n'as pas de pudeur, fais ce que tu veux. La pudeur retient des mauvaises actions.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:20}}

Traduction du sens : D'après Abū Masʿūd ʿUqba ibn ʿAmr al-Anṣārī al-Badrī : le Messager d'Allah ﷺ a dit : « Parmi ce que les gens ont retenu des paroles de la première prophétie : si tu n'as pas de pudeur, fais ce que tu veux. » Rapporté par al-Bukhārī (n° 6120). Hadith authentique.

2. La phrase à retenir
« {{NAWX:20:208:246}} » (idhā lam tastaḥi fa-ṣnaʿ mā shiʾt).
Sens : « Si tu n'as pas de pudeur, fais ce que tu veux. »

3. Explication
Le Prophète ﷺ rapporte un conseil des prophètes précédents, transmis de génération en génération jusqu'à la première génération de cette communauté : regarde ce que tu veux faire ; si c'est une chose dont tu n'as pas honte, fais-la ; si c'est une chose dont tu as honte, laisse-la. La pudeur empêche de commettre des actes vils ; celui qui n'a pas de pudeur se laisse aller à toutes sortes de mauvaises actions (selon HadeethEnc).
HadeethEnc rapporte l'explication d'an-Nawawī : la forme « fais » exprime ici une permission. Si tu veux faire une chose dont tu n'aurais honte ni devant Allah ni devant les gens, fais-la ; sinon, ne la fais pas.

4. Ce que l'élève peut retenir
- La pudeur est la base des nobles caractères.
- La pudeur fait partie des qualités des prophètes, et elle a été héritée d'eux.
- La pudeur pousse le musulman à faire ce qui l'embellit et à laisser ce qui l'enlaidit.

Exercice : citez une action que la pudeur empêche de commettre, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$20$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī$x$, $x$Si tu n'as pas de pudeur, fais ce que tu veux, d'après Abū Masʿūd$x$, null, null, $x$https://sunnah.com/nawawi40:20$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6120$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre des bonnes manières$x$, null, null, $x$https://sunnah.com/bukhari:6120$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66523$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66523$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$D'où vient la parole citée dans ce hadith ?$x$, array[$x$De la première prophétie, transmise jusqu'à nous$x$, $x$D'un poète arabe$x$, $x$D'un roi perse$x$]::text[], 0, $x$« Parmi ce que les gens ont retenu des paroles de la première prophétie. »$x$),
  (2, $x$Que signifie « idhā lam tastaḥi » ?$x$, array[$x$Si tu n'as pas de pudeur$x$, $x$Si tu n'as pas faim$x$, $x$Si tu n'as pas d'argent$x$]::text[], 0, $x$Al-ḥayāʾ est la pudeur.$x$),
  (3, $x$Selon l'explication d'an-Nawawī, que faire d'une action dont on aurait honte devant Allah ou les gens ?$x$, array[$x$Ne pas la faire$x$, $x$La faire en secret$x$, $x$La faire quand même$x$]::text[], 0, $x$Si on en a honte, on la laisse.$x$),
  (4, $x$Quel est le rôle de la pudeur ?$x$, array[$x$Empêcher les actes vils$x$, $x$Empêcher d'apprendre$x$, $x$Empêcher de parler$x$]::text[], 0, $x$Celui qui n'a pas de pudeur se laisse aller aux mauvaises actions.$x$),
  (5, $x$La pudeur fait-elle partie des qualités des prophètes ?$x$, array[$x$Oui$x$, $x$Non$x$]::text[], 0, $x$HadeethEnc le relève parmi les enseignements du hadith.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 20 d'an-Nawawī$x$),
       rv.h = '23e9749a2564580588537e60b2980047' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
