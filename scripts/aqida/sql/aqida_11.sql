-- Croyance 11 : les-annulatifs-de-l-islam
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$les-annulatifs-de-l-islam$x$, 'lesson', $x$aqida$x$, 'fr', 11) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Les dix annulatifs de l'islam$x$, $x$Les dix choses qui font sortir de l'islam, citées par Muḥammad ibn ʿAbd al-Wahhāb et expliquées par Ibn Bāz, apprises pour s'en préserver soi-même ; avec la mise en garde contre le fait de juger les gens soi-même.$x$, $x$1. Pourquoi apprendre cette leçon ?
Ibn Bāz explique qu'Allah a obligé tous les hommes à entrer dans l'islam, à s'y attacher et à se garder de ce qui le contredit. Les savants ont mentionné qu'un musulman peut sortir de sa religion par de nombreux annulatifs (nawāqiḍ) ; parmi les plus graves et les plus fréquents, il y en a dix, cités par Muḥammad ibn ʿAbd al-Wahhāb et d'autres savants. Ibn Bāz dit qu'il les présente pour que le musulman s'en garde et en préserve les autres, en espérant le salut. Le but de cette leçon est donc de se protéger soi-même, pas de juger les gens.

2. Les dix annulatifs (d'après Ibn Bāz)
1) Le shirk dans l'adoration d'Allah : par exemple invoquer les morts, leur demander secours, leur faire des vœux ou leur sacrifier des bêtes (4:48 ; 5:72 ; voir la leçon sur le shirk).
2) Mettre entre soi et Allah des intermédiaires qu'on invoque, à qui on demande l'intercession et sur qui on s'appuie. Ibn Bāz rapporte que c'est de la mécréance par consensus des savants.
3) Ne pas considérer comme mécréants les polythéistes, douter de leur mécréance, ou juger leur croyance correcte.
4) Croire qu'une autre guidance est plus parfaite que celle du Prophète ﷺ, ou qu'un autre jugement est meilleur que le sien.
5) Détester une chose que le Messager ﷺ a apportée, même si on la pratique (sourate Muḥammad, 47:9).
6) Se moquer d'une chose de la religion du Messager ﷺ, de sa récompense ou de son châtiment (sourate al-Tawba, 9:65-66).
7) La sorcellerie : la pratiquer ou l'accepter (sourate al-Baqara, 2:102).
8) Soutenir les polythéistes et les aider contre les musulmans (sourate al-Māʾida, 5:51).
9) Croire que certaines personnes peuvent se passer de la législation de Muḥammad ﷺ (sourate Āl ʿImrān, 3:85).
10) Se détourner de la religion d'Allah : ne pas l'apprendre et ne pas la pratiquer (sourate al-Sajda, 32:22).
Ibn Bāz ajoute qu'il n'y a pas de différence, pour ces annulatifs, entre celui qui plaisante, celui qui est sérieux et celui qui a peur, sauf celui qui est contraint (voir sourate al-Naḥl, 16:106). Il conclut que le musulman doit s'en garder et les craindre pour lui-même.

3. Ne pas se presser de juger les autres
a) Le Prophète ﷺ a dit :
« أَيُّمَا رَجُلٍ قَالَ لأَخِيهِ يَا كَافِرُ‏.‏ فَقَدْ بَاءَ بِهَا أَحَدُهُمَا » (ayyumā rajulin qāla li-akhīhi : yā kāfir, fa-qad bā’a bihā aḥaduhumā).
Sens : « Quiconque dit à son frère : « Ô mécréant ! », l'un des deux en porte la charge. » (al-Bukhārī n° 6104, d'après Ibn ʿUmar ; hadith authentique).
b) Ibn Taymiyya a écrit qu'une parole peut être de la mécréance, et qu'on dit d'une manière générale : celui qui dit cela est mécréant ; mais que la personne précise n'est pas jugée mécréante tant que l'argument (al-ḥujja) ne lui a pas été établi. Interrogé sur cette parole, Ibn Bāz a répondu que c'est la position correcte, en précisant qu'on explique d'abord à celui qui ignore, par exemple s'il vit loin des musulmans (fatwa n° 17382).
c) Les savants ont étudié en détail quand l'ignorance excuse et quand elle n'excuse pas. Ibn Bāz, par exemple, considère que celui qui vit parmi les musulmans et a entendu le Coran n'est pas excusé dans les questions du tawḥīd (fatwa n° 2351). C'est une question délicate. Juger une personne précise et en tirer les conséquences relève des savants, des juges et des autorités légitimes, comme le dit Ibn Bāz dans cette même fatwa, et non de l'élève ni du simple musulman.

4. Ce que l'élève peut retenir
- On apprend les dix annulatifs pour s'en préserver soi-même et protéger les autres.
- Plaisanterie, sérieux ou peur ne changent rien, sauf la contrainte.
- On ne dit pas à un musulman « mécréant » : l'un des deux en porterait la charge.
- Juger une personne précise relève des savants et des autorités légitimes.

