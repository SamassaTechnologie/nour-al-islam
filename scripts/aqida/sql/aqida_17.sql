-- Croyance 17 : la-foi-al-iman-parole-croyance-et-actes
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$la-foi-al-iman-parole-croyance-et-actes$x$, 'lesson', $x$aqida$x$, 'fr', 17) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Qu'est-ce que la foi (al-īmān) ? Parole, croyance et actes ; elle augmente et diminue$x$, $x$Selon Ahl as-Sunna, la foi est parole du cœur et de la langue, et acte du cœur et des membres ; elle augmente par l'obéissance et diminue par la désobéissance. Les branches de la foi, la prière appelée foi, le grand péché qui diminue la foi sans faire sortir de l'islam, et l'avis des « murji'a des juristes » (deux appréciations).$x$, $x$1. La définition d'Ahl as-Sunna
Ibn Bāz : selon Ahl as-Sunna wa l-Jamāʿa, la foi est parole et acte : parole du cœur et de la langue, et acte du cœur et des membres ; elle augmente par les obéissances et diminue par les désobéissances ; c'est ce qu'indiquent le Livre d'Allah et la Sunna (binbaz.org.sa, fatwa n° 20919).
Autrement dit, elle comprend quatre choses : la croyance du cœur (sa « parole »), la parole de la langue, les actes du cœur et les actes des membres (comme la prière, le jeûne, la zakāt, le pèlerinage) (IslamWeb, cours audio n° 190237).

2. Les branches de la foi
Le Prophète ﷺ dit :
« الإِيمَانُ بِضْعٌ وَسَبْعُونَ أَوْ بِضْعٌ وَسِتُّونَ شُعْبَةً فَأَفْضَلُهَا قَوْلُ لاَ إِلَهَ إِلاَّ اللَّهُ وَأَدْنَاهَا إِمَاطَةُ الأَذَى عَنِ الطَّرِيقِ وَالْحَيَاءُ شُعْبَةٌ مِنَ الإِيمَانِ » (al-īmānu biḍʿun wa sabʿūna aw biḍʿun wa sittūna shuʿba, fa-afḍaluhā qawlu lā ilāha illā llāh, wa adnāhā imāṭatu l-adhā ʿani ṭ-ṭarīq, wa l-ḥayā’u shuʿbatun mina l-īmān).
Sens : « La foi comprend soixante-dix et quelques (ou soixante et quelques) branches : la plus haute est de dire lā ilāha illā llāh, la plus basse est d'enlever ce qui gêne du chemin, et la pudeur est une branche de la foi. » (Muslim n° 35 ; hadith authentique).

3. La prière est appelée « foi »
Quand la qibla fut changée, des gens demandèrent ce qu'il en était des prières de ceux qui étaient morts avant ; Allah révéla qu'Il ne ferait pas perdre leur foi (al-Baqara 2:143), c'est-à-dire, selon le récit d'al-Barā', leurs prières vers Jérusalem (al-Bukhārī n° 40).

4. La foi augmente
Allah dit que les croyants, quand Ses versets leur sont récités, voient leur foi augmenter (al-Anfāl 8:2 ; voir aussi at-Tawba 9:124, al-Fatḥ 48:4, al-Muddaththir 74:31).
Des Compagnons ont dit que la foi augmente et diminue, dont Abū ad-Dardā' et Abū Hurayra ; et ʿUmar disait à ses compagnons : venez, augmentons notre foi, et ils évoquaient Allah (Ibn Taymiyya, Majmūʿ al-fatāwā, vol. 7).

5. La foi diminue
Le Prophète ﷺ dit :
« لاَ يَزْنِي الزَّانِي حِينَ يَزْنِي وَهْوَ مُؤْمِنٌ » (lā yaznī z-zānī ḥīna yaznī wahwa mu’min).
Sens : « Le fornicateur ne fornique pas, au moment où il fornique, en étant croyant » ; de même pour celui qui boit l'alcool et celui qui vole (al-Bukhārī n° 2475 ; hadith authentique).
Pour Ahl as-Sunna, ce hadith ne fait pas sortir de l'islam l'auteur d'un grand péché : il perd la foi complète, pas l'islam ; seule la mécréance fait sortir de l'islam (parole d'Abū Jaʿfar Muḥammad ibn ʿAlī, rapportée par Ibn Taymiyya, Majmūʿ al-fatāwā, vol. 7). Celui qui a dans le cœur le poids d'un grain de moutarde de foi sera sorti de l'Enfer (al-Bukhārī n° 22).

6. L'avis des « murji'a des juristes »
Certains savants, appelés « murji'a des juristes », disent que la foi est la croyance et la parole, et que les actes n'en font pas partie, tout en disant que celui qui délaisse un devoir mérite le châtiment (IslamWeb, cours audio n° 139340). Deux appréciations :
- Ibn Taymiyya : une grande partie de la divergence avec eux est dans les mots ; les Salaf ne les ont pas déclarés mécréants, mais le mot conforme au Coran et à la Sunna est le juste (Majmūʿ al-fatāwā, vol. 7) ;
- Ibn Bāz : la divergence n'est pas seulement verbale, elle est réelle ; Ahl as-Sunna disent que la foi est parole et acte, qui augmente et diminue (binbaz.org.sa, fatwa n° 20964).

7. Ce que l'élève peut retenir
- La foi : parole du cœur et de la langue, actes du cœur et des membres.
- Elle augmente par l'obéissance et diminue par la désobéissance.
- La plus haute branche : lā ilāha illā llāh ; la plus basse : enlever ce qui gêne du chemin.
- Le grand péché diminue la foi mais ne fait pas sortir de l'islam.

