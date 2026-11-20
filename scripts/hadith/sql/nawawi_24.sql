-- Hadith 24 d'an-Nawawī : nawawi-24-l-injustice-est-interdite
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-24-l-injustice-est-interdite$x$, 'lesson', 'hadith', 'fr', 24) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 24 : « Je Me suis interdit l'injustice » (hadith qudsī)$x$, $x$Un hadith rapporté par le Prophète ﷺ de son Seigneur : Allah S'est interdit l'injustice et l'a interdite entre Ses serviteurs ; tout bien vient de Lui.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:24}}

Traduction du sens : D'après Abū Dharr al-Ghifārī, le Prophète ﷺ rapporte de son Seigneur qu'Il a dit : « Ô Mes serviteurs ! Je Me suis interdit l'injustice et Je l'ai rendue interdite entre vous : ne soyez donc pas injustes les uns envers les autres. Ô Mes serviteurs ! Vous êtes tous égarés, sauf celui que Je guide : demandez-Moi la guidée, Je vous guiderai. Ô Mes serviteurs ! Vous avez tous faim, sauf celui que Je nourris : demandez-Moi de vous nourrir, Je vous nourrirai. Ô Mes serviteurs ! Vous êtes tous nus, sauf celui que Je vêts : demandez-Moi de vous vêtir, Je vous vêtirai. Ô Mes serviteurs ! Vous commettez des fautes la nuit et le jour, et c'est Moi qui pardonne tous les péchés : demandez-Moi pardon, Je vous pardonnerai. Ô Mes serviteurs ! Vous ne pourrez jamais Me nuire, ni Me profiter. Ô Mes serviteurs ! Si le premier et le dernier d'entre vous, les humains et les djinns, avaient le cœur de l'homme le plus pieux parmi vous, cela n'ajouterait rien à Mon royaume. Ô Mes serviteurs ! Si le premier et le dernier d'entre vous, les humains et les djinns, avaient le cœur de l'homme le plus pervers parmi vous, cela ne diminuerait en rien Mon royaume. Ô Mes serviteurs ! Si le premier et le dernier d'entre vous, les humains et les djinns, se tenaient sur une même étendue et Me demandaient, et que Je donnais à chacun ce qu'il demande, cela ne diminuerait ce que Je possède que comme diminue la mer lorsqu'on y plonge une aiguille. Ô Mes serviteurs ! Ce ne sont que vos œuvres, que Je compte pour vous, puis dont Je vous rétribue pleinement. Que celui qui trouve un bien loue Allah, et que celui qui trouve autre chose ne blâme que lui-même. » Rapporté par Muslim (n° 2577). Hadith authentique.

2. La phrase à retenir
« {{NAWX:24:168:259}} » (innī ḥarramtu ẓ-ẓulma ʿalā nafsī wa jaʿaltuhu baynakum muḥarraman fa-lā taẓālamū).
Sens : « Je Me suis interdit l'injustice et Je l'ai rendue interdite entre vous : ne soyez donc pas injustes les uns envers les autres. »

3. Explication
Selon HadeethEnc :
- Allah S'est interdit l'injustice et l'a interdite entre Ses créatures : personne ne doit être injuste envers personne.
- Toutes les créatures sont égarées, sauf celles qu'Allah guide : celui qui Lui demande la guidée, Allah le guide.
- Toutes les créatures ont besoin d'Allah pour tous leurs besoins : celui qui Lui demande, Allah lui suffit.
- Toutes les créatures commettent des péchés, et Allah pardonne à celui qui Lui demande pardon.
- Les créatures ne peuvent ni nuire à Allah ni Lui être utiles : leur piété n'ajoute rien à Son royaume, leur perversité ne lui enlève rien, et Ses dons ne diminuent pas ce qu'Il possède.

4. Ce que l'élève peut retenir
- C'est un hadith qudsī : le Prophète ﷺ le rapporte de son Seigneur. Il ne fait pourtant pas partie du Coran et n'en a pas les caractéristiques (sa récitation n'est pas une adoration en soi comme celle du Coran, il n'est pas un miracle inimitable…).
- La science et la guidée que les serviteurs obtiennent viennent de la guidée d'Allah et de Son enseignement.
- Tout bien obtenu vient de la grâce d'Allah ; le serviteur ne doit blâmer que lui-même pour le mal qu'il trouve.

Exercice : citez quatre choses que ce hadith nous invite à demander à Allah, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$24$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Ô Mes serviteurs, Je Me suis interdit l'injustice, d'après Abū Dharr$x$, null, null, $x$https://sunnah.com/nawawi40:24$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2577$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la bonté et des liens de parenté$x$, null, null, $x$https://sunnah.com/muslim:2577a$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4810$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4810$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qu'est-ce qu'un hadith qudsī ?$x$, array[$x$Un hadith que le Prophète ﷺ rapporte de son Seigneur$x$, $x$Un verset du Coran$x$, $x$Une parole d'un Compagnon$x$]::text[], 0, $x$Il ne fait pas partie du Coran et n'en a pas les caractéristiques.$x$),
  (2, $x$Qu'Allah S'est-Il interdit dans ce hadith ?$x$, array[$x$L'injustice$x$, $x$La miséricorde$x$, $x$Le pardon$x$]::text[], 0, $x$« Je Me suis interdit l'injustice. »$x$),
  (3, $x$À qui demander la guidée, la nourriture et le pardon ?$x$, array[$x$À Allah$x$, $x$Aux saints$x$, $x$Aux étoiles$x$]::text[], 0, $x$« Demandez-Moi… Je vous guiderai… Je vous pardonnerai. »$x$),
  (4, $x$La piété de toutes les créatures ajoute-t-elle quelque chose au royaume d'Allah ?$x$, array[$x$Non, rien$x$, $x$Oui, beaucoup$x$]::text[], 0, $x$Allah n'a besoin de personne ; ce sont les créatures qui ont besoin de Lui.$x$),
  (5, $x$Que doit faire celui qui trouve un bien ?$x$, array[$x$Louer Allah$x$, $x$Se vanter$x$, $x$Blâmer les autres$x$]::text[], 0, $x$« Que celui qui trouve un bien loue Allah. »$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 24 d'an-Nawawī$x$),
       rv.h = '6a334a1f1566c84f62e1cea474859ea2' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
