-- Zakāt 3 : zakat-des-marchandises-et-des-bijoux
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$zakat-des-marchandises-et-des-bijoux$x$, 'lesson', $x$zakat$x$, 'fr', 3) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La zakāt des marchandises de commerce et des bijoux$x$, $x$Pas de zakāt sur ce qu'on garde pour son usage ; la zakāt des marchandises destinées à la vente et la manière de les évaluer ; puis les bijoux d'or et d'argent portés, avec les deux avis des savants et leurs preuves, et les cas où tous sont d'accord.$x$, $x$1. Ce qu'on garde pour son usage personnel
Le Prophète ﷺ a dit :
« لَيْسَ عَلَى الْمُسْلِمِ فِي فَرَسِهِ وَغُلاَمِهِ صَدَقَةٌ » (laysa ʿala l-muslimi fī farasihi wa ghulāmihi ṣadaqah).
Sens : « Le musulman ne doit pas de zakāt sur son cheval ni sur son serviteur. » (al-Bukhārī n° 1463, d'après Abū Hurayra ; hadith authentique).
Ainsi, la maison où l'on habite, la voiture qu'on utilise, les meubles et les vêtements ne sont pas soumis à la zakāt. Un commentaire de fiqh (IslamWeb) le résume : ce qu'on garde pour son usage n'a pas de zakāt, et ce qu'on prépare pour le commerce en a, même un terrain.

2. Les marchandises de commerce (ʿurūḍ al-tijāra)
a) Le jugement : selon le même commentaire, Ibn al-Mundhir rapporte l'accord des musulmans sur l'obligation de la zakāt des marchandises destinées à la vente. Le site al-Alūka indique que la majorité s'appuie aussi sur le raisonnement : ce sont des biens gardés pour faire du profit, comme l'or et l'argent.
On cite aussi le hadith de Samura ibn Jundub : le Prophète ﷺ leur ordonnait de donner l'aumône de ce qu'ils préparaient pour la vente (Abū Dāwūd n° 1562). Ce hadith est jugé faible par al-Albānī et par d'autres ; Ibn Bāz le cite comme preuve, avec un témoin rapporté d'Abū Dharr (fatwa n° 5803).
b) La manière de calculer : à la fin de l'année lunaire, on évalue les marchandises à leur prix du jour, et non au prix d'achat ; si cette valeur atteint le seuil, on donne 2,5 % de la valeur (site al-Alūka ; Ibn Bāz, Majmūʿ fatāwā 14/160, cité par IslamQA n° 47761). On y ajoute l'argent liquide du commerce.
Ibn Bāz précise que celui qui n'a pas d'argent en dehors de ce bien (par exemple un terrain à vendre) peut attendre de le vendre, puis payer la zakāt de toutes les années, chaque année selon sa valeur (IslamQA n° 47761).
Exemple (chiffres fictifs) : un commerçant a, à la fin de son année, un stock valant 2 000 000 francs CFA et 400 000 francs en caisse ; si le seuil est atteint, il doit (2 000 000 + 400 000) ÷ 40 = 60 000 francs.

3. Les bijoux d'or et d'argent
a) Les cas où tous sont d'accord (IslamQA n° 221758) :
- les bijoux qui ne sont ni en or ni en argent (pierres précieuses, perles) : pas de zakāt, sauf s'ils sont destinés au commerce ;
- les bijoux interdits (par exemple un bracelet d'or porté par un homme) : zakāt due ;
- les bijoux destinés au commerce, à la location ou à l'épargne : zakāt due.
b) Les bijoux licites que la femme porte : deux avis.
- Pas de zakāt : avis de la majorité des mālikites, des shāfiʿites et des ḥanbalites, rapporté de Compagnons comme Jābir, Ibn ʿUmar, Anas, ʿĀ’isha et Asmā’. Ils disent que le bijou porté n'est pas un bien qui fructifie, et jugent faibles les hadiths particuliers sur ce sujet.
- Zakāt due : avis des ḥanafites, rapporté aussi d'autres savants, et retenu par Ibn Bāz, Ibn ʿUthaymīn et le Comité permanent des fatwas. Parmi leurs preuves, ce hadith : une femme vint avec sa fille, qui portait deux gros bracelets d'or ; le Prophète ﷺ lui dit :
« أَتُعْطِينَ زَكَاةَ هَذَا ‏"‏ ‏.‏ قَالَتْ لاَ ‏.‏ قَالَ ‏"‏ أَيَسُرُّكِ أَنْ يُسَوِّرَكِ اللَّهُ بِهِمَا يَوْمَ الْقِيَامَةِ سِوَارَيْنِ مِنْ نَارٍ » (a-tuʿṭīna zakāta hādhā ? qālat : lā. qāla : a-yasurruki an yusawwiraki llāhu bihimā yawma l-qiyāmati siwārayni min nār).
Sens : « Donnes-tu la zakāt de ceci ? » Elle répondit : « Non. » Il dit : « Aimerais-tu qu'Allah te mette à leur place, le Jour de la Résurrection, deux bracelets de feu ? » (Abū Dāwūd n° 1563 ; « ḥasan » selon al-Albānī ; jugé faible par d'autres, dont al-Tirmidhī et al-Nasā’ī, d'après IslamQA).
IslamQA présente les deux avis comme forts, et conclut qu'il vaut mieux payer la zakāt des bijoux par précaution. Suivez l'avis d'un savant de confiance.

