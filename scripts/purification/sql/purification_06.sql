-- Purification 6 : les-ablutions-seches-at-tayammum
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$les-ablutions-seches-at-tayammum$x$, 'lesson', $x$purification$x$, 'fr', 6) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Les ablutions sèches (at-tayammum)$x$, $x$Quand l'eau manque ou qu'on ne peut pas l'utiliser, on se purifie avec la terre. La terre a été rendue pure pour cette communauté ; le tayammum remplace aussi le grand lavage. La manière enseignée à ʿAmmār : une frappe, le visage et les mains ; la divergence des écoles (une ou deux frappes, mains ou avant-bras).$x$, $x$1. Un allègement d'Allah
Allah dit : si vous êtes malades, ou en voyage, ou si l'un de vous revient du lieu d'aisance, ou si vous avez touché les femmes, et que vous ne trouvez pas d'eau, recourez à une terre pure, et passez-en sur vos visages et vos mains ; Allah ne veut pas vous imposer de gêne (sourate al-Mā’ida, 5:6 ; voir aussi an-Nisā’, 4:43).
Le Prophète ﷺ a dit qu'il a reçu cinq choses qu'aucun prophète avant lui n'avait reçues, dont :
« وَجُعِلَتْ لِيَ الأَرْضُ مَسْجِدًا وَطَهُورًا » (wa juʿilat liya l-arḍu masjidan wa ṭahūrā).
Sens : « La terre a été faite pour moi lieu de prière et moyen de purification. » (al-Bukhārī n° 335, d'après Jābir ibn ʿAbd Allāh ; hadith authentique).

2. Quand fait-on le tayammum ?
- Quand on ne trouve pas d'eau (5:6).
- Quand on ne peut pas l'utiliser, par maladie ou par crainte d'un danger (5:6). ʿAmr ibn al-ʿĀṣ, en état d'impureté majeure par une nuit très froide, craignit de mourir s'il se lavait ; il fit le tayammum et dirigea la prière ; le Prophète ﷺ, informé de son explication, sourit et ne dit rien (Abū Dāwūd n° 334 ; authentique selon al-Albānī).
- Il remplace aussi le grand lavage : à un homme en état d'impureté majeure qui n'avait pas d'eau, le Prophète ﷺ dit : prends la terre, cela te suffit (al-Bukhārī n° 344, d'après ʿImrān ibn Ḥuṣayn).

3. La manière enseignée à ʿAmmār
ʿAmmār ibn Yāsir, en état d'impureté majeure sans eau, s'était roulé dans la terre. Le Prophète ﷺ lui dit : « Cela t'aurait suffi ainsi », puis il frappa la terre de ses paumes, souffla dessus, et s'en passa sur le visage et les mains (al-Bukhārī n° 338).
Cheikh Ibn Bāz explique que la manière prescrite est une seule frappe pour le visage et les mains, avec une terre pure, sans essuyer les avant-bras (binbaz.org.sa, fatwas n° 1548 et 12683).

