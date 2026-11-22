-- Bonnes manières 20 : ordonner-le-bien-et-interdire-le-mal-avec-sagesse
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$ordonner-le-bien-et-interdire-le-mal-avec-sagesse$x$, 'lesson', $x$adab$x$, 'fr', 20) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Ordonner le bien et interdire le mal, avec sagesse et douceur$x$, $x$Les croyants ordonnent le bien et interdisent le mal ; on appelle avec sagesse et bonne exhortation. Les trois degrés (la main, la langue, le cœur) et leurs limites expliquées par Ibn Bāz ; la parabole du navire ; la douceur embellit toute chose ; « la religion, c'est le bon conseil ».$x$, $x$1. Une qualité des croyants
Allah dit que les croyants et les croyantes sont alliés les uns des autres : ils ordonnent le convenable et interdisent le blâmable (sourate at-Tawba, 9:71). Qu'il y ait parmi vous une communauté qui appelle au bien (sourate Āl ʿImrān, 3:104). Vous êtes la meilleure communauté sortie pour les hommes : vous ordonnez le convenable et interdisez le blâmable (3:110).
La manière : appelle au chemin de ton Seigneur par la sagesse et la bonne exhortation, et discute avec eux de la meilleure façon (sourate an-Naḥl, 16:125). Allah ordonna à Mūsā et Hārūn de parler à Pharaon avec douceur (sourate Ṭā-Hā, 20:44).

2. Les trois degrés
Le Prophète ﷺ a dit :
« مَنْ رَأَى مِنْكُمْ مُنْكَرًا فَلْيُغَيِّرْهُ بِيَدِهِ فَإِنْ لَمْ يَسْتَطِعْ فَبِلِسَانِهِ فَإِنْ لَمْ يَسْتَطِعْ فَبِقَلْبِهِ وَذَلِكَ أَضْعَفُ الإِيمَانِ » (man ra’ā minkum munkaran fa-l-yughayyirhu bi-yadih, fa-in lam yastaṭiʿ fa-bi-lisānih, fa-in lam yastaṭiʿ fa-bi-qalbih, wa dhālika aḍʿafu l-īmān).
Sens : « Que celui d'entre vous qui voit un mal le change par sa main ; s'il ne le peut pas, par sa langue ; s'il ne le peut pas, par son cœur, et c'est là le plus faible de la foi. » (Muslim n° 49, d'après Abū Saʿīd al-Khudrī ; voir la leçon sur le hadith 34 des Quarante d'an-Nawawī).

3. Les limites expliquées par Ibn Bāz
Cheikh Ibn Bāz a expliqué que chacun change le mal selon sa capacité, mais que le changement par la main suppose une capacité qui n'entraîne pas un mal plus grand : on change par la main chez soi (envers ses enfants, son épouse, ceux qui sont sous son autorité), et le responsable chargé officiellement de cette mission agit selon les pouvoirs qui lui ont été donnés ; celui qui n'a pas ce pouvoir ne change pas par la main, mais par la parole, en rappelant la règle avec ses preuves (binbaz.org.sa, fatwa n° 2112). Il a aussi expliqué que si le changement par la main entraîne la discorde et les affrontements, on ne le fait pas : on se contente de la parole, pour ne pas provoquer un mal plus grand que celui qu'on combat ; puis vient le cœur, qui déteste le mal et ne s'assoit pas avec ceux qui le commettent (Majmūʿ fatāwā Ibn Bāz 6/64, fatwa n° 1560 de son site).

4. La parabole du navire
Le Prophète ﷺ compara celui qui respecte les limites d'Allah et celui qui les transgresse à des gens qui ont tiré au sort leurs places sur un navire : les uns en haut, les autres en bas. Ceux du bas, pour prendre de l'eau, passaient devant ceux du haut ; ils dirent : si nous faisions un trou dans notre part, nous ne gênerions pas ceux d'en haut. S'ils les laissent faire, tous périssent ; s'ils les retiennent, tous sont sauvés (al-Bukhārī n° 2493, d'après an-Nuʿmān ibn Bashīr).

