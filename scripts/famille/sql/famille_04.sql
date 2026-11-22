-- Famille 4 : l-education-des-enfants
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$l-education-des-enfants$x$, 'lesson', $x$famille$x$, 'fr', 4) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$L'éducation des enfants$x$, $x$Préservez-vous et vos familles du Feu ; chacun est un berger responsable de son troupeau. L'enfant naît sur la fiṭra ; enseigner la prière dès sept ans ; la justice entre les enfants ; la miséricorde envers eux ; les conseils de Luqmān ; l'invocation pour une descendance pieuse.$x$, $x$1. Une responsabilité
Allah dit : ô vous qui croyez, préservez-vous, vous et vos familles, d'un Feu dont le combustible est les hommes et les pierres (sourate at-Taḥrīm, 66:6). Ordonne la prière à ta famille et sois-y constant (sourate Ṭā-Hā, 20:132).
Le Prophète ﷺ a dit : chacun de vous est un berger, et chacun est responsable de son troupeau ; l'homme est un berger dans sa famille et il en est responsable ; la femme est une bergère dans la maison de son mari et elle en est responsable (al-Bukhārī n° 893, d'après Ibn ʿUmar).

2. La fiṭra
Le Prophète ﷺ a dit :
« كُلُّ مَوْلُودٍ يُولَدُ عَلَى الْفِطْرَةِ، فَأَبَوَاهُ يُهَوِّدَانِهِ أَوْ يُنَصِّرَانِهِ أَوْ يُمَجِّسَانِهِ » (kullu mawlūdin yūladu ʿalā l-fiṭra, fa-abawāhu yuhawwidānihi aw yunaṣṣirānihi aw yumajjisānih).
Sens : « Tout enfant naît sur la nature saine (al-fiṭra) ; ce sont ses parents qui en font un juif, un chrétien ou un mazdéen. » (al-Bukhārī n° 1385, d'après Abū Hurayra ; hadith authentique).

3. La prière dès l'enfance
Le Prophète ﷺ a dit :
« مُرُوا أَوْلاَدَكُمْ بِالصَّلاَةِ وَهُمْ أَبْنَاءُ سَبْعِ سِنِينَ وَاضْرِبُوهُمْ عَلَيْهَا وَهُمْ أَبْنَاءُ عَشْرِ سِنِينَ وَفَرِّقُوا بَيْنَهُمْ فِي الْمَضَاجِعِ » (murū awlādakum bi-ṣ-ṣalāti wa hum abnā’u sabʿi sinīn, wa ḍribūhum ʿalayhā wa hum abnā’u ʿashri sinīn, wa farriqū baynahum fī l-maḍājiʿ).
Sens : « Ordonnez la prière à vos enfants quand ils ont sept ans, corrigez-les (litt. frappez-les) pour elle quand ils ont dix ans, et séparez-les dans leurs couches. » (Abū Dāwūd n° 495, d'après ʿAmr ibn Shuʿayb, de son père, de son grand-père ; « ḥasan ṣaḥīḥ » selon al-Albānī). La manière et les limites de cette correction sont expliquées par les savants : on les leur demande, et on se rappelle que le Prophète ﷺ n'a jamais rien frappé de sa main, ni femme ni serviteur, sauf en combattant dans le sentier d'Allah (Muslim n° 2328, d'après ʿĀ’isha).

4. La justice entre les enfants
Le père d'an-Nuʿmān ibn Bashīr fit un don à son fils et voulut prendre le Prophète ﷺ à témoin. Celui-ci demanda : as-tu donné la même chose à tous tes enfants ? Il répondit non. Il dit :
« فَاتَّقُوا اللَّهَ، وَاعْدِلُوا بَيْنَ أَوْلاَدِكُمْ » (fa-ttaqū llāha wa ʿdilū bayna awlādikum).
Sens : « Craignez Allah et soyez justes entre vos enfants. » Il reprit alors son don (al-Bukhārī n° 2587 ; hadith authentique).

5. La miséricorde et l'enseignement
Le Prophète ﷺ embrassait ses petits-enfants et disait : celui qui ne fait pas miséricorde, on ne lui fera pas miséricorde (al-Bukhārī n° 5997). Il enseignait aux enfants avec douceur : « ô garçon, dis Bismillāh, mange de ta main droite et mange de ce qui est devant toi » (al-Bukhārī n° 5376, à ʿUmar ibn Abī Salama ; voir la leçon « Le salut et les manières de la table »).
Luqmān conseilla son fils : ne pas associer à Allah, être bon envers ses parents, savoir qu'Allah voit tout, accomplir la prière, ordonner le bien et interdire le mal, être patient, ne pas être arrogant, et baisser la voix (sourate Luqmān, 31:13-19).
L'enfant pieux qui invoque pour ses parents fait partie des œuvres qui continuent après la mort (Muslim n° 1631).

6. L'invocation
Allah rapporte l'invocation des serviteurs du Tout Miséricordieux : Seigneur, donne-nous, en nos épouses et nos descendants, la joie de nos yeux, et fais de nous un modèle pour les pieux (sourate al-Furqān, 25:74).

7. Ce que l'élève peut retenir
- Les parents sont responsables de l'éducation religieuse de leurs enfants.
- On enseigne la prière dès sept ans, avec patience.
- On est juste entre ses enfants, même dans les cadeaux.
- On éduque avec miséricorde et douceur, à l'exemple du Prophète ﷺ et de Luqmān.
- On invoque Allah pour une descendance pieuse.

Exercice : choisissez un conseil de Luqmān (31:13-19) et expliquez-le à un enfant de votre famille cette semaine, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 66::int, 6::int, 6::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 20::int, 132::int, 132::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$893$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Chacun de vous est un berger », d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:893$x$, null),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1385$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Tout enfant naît sur la fiṭra, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:1385$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$495$x$, $x$Ḥasan ṣaḥīḥ (al-Albānī) ; authentique (Zubayr ʿAlī Zaʾī)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$Ordonner la prière aux enfants à sept ans, d'après ʿAmr ibn Shuʿayb$x$, null, null, $x$https://sunnah.com/abudawud:495$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2328$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Le Prophète ﷺ n'a jamais frappé de sa main ni femme ni serviteur, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/muslim:2328$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2587$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Soyez justes entre vos enfants », d'après an-Nuʿmān ibn Bashīr$x$, null, null, $x$https://sunnah.com/bukhari:2587$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5997$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le baiser à al-Ḥasan, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5997$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5376$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ô garçon, dis Bismillāh », d'après ʿUmar ibn Abī Salama$x$, null, null, $x$https://sunnah.com/bukhari:5376$x$, null),
  (10, $x$quran$x$::public.reference_kind, 31::int, 13::int, 19::int, null, null, null, null, null, null, null, null, null, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1631$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Les œuvres qui continuent après la mort, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:1631$x$, null),
  (12, $x$quran$x$::public.reference_kind, 25::int, 74::int, 74::int, null, null, null, null, null, null, null, null, null, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que demande Allah aux croyants envers leurs familles en 66:6 ?$x$, array[$x$De les préserver du Feu$x$, $x$De les laisser faire$x$, $x$Rien$x$]::text[], 0, $x$Sourate at-Taḥrīm, 66:6.$x$),
  (2, $x$Que dit le hadith « chacun de vous est un berger » ?$x$, array[$x$Chacun est responsable de ceux dont il a la charge$x$, $x$Il faut élever des moutons$x$, $x$Personne n'est responsable$x$]::text[], 0, $x$Al-Bukhārī n° 893.$x$),
  (3, $x$Sur quoi naît tout enfant ?$x$, array[$x$Sur la fiṭra (la nature saine)$x$, $x$Sur l'ignorance$x$, $x$Sur le mal$x$]::text[], 0, $x$Al-Bukhārī n° 1385.$x$),
  (4, $x$À quel âge ordonne-t-on la prière à l'enfant selon le hadith ?$x$, array[$x$Sept ans$x$, $x$Quinze ans$x$, $x$Trois ans$x$]::text[], 0, $x$Abū Dāwūd n° 495.$x$),
  (5, $x$Que dit ʿĀ’isha du Prophète ﷺ ?$x$, array[$x$Il n'a jamais frappé de sa main ni femme ni serviteur$x$, $x$Il frappait souvent$x$, $x$Elle n'en parle pas$x$]::text[], 0, $x$Muslim n° 2328.$x$),
  (6, $x$Que dit le Prophète ﷺ au père qui avait donné un cadeau à un seul de ses enfants ?$x$, array[$x$Soyez justes entre vos enfants$x$, $x$C'est permis$x$, $x$Donne-lui encore plus$x$]::text[], 0, $x$Al-Bukhārī n° 2587.$x$),
  (7, $x$Lequel de ces conseils Luqmān donna-t-il à son fils ?$x$, array[$x$Accomplir la prière et être patient$x$, $x$Élever la voix$x$, $x$Être arrogant$x$]::text[], 0, $x$Sourate Luqmān, 31:13-19.$x$),
  (8, $x$Que demandent les serviteurs du Tout Miséricordieux pour leurs familles ?$x$, array[$x$Que leurs épouses et descendants soient la joie de leurs yeux$x$, $x$La richesse seulement$x$, $x$Rien$x$]::text[], 0, $x$Sourate al-Furqān, 25:74.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Famille 4$x$),
       rv.h = 'c8d159de9fa63c2c53a8d38565e2612d' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