Exercice : citez une action qui augmente votre foi pour chacune des quatre parties (croyance du cœur, parole, acte du cœur, acte des membres). Puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La croyance des murji'a et son jugement$x$, $x$ʿAbd al-ʿAzīz ibn Bāz$x$, $x$Fatwa n° 20919, binbaz.org.sa$x$, $x$https://binbaz.org.sa/fatwas/20919$x$, $x$La foi : parole et acte, du cœur, de la langue et des membres ; augmente et diminue.$x$),
  (2, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Définition de la foi$x$, $x$IslamWeb (cours audio)$x$, $x$Cours n° 190237$x$, $x$https://audio.islamweb.net/audio/Fulltxt.php?audioid=190237$x$, $x$Quatre parties : croyance du cœur, parole de la langue, actes du cœur, actes des membres.$x$),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$35b$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Les branches de la foi, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:35b$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (4, $x$quran$x$::public.reference_kind, 2::int, 143::int, 143::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$40$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le changement de qibla et la révélation de 2:143, d'après al-Barā'$x$, null, null, $x$https://sunnah.com/bukhari:40$x$, null),
  (6, $x$quran$x$::public.reference_kind, 8::int, 2::int, 2::int, null, null, null, null, null, null, null, null, null, null),
  (7, $x$quran$x$::public.reference_kind, 9::int, 124::int, 124::int, null, null, null, null, null, null, null, null, null, null),
  (8, $x$quran$x$::public.reference_kind, 48::int, 4::int, 4::int, null, null, null, null, null, null, null, null, null, null),
  (9, $x$quran$x$::public.reference_kind, 74::int, 31::int, 31::int, null, null, null, null, null, null, null, null, null, null),
  (10, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Majmūʿ al-fatāwā, vol. 7 : la foi augmente et diminue$x$, $x$Ibn Taymiyya$x$, $x$Kitāb al-īmān (Wikisource arabe)$x$, $x$https://ar.wikisource.org/wiki/مجموع_الفتاوى/المجلد_السابع$x$, $x$Paroles d'Abū ad-Dardā', Abū Hurayra, ʿUmar ; parole d'Abū Jaʿfar sur le grand péché ; murji'a des juristes non déclarés mécréants.$x$),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2475$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Le fornicateur ne fornique pas en étant croyant », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:2475$x$, $x$Début de la parole copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$22$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Un grain de moutarde de foi, d'après Abū Saʿīd al-Khudrī$x$, null, null, $x$https://sunnah.com/bukhari:22$x$, null),
  (13, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La réalité de la foi et la divergence à son sujet$x$, $x$IslamWeb (cours audio)$x$, $x$Cours n° 139340$x$, $x$https://audio.islamweb.net/audio/lectures/fullcontent/139340$x$, $x$Les murji'a des juristes ; la divergence verbale selon Ibn Taymiyya (Kitāb al-īmān).$x$),
  (14, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$La divergence avec les murji'a des juristes est-elle seulement verbale ?$x$, $x$ʿAbd al-ʿAzīz ibn Bāz$x$, $x$Fatwa n° 20964, binbaz.org.sa$x$, $x$https://binbaz.org.sa/fatwas/20964$x$, $x$Elle n'est pas seulement verbale, elle est réelle.$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Selon Ahl as-Sunna, de quoi se compose la foi ?$x$, array[$x$Parole et actes : du cœur, de la langue et des membres$x$, $x$Seulement de la croyance du cœur$x$, $x$Seulement des actes$x$]::text[], 0, $x$Ibn Bāz, fatwa n° 20919.$x$),
  (2, $x$La foi augmente-t-elle et diminue-t-elle ?$x$, array[$x$Oui : par l'obéissance et la désobéissance$x$, $x$Non, elle ne change jamais$x$, $x$Elle augmente seulement$x$]::text[], 0, $x$Al-Anfāl 8:2 ; Ibn Bāz, fatwa n° 20919.$x$),
  (3, $x$Quelle est la plus haute branche de la foi ?$x$, array[$x$Dire lā ilāha illā llāh$x$, $x$Enlever ce qui gêne du chemin$x$, $x$La pudeur$x$]::text[], 0, $x$Muslim n° 35.$x$),
  (4, $x$Quelle est la plus basse branche de la foi ?$x$, array[$x$Enlever ce qui gêne du chemin$x$, $x$Le jeûne$x$, $x$Le pèlerinage$x$]::text[], 0, $x$Muslim n° 35.$x$),
  (5, $x$Qu'a appelé Allah « votre foi » en 2:143, selon le récit d'al-Barā' ?$x$, array[$x$Leurs prières vers Jérusalem$x$, $x$Leur argent$x$, $x$Leurs maisons$x$]::text[], 0, $x$Al-Bukhārī n° 40.$x$),
  (6, $x$L'auteur d'un grand péché sort-il de l'islam selon Ahl as-Sunna ?$x$, array[$x$Non, sa foi diminue$x$, $x$Oui, toujours$x$, $x$Seulement s'il est riche$x$]::text[], 0, $x$Al-Bukhārī n° 2475 et 22 ; Ibn Taymiyya.$x$),
  (7, $x$Que disent les « murji'a des juristes » ?$x$, array[$x$Que les actes ne font pas partie de la foi$x$, $x$Que la foi n'existe pas$x$, $x$Que la prière n'est pas obligatoire$x$]::text[], 0, $x$IslamWeb, cours audio n° 139340.$x$),
  (8, $x$Selon Ibn Bāz, la divergence avec eux est-elle seulement verbale ?$x$, array[$x$Non, elle est réelle$x$, $x$Oui, seulement verbale$x$, $x$Il n'en a pas parlé$x$]::text[], 0, $x$Ibn Bāz, fatwa n° 20964.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Croyance 17$x$),
       rv.h = '3051371b41ead8bc2e3fd7547dd90234' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
