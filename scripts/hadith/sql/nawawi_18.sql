-- Hadith 18 d'an-Nawawī : nawawi-18-crains-allah-ou-que-tu-sois
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-18-crains-allah-ou-que-tu-sois$x$, 'lesson', 'hadith', 'fr', 18) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 18 : crains Allah où que tu sois$x$, $x$Trois conseils : craindre Allah partout, faire suivre la mauvaise action d'une bonne qui l'efface, et bien se comporter avec les gens.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:18}}

Traduction du sens : D'après Abū Dharr Jundab ibn Junāda et Abū ʿAbd ar-Raḥmān Muʿādh ibn Jabal : le Messager d'Allah ﷺ a dit : « Crains Allah où que tu sois, fais suivre la mauvaise action d'une bonne action qui l'effacera, et comporte-toi avec les gens d'un bon comportement. » Rapporté par at-Tirmidhī (n° 1987), qui a dit : hadith ḥasan ; dans certaines copies : ḥasan ṣaḥīḥ.

2. La phrase à retenir
« {{NAWX:18:163:193}} » (ittaqi llāha ḥaythumā kunt).
Sens : « Crains Allah où que tu sois. »

3. Explication
Le Prophète ﷺ ordonne trois choses (selon HadeethEnc) :
- Craindre Allah (at-taqwā) : accomplir les obligations et laisser les interdits, en tout lieu, à tout moment et en toute situation, en secret comme en public, dans la sécurité comme dans l'épreuve.
- Après une mauvaise action, accomplir une bonne action — une prière, une aumône, un bienfait, le maintien des liens de parenté, le repentir… — car elle efface la mauvaise.
- Bien se comporter avec les gens : leur sourire, être doux et agréable, leur faire du bien et ne pas leur nuire.

4. Ce que l'élève peut retenir
- Ce hadith montre la grâce d'Allah envers Ses serviteurs : Sa miséricorde et Son pardon.
- Il réunit trois droits : le droit d'Allah (la crainte), le droit de soi-même (réparer ses fautes par de bonnes actions) et le droit des gens (le bon comportement).
- Faire suivre la faute d'une bonne action et bien se comporter font eux-mêmes partie de la crainte d'Allah ; ils sont cités à part pour les expliquer.

Exercice : choisissez une bonne action que vous pouvez faire aujourd'hui après une erreur, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$18$x$, $x$Ḥasan (bon)$x$, $x$At-Tirmidhī$x$, $x$Crains Allah où que tu sois, d'après Abū Dharr et Muʿādh$x$, null, null, $x$https://sunnah.com/nawawi40:18$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1987$x$, $x$Ḥasan (bon)$x$, $x$At-Tirmidhī$x$, $x$Livre de la piété filiale et des liens de parenté$x$, null, null, $x$https://sunnah.com/tirmidhi:1987$x$, $x$An-Nawawī précise que certaines copies d'at-Tirmidhī portent : ḥasan ṣaḥīḥ.$x$),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4302$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4302$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « ittaqi llāha ḥaythumā kunt » ?$x$, array[$x$Crains Allah où que tu sois$x$, $x$Voyage où tu veux$x$, $x$Prie où que tu sois$x$]::text[], 0, $x$La crainte d'Allah en tout lieu et en toute situation.$x$),
  (2, $x$Qu'efface la bonne action qui suit une mauvaise ?$x$, array[$x$La mauvaise action$x$, $x$Les bonnes actions précédentes$x$, $x$Rien$x$]::text[], 0, $x$« Fais suivre la mauvaise action d'une bonne action qui l'effacera. »$x$),
  (3, $x$Quels sont les trois droits réunis dans ce hadith ?$x$, array[$x$Le droit d'Allah, le droit de soi-même, le droit des gens$x$, $x$Le droit des rois, des riches et des savants$x$, $x$Aucun droit$x$]::text[], 0, $x$C'est l'un des enseignements relevés par HadeethEnc.$x$),
  (4, $x$Comment se comporte-t-on bien avec les gens ?$x$, array[$x$En souriant, en étant doux et en ne nuisant pas$x$, $x$En les évitant tous$x$, $x$En étant dur avec eux$x$]::text[], 0, $x$C'est le troisième conseil du hadith.$x$),
  (5, $x$Quel grade at-Tirmidhī a-t-il donné à ce hadith ?$x$, array[$x$Ḥasan (bon)$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$Il a dit : ḥasan ; certaines copies portent ḥasan ṣaḥīḥ.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 18 d'an-Nawawī$x$),
       rv.h = 'e6fd239b69dbf93d2f0042f3b86fd684' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
