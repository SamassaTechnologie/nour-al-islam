-- Bonnes manières 3 : les-droits-du-voisin-et-de-l-invite
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$les-droits-du-voisin-et-de-l-invite$x$, 'lesson', $x$adab$x$, 'fr', 3) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Les droits du voisin et de l'invité$x$, $x$Le voisin dans le Coran et la Sunna : la recommandation de Jibrīl, la foi de celui dont le voisin n'est pas à l'abri, les petits cadeaux et le partage de la nourriture, le voisin le plus proche ; puis l'hospitalité : honorer l'invité, un jour et une nuit, trois jours, et les devoirs de l'invité.$x$, $x$1. Le voisin : une recommandation répétée
Allah ordonne d'être bon envers les parents, les proches, les orphelins, les pauvres, le voisin proche et le voisin éloigné (sourate al-Nisā’, 4:36).
Le Prophète ﷺ a dit :
« مَا زَالَ يُوصِينِي جِبْرِيلُ بِالْجَارِ حَتَّى ظَنَنْتُ أَنَّهُ سَيُوَرِّثُهُ » (mā zāla yūṣīnī jibrīlu bi-l-jāri ḥattā ẓanantu annahu sa-yuwarrithuh).
Sens : « Jibrīl n'a cessé de me recommander le voisin, au point que j'ai pensé qu'il allait le faire hériter. » (al-Bukhārī n° 6014, d'après ʿĀ’isha ; hadith authentique).

2. Ne pas nuire à son voisin
Le Prophète ﷺ dit trois fois : « Par Allah, il ne croit pas ! » On demanda : qui donc, ô Messager d'Allah ? Il répondit : « Celui dont le voisin n'est pas à l'abri de ses méfaits » (al-Bukhārī n° 6016, d'après Abū Shurayḥ ; hadith authentique). Il a dit aussi : que celui qui croit en Allah et au Jour dernier ne nuise pas à son voisin (al-Bukhārī n° 6018).

3. Faire du bien à son voisin
a) Partager la nourriture : le Prophète ﷺ dit à Abū Dharr :
« يَا أَبَا ذَرٍّ إِذَا طَبَخْتَ مَرَقَةً فَأَكْثِرْ مَاءَهَا وَتَعَاهَدْ جِيرَانَكَ » (yā abā dharrin idhā ṭabakhta maraqatan fa-akthir mā’ahā wa taʿāhad jīrānak).
Sens : « Ô Abū Dharr, quand tu prépares une sauce, mets-y beaucoup d'eau et pense à tes voisins. » (Muslim n° 2625 ; hadith authentique).
b) Ne pas mépriser un petit cadeau : il disait aux femmes musulmanes qu'aucune ne méprise un cadeau à sa voisine, fût-ce un sabot de mouton (al-Bukhārī n° 6017, d'après Abū Hurayra).
c) Le plus proche d'abord : ʿĀ’isha demanda auquel de ses deux voisins offrir un cadeau ; il répondit : « À celui dont la porte est la plus proche de toi » (al-Bukhārī n° 6020).

4. L'invité
a) L'honorer : le Prophète ﷺ a dit :
« فَلْيُكْرِمْ ضَيْفَهُ، جَائِزَتُهُ يَوْمٌ وَلَيْلَةٌ، وَالضِّيَافَةُ ثَلاَثَةُ أَيَّامٍ، فَمَا بَعْدَ ذَلِكَ فَهْوَ صَدَقَةٌ، وَلاَ يَحِلُّ لَهُ أَنْ يَثْوِيَ عِنْدَهُ حَتَّى يُحْرِجَهُ » (fal-yukrim ḍayfah, jā’izatuhu yawmun wa laylah, wa ḍ-ḍiyāfatu thalāthatu ayyām, fa-mā baʿda dhālika fa-huwa ṣadaqah, wa lā yaḥillu lahu an yathwiya ʿindahu ḥattā yuḥrijah).
Sens : « (Que celui qui croit en Allah et au Jour dernier) honore son invité : son dû est d'un jour et d'une nuit, et l'hospitalité est de trois jours ; ce qui est au-delà est une aumône. Et il n'est pas permis à l'invité de rester chez lui au point de le mettre dans l'embarras. » (al-Bukhārī n° 6135, d'après Abū Shurayḥ al-Kaʿbī ; hadith authentique). Dans une autre version, le rapporteur précise que le « dû » (jā’iza) est d'un jour et d'une nuit (al-Bukhārī n° 6019).
b) L'exemple d'Ibrāhīm : quand des invités vinrent chez lui, il alla discrètement vers sa famille, apporta un veau gras et le leur présenta (sourate al-Dhāriyāt, 51:24-27).
c) Les devoirs de l'invité : ne pas rester au point de gêner son hôte (al-Bukhārī n° 6135).

