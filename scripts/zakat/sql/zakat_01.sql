-- Zakāt 1 : la-zakat-obligation-conditions-et-nisab
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-zakat-obligation-conditions-et-nisab$x$, 'lesson', $x$zakat$x$, 'fr', 1) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La zakāt : son obligation, ses conditions et le seuil (niṣāb) de l'or, de l'argent et de la monnaie$x$, $x$La place de la zakāt dans l'islam, la menace contre celui qui ne la paie pas, ses conditions (islam, liberté, seuil, propriété stable, année écoulée), le seuil de l'or et de l'argent d'après la Sunna, son taux de 2,5 %, et le calcul pour la monnaie d'aujourd'hui.$x$, $x$1. Un pilier de l'islam
La zakāt est le troisième pilier de l'islam (al-Bukhārī n° 8). Allah l'associe souvent à la prière : accomplissez la prière et acquittez la zakāt (sourate al-Baqara, 2:43). Quand le Prophète ﷺ envoya Muʿādh au Yémen, il lui dit de leur apprendre, après les deux témoignages et la prière :
« أَنَّ اللَّهَ افْتَرَضَ عَلَيْهِمْ صَدَقَةً فِي أَمْوَالِهِمْ، تُؤْخَذُ مِنْ أَغْنِيَائِهِمْ وَتُرَدُّ عَلَى فُقَرَائِهِمْ » (anna llāha ftaraḍa ʿalayhim ṣadaqatan fī amwālihim, tu’khadhu min aghniyā’ihim wa turaddu ʿalā fuqarā’ihim).
Sens : « qu'Allah leur a prescrit une aumône sur leurs biens, prise de leurs riches et rendue à leurs pauvres. » (al-Bukhārī n° 1395, d'après Ibn ʿAbbās ; hadith authentique).
Allah dit aussi au Prophète ﷺ de prendre de leurs biens une aumône par laquelle il les purifie (sourate al-Tawba, 9:103).

2. La menace contre celui qui ne la paie pas
Allah menace d'un châtiment douloureux ceux qui thésaurisent l'or et l'argent sans les dépenser dans le chemin d'Allah (sourate al-Tawba, 9:34-35). Le Prophète ﷺ a dit que celui à qui Allah a donné des biens et qui n'en paie pas la zakāt, ses biens prendront le Jour de la Résurrection la forme d'un serpent chauve qui l'enserrera et lui dira : « Je suis ton bien, je suis ton trésor » ; puis il récita le verset 3:180 (al-Bukhārī n° 1403, d'après Abū Hurayra ; hadith authentique, en substance).

3. Les conditions de l'obligation
D'après un commentaire de fiqh (IslamWeb), la zakāt est due par le musulman libre, sur un bien qu'il possède, qui atteint le seuil (niṣāb), dont la propriété est stable, et sur lequel une année lunaire (ḥawl) est passée, sauf ce que produit la terre (récoltes et fruits), dont la zakāt est due à la récolte (sourate al-Anʿām, 6:141).
Au sujet de l'année, ʿAlī rapporte que le Prophète ﷺ a dit qu'il n'y a pas de zakāt sur un bien tant qu'une année n'est pas passée dessus (Abū Dāwūd n° 1573 ; voir le point 4).

4. Le seuil (niṣāb)
Le Prophète ﷺ a dit :
« لَيْسَ فِيمَا دُونَ خَمْسِ أَوَاقٍ صَدَقَةٌ، وَلَيْسَ فِيمَا دُونَ خَمْسِ ذَوْدٍ صَدَقَةٌ، وَلَيْسَ فِيمَا دُونَ خَمْسِ أَوْسُقٍ صَدَقَةٌ » (laysa fīmā dūna khamsi awāqin ṣadaqah, wa laysa fīmā dūna khamsi dhawdin ṣadaqah, wa laysa fīmā dūna khamsati awsuqin ṣadaqah).
Sens : « En dessous de cinq awāq (d'argent), pas de zakāt ; en dessous de cinq chameaux, pas de zakāt ; en dessous de cinq awsuq (de grains ou de dattes), pas de zakāt. » (al-Bukhārī n° 1405, d'après Abū Saʿīd ; hadith authentique).
Pour l'argent-métal et l'or, ʿAlī rapporte :
« فَإِذَا كَانَتْ لَكَ مِائَتَا دِرْهَمٍ وَحَالَ عَلَيْهَا الْحَوْلُ فَفِيهَا خَمْسَةُ دَرَاهِمَ وَلَيْسَ عَلَيْكَ شَىْءٌ - يَعْنِي فِي الذَّهَبِ - حَتَّى يَكُونَ لَكَ عِشْرُونَ دِينَارًا فَإِذَا كَانَ لَكَ عِشْرُونَ دِينَارًا وَحَالَ عَلَيْهَا الْحَوْلُ فَفِيهَا نِصْفُ دِينَارٍ فَمَا زَادَ فَبِحِسَابِ ذَلِكَ » (fa-idhā kānat laka mi’tā dirhamin wa ḥāla ʿalayhā l-ḥawlu fa-fīhā khamsatu darāhim, wa laysa ʿalayka shay’un yaʿnī fi dh-dhahabi ḥattā yakūna laka ʿishrūna dīnāran, fa-idhā kāna laka ʿishrūna dīnāran wa ḥāla ʿalayhā l-ḥawlu fa-fīhā niṣfu dīnār, fa-mā zāda fa-bi-ḥisābi dhālik).
Sens : « Si tu possèdes deux cents dirhams et qu'une année est passée dessus, tu dois cinq dirhams. Tu ne dois rien sur l'or tant que tu n'as pas vingt dinars ; si tu as vingt dinars et qu'une année est passée dessus, tu dois un demi-dinar, et ce qui dépasse se calcule de la même façon. » (Abū Dāwūd n° 1573 ; jugé authentique par al-Albānī, faible par Zubayr ʿAlī Zaʾī ; le rapporteur ne sait pas si la dernière phrase est de ʿAlī ou du Prophète ﷺ).
En poids d'aujourd'hui, selon un article du site al-Alūka, le seuil de l'or est d'environ 85 grammes (20 dinars de 4,25 g) et celui de l'argent d'environ 595 grammes (200 dirhams de 2,975 g).

