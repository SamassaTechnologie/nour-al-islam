-- Hadith 5 d'an-Nawawī : nawawi-05-innovations-rejetees
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-05-innovations-rejetees$x$, 'lesson', 'hadith', 'fr', 5) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 5 : toute innovation dans la religion est rejetée$x$, $x$Une œuvre religieuse qui n'est pas conforme à ce qu'a enseigné le Prophète ﷺ n'est pas acceptée.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:5}}

Traduction du sens : D'après la mère des croyants, Umm ʿAbd Allāh ʿĀʾisha, qui a dit : le Messager d'Allah ﷺ a dit : « Quiconque introduit dans notre affaire que voici (la religion) ce qui n'en fait pas partie, cela est rejeté. » Rapporté par al-Bukhārī (n° 2697) et Muslim (n° 1718). Dans une version de Muslim : « Quiconque accomplit une œuvre qui n'est pas conforme à notre affaire, elle est rejetée. » Hadith authentique.

2. La phrase à retenir
« {{NAWX:5:133:197}} » (man aḥdatha fī amrinā hādhā mā laysa minhu fa-huwa radd).
Sens : « Quiconque introduit dans notre affaire que voici ce qui n'en fait pas partie, cela est rejeté. »

3. Explication
Le Prophète ﷺ explique que celui qui invente quelque chose dans la religion, ou qui accomplit une adoration qui ne repose sur aucune preuve du Coran ou de la Sunna, voit cette œuvre rejetée : elle n'est pas acceptée auprès d'Allah (selon HadeethEnc).
- « Notre affaire » désigne la religion.
- L'innovation (bidʿa) est ce qui a été ajouté à la religion et qui n'existait pas à l'époque du Prophète ﷺ et de ses Compagnons, qu'il s'agisse d'une croyance, d'une parole ou d'un acte.
- Ce hadith est comme une balance des œuvres : de même qu'une œuvre qui ne vise pas le Visage d'Allah n'apporte aucune récompense, une œuvre qui n'est pas conforme à ce qu'a apporté le Messager ﷺ est rejetée (selon HadeethEnc). Le hadith 1 (les intentions) traite du premier point, ce hadith du second.

4. Ce que l'élève peut retenir
- On n'adore Allah que par ce qu'Il a prescrit dans le Coran et la Sunna.
- La religion n'est pas une affaire d'opinion personnelle : elle repose sur le suivi du Messager ﷺ.
- Ce hadith montre que la religion est complète.
- L'interdiction concerne les nouveautés dans la religion, pas les choses de la vie courante (outils, techniques, moyens de transport…).

Exercice : citez une nouveauté de la vie courante qui n'est pas concernée par ce hadith, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$5$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Quiconque introduit dans notre affaire ce qui n'en fait pas partie, d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/nawawi40:5$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2697$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre de la réconciliation$x$, null, null, $x$https://sunnah.com/bukhari:2697$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1718$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre des jugements$x$, null, null, $x$https://sunnah.com/muslim:1718a$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66514$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66514$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « fa-huwa radd » ?$x$, array[$x$Cela est rejeté$x$, $x$Cela est recommandé$x$, $x$Cela est permis$x$]::text[], 0, $x$L'œuvre inventée dans la religion n'est pas acceptée auprès d'Allah.$x$),
  (2, $x$Que désigne « notre affaire » dans ce hadith ?$x$, array[$x$Le commerce$x$, $x$La religion$x$, $x$La politique$x$]::text[], 1, $x$« Notre affaire » désigne la religion apportée par le Prophète ﷺ.$x$),
  (3, $x$Qu'est-ce que l'innovation (bidʿa) dans la religion ?$x$, array[$x$Ce qui a été ajouté à la religion et n'existait pas à l'époque du Prophète ﷺ et de ses Compagnons$x$, $x$Toute invention technique$x$, $x$Toute nouvelle langue apprise$x$]::text[], 0, $x$Il s'agit d'une croyance, d'une parole ou d'un acte ajouté à la religion.$x$),
  (4, $x$Les nouveautés de la vie courante (téléphone, voiture…) sont-elles visées par ce hadith ?$x$, array[$x$Oui$x$, $x$Non, il s'agit des nouveautés dans la religion$x$]::text[], 1, $x$L'interdiction concerne ce qui touche à la religion, et non les affaires de ce monde.$x$),
  (5, $x$Quelles sont les deux conditions d'une œuvre acceptée, en réunissant les hadiths 1 et 5 ?$x$, array[$x$La faire pour Allah et selon la voie du Prophète ﷺ$x$, $x$La faire souvent et en public$x$, $x$La faire seul et la nuit$x$]::text[], 0, $x$Le hadith 1 parle de l'intention sincère, le hadith 5 de la conformité à la Sunna.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 5 d'an-Nawawī$x$),
       rv.h = 'd3a9fc860d700be0be147e469e588ada' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