5. Ce que l'élève peut retenir
- Jibrīl a tant recommandé le voisin que le Prophète ﷺ a pensé qu'il allait hériter.
- Celui dont le voisin n'est pas à l'abri de ses méfaits n'a pas la foi complète.
- On partage la nourriture et on offre de petits cadeaux, en commençant par la porte la plus proche.
- On honore l'invité ; l'hospitalité est de trois jours ; l'invité ne gêne pas son hôte.

Exercice : choisissez un geste concret pour un voisin cette semaine (un plat, un cadeau, une visite), puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 4::int, 36::int, 36::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6014$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Jibrīl n'a cessé de recommander le voisin, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/bukhari:6014$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6016$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Celui dont le voisin n'est pas à l'abri de ses méfaits », d'après Abū Shurayḥ$x$, null, null, $x$https://sunnah.com/bukhari:6016$x$, null),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6018$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Ne pas nuire à son voisin, honorer son invité, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:6018$x$, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2625b$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Mets beaucoup d'eau dans ta sauce et pense à tes voisins », d'après Abū Dharr$x$, null, null, $x$https://sunnah.com/muslim:2625b$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6017$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Ne pas mépriser un cadeau à sa voisine, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:6017$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6020$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le voisin dont la porte est la plus proche, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/bukhari:6020$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6135$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Honorer l'invité : un jour et une nuit, trois jours d'hospitalité, d'après Abū Shurayḥ al-Kaʿbī$x$, null, null, $x$https://sunnah.com/bukhari:6135$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6019$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Qu'est-ce que son dû ? Un jour et une nuit », d'après Abū Shurayḥ al-ʿAdawī$x$, null, null, $x$https://sunnah.com/bukhari:6019$x$, null),
  (10, $x$quran$x$::public.reference_kind, 51::int, 24::int, 27::int, null, null, null, null, null, null, null, null, null, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qui a recommandé le voisin au Prophète ﷺ avec insistance ?$x$, array[$x$Jibrīl$x$, $x$Abū Bakr$x$, $x$Personne$x$]::text[], 0, $x$Al-Bukhārī n° 6014.$x$),
  (2, $x$Que dit le Prophète ﷺ de celui dont le voisin n'est pas à l'abri de ses méfaits ?$x$, array[$x$Il ne croit pas$x$, $x$Il est un bon voisin$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 6016.$x$),
  (3, $x$Que conseille le Prophète ﷺ à Abū Dharr quand il prépare une sauce ?$x$, array[$x$Mettre beaucoup d'eau et penser à ses voisins$x$, $x$La manger seul$x$, $x$La vendre$x$]::text[], 0, $x$Muslim n° 2625.$x$),
  (4, $x$Faut-il mépriser un petit cadeau entre voisines ?$x$, array[$x$Non, même un sabot de mouton$x$, $x$Oui, s'il est petit$x$, $x$Seulement le vendredi$x$]::text[], 0, $x$Al-Bukhārī n° 6017.$x$),
  (5, $x$À quel voisin offrir d'abord un cadeau ?$x$, array[$x$Celui dont la porte est la plus proche$x$, $x$Le plus riche$x$, $x$Le plus éloigné$x$]::text[], 0, $x$Al-Bukhārī n° 6020.$x$),
  (6, $x$Combien de jours dure l'hospitalité ?$x$, array[$x$Trois jours$x$, $x$Un mois$x$, $x$Une heure$x$]::text[], 0, $x$Al-Bukhārī n° 6135.$x$),
  (7, $x$Que doit éviter l'invité ?$x$, array[$x$Rester au point de mettre son hôte dans l'embarras$x$, $x$Dire merci$x$, $x$Manger ce qu'on lui offre$x$]::text[], 0, $x$Al-Bukhārī n° 6135.$x$),
  (8, $x$Qu'apporta Ibrāhīm à ses invités ?$x$, array[$x$Un veau gras$x$, $x$De l'eau seulement$x$, $x$Rien$x$]::text[], 0, $x$Sourate al-Dhāriyāt, 51:26.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 3$x$),
       rv.h = 'fe66b1815333693712b85bbe0268439b' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
