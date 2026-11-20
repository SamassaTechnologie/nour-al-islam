-- Hadith 16 d'an-Nawawī : nawawi-16-ne-te-mets-pas-en-colere
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-16-ne-te-mets-pas-en-colere$x$, 'lesson', 'hadith', 'fr', 16) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 16 : ne te mets pas en colère$x$, $x$Un homme demande un conseil ; le Prophète ﷺ lui répète : « Ne te mets pas en colère. » Éviter les causes de la colère et se maîtriser protège de nombreux maux.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:16}}

Traduction du sens : D'après Abū Hurayra : un homme a dit au Prophète ﷺ : « Fais-moi une recommandation. » Il a dit : « Ne te mets pas en colère. » L'homme a répété sa demande plusieurs fois, et il a dit : « Ne te mets pas en colère. » Rapporté par al-Bukhārī (n° 6116). Hadith authentique.

2. La phrase à retenir
« {{NAWX:16:112:124}} » (lā taghḍab).
Sens : « Ne te mets pas en colère. »

3. Explication
Un Compagnon a demandé au Prophète ﷺ de lui indiquer une chose utile ; il lui a ordonné de ne pas se mettre en colère. Cela signifie (selon HadeethEnc) :
- éviter les causes qui mènent à la colère ;
- se maîtriser lorsque la colère survient, pour qu'elle ne pousse pas à frapper, à insulter, ou à pire encore.
L'homme a redemandé plusieurs fois, et le Prophète ﷺ n'a rien ajouté d'autre à ce conseil.

4. Ce que l'élève peut retenir
- La colère réunit beaucoup de mal, et s'en préserver réunit beaucoup de bien.
- La colère pour Allah, lorsque Ses interdits sont violés, fait partie de la colère louable (selon HadeethEnc).
- On peut répéter une parole jusqu'à ce que l'interlocuteur la retienne et en comprenne l'importance.
- Il est bon de demander conseil aux gens de science.

Exercice : citez deux situations qui vous mettent en colère et ce que vous pouvez faire pour les éviter, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$16$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī$x$, $x$Ne te mets pas en colère, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:16$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6116$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre des bonnes manières$x$, null, null, $x$https://sunnah.com/bukhari:6116$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4709$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4709$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « lā taghḍab » ?$x$, array[$x$Ne te mets pas en colère$x$, $x$Ne mens pas$x$, $x$Ne dors pas$x$]::text[], 0, $x$C'est la recommandation répétée par le Prophète ﷺ.$x$),
  (2, $x$Combien de fois l'homme a-t-il redemandé un conseil ?$x$, array[$x$Plusieurs fois$x$, $x$Jamais$x$, $x$Une seule fois$x$]::text[], 0, $x$Il a répété sa demande, et la réponse est restée la même.$x$),
  (3, $x$Que signifie ce conseil selon HadeethEnc ?$x$, array[$x$Éviter les causes de la colère et se maîtriser quand elle survient$x$, $x$Ne jamais ressentir aucune émotion$x$, $x$Se taire toute sa vie$x$]::text[], 0, $x$Il s'agit d'éviter ce qui y mène et de ne pas se laisser entraîner par elle.$x$),
  (4, $x$Toute colère est-elle blâmable ?$x$, array[$x$Oui, toujours$x$, $x$Non, la colère pour Allah quand Ses interdits sont violés est louable$x$]::text[], 1, $x$HadeethEnc le précise dans les enseignements du hadith.$x$),
  (5, $x$Pourquoi le Prophète ﷺ a-t-il répété sa réponse ?$x$, array[$x$Pour que l'homme la retienne et en comprenne l'importance$x$, $x$Parce qu'il n'avait pas entendu$x$, $x$Par hasard$x$]::text[], 0, $x$La répétition aide à retenir.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 16 d'an-Nawawī$x$),
       rv.h = 'e980b89fe5608d72f321a9b6f615acb1' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
