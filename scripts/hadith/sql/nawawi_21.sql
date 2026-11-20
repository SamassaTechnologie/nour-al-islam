-- Hadith 21 d'an-Nawawī : nawawi-21-je-crois-en-allah-puis-sois-droit
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-21-je-crois-en-allah-puis-sois-droit$x$, 'lesson', 'hadith', 'fr', 21) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 21 : dis « je crois en Allah », puis sois droit$x$, $x$Une parole qui résume l'islam : croire en Allah, puis rester droit en accomplissant les obligations et en évitant les interdits.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:21}}

Traduction du sens : D'après Abū ʿAmr — on dit aussi Abū ʿAmra — Sufyān ibn ʿAbd Allāh, qui a dit : j'ai dit : « Ô Messager d'Allah ! Dis-moi sur l'islam une parole au sujet de laquelle je n'interrogerai personne d'autre que toi. » Il a dit : « Dis : je crois en Allah, puis sois droit. » Rapporté par Muslim (n° 38). Hadith authentique.

2. La phrase à retenir
« {{NAWX:21:212:245}} » (āmantu bi-llāhi thumma staqim).
Sens : « Je crois en Allah, puis sois droit. »

3. Explication
Le Compagnon Sufyān ibn ʿAbd Allāh a demandé au Prophète ﷺ une parole qui réunisse le sens de l'islam, afin de s'y attacher sans avoir à interroger quelqu'un d'autre (selon HadeethEnc) :
- « Dis : je crois en Allah » : j'affirme l'unicité d'Allah, je crois qu'Il est mon Seigneur, mon Dieu, mon Créateur, Celui que j'adore en vérité, sans associé.
- « Puis sois droit » (istiqāma) : soumets-toi à Allah en accomplissant Ses obligations et en laissant Ses interdits, et persévère dans cela.

4. Ce que l'élève peut retenir
- Le fondement de la religion est la foi en Allah : en Sa seigneurie, Sa divinité, Ses noms et Ses attributs.
- La droiture après la foi est essentielle : persévérer dans l'adoration et y rester ferme.
- La foi est une condition de l'acceptation des œuvres.
- La foi englobe la croyance du cœur et ce qui en découle : les œuvres du cœur et la soumission à Allah, en apparence comme à l'intérieur.

Exercice : expliquez avec vos mots ce que veut dire « être droit » dans sa vie de musulman, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$21$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Dis : je crois en Allah, puis sois droit, d'après Sufyān ibn ʿAbd Allāh$x$, null, null, $x$https://sunnah.com/nawawi40:21$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$38$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:38$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66524$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66524$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « thumma staqim » ?$x$, array[$x$Puis sois droit$x$, $x$Puis repose-toi$x$, $x$Puis voyage$x$]::text[], 0, $x$L'istiqāma : rester droit sur la voie d'Allah.$x$),
  (2, $x$Que demandait Sufyān au Prophète ﷺ ?$x$, array[$x$Une parole qui résume l'islam$x$, $x$De l'argent$x$, $x$Un poste de gouverneur$x$]::text[], 0, $x$Il voulait une parole pour ne plus avoir à interroger quelqu'un d'autre.$x$),
  (3, $x$En quoi consiste la droiture selon HadeethEnc ?$x$, array[$x$Accomplir les obligations, laisser les interdits et persévérer$x$, $x$Ne jamais sortir de chez soi$x$, $x$Prier une seule fois par an$x$]::text[], 0, $x$C'est l'attachement à la voie d'Allah.$x$),
  (4, $x$Qu'est-ce qui vient en premier dans ce hadith ?$x$, array[$x$La foi en Allah$x$, $x$La droiture$x$, $x$Le pèlerinage$x$]::text[], 0, $x$« Dis : je crois en Allah, puis sois droit. »$x$),
  (5, $x$La foi est-elle une condition pour que les œuvres soient acceptées ?$x$, array[$x$Oui$x$, $x$Non$x$]::text[], 0, $x$HadeethEnc le relève parmi les enseignements du hadith.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 21 d'an-Nawawī$x$),
       rv.h = '70dce55d663d676ca813c3ceb9d111e5' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