5. Le taux : un quarantième (2,5 %)
Dans la lettre d'Abū Bakr sur la zakāt, il est écrit : sur l'argent, un quart du dixième (al-Bukhārī n° 1454). Ibn Bāz précise que c'est deux et demi pour cent (fatwa n° 5745). Cinq dirhams sur deux cents, ou un demi-dinar sur vingt, c'est bien un quarantième.

6. La monnaie d'aujourd'hui (billets, comptes)
Ibn Bāz explique que la zakāt est due sur la monnaie quand sa valeur atteint le plus bas des deux seuils, celui de l'or ou celui de l'argent, ou quand elle complète ce seuil avec d'autres biens de même nature (fatwa n° 5774). Le Comité permanent des fatwas dit de prendre le seuil le plus avantageux pour les pauvres (cité par IslamQA, n° 2795), et IslamQA rapporte le même avis de plusieurs instances (n° 370380). IslamQA en conclut qu'il s'agit en pratique du seuil de l'argent, environ 595 g.
Exemple : si 595 g d'argent valent 300 000 francs CFA (chiffre fictif) et que vous gardez 500 000 francs pendant une année lunaire, vous devez 500 000 ÷ 40 = 12 500 francs. Vérifiez le prix du jour auprès d'une source fiable de votre pays.

7. Ce que l'élève peut retenir
- La zakāt est un pilier de l'islam, prise des riches et rendue aux pauvres.
- Conditions : musulman, libre, seuil atteint, propriété stable, une année lunaire passée (sauf les récoltes).
- Seuil : 20 dinars d'or (environ 85 g) ou 200 dirhams d'argent (environ 595 g) ; taux : 2,5 %.
- Pour la monnaie, Ibn Bāz et le Comité permanent retiennent le plus bas des deux seuils.

