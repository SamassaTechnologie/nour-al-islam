-- Bonnes manières 9 : la-misericorde-envers-les-faibles-les-orphelins-et-les-animaux
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-misericorde-envers-les-faibles-les-orphelins-et-les-animaux$x$, 'lesson', $x$adab$x$, 'fr', 9) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La miséricorde envers les faibles, les orphelins et les animaux$x$, $x$Celui qui ne fait pas miséricorde ne reçoit pas miséricorde. Le mérite de celui qui prend en charge l'orphelin, de celui qui aide la veuve et le pauvre ; les faibles, cause de la victoire et de la subsistance ; la bonté envers les serviteurs ; et la miséricorde envers les animaux : la femme et la chatte, l'homme et le chien, bien égorger.$x$, $x$1. Faites miséricorde, on vous fera miséricorde
Le Prophète ﷺ a dit :
« الرَّاحِمُونَ يَرْحَمُهُمُ الرَّحْمَنُ ارْحَمُوا مَنْ فِي الأَرْضِ يَرْحَمْكُمْ مَنْ فِي السَّمَاءِ » (ar-rāḥimūna yarḥamuhumu r-raḥmān, irḥamū man fī l-arḍi yarḥamkum man fī s-samā’).
Sens : « Ceux qui font miséricorde, le Tout Miséricordieux leur fait miséricorde. Faites miséricorde à ceux qui sont sur la terre, Celui qui est au-dessus du ciel vous fera miséricorde. » (al-Tirmidhī n° 1924, d'après ʿAbd Allāh ibn ʿAmr ; « ḥasan ṣaḥīḥ » selon al-Tirmidhī, authentique selon al-Albānī et Aḥmad Shākir).
Le Prophète ﷺ embrassa son petit-fils al-Ḥasan ibn ʿAlī. Al-Aqraʿ ibn Ḥābis dit : j'ai dix enfants et je n'en ai jamais embrassé un seul. Le Prophète ﷺ le regarda et dit : celui qui ne fait pas miséricorde, on ne lui fera pas miséricorde (al-Bukhārī n° 5997, d'après Abū Hurayra ; voir aussi al-Bukhārī n° 6013).

2. L'orphelin
Allah dit : quant à l'orphelin, ne le maltraite pas (sourate aḍ-Ḍuḥā, 93:9). Il blâme celui qui repousse l'orphelin et n'encourage pas à nourrir le pauvre (sourate al-Māʿūn, 107:1-3), et menace ceux qui mangent injustement les biens des orphelins (sourate an-Nisā’, 4:10).
Le Prophète ﷺ a dit :
« أَنَا وَكَافِلُ الْيَتِيمِ، فِي الْجَنَّةِ هَكَذَا » (anā wa kāfilu l-yatīmi fī l-jannati hākadhā).
Sens : « Moi et celui qui prend en charge l'orphelin, nous serons au Paradis ainsi. » Et il montra son index et son majeur (al-Bukhārī n° 6005, d'après Sahl ibn Saʿd ; hadith authentique).

3. La veuve, le pauvre et les faibles
Le Prophète ﷺ a dit que celui qui s'occupe de la veuve et du pauvre est comme celui qui combat dans le sentier d'Allah, ou comme celui qui jeûne le jour et prie la nuit (al-Bukhārī n° 6006, d'après Abū Hurayra).
Saʿd ibn Abī Waqqāṣ pensa qu'il avait une supériorité sur ceux qui étaient en dessous de lui ; le Prophète ﷺ dit : n'êtes-vous secourus et nourris que grâce à vos faibles ? (al-Bukhārī n° 2896, d'après Muṣʿab ibn Saʿd).

4. Ceux qui sont sous notre autorité
Abū Dharr avait insulté un homme en lui reprochant sa mère. Le Prophète ﷺ lui dit : tu es un homme qui a encore en lui de la jāhiliyya. Ce sont vos frères, qu'Allah a placés sous votre autorité : que celui qui a son frère sous son autorité le nourrisse de ce qu'il mange, l'habille de ce qu'il porte, ne le charge pas de ce qui le dépasse, et s'il l'en charge, qu'il l'aide (al-Bukhārī n° 30).

5. Les animaux
Le Prophète ﷺ a dit qu'une femme entra en Enfer à cause d'une chatte qu'elle avait attachée, sans la nourrir ni la laisser manger les petites bêtes de la terre (al-Bukhārī n° 3318, d'après Ibn ʿUmar).
Il raconta aussi qu'un homme assoiffé descendit dans un puits pour boire ; en sortant, il vit un chien haletant qui mangeait la terre humide de soif ; il remplit sa chaussure d'eau et lui donna à boire ; Allah le remercia et lui pardonna. On demanda : avons-nous une récompense pour les bêtes ? Il répondit :
« فِي كُلِّ كَبِدٍ رَطْبَةٍ أَجْرٌ » (fī kulli kabidin raṭbatin ajr).
Sens : « Pour tout être vivant (litt. tout foie humide), il y a une récompense. » (al-Bukhārī n° 2363, d'après Abū Hurayra ; hadith authentique).
Bien égorger : le Prophète ﷺ a dit qu'Allah a prescrit la bonté (al-iḥsān) en toute chose ; quand vous égorgez, égorgez bien : que chacun aiguise sa lame et soulage sa bête (Muslim n° 1955, d'après Shaddād ibn Aws ; voir la leçon sur le hadith 17 des Quarante d'an-Nawawī).

6. Ce que l'élève peut retenir
- Celui qui fait miséricorde reçoit la miséricorde d'Allah.
- Prendre en charge l'orphelin rapproche du Prophète ﷺ au Paradis.
- Aider la veuve et le pauvre a une grande récompense ; on ne méprise pas les faibles.
- On traite avec bonté ceux qui sont sous notre autorité.
- La bonté envers les animaux est récompensée, et leur maltraitance est un péché grave.

Exercice : choisissez un geste de miséricorde cette semaine (aider un orphelin, un voisin âgé, donner à boire et à manger à un animal), puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$1924$x$, $x$Ḥasan ṣaḥīḥ (al-Tirmidhī) ; authentique (al-Albānī, Aḥmad Shākir)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Ceux qui font miséricorde, le Tout Miséricordieux leur fait miséricorde », d'après ʿAbd Allāh ibn ʿAmr$x$, null, null, $x$https://sunnah.com/tirmidhi:1924$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5997$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le baiser à al-Ḥasan et la réponse à al-Aqraʿ, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5997$x$, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6013$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Celui qui ne fait pas miséricorde… », d'après Jarīr ibn ʿAbd Allāh$x$, null, null, $x$https://sunnah.com/bukhari:6013$x$, null),
  (4, $x$quran$x$::public.reference_kind, 93::int, 9::int, 9::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$quran$x$::public.reference_kind, 107::int, 1::int, 3::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$quran$x$::public.reference_kind, 4::int, 10::int, 10::int, null, null, null, null, null, null, null, null, null, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6005$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Moi et celui qui prend en charge l'orphelin », d'après Sahl ibn Saʿd$x$, null, null, $x$https://sunnah.com/bukhari:6005$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6006$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Celui qui s'occupe de la veuve et du pauvre, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:6006$x$, $x$Rapporté aussi de Ṣafwān ibn Sulaym sans nommer le Compagnon ; la seconde chaîne remonte à Abū Hurayra.$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2896$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« N'êtes-vous secourus et nourris que grâce à vos faibles ? », d'après Muṣʿab ibn Saʿd$x$, null, null, $x$https://sunnah.com/bukhari:2896$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$30$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Abū Dharr et « ce sont vos frères »$x$, null, null, $x$https://sunnah.com/bukhari:30$x$, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$3318$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La femme et la chatte, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:3318$x$, null),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2363$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'homme qui donna à boire au chien, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:2363$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (13, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1955a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Allah a prescrit la bonté en toute chose », d'après Shaddād ibn Aws$x$, null, null, $x$https://sunnah.com/muslim:1955a$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que promet le hadith à ceux qui font miséricorde ?$x$, array[$x$Le Tout Miséricordieux leur fait miséricorde$x$, $x$Rien$x$, $x$La richesse$x$]::text[], 0, $x$Al-Tirmidhī n° 1924.$x$),
  (2, $x$Que dit le Prophète ﷺ à al-Aqraʿ, qui n'embrassait jamais ses enfants ?$x$, array[$x$Celui qui ne fait pas miséricorde, on ne lui fera pas miséricorde$x$, $x$Tu as raison$x$, $x$Embrasser les enfants est interdit$x$]::text[], 0, $x$Al-Bukhārī n° 5997.$x$),
  (3, $x$Où sera celui qui prend en charge l'orphelin ?$x$, array[$x$Au Paradis, proche du Prophète ﷺ comme deux doigts$x$, $x$Nulle part$x$, $x$Loin du Prophète ﷺ$x$]::text[], 0, $x$Al-Bukhārī n° 6005.$x$),
  (4, $x$À qui est comparé celui qui s'occupe de la veuve et du pauvre ?$x$, array[$x$À celui qui combat dans le sentier d'Allah$x$, $x$À un commerçant$x$, $x$À rien$x$]::text[], 0, $x$Al-Bukhārī n° 6006.$x$),
  (5, $x$Grâce à qui, selon le hadith, les musulmans sont-ils secourus et nourris ?$x$, array[$x$Grâce à leurs faibles$x$, $x$Grâce aux riches seulement$x$, $x$Grâce à leurs armes seulement$x$]::text[], 0, $x$Al-Bukhārī n° 2896.$x$),
  (6, $x$Comment nourrir celui qui est sous notre autorité ?$x$, array[$x$De ce que l'on mange soi-même$x$, $x$Des restes seulement$x$, $x$Comme on veut$x$]::text[], 0, $x$Al-Bukhārī n° 30.$x$),
  (7, $x$Pourquoi une femme est-elle entrée en Enfer selon le hadith ?$x$, array[$x$Elle avait enfermé une chatte sans la nourrir$x$, $x$Elle avait nourri une chatte$x$, $x$Elle avait un chat$x$]::text[], 0, $x$Al-Bukhārī n° 3318.$x$),
  (8, $x$Y a-t-il une récompense pour la bonté envers les animaux ?$x$, array[$x$Oui, pour tout être vivant il y a une récompense$x$, $x$Non$x$, $x$Seulement pour les chevaux$x$]::text[], 0, $x$Al-Bukhārī n° 2363.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 9$x$),
       rv.h = 'b1d62dbc5f225a3aa76f27d54eb5ebdc' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