Exercice : citez les dix annulatifs avec la preuve de ceux qui en ont une, puis répondez aux questions. Pour toute situation précise, interrogez un savant qualifié.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Nawāqiḍ al-islām (les annulatifs de l'islam), avec explications$x$, $x$Ibn Bāz, d'après Muḥammad ibn ʿAbd al-Wahhāb$x$, $x$Article n° 20 du site officiel du cheikh Ibn Bāz$x$, $x$https://binbaz.org.sa/articles/20/نواقض-الاسلام$x$, $x$Les dix annulatifs avec leurs preuves ; pas de différence entre plaisanterie, sérieux et peur, sauf la contrainte ; ce sont parmi les plus graves et les plus fréquents ; le musulman doit s'en garder et les craindre pour lui-même.$x$),
  (2, $x$quran$x$::public.reference_kind, 4::int, 48::int, 48::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 5::int, 72::int, 72::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 47::int, 9::int, 9::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$quran$x$::public.reference_kind, 9::int, 65::int, 66::int, null, null, null, null, null, null, null, null, null, null),
  (6, $x$quran$x$::public.reference_kind, 2::int, 102::int, 102::int, null, null, null, null, null, null, null, null, null, null),
  (7, $x$quran$x$::public.reference_kind, 5::int, 51::int, 51::int, null, null, null, null, null, null, null, null, null, null),
  (8, $x$quran$x$::public.reference_kind, 3::int, 85::int, 85::int, null, null, null, null, null, null, null, null, null, null),
  (9, $x$quran$x$::public.reference_kind, 32::int, 22::int, 22::int, null, null, null, null, null, null, null, null, null, null),
  (10, $x$quran$x$::public.reference_kind, 16::int, 106::int, 106::int, null, null, null, null, null, null, null, null, null, null),
  (11, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6104$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Quiconque dit à son frère : ô mécréant », d'après Ibn ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:6104$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (12, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 17382 : « Ḥukm man irtakaba amran jāhilan yukaffaru fāʿiluh » (celui qui commet par ignorance un acte de mécréance)$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh, émission Nūr ʿalā al-darb$x$, $x$https://binbaz.org.sa/fatwas/17382/$x$, $x$Approuve la parole d'Ibn Taymiyya : une parole peut être de la mécréance, mais la personne précise n'est jugée mécréante qu'une fois l'argument établi ; on explique d'abord à celui qui ignore.$x$),
  (13, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Fatwa n° 2351 : « Umūr al-tawḥīd… lā ʿudhra fīhā » (les questions du tawḥīd, sans excuse)$x$, $x$Ibn Bāz$x$, $x$Site officiel du cheikh$x$, $x$https://binbaz.org.sa/fatwas/2351/$x$, $x$Celui qui vit parmi les musulmans et a entendu le Coran n'est pas excusé dans les questions du tawḥīd ; celui qui vit loin des musulmans relève du jugement d'Allah ; les conséquences relèvent des autorités légitimes.$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Pourquoi apprend-on les annulatifs de l'islam, selon Ibn Bāz ?$x$, array[$x$Pour s'en garder soi-même et en préserver les autres$x$, $x$Pour juger les gens$x$, $x$Pour polémiquer$x$]::text[], 0, $x$Introduction d'Ibn Bāz.$x$),
  (2, $x$Quel est le premier des dix annulatifs ?$x$, array[$x$Le shirk dans l'adoration d'Allah$x$, $x$Oublier une prière$x$, $x$Manger en Ramaḍān par oubli$x$]::text[], 0, $x$Sourate al-Nisā’, 4:48.$x$),
  (3, $x$Se moquer d'une chose de la religion, est-ce grave ?$x$, array[$x$Oui, c'est un annulatif de l'islam$x$, $x$Non, si c'est pour rire$x$, $x$Seulement en public$x$]::text[], 0, $x$Sourate al-Tawba, 9:65-66 ; la plaisanterie ne change rien.$x$),
  (4, $x$Qui n'est pas concerné, selon Ibn Bāz, quand il prononce une parole de mécréance ?$x$, array[$x$Celui qui est contraint$x$, $x$Celui qui plaisante$x$, $x$Celui qui a peur d'être critiqué$x$]::text[], 0, $x$Voir sourate al-Naḥl, 16:106.$x$),
  (5, $x$Que dit le hadith d'al-Bukhārī n° 6104 ?$x$, array[$x$Celui qui dit à son frère « ô mécréant », l'un des deux en porte la charge$x$, $x$On peut traiter quelqu'un de mécréant librement$x$, $x$Rien sur ce sujet$x$]::text[], 0, $x$D'après Ibn ʿUmar.$x$),
  (6, $x$Selon Ibn Taymiyya, approuvé par Ibn Bāz, quand juge-t-on une personne précise mécréante ?$x$, array[$x$Après que l'argument lui a été établi$x$, $x$Dès qu'on la soupçonne$x$, $x$Jamais, quoi qu'elle fasse$x$]::text[], 0, $x$Fatwa n° 17382 d'Ibn Bāz.$x$),
  (7, $x$Qui juge une personne précise et en tire les conséquences ?$x$, array[$x$Les savants, les juges et les autorités légitimes$x$, $x$N'importe quel musulman$x$, $x$Les réseaux sociaux$x$]::text[], 0, $x$Ibn Bāz, fatwa n° 2351.$x$),
  (8, $x$Se détourner de la religion sans l'apprendre ni la pratiquer est :$x$, array[$x$Le dixième annulatif$x$, $x$Une chose sans importance$x$, $x$Un acte recommandé$x$]::text[], 0, $x$Sourate al-Sajda, 32:22.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Croyance 11$x$),
       rv.h = '5b74546adc9aff3ab06b9259c73cf02e' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