Exercice : calculez la zakāt d'une somme d'épargne gardée une année, avec le prix de l'argent-métal du jour, puis répondez aux questions. Pour un cas compliqué (dettes, commerce, salaires reçus chaque mois), interrogez un savant qualifié.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$8$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les cinq piliers de l'islam, d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:8$x$, null),
  (2, $x$quran$x$::public.reference_kind, 2::int, 43::int, 43::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1395$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'envoi de Muʿādh au Yémen : une aumône prise des riches et rendue aux pauvres, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/bukhari:1395$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (4, $x$quran$x$::public.reference_kind, 9::int, 103::int, 103::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$quran$x$::public.reference_kind, 9::int, 34::int, 35::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1403$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les biens dont la zakāt n'est pas payée deviennent un serpent, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:1403$x$, null),
  (7, $x$quran$x$::public.reference_kind, 3::int, 180::int, 180::int, null, null, null, null, null, null, null, null, null, null),
  (8, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Sharḥ Kitāb al-zakāt (leçon audio transcrite)$x$, $x$IslamWeb$x$, $x$Site audio.islamweb.net, leçon n° 280582$x$, $x$https://audio.islamweb.net/audio/Fulltxt.php?audioid=280582$x$, $x$La zakāt est due par le musulman libre dont le bien atteint le seuil, à propriété stable, après une année, sauf ce que produit la terre.$x$),
  (9, $x$quran$x$::public.reference_kind, 6::int, 141::int, 141::int, null, null, null, null, null, null, null, null, null, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1405$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les seuils de l'argent, des chameaux et des récoltes, d'après Abū Saʿīd$x$, null, null, $x$https://sunnah.com/bukhari:1405$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$1573$x$, $x$Authentique selon al-Albānī ; faible selon Zubayr ʿAlī Zaʾī$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Deux cents dirhams, vingt dinars et l'année écoulée, d'après ʿAlī$x$, null, null, $x$https://sunnah.com/abudawud:1573$x$, $x$Passage copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (12, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Zakāt al-dhahab wa l-fiḍḍa (la zakāt de l'or et de l'argent)$x$, $x$Site al-Alūka$x$, $x$Article n° 67587$x$, $x$https://www.alukah.net/sharia/1048/67587/$x$, $x$Le dinar pèse 4,25 g : seuil de l'or 20 × 4,25 = 85 g ; seuil de l'argent 200 × 2,975 = 595 g ; taux 2,5 %.$x$),
  (13, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1454$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La lettre d'Abū Bakr : sur l'argent, un quart du dixième, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:1454$x$, null),
  (14, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 5745 : le seuil de la zakāt de l'argent$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh (Majmūʿ fatāwā 14/81)$x$, $x$https://binbaz.org.sa/fatwas/5745/$x$, $x$Seuil de l'argent : 140 mithqāl ; le dû est un quart du dixième, soit 2,5 %.$x$),
  (15, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 5774 : le seuil de la monnaie en papier$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh (Majmūʿ fatāwā 14/125)$x$, $x$https://binbaz.org.sa/fatwas/5774/$x$, $x$La zakāt est due sur la monnaie quand sa valeur atteint le plus bas des deux seuils (or ou argent), ou le complète avec d'autres biens.$x$),
  (16, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Mā huwa al-niṣāb fī l-māl ? (le seuil de l'argent), réponse n° 2795$x$, $x$IslamQA, d'après le Comité permanent des fatwas$x$, $x$Cite Fatāwā al-Lajna al-Dā'ima (9/254 et 9/257)$x$, $x$https://islamqa.info/ar/answers/2795$x$, $x$Le seuil de la monnaie est la valeur de 20 mithqāl d'or ou de 140 mithqāl d'argent, en prenant le plus avantageux pour les pauvres.$x$),
  (17, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le seuil de la monnaie se mesure-t-il par l'argent ou par l'or ? Réponse n° 370380$x$, $x$IslamQA$x$, $x$Site IslamQA, en arabe$x$, $x$https://islamqa.info/ar/answers/370380$x$, $x$Le plus bas des deux seuils : avis de l'Académie de fiqh de la Ligue islamique mondiale, du Conseil des grands savants, du Comité permanent et d'Ibn Bāz ; en pratique 595 g d'argent.$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quel pilier de l'islam est la zakāt ?$x$, array[$x$Le troisième$x$, $x$Le premier$x$, $x$Le cinquième$x$]::text[], 0, $x$Après les deux témoignages et la prière (al-Bukhārī n° 8 et 1395).$x$),
  (2, $x$D'où la zakāt est-elle prise et à qui est-elle rendue ?$x$, array[$x$Prise des riches, rendue aux pauvres$x$, $x$Prise des pauvres, rendue aux riches$x$, $x$Prise de tous, gardée par l'État$x$]::text[], 0, $x$Al-Bukhārī n° 1395.$x$),
  (3, $x$Que deviennent, le Jour de la Résurrection, les biens dont la zakāt n'a pas été payée ?$x$, array[$x$Un serpent qui enserre leur propriétaire$x$, $x$Rien$x$, $x$Une récompense$x$]::text[], 0, $x$Al-Bukhārī n° 1403.$x$),
  (4, $x$Combien de temps faut-il garder l'argent pour que la zakāt soit due ?$x$, array[$x$Une année lunaire$x$, $x$Un mois$x$, $x$Dix ans$x$]::text[], 0, $x$Abū Dāwūd n° 1573 ; sauf les récoltes, dues à la récolte (6:141).$x$),
  (5, $x$Quel est le seuil de l'or d'après le hadith de ʿAlī ?$x$, array[$x$Vingt dinars (environ 85 g)$x$, $x$Deux dinars$x$, $x$Mille dinars$x$]::text[], 0, $x$Abū Dāwūd n° 1573 ; poids d'après al-Alūka.$x$),
  (6, $x$Quel est le seuil de l'argent-métal ?$x$, array[$x$Deux cents dirhams (environ 595 g)$x$, $x$Vingt dirhams$x$, $x$Dix mille dirhams$x$]::text[], 0, $x$Abū Dāwūd n° 1573 et al-Bukhārī n° 1405 (cinq awāq).$x$),
  (7, $x$Quel est le taux de la zakāt sur l'or, l'argent et la monnaie ?$x$, array[$x$2,5 % (un quarantième)$x$, $x$10 %$x$, $x$50 %$x$]::text[], 0, $x$Al-Bukhārī n° 1454 ; Ibn Bāz, fatwa n° 5745.$x$),
  (8, $x$Quel seuil Ibn Bāz retient-il pour la monnaie en papier ?$x$, array[$x$Le plus bas des deux seuils, or ou argent$x$, $x$Toujours le seuil de l'or$x$, $x$Aucun seuil$x$]::text[], 0, $x$Fatwa n° 5774.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Zakāt 1$x$),
       rv.h = '8beb235404707bd489248cdb016ffd54' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