4. La divergence des écoles
- Deux frappes, l'une pour le visage et l'autre pour les mains jusqu'aux coudes : avis des ḥanafites et des shāfiʿites ;
- une seule frappe, et les mains jusqu'aux poignets : avis des mālikites et des ḥanbalites, pour qui aller jusqu'aux coudes est recommandé (d'après fiqh.islamonline.net).
Ibn Ḥajar remarque que seuls les hadiths de ʿAmmār et d'Abū Juhaym sont authentiques sur la manière du tayammum (cité par fiqh.islamonline.net), et ash-Shawkānī juge faibles les hadiths des deux frappes (même source).

5. Ce que le tayammum permet
Selon Ibn Bāz, le tayammum remplace l'eau pour lever l'impureté, selon l'avis le plus juste : on peut prier avec lui les prières obligatoires et surérogatoires tant qu'on n'a pas perdu sa pureté, ou jusqu'à ce qu'on trouve de l'eau, ou qu'on puisse de nouveau l'utiliser (binbaz.org.sa, fatwa n° 1548).

6. Ce que l'élève peut retenir
- Le tayammum se fait quand l'eau manque ou ne peut pas être utilisée.
- Il remplace les ablutions et le grand lavage.
- Selon le hadith de ʿAmmār : une frappe de la terre, puis le visage et les mains.
- Les écoles divergent sur le nombre de frappes et la limite des mains.

Exercice : décrivez le tayammum selon le hadith de ʿAmmār, puis citez les deux avis des écoles, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 5::int, 6::int, 6::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 4::int, 43::int, 43::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$335$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« La terre a été faite pour moi lieu de prière et moyen de purification », d'après Jābir$x$, null, null, $x$https://sunnah.com/bukhari:335$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$334$x$, $x$Authentique (al-Albānī, Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$ʿAmr ibn al-ʿĀṣ et la nuit froide$x$, null, null, $x$https://sunnah.com/abudawud:334$x$, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$344$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Prends la terre, cela te suffit », d'après ʿImrān ibn Ḥuṣayn$x$, null, null, $x$https://sunnah.com/bukhari:344$x$, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$338$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le tayammum enseigné à ʿAmmār ibn Yāsir$x$, null, null, $x$https://sunnah.com/bukhari:338$x$, null),
  (7, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La manière du tayammum$x$, $x$ʿAbd al-ʿAzīz ibn Bāz$x$, $x$Fatwas n° 1548 et 12683, binbaz.org.sa$x$, $x$https://binbaz.org.sa/fatwas/1548$x$, $x$Une frappe pour le visage et les mains ; terre pure ; le tayammum remplace l'eau pour lever l'impureté.$x$),
  (8, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le tayammum : ses causes et sa manière$x$, $x$fiqh.islamonline.net$x$, $x$Article en ligne$x$, $x$https://fiqh.islamonline.net/%d8%a7%d9%84%d8%aa%d9%8a%d9%85%d9%85-%d8%af%d9%88%d8%a7%d8%b9%d9%8a%d9%87-%d9%88%d9%83%d9%8a%d9%81%d9%8a%d8%aa%d9%87/$x$, $x$Deux frappes jusqu'aux coudes (ḥanafites, shāfiʿites) ; une frappe jusqu'aux poignets (mālikites, ḥanbalites) ; remarque d'Ibn Ḥajar.$x$),
  (9, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La manière correcte du tayammum$x$, $x$fiqh.islamonline.net (citant ash-Shawkānī, as-Sayl al-jarrār 1/133)$x$, $x$Article en ligne$x$, $x$https://fiqh.islamonline.net/%D8%A7%D9%84%D9%83%D9%8A%D9%81%D9%8A%D8%A9-%D8%A7%D9%84%D8%B5%D8%AD%D9%8A%D8%AD%D9%8A%D8%A9-%D9%84%D9%84%D8%AA%D9%8A%D9%85%D9%85/$x$, $x$Les hadiths des deux frappes ou jusqu'aux coudes sont faibles selon ash-Shawkānī.$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quand peut-on faire le tayammum selon 5:6 ?$x$, array[$x$Quand on ne trouve pas d'eau, ou en cas de maladie$x$, $x$Quand on est pressé$x$, $x$Jamais$x$]::text[], 0, $x$Sourate al-Mā’ida, 5:6.$x$),
  (2, $x$Qu'a dit le Prophète ﷺ de la terre ?$x$, array[$x$Elle a été faite lieu de prière et moyen de purification$x$, $x$Elle est impure$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 335.$x$),
  (3, $x$Le tayammum remplace-t-il le grand lavage ?$x$, array[$x$Oui, quand l'eau manque$x$, $x$Non, jamais$x$, $x$Seulement le vendredi$x$]::text[], 0, $x$Al-Bukhārī n° 344.$x$),
  (4, $x$Pourquoi ʿAmr ibn al-ʿĀṣ fit-il le tayammum malgré la présence d'eau ?$x$, array[$x$Il craignait de mourir de froid$x$, $x$Il était pressé$x$, $x$Il n'aimait pas l'eau$x$]::text[], 0, $x$Abū Dāwūd n° 334.$x$),
  (5, $x$Combien de frappes dans le hadith de ʿAmmār ?$x$, array[$x$Une$x$, $x$Deux$x$, $x$Trois$x$]::text[], 0, $x$Al-Bukhārī n° 338.$x$),
  (6, $x$Que essuie-t-on avec la terre selon le hadith de ʿAmmār ?$x$, array[$x$Le visage et les mains$x$, $x$La tête et les pieds$x$, $x$Tout le corps$x$]::text[], 0, $x$Al-Bukhārī n° 338.$x$),
  (7, $x$Quel est l'avis des ḥanafites et des shāfiʿites ?$x$, array[$x$Deux frappes, les mains jusqu'aux coudes$x$, $x$Une frappe, les mains jusqu'aux poignets$x$, $x$Pas de tayammum$x$]::text[], 0, $x$Fiqh.islamonline.net.$x$),
  (8, $x$Selon Ibn Bāz, jusqu'à quand le tayammum reste-t-il valable ?$x$, array[$x$Jusqu'à la perte de la pureté ou jusqu'à pouvoir utiliser l'eau$x$, $x$Une seule prière$x$, $x$Une heure$x$]::text[], 0, $x$Ibn Bāz, fatwa n° 1548.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Purification 6$x$),
       rv.h = '6b240cb4af4e0bebcc522db2f5e6d991' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
