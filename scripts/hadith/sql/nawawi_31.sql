-- Hadith 31 d'an-Nawawī : nawawi-31-le-detachement-du-bas-monde
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-31-le-detachement-du-bas-monde$x$, 'lesson', 'hadith', 'fr', 31) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 31 : détache-toi de ce bas monde, Allah t'aimera$x$, $x$Se détacher du bas monde attire l'amour d'Allah ; ne pas convoiter ce que possèdent les gens attire leur amour.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:31}}

Traduction du sens : D'après Abū l-ʿAbbās Sahl ibn Saʿd as-Sāʿidī, qui a dit : un homme est venu voir le Prophète ﷺ et a dit : « Ô Messager d'Allah ! Indique-moi une œuvre qui, si je l'accomplis, me vaudra l'amour d'Allah et l'amour des gens. » Il a dit : « Détache-toi de ce bas monde, Allah t'aimera ; et détache-toi de ce que possèdent les gens, les gens t'aimeront. » An-Nawawī a dit : hadith ḥasan, rapporté par Ibn Mājah (n° 4102) et d'autres avec de bonnes chaînes.

2. La phrase à retenir
« {{NAWX:31:246:283}} » (izhad fī d-dunyā yuḥibbaka llāh).
Sens : « Détache-toi de ce bas monde, Allah t'aimera. »

3. Explication
Allah t'aimera si tu te détournes du bas monde, c'est-à-dire de ce qui ne te profite pas pour l'au-delà et de ce qui peut nuire à ta religion ; et les gens t'aimeront si tu ne convoites pas ce qu'ils possèdent (selon HadeethEnc).
HadeethEnc cite as-Sindī : les gens aiment ce bas monde ; celui qui rivalise avec eux pour l'obtenir devient détesté d'eux à la mesure de cette rivalité, et celui qui le leur laisse devient aimé d'eux dans la même mesure.

4. Ce que l'élève peut retenir
- Le détachement (zuhd) consiste à délaisser ce qui ne profite pas pour l'au-delà.
- Le détachement est un degré au-dessus de la prudence scrupuleuse (waraʿ) : le waraʿ laisse ce qui peut nuire, le zuhd laisse ce qui ne profite pas pour l'au-delà (selon HadeethEnc).
- Ne pas convoiter les biens des autres attire leur affection.

Exercice : citez une chose du quotidien que l'on peut délaisser parce qu'elle n'apporte rien pour l'au-delà, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$31$x$, $x$Ḥasan (bon) selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Détache-toi de ce bas monde, Allah t'aimera, d'après Sahl ibn Saʿd$x$, null, null, $x$https://sunnah.com/nawawi40:31$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan Ibn Mājah$x$, $x$Numérotation de sunnah.com$x$, $x$4102$x$, $x$Ḥasan selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Livre de l'ascèse$x$, null, null, $x$https://sunnah.com/ibnmajah:4102$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4307$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4307$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que demandait l'homme au Prophète ﷺ ?$x$, array[$x$Une œuvre qui lui vaut l'amour d'Allah et des gens$x$, $x$Une richesse rapide$x$, $x$Un métier$x$]::text[], 0, $x$C'est la question du début du hadith.$x$),
  (2, $x$Comment obtenir l'amour des gens selon ce hadith ?$x$, array[$x$En ne convoitant pas ce qu'ils possèdent$x$, $x$En leur demandant beaucoup$x$, $x$En les flattant$x$]::text[], 0, $x$« Détache-toi de ce que possèdent les gens, les gens t'aimeront. »$x$),
  (3, $x$Que signifie le zuhd (détachement) selon HadeethEnc ?$x$, array[$x$Délaisser ce qui ne profite pas pour l'au-delà$x$, $x$Ne plus travailler du tout$x$, $x$Refuser tout ce qui est permis$x$]::text[], 0, $x$Il s'agit de laisser ce qui n'apporte rien pour l'au-delà.$x$),
  (4, $x$Quel grade an-Nawawī donne-t-il à ce hadith ?$x$, array[$x$Ḥasan$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$Il dit : hadith ḥasan, avec de bonnes chaînes.$x$),
  (5, $x$Pourquoi celui qui rivalise avec les gens pour ce monde est-il détesté ?$x$, array[$x$Parce que les gens aiment ce bas monde$x$, $x$Parce qu'il est pauvre$x$, $x$Sans raison$x$]::text[], 0, $x$C'est l'explication d'as-Sindī citée par HadeethEnc.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 31 d'an-Nawawī$x$),
       rv.h = '1911d279362c043b2e73203b9c4312c1' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
