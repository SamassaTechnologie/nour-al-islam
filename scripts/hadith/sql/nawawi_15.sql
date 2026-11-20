-- Hadith 15 d'an-Nawawī : nawawi-15-dire-du-bien-ou-se-taire
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-15-dire-du-bien-ou-se-taire$x$, 'lesson', 'hadith', 'fr', 15) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 15 : dire du bien ou se taire, honorer son voisin et son invité$x$, $x$La foi en Allah et au Jour dernier pousse à bien parler ou à se taire, à honorer son voisin et à honorer son invité.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:15}}

Traduction du sens : D'après Abū Hurayra : le Messager d'Allah ﷺ a dit : « Que celui qui croit en Allah et au Jour dernier dise du bien ou se taise. Que celui qui croit en Allah et au Jour dernier honore son voisin. Que celui qui croit en Allah et au Jour dernier honore son invité. » Rapporté par al-Bukhārī (n° 6018) et Muslim (n° 47). Hadith authentique.

2. La phrase à retenir
« {{NAWX:15:143:177}} » (fal-yaqul khayran aw li-yaṣmut).
Sens : « Qu'il dise du bien ou qu'il se taise. »

3. Explication
Le serviteur qui croit en Allah et au Jour dernier, sachant qu'il retournera vers Allah pour être rétribué de ses œuvres, est poussé par sa foi à trois choses (selon HadeethEnc) :
- Bien parler : glorifier Allah, ordonner le bien, interdire le mal, réconcilier les gens… Et s'il n'a rien de bon à dire, il se tait, évite de nuire et garde sa langue.
- Honorer son voisin : lui faire du bien et ne pas lui nuire.
- Honorer son invité : lui parler aimablement, lui offrir à manger et ce qui ressemble à cela.

4. Ce que l'élève peut retenir
- La foi en Allah et au Jour dernier est la base de tout bien : elle pousse à agir bien.
- Il faut se méfier des dangers de la langue.
- L'islam est une religion de bonté et de générosité.
- Ces trois comportements font partie des branches de la foi et des bonnes manières.
- Beaucoup parler peut entraîner vers ce qui est détestable ou interdit ; la sécurité est de ne parler que pour le bien.

Exercice : pendant une journée, avant de parler, demandez-vous : « Est-ce du bien ? », puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$15$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Que celui qui croit en Allah et au Jour dernier dise du bien ou se taise, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:15$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6018$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre des bonnes manières$x$, null, null, $x$https://sunnah.com/bukhari:6018$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$47$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:47a$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 5437$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/5437$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que doit faire le croyant s'il n'a rien de bon à dire ?$x$, array[$x$Se taire$x$, $x$Dire n'importe quoi$x$, $x$Crier$x$]::text[], 0, $x$« Qu'il dise du bien ou qu'il se taise. »$x$),
  (2, $x$Quelles sont les trois choses citées dans ce hadith ?$x$, array[$x$Bien parler ou se taire, honorer son voisin, honorer son invité$x$, $x$Prier, jeûner, voyager$x$, $x$Lire, écrire, compter$x$]::text[], 0, $x$Chacune est liée à la foi en Allah et au Jour dernier.$x$),
  (3, $x$Comment honore-t-on son voisin ?$x$, array[$x$En lui faisant du bien et en ne lui nuisant pas$x$, $x$En l'ignorant$x$, $x$En parlant de lui en son absence$x$]::text[], 0, $x$C'est l'explication donnée par HadeethEnc.$x$),
  (4, $x$Qu'est-ce qui pousse le croyant à ces comportements ?$x$, array[$x$Sa foi en Allah et au Jour dernier$x$, $x$La peur des gens$x$, $x$L'envie d'être célèbre$x$]::text[], 0, $x$Il sait qu'il sera rétribué de ses œuvres.$x$),
  (5, $x$Que peut entraîner le fait de trop parler ?$x$, array[$x$Des paroles détestables ou interdites$x$, $x$Plus de récompense automatiquement$x$, $x$Rien du tout$x$]::text[], 0, $x$La sécurité est de ne parler que pour le bien.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 15 d'an-Nawawī$x$),
       rv.h = 'b9d057007a670ffc7bcb099bb009f233' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
