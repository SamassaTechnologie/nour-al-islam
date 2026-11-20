-- Hadith 42 d'an-Nawawī : nawawi-42-o-fils-d-adam-tant-que-tu-m-invoques
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-42-o-fils-d-adam-tant-que-tu-m-invoques$x$, 'lesson', 'hadith', 'fr', 42) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 42 : « Ô fils d'Adam, tant que tu M'invoques » (hadith qudsī)$x$, $x$L'immense pardon d'Allah : pour celui qui L'invoque avec espoir, qui Lui demande pardon, et qui meurt sans rien Lui associer.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:42}}

Traduction du sens : D'après Anas ibn Mālik, qui a dit : j'ai entendu le Messager d'Allah ﷺ dire : « Allah, le Très-Haut, a dit : Ô fils d'Adam ! Tant que tu M'invoques et que tu espères en Moi, Je te pardonne ce que tu as fait, et Je ne M'en soucie pas. Ô fils d'Adam ! Si tes péchés atteignaient les nuages du ciel, puis que tu Me demandais pardon, Je te pardonnerais. Ô fils d'Adam ! Si tu venais à Moi avec presque la terre entière de péchés, puis que tu Me rencontrais sans rien M'associer, Je viendrais à toi avec presque autant de pardon. » Rapporté par at-Tirmidhī (n° 3540), qui a dit : hadith ḥasan ṣaḥīḥ.

2. La phrase à retenir
« {{NAWX:42:129:231}} » (yā bna ādama innaka mā daʿawtanī wa rajawtanī ghafartu laka ʿalā mā kāna minka wa lā ubālī).
Sens : « Ô fils d'Adam ! Tant que tu M'invoques et que tu espères en Moi, Je te pardonne ce que tu as fait, et Je ne M'en soucie pas. »

3. Explication
Selon HadeethEnc :
- Tant que le serviteur invoque Allah, espère Sa miséricorde et ne désespère pas, Allah couvre et efface ses péchés, même s'ils font partie des grands péchés.
- Même si les péchés remplissaient ce qui est entre le ciel et la terre, puis que le serviteur demandait pardon, Allah les lui pardonnerait tous.
- Celui qui meurt en ayant affirmé l'unicité d'Allah, sans rien Lui associer, trouvera un pardon à la mesure de ses péchés.

4. Ce que l'élève peut retenir
- La miséricorde, le pardon et la grâce d'Allah sont immenses.
- Le tawḥīd (l'unicité d'Allah) a un grand mérite : Allah pardonne aux monothéistes leurs péchés.
- Le danger de l'association (shirk) : Allah ne la pardonne pas à celui qui meurt dessus.
- HadeethEnc cite Ibn Rajab : ce hadith réunit trois causes du pardon : l'invocation avec espoir, la demande de pardon avec le repentir, et la mort sur le tawḥīd.
- C'est un hadith qudsī : le Prophète ﷺ le rapporte de son Seigneur, mais il ne fait pas partie du Coran.

Exercice : citez les trois causes du pardon mentionnées par Ibn Rajab, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$42$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Ô fils d'Adam, tant que tu M'invoques, d'après Anas ibn Mālik$x$, null, null, $x$https://sunnah.com/nawawi40:42$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$3540$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Livre des invocations$x$, null, null, $x$https://sunnah.com/tirmidhi:3540$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 5456$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/5456$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quelles sont les trois causes du pardon citées par Ibn Rajab ?$x$, array[$x$L'invocation avec espoir, la demande de pardon, la mort sur le tawḥīd$x$, $x$La richesse, la force, la beauté$x$, $x$Le voyage, le sommeil, la nourriture$x$]::text[], 0, $x$C'est le résumé d'Ibn Rajab rapporté par HadeethEnc.$x$),
  (2, $x$Que fait Allah pour celui qui L'invoque et espère en Lui ?$x$, array[$x$Il lui pardonne$x$, $x$Il l'ignore$x$, $x$Il le punit immédiatement$x$]::text[], 0, $x$« Je te pardonne ce que tu as fait, et Je ne M'en soucie pas. »$x$),
  (3, $x$Allah pardonne-t-Il à celui qui meurt en Lui associant des partenaires ?$x$, array[$x$Non$x$, $x$Oui, toujours$x$]::text[], 0, $x$Le pardon promis concerne celui qui rencontre Allah sans rien Lui associer.$x$),
  (4, $x$Qui a rapporté ce hadith ?$x$, array[$x$Anas ibn Mālik$x$, $x$Abū Dharr$x$, $x$Ibn ʿUmar$x$]::text[], 0, $x$Anas ibn Mālik l'a entendu du Prophète ﷺ.$x$),
  (5, $x$Que doit éviter le pécheur selon ce hadith ?$x$, array[$x$Le désespoir de la miséricorde d'Allah$x$, $x$L'invocation$x$, $x$La demande de pardon$x$]::text[], 0, $x$Tant qu'il invoque et espère, Allah lui pardonne.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 42 d'an-Nawawī$x$),
       rv.h = 'eca2ed41daae9358991c12edbd81edc1' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
