-- Famille 5 : les-parents-ages-et-le-respect-des-aines
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$les-parents-ages-et-le-respect-des-aines$x$, 'lesson', $x$famille$x$, 'fr', 5) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La bonté envers les parents âgés et le respect des aînés$x$, $x$Quand l'un d'eux ou les deux atteignent la vieillesse, ne leur dis pas « ouf ». Malheur à celui qui a connu ses parents âgés sans entrer au Paradis ; servir ses parents est un combat ; après leur mort : l'invocation, l'aumône, et la bonté envers leurs amis ; respecter les aînés.$x$, $x$1. La vieillesse des parents
Allah dit : ton Seigneur a décrété que vous n'adoriez que Lui et que vous soyez bons envers les parents ; si l'un d'eux ou les deux atteignent la vieillesse auprès de toi, ne leur dis pas « ouf », ne les brusque pas, et adresse-leur des paroles respectueuses ; abaisse pour eux l'aile de l'humilité par miséricorde, et dis : Seigneur, fais-leur miséricorde comme ils m'ont élevé tout petit (sourate al-Isrā’, 17:23-24). Allah rappelle aussi que la mère a porté l'enfant avec peine et l'a mis au monde avec peine (sourate al-Aḥqāf, 46:15).

2. Une occasion d'entrer au Paradis
Le Prophète ﷺ dit trois fois : que son nez soit dans la poussière ! On demanda : qui, ô Messager d'Allah ? Il répondit :
« مَنْ أَدْرَكَ أَبَوَيْهِ عِنْدَ الْكِبَرِ أَحَدَهُمَا أَوْ كِلَيْهِمَا فَلَمْ يَدْخُلِ الْجَنَّةَ » (man adraka abawayhi ʿinda l-kibari aḥadahumā aw kilayhimā fa-lam yadkhuli l-janna).
Sens : « Celui qui a connu ses parents dans leur vieillesse, l'un d'eux ou les deux, et qui n'est pas entré au Paradis. » (Muslim n° 2551, d'après Abū Hurayra ; hadith authentique).

3. Servir ses parents est un combat
Un homme vint demander au Prophète ﷺ la permission de partir au combat. Il lui demanda : tes parents sont-ils vivants ? Il répondit oui. Il dit :
« فَفِيهِمَا فَجَاهِدْ » (fa-fīhimā fa-jāhid).
Sens : « Alors c'est pour eux que tu dois lutter. » (al-Bukhārī n° 3004, d'après ʿAbd Allāh ibn ʿAmr ; hadith authentique).

4. Après leur mort
- L'invocation : quand l'homme meurt, ses œuvres s'arrêtent sauf trois, dont un enfant pieux qui invoque pour lui (Muslim n° 1631). Nūḥ invoqua : Seigneur, pardonne-moi ainsi qu'à mes parents (sourate Nūḥ, 71:28).
- L'aumône : un homme dit que sa mère était morte soudainement et qu'il pensait qu'elle aurait fait une aumône si elle avait pu parler ; il demanda s'il pouvait faire l'aumône pour elle ; le Prophète ﷺ répondit : oui, fais l'aumône pour elle (al-Bukhārī n° 2760, d'après ʿĀ’isha).
- La bonté envers leurs amis : le Prophète ﷺ a dit :
« أَبَرُّ الْبِرِّ أَنْ يَصِلَ الرَّجُلُ وُدَّ أَبِيهِ » (abarru l-birri an yaṣila r-rajulu wudda abīh).
Sens : « La plus grande des bontés est que l'homme garde le lien avec ceux que son père aimait. » (Muslim n° 2552, d'après Ibn ʿUmar ; hadith authentique). Ibn ʿUmar donna son âne et son turban à un bédouin dont le père était un ami de ʿUmar, en citant ce hadith (même référence).

