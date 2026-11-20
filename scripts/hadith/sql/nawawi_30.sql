-- Hadith 30 d'an-Nawawī : nawawi-30-obligations-limites-interdits
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-30-obligations-limites-interdits$x$, 'lesson', 'hadith', 'fr', 30) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 30 : les obligations, les limites et les interdits d'Allah$x$, $x$Allah a prescrit des obligations, fixé des limites, interdit des choses, et S'est tu sur d'autres par miséricorde : ce sur quoi Il S'est tu reste permis.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:30}}

Traduction du sens : D'après Abū Thaʿlaba al-Khushanī, Jurthūm ibn Nāshir : le Messager d'Allah ﷺ a dit : « Allah, le Très-Haut, a prescrit des obligations : ne les négligez pas. Il a fixé des limites : ne les dépassez pas. Il a interdit des choses : ne les violez pas. Et Il S'est tu sur d'autres choses, par miséricorde pour vous et non par oubli : ne cherchez donc pas à leur sujet. » An-Nawawī a dit : hadith ḥasan (bon), rapporté par ad-Dāraquṭnī dans ses Sunan et par d'autres.

2. La phrase à retenir
« {{NAWX:30:123:181}} » (inna llāha taʿālā faraḍa farāʾiḍa fa-lā tuḍayyiʿūhā).
Sens : « Allah a prescrit des obligations : ne les négligez pas. »

3. Explication
Allah a rendu certaines choses obligatoires, a fixé des limites et a interdit d'autres choses. Ce sur quoi Il S'est tu, par miséricorde pour Ses serviteurs, reste sur le principe de la permission : il ne faut pas aller fouiller à son sujet (selon HadeethEnc).

4. Ce que l'élève peut retenir
- Allah est le Législateur : c'est à Lui qu'appartient le commandement.
- Le hadith réunit les grandes catégories de règles : ce qui est demandé (obligatoire ou recommandé), ce qui est interdit (illicite ou déconseillé) et ce qui est permis.
- Ce sur quoi Allah S'est tu — sans l'imposer, sans le limiter, sans l'interdire — est permis.
- Il faut préserver les obligations d'Allah et ne pas dépasser Ses limites.

Exercice : classez trois exemples dans les catégories « obligation », « interdit » et « permis », puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$30$x$, $x$Ḥasan (bon) selon an-Nawawī$x$, $x$An-Nawawī$x$, $x$Allah a prescrit des obligations…, d'après Abū Thaʿlaba al-Khushanī$x$, null, null, $x$https://sunnah.com/nawawi40:30$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Sunan ad-Dāraquṭnī$x$, $x$Ad-Dāraquṭnī$x$, $x$Hadith n° 4396 (selon HadeethEnc)$x$, $x$https://hadeethenc.com/fr/browse/hadith/66510$x$, $x$Référence relevée par HadeethEnc ; le texte d'an-Nawawī renvoie à « 4/184 ».$x$),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66510$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66510$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que faut-il faire des obligations prescrites par Allah ?$x$, array[$x$Ne pas les négliger$x$, $x$Les oublier$x$, $x$Les changer$x$]::text[], 0, $x$« Il a prescrit des obligations : ne les négligez pas. »$x$),
  (2, $x$Pourquoi Allah S'est-Il tu sur certaines choses ?$x$, array[$x$Par miséricorde, et non par oubli$x$, $x$Par oubli$x$, $x$Sans raison$x$]::text[], 0, $x$« Par miséricorde pour vous et non par oubli. »$x$),
  (3, $x$Quel est le statut de ce sur quoi Allah S'est tu ?$x$, array[$x$C'est permis$x$, $x$C'est interdit$x$, $x$C'est obligatoire$x$]::text[], 0, $x$Cela reste sur le principe de la permission.$x$),
  (4, $x$Quel grade an-Nawawī a-t-il donné à ce hadith ?$x$, array[$x$Ḥasan (bon)$x$, $x$Inventé$x$, $x$Mutawātir$x$]::text[], 0, $x$An-Nawawī a dit : hadith ḥasan.$x$),
  (5, $x$À qui appartient le droit de légiférer selon ce hadith ?$x$, array[$x$À Allah$x$, $x$À chaque personne$x$, $x$Aux coutumes$x$]::text[], 0, $x$Allah est le Législateur.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 30 d'an-Nawawī$x$),
       rv.h = 'a813f0d0dca447856372079175f52078' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
