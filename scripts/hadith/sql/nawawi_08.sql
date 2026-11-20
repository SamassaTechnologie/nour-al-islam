-- Hadith 8 d'an-Nawawī : nawawi-08-le-sang-et-les-biens-proteges
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-08-le-sang-et-les-biens-proteges$x$, 'lesson', 'hadith', 'fr', 8) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 8 : l'islam protège le sang et les biens$x$, $x$Celui qui atteste de l'unicité d'Allah et du message de Muḥammad ﷺ, prie et donne la zakat voit son sang et ses biens protégés ; son compte appartient à Allah.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:8}}

Traduction du sens : D'après Ibn ʿUmar : le Messager d'Allah ﷺ a dit : « Il m'a été ordonné de combattre les gens jusqu'à ce qu'ils attestent qu'il n'y a de divinité digne d'adoration qu'Allah et que Muḥammad est le Messager d'Allah, qu'ils accomplissent la prière et qu'ils acquittent la zakat. S'ils font cela, ils protègent de moi leur sang et leurs biens, sauf selon le droit de l'islam, et leur compte appartient à Allah, le Très-Haut. » Rapporté par al-Bukhārī (n° 25) et Muslim (n° 22). Hadith authentique.

2. La phrase à retenir
« {{NAWX:8:280:323}} » (ʿaṣamū minnī dimāʾahum wa amwālahum).
Sens : « Ils protègent de moi leur sang et leurs biens. »

3. Explication
Le Prophète ﷺ informe qu'Allah lui a ordonné de combattre les polythéistes jusqu'à ce qu'ils attestent qu'il n'y a de divinité adorée en vérité qu'Allah, seul et sans associé, et que Muḥammad ﷺ est Son messager, et qu'ils mettent en pratique cette attestation en étant assidus aux cinq prières obligatoires et en versant la zakat à ceux qui y ont droit (selon HadeethEnc).
- S'ils font cela, l'islam protège leur sang et leurs biens. Il n'est alors permis de leur ôter la vie que s'ils commettent un crime pour lequel la Loi de l'islam prévoit cette peine : c'est le sens de « sauf selon le droit de l'islam ».
- « Leur compte appartient à Allah » : au Jour de la Résurrection, Allah les jugera, car Lui seul connaît ce que cachent les cœurs.

Une précision importante, donnée par HadeethEnc : ce hadith ne signifie pas qu'il faut contraindre les polythéistes à entrer dans l'islam. Le combat dont il parle reste soumis aux règles de la Loi islamique.

4. Ce que l'élève peut retenir
- Les jugements de ce monde se fondent sur ce qui est apparent ; Allah se charge de ce qui est caché dans les cœurs.
- L'appel au tawḥīd (l'unicité d'Allah) est la première chose par laquelle on commence la prédication.
- La prière et la zakat sont citées juste après les deux attestations : elles en sont la mise en pratique.

Exercice : expliquez avec vos mots la phrase « leur compte appartient à Allah », puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, ord, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, (select coalesce(max(ord), 0) from public.content_references) + v.k, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$8$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Il m'a été ordonné de combattre les gens jusqu'à ce qu'ils attestent…, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/nawawi40:8$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$25$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/bukhari:25$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$22$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:22$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4211$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4211$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) returning 1),
qq as (insert into public.content_questions (revision_id, ord, prompt, options, answer, explanation)
       select rv.id, (select coalesce(max(ord), 0) from public.content_questions) + v.k, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quelles œuvres sont citées après les deux attestations ?$x$, array[$x$La prière et la zakat$x$, $x$Le jeûne et le pèlerinage$x$, $x$L'aumône volontaire et la lecture du Coran$x$]::text[], 0, $x$« Qu'ils accomplissent la prière et qu'ils acquittent la zakat. »$x$),
  (2, $x$Que signifie « leur compte appartient à Allah » ?$x$, array[$x$Allah jugera ce que cachent leurs cœurs$x$, $x$Ils doivent payer une taxe$x$, $x$Ils n'auront pas de jugement$x$]::text[], 0, $x$Nous jugeons selon l'apparence ; Allah connaît les secrets des cœurs.$x$),
  (3, $x$Ce hadith signifie-t-il qu'on force les gens à entrer dans l'islam ?$x$, array[$x$Oui$x$, $x$Non$x$]::text[], 1, $x$HadeethEnc précise que ce hadith ne signifie pas qu'on contraint les polythéistes à embrasser l'islam.$x$),
  (4, $x$Sur quoi se fondent les jugements de ce monde selon ce hadith ?$x$, array[$x$Sur ce qui est apparent$x$, $x$Sur les rêves$x$, $x$Sur les suppositions$x$]::text[], 0, $x$Les règles s'appliquent selon l'apparent ; Allah se charge de l'intérieur.$x$),
  (5, $x$Par quoi commence la prédication selon les enseignements de ce hadith ?$x$, array[$x$L'appel à l'unicité d'Allah$x$, $x$Les règles du commerce$x$, $x$L'histoire des peuples anciens$x$]::text[], 0, $x$L'attestation de l'unicité d'Allah est citée en premier.$x$)) v(k, p, o, a, e) returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 8 d'an-Nawawī$x$),
       rv.h = '92316b29ab12d90fe70e15c90aa8e507' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