5. Respecter les aînés
Le Prophète ﷺ a dit : n'est pas des nôtres celui qui ne fait pas miséricorde à nos petits et ne reconnaît pas l'honneur de nos aînés (al-Tirmidhī n° 1920, d'après ʿAmr ibn Shuʿayb, de son père, de son grand-père ; authentique selon al-Albānī et Aḥmad Shākir).

6. Ce que l'élève peut retenir
- La vieillesse des parents est une occasion d'entrer au Paradis.
- On leur parle avec respect et douceur, sans même dire « ouf ».
- Servir ses parents est une forme de lutte dans le sentier d'Allah.
- Après leur mort, on invoque pour eux, on fait l'aumône pour eux et on honore leurs amis.
- On respecte les aînés et on fait miséricorde aux petits.

Exercice : rendez visite ou téléphonez cette semaine à une personne âgée de votre famille, et récitez l'invocation de 17:24 pour vos parents, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 17::int, 23::int, 24::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 46::int, 15::int, 15::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2551a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Celui qui a connu ses parents âgés sans entrer au Paradis, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2551a$x$, $x$Paroles du Prophète ﷺ copiées telles quelles de l'édition de sunnah.com (base hadith-api).$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$3004$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« C'est pour eux que tu dois lutter », d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/bukhari:3004$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1631$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Les œuvres qui continuent après la mort, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:1631$x$, null),
  (6, $x$quran$x$::public.reference_kind, 71::int, 28::int, 28::int, null, null, null, null, null, null, null, null, null, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2760$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'aumône pour la mère décédée, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/bukhari:2760$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2552b$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« La plus grande des bontés… », d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/muslim:2552b$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api) ; le récit du bédouin est en Muslim 2552a et c.$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1920$x$, $x$Authentique (al-Albānī, Aḥmad Shākir) ; ḥasan (Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Faire miséricorde aux petits et honorer les aînés, d'après ʿAmr ibn Shuʿayb$x$, null, null, $x$https://sunnah.com/tirmidhi:1920$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que ne doit-on pas dire à ses parents âgés selon 17:23 ?$x$, array[$x$« Ouf »$x$, $x$« Merci »$x$, $x$« Salām »$x$]::text[], 0, $x$Sourate al-Isrā’, 17:23.$x$),
  (2, $x$Quelle invocation pour les parents se trouve en 17:24 ?$x$, array[$x$Seigneur, fais-leur miséricorde comme ils m'ont élevé tout petit$x$, $x$Seigneur, enrichis-moi$x$, $x$Aucune$x$]::text[], 0, $x$Sourate al-Isrā’, 17:24.$x$),
  (3, $x$Qui est blâmé trois fois dans le hadith d'Abū Hurayra ?$x$, array[$x$Celui qui a connu ses parents âgés sans entrer au Paradis$x$, $x$Celui qui voyage$x$, $x$Celui qui dort$x$]::text[], 0, $x$Muslim n° 2551.$x$),
  (4, $x$Que dit le Prophète ﷺ à l'homme dont les parents étaient vivants et qui voulait partir au combat ?$x$, array[$x$C'est pour eux que tu dois lutter$x$, $x$Pars tout de suite$x$, $x$Abandonne-les$x$]::text[], 0, $x$Al-Bukhārī n° 3004.$x$),
  (5, $x$Peut-on faire l'aumône pour un parent décédé ?$x$, array[$x$Oui$x$, $x$Non$x$, $x$Seulement le vendredi$x$]::text[], 0, $x$Al-Bukhārī n° 2760.$x$),
  (6, $x$Quelle est la plus grande des bontés selon le hadith d'Ibn ʿUmar ?$x$, array[$x$Garder le lien avec ceux que son père aimait$x$, $x$Donner beaucoup d'argent$x$, $x$Voyager$x$]::text[], 0, $x$Muslim n° 2552.$x$),
  (7, $x$Que dit le hadith de celui qui ne reconnaît pas l'honneur des aînés ?$x$, array[$x$Il n'est pas des nôtres$x$, $x$Il est respecté$x$, $x$Rien$x$]::text[], 0, $x$Al-Tirmidhī n° 1920.$x$),
  (8, $x$Quelle œuvre du fils pieux profite à ses parents après leur mort selon Muslim n° 1631 ?$x$, array[$x$Son invocation pour eux$x$, $x$Rien$x$, $x$Seulement son travail$x$]::text[], 0, $x$Muslim n° 1631.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Famille 5$x$),
       rv.h = 'e421fa0d490f62860487c51315fc231a' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