5. La douceur
Le Prophète ﷺ a dit :
« إِنَّ الرِّفْقَ لاَ يَكُونُ فِي شَىْءٍ إِلاَّ زَانَهُ وَلاَ يُنْزَعُ مِنْ شَىْءٍ إِلاَّ شَانَهُ » (inna r-rifqa lā yakūnu fī shay’in illā zānah, wa lā yunzaʿu min shay’in illā shānah).
Sens : « La douceur n'est dans une chose sans l'embellir, et elle n'en est retirée sans l'enlaidir. » (Muslim n° 2594, d'après ʿĀ’isha ; hadith authentique).
Il a dit aussi à ʿĀ’isha : Allah est doux et aime la douceur en toute chose (al-Bukhārī n° 6927). Voir aussi le bédouin dans la mosquée, traité avec douceur (al-Bukhārī n° 220 ; leçon « Les manières de la mosquée »).

6. Le bon conseil
Le Prophète ﷺ a dit : la religion, c'est le bon conseil (an-naṣīḥa). On demanda : pour qui ? Il répondit : pour Allah, Son Livre, Son Messager, les dirigeants des musulmans et l'ensemble des musulmans (Muslim n° 55, d'après Tamīm ad-Dārī ; voir la leçon sur le hadith 7 des Quarante d'an-Nawawī).

7. Ce que l'élève peut retenir
- Ordonner le bien et interdire le mal est une qualité des croyants.
- On le fait avec sagesse, bonne exhortation et douceur.
- La main dans les limites de son autorité, sans provoquer un mal plus grand ; sinon la parole ; au moins le cœur.
- Laisser faire le mal met en danger toute la société.

Exercice : pensez à une situation où vous avez vu un mal cette semaine et à la manière douce et sage d'en parler, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 9::int, 71::int, 71::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 3::int, 104::int, 104::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 3::int, 110::int, 110::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 16::int, 125::int, 125::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$quran$x$::public.reference_kind, 20::int, 44::int, 44::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$49a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Que celui d'entre vous qui voit un mal le change… », d'après Abū Saʿīd al-Khudrī$x$, null, null, $x$https://sunnah.com/muslim:49a$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (7, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le changement du mal par la main revient-il à chacun ?$x$, $x$ʿAbd al-ʿAzīz ibn Bāz$x$, $x$Fatwa n° 2112, site officiel binbaz.org.sa$x$, $x$https://binbaz.org.sa/fatwas/2112$x$, $x$Par la main selon la capacité et l'autorité (chez soi, responsable mandaté), sans mal plus grand ; sinon par la parole.$x$),
  (8, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Le jugement du changement du mal par la main$x$, $x$ʿAbd al-ʿAzīz ibn Bāz$x$, $x$Majmūʿ fatāwā wa maqālāt 6/64 ; fatwa n° 1560, binbaz.org.sa$x$, $x$https://binbaz.org.sa/fatwas/1560$x$, $x$Si la main entraîne discorde et affrontements, on se contente de la parole ; puis le cœur.$x$),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2493$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La parabole du navire, d'après an-Nuʿmān ibn Bashīr$x$, null, null, $x$https://sunnah.com/bukhari:2493$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2594a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$La douceur embellit toute chose, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/muslim:2594a$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6927$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Allah est doux et aime la douceur en toute chose », d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/bukhari:6927$x$, null),
  (12, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$220$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le bédouin dans la mosquée, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:220$x$, null),
  (13, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$55a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« La religion, c'est le bon conseil », d'après Tamīm ad-Dārī$x$, null, null, $x$https://sunnah.com/muslim:55a$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quelle qualité des croyants est citée dans 9:71 ?$x$, array[$x$Ils ordonnent le convenable et interdisent le blâmable$x$, $x$Ils se taisent devant le mal$x$, $x$Ils ne s'occupent que d'eux-mêmes$x$]::text[], 0, $x$Sourate at-Tawba, 9:71.$x$),
  (2, $x$Comment appeler au chemin d'Allah selon 16:125 ?$x$, array[$x$Par la sagesse et la bonne exhortation$x$, $x$Par la violence$x$, $x$Par l'insulte$x$]::text[], 0, $x$Sourate an-Naḥl, 16:125.$x$),
  (3, $x$Quel est le degré le plus faible de la foi dans le hadith d'Abū Saʿīd ?$x$, array[$x$Changer le mal par le cœur$x$, $x$Changer par la main$x$, $x$Changer par la langue$x$]::text[], 0, $x$Muslim n° 49.$x$),
  (4, $x$Selon Ibn Bāz, où peut-on changer le mal par la main ?$x$, array[$x$Dans les limites de son autorité, comme chez soi, sans provoquer un mal plus grand$x$, $x$Partout et sur tout le monde$x$, $x$Jamais$x$]::text[], 0, $x$Ibn Bāz, fatwa n° 2112.$x$),
  (5, $x$Que fait-on si le changement par la main entraîne la discorde et les affrontements ?$x$, array[$x$On se contente de la parole$x$, $x$On insiste par la force$x$, $x$On abandonne même le cœur$x$]::text[], 0, $x$Ibn Bāz, Majmūʿ fatāwā 6/64.$x$),
  (6, $x$Que montre la parabole du navire ?$x$, array[$x$Laisser faire le mal met tout le monde en danger$x$, $x$Chacun peut faire ce qu'il veut$x$, $x$Il ne faut pas voyager en bateau$x$]::text[], 0, $x$Al-Bukhārī n° 2493.$x$),
  (7, $x$Que fait la douceur à une chose selon le hadith ?$x$, array[$x$Elle l'embellit$x$, $x$Elle l'enlaidit$x$, $x$Rien$x$]::text[], 0, $x$Muslim n° 2594.$x$),
  (8, $x$Qu'est-ce que la religion selon le hadith de Tamīm ad-Dārī ?$x$, array[$x$Le bon conseil$x$, $x$La dureté$x$, $x$Le silence$x$]::text[], 0, $x$Muslim n° 55.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 20$x$),
       rv.h = 'e3ad3e023314073ab9211853c71a750c' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
