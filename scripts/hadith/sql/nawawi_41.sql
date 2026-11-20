-- Hadith 41 d'an-Nawawī : nawawi-41-que-ses-penchants-suivent-la-revelation
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-41-que-ses-penchants-suivent-la-revelation$x$, 'lesson', 'hadith', 'fr', 41) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 41 : que ses penchants suivent ce qu'a apporté le Prophète ﷺ$x$, $x$La foi n'est complète que lorsque les désirs suivent ce qu'a apporté le Prophète ﷺ. Les savants divergent sur l'authenticité de ce hadith, mais son sens est juste.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:41}}

Traduction du sens : D'après Abū Muḥammad ʿAbd Allāh ibn ʿAmr ibn al-ʿĀṣ : le Messager d'Allah ﷺ a dit : « Aucun de vous n'est vraiment croyant tant que ses penchants ne suivent pas ce que j'ai apporté. » An-Nawawī a dit : hadith ḥasan ṣaḥīḥ, que nous avons rapporté dans le livre « al-Ḥujja » avec une chaîne authentique.

2. Le grade de ce hadith : une divergence entre savants
Ce hadith n'est ni dans al-Bukhārī ni dans Muslim, et les savants ne sont pas d'accord sur son authenticité :
- An-Nawawī l'a jugé authentique (ḥasan ṣaḥīḥ), comme on le lit dans son recueil ; HadeethEnc reprend ce jugement.
- Ibn Rajab, dans son explication des Quarante hadiths (Jāmiʿ al-ʿulūm wa l-ḥikam), a dit que le déclarer authentique est « très éloigné », pour plusieurs raisons liées à sa chaîne de transmission.
- Le cheikh Ibn Bāz a répondu à ce sujet : certains l'ont jugé authentique et d'autres faible ; il y a de la faiblesse dans sa chaîne, mais son sens est juste.
Le sens, lui, est confirmé par d'autres textes, comme le verset 65 de la sourate 4 (an-Nisāʾ), qui conditionne la foi au fait d'accepter le jugement du Prophète ﷺ sans réticence.

3. La phrase à retenir
« {{NAWX:41:139:211}} » (lā yuʾminu aḥadukum ḥattā yakūna hawāhu tabaʿan li-mā jiʾtu bih).
Sens : « Aucun de vous n'est vraiment croyant tant que ses penchants ne suivent pas ce que j'ai apporté. »

4. Explication
La foi n'est complète que lorsque les penchants de la personne se conforment à ce qu'a apporté le Prophète ﷺ : elle aime ce qu'il a ordonné et déteste ce qu'il a interdit (selon HadeethEnc).

5. Ce que l'élève peut retenir
- C'est une règle de base de la soumission à la Loi d'Allah.
- Celui qui place sa raison ou ses habitudes au-dessus de ce qu'a apporté le Messager ﷺ n'a pas la foi complète (selon HadeethEnc).
- Il faut prendre la Révélation comme juge en toute chose.
- La foi augmente par l'obéissance et diminue par la désobéissance.
- Quand les savants divergent sur un hadith, on présente honnêtement leurs avis.

Exercice : expliquez pourquoi un hadith peut être discuté dans sa chaîne tout en ayant un sens juste, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$41$x$, $x$Ḥasan ṣaḥīḥ selon an-Nawawī ; jugé faible par Ibn Rajab$x$, $x$An-Nawawī ; Ibn Rajab$x$, $x$Que ses penchants suivent ce que j'ai apporté, d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/nawawi40:41$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Jāmiʿ al-ʿulūm wa l-ḥikam$x$, $x$Ibn Rajab al-Ḥanbalī$x$, $x$Explication du hadith 41 (2/393 selon ad-Durar as-Saniyya)$x$, $x$https://dorar.net/hadith/sharh/113229$x$, $x$Ibn Rajab y juge très éloigné de le déclarer authentique, pour plusieurs raisons liées à sa chaîne.$x$),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa : le jugement du hadith « lā yuʾminu aḥadukum ḥattā yakūna hawāhu… »$x$, $x$Ibn Bāz$x$, $x$Fatwa n° 15783 (site officiel)$x$, $x$https://binbaz.org.sa/fatwas/15783$x$, null),
  (4, $x$quran$x$::reference_kind, 4::int, 65::int, 65::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66535$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66535$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « ḥattā yakūna hawāhu tabaʿan li-mā jiʾtu bih » ?$x$, array[$x$Tant que ses penchants ne suivent pas ce que j'ai apporté$x$, $x$Tant qu'il ne prie pas la nuit$x$, $x$Tant qu'il n'est pas riche$x$]::text[], 0, $x$La foi complète demande que les désirs suivent la Révélation.$x$),
  (2, $x$Les savants sont-ils d'accord sur l'authenticité de ce hadith ?$x$, array[$x$Non : an-Nawawī l'a jugé authentique, Ibn Rajab l'a jugé faible$x$, $x$Oui, tous le jugent authentique$x$, $x$Oui, tous le jugent inventé$x$]::text[], 0, $x$C'est une divergence connue entre savants.$x$),
  (3, $x$Qu'a dit le cheikh Ibn Bāz de ce hadith ?$x$, array[$x$Sa chaîne est faible, mais son sens est juste$x$, $x$Il est inventé et son sens est faux$x$, $x$Il est dans al-Bukhārī$x$]::text[], 0, $x$Fatwa n° 15783 sur son site officiel.$x$),
  (4, $x$Que doit aimer le croyant selon l'explication de HadeethEnc ?$x$, array[$x$Ce que le Prophète ﷺ a ordonné$x$, $x$Tout ce que veulent ses désirs$x$, $x$Ce que pensent les gens$x$]::text[], 0, $x$Et détester ce qu'il a interdit.$x$),
  (5, $x$Quel verset confirme le sens de ce hadith ?$x$, array[$x$Sourate 4, verset 65$x$, $x$Sourate 1, verset 1$x$, $x$Sourate 114, verset 1$x$]::text[], 0, $x$Il conditionne la foi à l'acceptation du jugement du Prophète ﷺ.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 41 d'an-Nawawī$x$),
       rv.h = '817af06783519bd654d2cc0a4ce93e7f' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
