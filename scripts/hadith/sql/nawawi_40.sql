-- Hadith 40 d'an-Nawawī : nawawi-40-sois-comme-un-etranger
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-40-sois-comme-un-etranger$x$, 'lesson', 'hadith', 'fr', 40) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 40 : sois dans ce monde comme un étranger$x$, $x$Le Prophète ﷺ conseille à Ibn ʿUmar d'être dans ce monde comme un étranger ou un voyageur de passage ; Ibn ʿUmar invite à profiter de sa santé et de sa vie.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:40}}

Traduction du sens : D'après Ibn ʿUmar, qui a dit : le Messager d'Allah ﷺ m'a pris par l'épaule et m'a dit : « Sois dans ce monde comme si tu étais un étranger, ou un voyageur de passage. » Et Ibn ʿUmar disait : « Quand tu arrives au soir, n'attends pas le matin ; et quand tu arrives au matin, n'attends pas le soir. Prends de ta santé pour ta maladie, et de ta vie pour ta mort. » Rapporté par al-Bukhārī (n° 6416). Hadith authentique.

2. La phrase à retenir
« {{NAWX:40:114:171}} » (kun fī d-dunyā kaʾannaka gharībun aw ʿābiru sabīl).
Sens : « Sois dans ce monde comme si tu étais un étranger, ou un voyageur de passage. »

3. Explication
Selon HadeethEnc :
- L'étranger vient d'arriver dans un pays où il n'a ni maison, ni refuge, ni proches : rien ne le détourne de son Créateur.
- Le voyageur de passage va encore plus loin : l'étranger peut s'installer dans le pays, alors que le voyageur ne fait qu'y passer, en route vers sa vraie patrie.
- Ibn ʿUmar en tirait une leçon pratique : ne pas compter sur le soir ou le matin suivant, et profiter de sa santé et de sa vie avant la maladie et la mort.

4. Ce que l'élève peut retenir
- Le maître peut poser la main sur l'épaule de l'élève, par affection et pour attirer son attention.
- On peut commencer à conseiller sincèrement même celui qui ne l'a pas demandé.
- Le Prophète ﷺ enseignait avec des exemples parlants.
- Les gens ne sont pas tous au même niveau sur le chemin de l'au-delà : le voyageur de passage est plus détaché que l'étranger.

Exercice : expliquez avec vos mots la différence entre « l'étranger » et « le voyageur de passage », puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$40$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī$x$, $x$Sois dans ce monde comme un étranger, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/nawawi40:40$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6416$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre des choses qui attendrissent les cœurs$x$, null, null, $x$https://sunnah.com/bukhari:6416$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4704$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4704$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Comment le Prophète ﷺ a-t-il attiré l'attention d'Ibn ʿUmar ?$x$, array[$x$Il l'a pris par l'épaule$x$, $x$Il l'a appelé de loin$x$, $x$Il lui a écrit une lettre$x$]::text[], 0, $x$« Le Messager d'Allah ﷺ m'a pris par l'épaule. »$x$),
  (2, $x$Que signifie « kun fī d-dunyā kaʾannaka gharīb » ?$x$, array[$x$Sois dans ce monde comme un étranger$x$, $x$Voyage dans le monde entier$x$, $x$Quitte ta famille$x$]::text[], 0, $x$Ne pas s'attacher à ce monde.$x$),
  (3, $x$Qui est plus détaché : l'étranger ou le voyageur de passage ?$x$, array[$x$Le voyageur de passage$x$, $x$L'étranger$x$]::text[], 0, $x$L'étranger peut s'installer, le voyageur ne fait que passer.$x$),
  (4, $x$Que conseille Ibn ʿUmar au sujet de la santé ?$x$, array[$x$En profiter pour le temps de la maladie$x$, $x$La négliger$x$, $x$N'y penser jamais$x$]::text[], 0, $x$« Prends de ta santé pour ta maladie. »$x$),
  (5, $x$Qui a dit « quand tu arrives au soir, n'attends pas le matin » ?$x$, array[$x$Ibn ʿUmar$x$, $x$Le Prophète ﷺ$x$, $x$Abū Bakr$x$]::text[], 0, $x$C'est une parole d'Ibn ʿUmar rapportée à la suite du hadith.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 40 d'an-Nawawī$x$),
       rv.h = 'dafea60d3ec9d883fddd077a058c5d45' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
