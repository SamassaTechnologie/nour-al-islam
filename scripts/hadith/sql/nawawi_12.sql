-- Hadith 12 d'an-Nawawī : nawawi-12-delaisser-ce-qui-ne-nous-regarde-pas
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-12-delaisser-ce-qui-ne-nous-regarde-pas$x$, 'lesson', 'hadith', 'fr', 12) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 12 : délaisser ce qui ne nous regarde pas$x$, $x$Fait partie du bon islam de la personne qu'elle laisse ce qui ne la concerne pas, en paroles comme en actes.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:12}}

Traduction du sens : D'après Abū Hurayra : le Messager d'Allah ﷺ a dit : « Fait partie du bon islam de la personne qu'elle délaisse ce qui ne la regarde pas. » An-Nawawī a dit : hadith ḥasan (bon). Rapporté par at-Tirmidhī (n° 2317 dans la numérotation de sunnah.com) et Ibn Mājah (n° 3976).

2. La phrase à retenir
« {{NAWX:12:91:148}} » (min ḥusni islāmi l-marʾi tarkuhu mā lā yaʿnīh).
Sens : « Fait partie du bon islam de la personne qu'elle délaisse ce qui ne la regarde pas. »

3. Explication
Parmi les plus belles qualités de l'islam du musulman, il y a le fait de laisser ce qui ne le concerne pas, en paroles comme en actes, dans les affaires religieuses comme dans celles de ce monde. S'occuper de ce qui ne nous regarde pas détourne souvent de ce qui nous regarde, ou entraîne vers le mal ; et chacun sera interrogé sur ses actes le Jour de la Résurrection (selon HadeethEnc).
HadeethEnc rapporte aussi le commentaire d'Ibn al-Qayyim : selon lui, le Prophète ﷺ a résumé en une seule parole la voie du bien et du salut, et elle englobe ce que l'on dit, regarde, écoute, fait, et même ce à quoi l'on pense.

4. Ce que l'élève peut retenir
- Les gens n'ont pas tous le même niveau d'islam : sa beauté augmente par certaines œuvres.
- Laisser le futile et le superflu, en paroles et en actes, est un signe de bon islam.
- À l'inverse, s'occuper de ce qui nous concerne, dans la religion et dans la vie, fait aussi partie de la beauté de l'islam.

Exercice : citez deux exemples de choses « qui ne nous regardent pas » et que l'on peut laisser, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$12$x$, $x$Ḥasan (bon)$x$, $x$An-Nawawī$x$, $x$Fait partie du bon islam de la personne…, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:12$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2317$x$, $x$Ḥasan selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Livre de l'ascèse$x$, null, null, $x$https://sunnah.com/tirmidhi:2317$x$, $x$Le texte d'an-Nawawī indique le n° 2318 (autre numérotation).$x$),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan Ibn Mājah$x$, $x$Numérotation de sunnah.com$x$, $x$3976$x$, $x$Ḥasan selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Livre des épreuves$x$, null, null, $x$https://sunnah.com/ibnmajah:3976$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 65255$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/65255$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « tarkuhu mā lā yaʿnīh » ?$x$, array[$x$Délaisser ce qui ne le regarde pas$x$, $x$Faire ce qui lui plaît$x$, $x$Parler de tout$x$]::text[], 0, $x$C'est un signe du bon islam de la personne.$x$),
  (2, $x$Quel grade an-Nawawī a-t-il donné à ce hadith ?$x$, array[$x$Ḥasan (bon)$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$An-Nawawī a dit : hadith ḥasan.$x$),
  (3, $x$Ce hadith concerne-t-il seulement les paroles ?$x$, array[$x$Oui, uniquement les paroles$x$, $x$Non, les paroles et les actes$x$]::text[], 1, $x$HadeethEnc précise : en paroles comme en actes.$x$),
  (4, $x$Pourquoi s'occuper de ce qui ne nous regarde pas est-il dangereux ?$x$, array[$x$Cela détourne de ce qui nous regarde et peut mener au mal$x$, $x$Cela fatigue les yeux$x$, $x$Cela coûte de l'argent$x$]::text[], 0, $x$Et chacun sera interrogé sur ses actes.$x$),
  (5, $x$Selon Ibn al-Qayyim, cité par HadeethEnc, que résume ce hadith ?$x$, array[$x$La voie du bien et du salut$x$, $x$Les règles de la prière$x$, $x$L'histoire des prophètes$x$]::text[], 0, $x$Il englobe la parole, le regard, l'écoute, les gestes et les pensées.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 12 d'an-Nawawī$x$),
       rv.h = 'ca713ef752f963bd9ff233f2eba1d8c0' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
