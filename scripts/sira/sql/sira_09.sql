-- Sira 9 : boycott-de-banu-hashim
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$boycott-de-banu-hashim$x$, 'lesson', 'sira', 'fr', 9) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Le boycott de Banū Hāshim (le Shiʿb d'Abū Ṭālib)$x$, $x$Le pacte de Quraysh contre Banū Hāshim et Banū al-Muṭṭalib, les années de privation dans le Shiʿb d'Abū Ṭālib, et la fin du boycott.$x$, $x$1. Pourquoi Quraysh décida un boycott
Ḥamza et ʿUmar étaient devenus musulmans, et Abū Ṭālib continuait de protéger le Prophète ﷺ avec Banū Hāshim et Banū al-Muṭṭalib, même ceux d'entre eux qui n'étaient pas musulmans. Les chefs de Quraysh décidèrent alors de faire pression sur tout le clan.

2. Le pacte, d'après un hadith authentique
Abū Hurayra rapporte que le Prophète ﷺ dit à Minā, pendant le pèlerinage :
« نَحْنُ نَازِلُونَ غَدًا بِخَيْفِ بَنِي كِنَانَةَ حَيْثُ تَقَاسَمُوا عَلَى الْكُفْرِ » (naḥnu nāzilūna ghadan bi-khayfi Banī Kināna ḥaythu taqāsamū ʿalā l-kufr).
Sens : « Demain, nous ferons halte au Khayf de Banū Kināna, là où ils se sont juré fidélité dans la mécréance. » Le hadith explique qu'il s'agit d'al-Muḥaṣṣab : c'est là que Quraysh et Kināna s'étaient alliés contre Banū Hāshim et Banū ʿAbd al-Muṭṭalib (ou Banū al-Muṭṭalib), en s'engageant à ne pas se marier avec eux et à ne pas commercer avec eux tant qu'ils ne leur livreraient pas le Prophète ﷺ (al-Bukhārī n° 1590 ; hadith authentique).
Ce hadith montre donc que le boycott a bien eu lieu, et ce qu'il interdisait.

3. Les années dans le Shiʿb, d'après les livres de Sira
Selon al-Mubārakfūrī, Banū Hāshim et Banū al-Muṭṭalib furent enfermés dans un étroit défilé à l'est de La Mecque, le Shiʿb d'Abū Ṭālib, du début du mois de Muḥarram de la septième année de la mission jusqu'à la dixième, soit environ trois ans. La nourriture n'arrivait presque plus et ils connurent de grandes privations (al-Raḥīq al-Makhtūm).
Les livres de Sira rapportent aussi que le pacte fut écrit et accroché dans la Kaʿba, et que des proches, comme Hishām ibn ʿAmr, faisaient passer en secret un peu de nourriture la nuit (al-Raḥīq al-Makhtūm). Ces détails viennent des historiens (Ibn Isḥāq, Ibn Saʿd et d'autres), et non des recueils de hadiths authentiques.

4. La fin du boycott
Selon al-Mubārakfūrī, en Muḥarram de la dixième année, cinq hommes de Quraysh, poussés par les liens de parenté, s'entendirent pour annuler le pacte : Hishām ibn ʿAmr, Zuhayr ibn Abī Umayya, al-Muṭʿim ibn ʿAdī, Abū l-Bakhtarī et Zamʿa ibn al-Aswad. Zuhayr le dénonça publiquement près de la Kaʿba, et le boycott prit fin (al-Raḥīq al-Makhtūm).
Les historiens rapportent aussi que des termites avaient rongé le document accroché dans la Kaʿba, ne laissant que le nom d'Allah. Ce récit vient des livres de Sira (Ibn Isḥāq, Ibn Saʿd, al-Bayhaqī, Abū Nuʿaym) ; il n'est pas dans les recueils authentiques, et l'élève doit savoir le distinguer de ce qui est établi par le hadith d'al-Bukhārī.

5. Ce que l'élève peut retenir
- Quraysh et Kināna s'allièrent contre Banū Hāshim et Banū al-Muṭṭalib : pas de mariage ni de commerce avec eux tant qu'ils ne livreraient pas le Prophète ﷺ (al-Bukhārī n° 1590).
- Des années plus tard, pendant son pèlerinage, le Prophète ﷺ fit halte à l'endroit même où ce pacte avait été conclu.
- Selon les livres de Sira, le boycott dura environ trois ans dans le Shiʿb d'Abū Ṭālib, dans de grandes privations.
- Il prit fin quand des hommes de Quraysh, touchés par les liens de parenté, annulèrent le pacte.
- Le récit des termites vient des historiens, pas des recueils authentiques.

Exercice : expliquez ce qu'interdisait le pacte de Quraysh, répétez la parole du Prophète ﷺ à Minā avec son sens, et répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1590$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Là où ils se sont juré fidélité dans la mécréance » : le pacte contre Banū Hāshim, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:1590$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api). Même récit, plus court, en al-Bukhārī n° 1589 et 3882.$x$),
  (2, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Al-Raḥīq al-Makhtūm (Le Nectar cacheté)$x$, $x$Ṣafī al-Raḥmān al-Mubārakfūrī$x$, $x$Chapitres « Le boycott général » et « La fin du pacte »$x$, $x$https://lawphilospher.blogspot.com/2014/01/ar-raheeq-al-makhtum-sealed-nectar-by_1653.html$x$, $x$Shiʿb d'Abū Ṭālib de Muḥarram de la 7e année à la 10e (environ trois ans) ; Hishām ibn ʿAmr et les cinq hommes qui annulèrent le pacte.$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Récit d'Ibn Isḥāq repris par al-Bayhaqī (via Yūnus ibn Bukayr)$x$, $x$Ibn Kathīr$x$, $x$Bibliothèque Shamela, livre 930, page 569$x$, $x$https://shamela.ws/book/930/569$x$, $x$Banū Hāshim et Banū al-Muṭṭalib refusèrent de livrer le Prophète ﷺ, même s'ils ne partageaient pas sa religion.$x$),
  (4, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le siège de Banū Hāshim dans le Shiʿb d'Abū Ṭālib : récit historique et analyse$x$, $x$Tohed.com$x$, $x$Article (anglais)$x$, $x$https://en.tohed.com/threads/the-siege-of-banu-hashim-a-trial-of-faith-and-tribal-solidarity.3922/$x$, $x$Le récit des termites est rapporté par des historiens anciens (Ibn Isḥāq, Ibn Saʿd, al-Bayhaqī, Abū Nuʿaym).$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Contre quels clans Quraysh et Kināna conclurent-ils un pacte ?$x$, array[$x$Banū Hāshim et Banū al-Muṭṭalib$x$, $x$Banū Makhzūm et Banū Sahm$x$, $x$Les Anṣār de Médine$x$]::text[], 0, $x$Al-Bukhārī n° 1590 : le pacte visait Banū Hāshim et Banū ʿAbd al-Muṭṭalib (ou Banū al-Muṭṭalib).$x$),
  (2, $x$Que leur interdisait ce pacte ?$x$, array[$x$Le mariage et le commerce avec eux$x$, $x$L'entrée dans La Mecque seulement$x$, $x$La prière près de la Kaʿba seulement$x$]::text[], 0, $x$Ils s'engagèrent à ne pas se marier avec eux et à ne pas commercer avec eux.$x$),
  (3, $x$Jusqu'à quand devait durer ce boycott, selon le hadith ?$x$, array[$x$Jusqu'à ce qu'ils livrent le Prophète ﷺ$x$, $x$Une seule année$x$, $x$Jusqu'au prochain pèlerinage$x$]::text[], 0, $x$Le pacte devait durer tant qu'ils ne leur livreraient pas le Prophète ﷺ.$x$),
  (4, $x$Où le Prophète ﷺ annonça-t-il qu'il ferait halte, à l'endroit même du pacte ?$x$, array[$x$Au Khayf de Banū Kināna (al-Muḥaṣṣab)$x$, $x$Au mont Ḥirā'$x$, $x$À Ṭā'if$x$]::text[], 0, $x$Il dit à Minā : demain nous ferons halte au Khayf de Banū Kināna, là où ils se sont juré fidélité dans la mécréance.$x$),
  (5, $x$Combien de temps dura le boycott selon les livres de Sira ?$x$, array[$x$Environ trois ans$x$, $x$Quelques jours$x$, $x$Dix ans$x$]::text[], 0, $x$Selon al-Mubārakfūrī, de Muḥarram de la 7e année jusqu'à la 10e année de la mission.$x$),
  (6, $x$Comment le boycott prit-il fin selon les livres de Sira ?$x$, array[$x$Des hommes de Quraysh, touchés par les liens de parenté, annulèrent le pacte$x$, $x$Les musulmans gagnèrent une bataille$x$, $x$Abū Jahl le leva lui-même$x$]::text[], 0, $x$Hishām ibn ʿAmr, Zuhayr ibn Abī Umayya, al-Muṭʿim ibn ʿAdī, Abū l-Bakhtarī et Zamʿa ibn al-Aswad s'entendirent pour l'annuler.$x$),
  (7, $x$D'où vient le récit des termites qui rongèrent le document ?$x$, array[$x$Des livres de Sira (historiens)$x$, $x$De Ṣaḥīḥ al-Bukhārī$x$, $x$Du Coran$x$]::text[], 0, $x$Il est rapporté par des historiens comme Ibn Isḥāq et Ibn Saʿd, et non par les recueils authentiques.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Sira 9$x$),
       rv.h = 'b77eeddf9b3e056dad6a5e78a10297b5' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