4. Ce que l'élève peut retenir
- Pas de zakāt sur ce qu'on garde pour son usage (maison, voiture, vêtements).
- Les marchandises à vendre : on les évalue à la fin de l'année au prix du jour, et on donne 2,5 %.
- Bijoux : tous sont d'accord pour les bijoux de commerce ou d'épargne ; pour les bijoux portés, il y a deux avis.

Exercice : calculez la zakāt d'une petite boutique (stock et caisse) avec des chiffres de votre choix, puis répondez aux questions. Pour une entreprise ou des bijoux de grande valeur, interrogez un savant qualifié.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1463$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Pas de zakāt sur le cheval ni le serviteur du musulman, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:1463$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Sharḥ Bulūgh al-marām : zakāt ʿurūḍ al-tijāra (leçon audio transcrite)$x$, $x$IslamWeb$x$, $x$Site audio.islamweb.net, leçon n° 134657$x$, $x$https://audio.islamweb.net/audio/Fulltxt.php?audioid=134657$x$, $x$Hadith de Samura cité avec la mention « sa chaîne est faible » ; Ibn al-Mundhir rapporte l'accord sur la zakāt des marchandises ; ce qu'on garde pour son usage n'a pas de zakāt, ce qu'on prépare pour le commerce en a, même un terrain.$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Zakāt ʿurūḍ al-tijāra (la zakāt des marchandises de commerce)$x$, $x$Site al-Alūka$x$, $x$Articles n° 77711 et 146513$x$, $x$https://www.alukah.net/web/shigawi/0/146513/$x$, $x$La majorité s'appuie aussi sur le raisonnement (biens destinés au profit) ; évaluation à la fin de l'année selon la valeur du jour, pas selon le prix d'achat ; 2,5 % de la valeur.$x$),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$1562$x$, $x$Faible (al-Albānī, Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Samura ibn Jundub : l'aumône de ce qu'on prépare pour la vente$x$, null, null, $x$https://sunnah.com/abudawud:1562$x$, $x$Cité pour signaler sa faiblesse ; Ibn Bāz le cite avec un témoin d'Abū Dharr.$x$),
  (5, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 5803 : l'avis mālikite sur la zakāt des marchandises est faible$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh$x$, $x$https://binbaz.org.sa/fatwas/5803/$x$, $x$Zakāt des biens préparés pour la vente selon leur valeur, qu'elle monte ou baisse ; cite le hadith de Samura et un témoin d'Abū Dharr.$x$),
  (6, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Il doit la zakāt de marchandises mais n'a pas d'argent, réponse n° 47761$x$, $x$IslamQA, d'après Ibn Bāz$x$, $x$Cite Majmūʿ fatāwā Ibn Bāz (14/160-161)$x$, $x$https://islamqa.info/ar/answers/47761$x$, $x$Évaluation chaque année à la fin de l'année ; celui qui n'a pas d'autre argent attend la vente et paie toutes les années, chacune selon sa valeur.$x$),
  (7, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le détail de la divergence des savants sur la zakāt des bijoux, réponse n° 221758$x$, $x$IslamQA$x$, $x$Site IslamQA, en arabe$x$, $x$https://islamqa.info/ar/answers/221758$x$, $x$Accord : pas de zakāt sur ce qui n'est pas or ou argent ; zakāt sur le bijou interdit et sur celui destiné au commerce ou à l'épargne. Divergence sur le bijou porté : majorité (non) ; ḥanafites, Ibn Bāz, Ibn ʿUthaymīn, Comité permanent (oui). Conclusion : mieux vaut payer par précaution.$x$),
  (8, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Al-Mawsūʿa al-fiqhiyya : la zakāt des bijoux portés$x$, $x$Dorar al-Saniyya$x$, $x$Section 2134$x$, $x$https://dorar.net/feqhia/2134$x$, $x$Divergence en plusieurs avis, dont deux principaux ; zakāt due : ḥanafites, un avis d'al-Shāfiʿī, une version d'Aḥmad, et un groupe des pieux prédécesseurs.$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$1563$x$, $x$Ḥasan selon al-Albānī ; jugé faible par d'autres$x$, $x$Jugements affichés sur sunnah.com ; IslamQA n° 221758$x$, $x$Les deux bracelets d'or de la fillette, d'après ʿAmr ibn Shuʿayb, de son père, de son grand-père$x$, null, null, $x$https://sunnah.com/abudawud:1563$x$, $x$Paroles du Prophète ﷺ copiées telles quelles de l'édition de sunnah.com (base hadith-api).$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Doit-on la zakāt sur la voiture qu'on utilise ?$x$, array[$x$Non, ce qu'on garde pour son usage n'a pas de zakāt$x$, $x$Oui, chaque année$x$, $x$Oui, si elle est neuve$x$]::text[], 0, $x$Al-Bukhārī n° 1463.$x$),
  (2, $x$Doit-on la zakāt sur un terrain acheté pour le revendre ?$x$, array[$x$Oui, c'est une marchandise de commerce$x$, $x$Non, jamais$x$, $x$Seulement s'il est construit$x$]::text[], 0, $x$IslamWeb ; Ibn Bāz (IslamQA n° 47761).$x$),
  (3, $x$À quel prix évalue-t-on les marchandises pour la zakāt ?$x$, array[$x$Au prix du jour à la fin de l'année$x$, $x$Au prix d'achat$x$, $x$Au prix le plus bas de l'année$x$]::text[], 0, $x$Al-Alūka ; Ibn Bāz.$x$),
  (4, $x$Quel est le degré du hadith de Samura sur les marchandises ?$x$, array[$x$Jugé faible par al-Albānī et d'autres$x$, $x$Authentique selon tous$x$, $x$Inventé$x$]::text[], 0, $x$Abū Dāwūd n° 1562 ; Ibn Bāz le cite avec un témoin.$x$),
  (5, $x$Doit-on la zakāt sur des bijoux en perles portés ?$x$, array[$x$Non, ils ne sont ni en or ni en argent, sauf s'ils sont pour le commerce$x$, $x$Oui, toujours$x$, $x$Oui, plus que l'or$x$]::text[], 0, $x$Accord des savants (IslamQA n° 221758).$x$),
  (6, $x$Sur les bijoux d'or gardés comme épargne, que disent les savants ?$x$, array[$x$Ils sont d'accord : zakāt due$x$, $x$Ils sont d'accord : pas de zakāt$x$, $x$Ils ne disent rien$x$]::text[], 0, $x$IslamQA n° 221758.$x$),
  (7, $x$Que pense la majorité des mālikites, shāfiʿites et ḥanbalites des bijoux portés ?$x$, array[$x$Pas de zakāt$x$, $x$Zakāt due$x$, $x$Zakāt doublée$x$]::text[], 0, $x$IslamQA n° 221758 ; Dorar.$x$),
  (8, $x$Quel avis retiennent Ibn Bāz et Ibn ʿUthaymīn pour les bijoux portés ?$x$, array[$x$La zakāt est due$x$, $x$Pas de zakāt$x$, $x$Ils ne se sont pas prononcés$x$]::text[], 0, $x$IslamQA n° 221758 ; Abū Dāwūd n° 1563.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Zakāt 3$x$),
       rv.h = '230b8e87653d030fa356795e34c870f0' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
