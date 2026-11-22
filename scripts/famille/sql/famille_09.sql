-- Famille 9 : l-heritage-les-principes-et-les-parts-fixees-par-le-coran
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$l-heritage-les-principes-et-les-parts-fixees-par-le-coran$x$, 'lesson', $x$famille$x$, 'fr', 9) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$L'héritage (1) : les principes et les parts fixées par le Coran$x$, $x$Allah a fixé Lui-même les parts d'héritage. Le testament limité au tiers et jamais pour un héritier ; pas d'héritage entre musulman et non-musulman ; les parts des enfants, des parents, des époux et des frères et sœurs (4:11, 4:12, 4:176) ; le reste au plus proche parent homme.$x$, $x$1. Des parts fixées par Allah
Allah dit : Allah vous recommande, au sujet de vos enfants… ces parts sont obligatoires de la part d'Allah, Il est Omniscient et Sage (sourate an-Nisā’, 4:11) ; ce sont les limites d'Allah (4:13-14). Les parts ne sont donc pas choisies par la famille.
Le Prophète ﷺ a dit :
« أَلْحِقُوا الْفَرَائِضَ بِأَهْلِهَا، فَمَا بَقِيَ فَهْوَ لأَوْلَى رَجُلٍ ذَكَرٍ » (alḥiqū l-farā’iḍa bi-ahlihā, fa-mā baqiya fahwa li-awlā rajulin dhakar).
Sens : « Donnez les parts fixées à ceux qui y ont droit, et ce qui reste revient au plus proche parent de sexe masculin. » (al-Bukhārī n° 6732, d'après Ibn ʿAbbās ; hadith authentique).

2. Avant le partage : le testament et les dettes
Le Coran précise que le partage se fait après l'exécution du testament et le paiement des dettes (sourate an-Nisā’, 4:11-12).
Le testament est limité au tiers : Saʿd ibn Abī Waqqāṣ voulut léguer tous ses biens, puis la moitié ; le Prophète ﷺ refusa et dit : le tiers, et le tiers c'est beaucoup ; laisser tes héritiers riches vaut mieux que les laisser dans le besoin, à tendre la main aux gens (al-Bukhārī n° 2742).
Pas de testament pour un héritier :
« إِنَّ اللَّهَ قَدْ أَعْطَى كُلَّ ذِي حَقٍّ حَقَّهُ فَلاَ وَصِيَّةَ لِوَارِثٍ » (inna llāha qad aʿṭā kulla dhī ḥaqqin ḥaqqah, fa-lā waṣiyyata li-wārith).
Sens : « Allah a donné à chaque ayant droit son droit : pas de testament pour un héritier. » (Abū Dāwūd n° 2870, d'après Abū Umāma ; « ḥasan ṣaḥīḥ » selon al-Albānī).

3. Pas d'héritage entre musulman et non-musulman
Le Prophète ﷺ a dit :
« لاَ يَرِثُ الْمُسْلِمُ الْكَافِرَ، وَلاَ الْكَافِرُ الْمُسْلِمَ » (lā yarithu l-muslimu l-kāfir, wa lā l-kāfiru l-muslim).
Sens : « Le musulman n'hérite pas du mécréant, ni le mécréant du musulman. » (al-Bukhārī n° 6764, d'après Usāma ibn Zayd ; hadith authentique).

4. Les parts fixées par le Coran
Les enfants (4:11) :
- fils et filles ensemble : au garçon, l'équivalent de la part de deux filles ;
- seulement des filles : plus de deux, les deux tiers ; une seule, la moitié ; pour deux filles, les deux tiers aussi, par accord des savants, comme l'explique as-Saʿdī.
Les parents (4:11) :
- si le défunt a un enfant : un sixième au père et un sixième à la mère ;
- s'il n'a pas d'enfant et que ses parents héritent : un tiers à la mère ; s'il a des frères, un sixième à la mère.
Les époux (4:12) :
- le mari : la moitié si l'épouse n'a pas d'enfant, le quart si elle en a ;
- l'épouse (ou les épouses ensemble) : le quart si le mari n'a pas d'enfant, le huitième s'il en a.
Les frères et sœurs utérins (même mère seulement) quand il n'y a ni ascendant ni descendant (al-kalāla) (4:12) : un sixième pour un seul ; s'ils sont plusieurs, ils partagent un tiers.
Les frères et sœurs germains ou consanguins dans la kalāla (4:176) : une sœur, la moitié ; deux sœurs ou plus, les deux tiers ; frères et sœurs ensemble, au frère la part de deux sœurs.
Précisions d'as-Saʿdī (tafsir de 4:11-12, consultable dans l'application) : les filles du fils prennent la place des filles en leur absence ; l'« enfant » dont l'existence change les parts comprend les enfants du fils, mais pas les enfants de la fille, par accord des savants ; les frères et sœurs de 4:12 sont, par accord des savants, ceux de même mère ; et la kalāla est le cas où le défunt ne laisse ni ascendant ni descendant, comme l'a expliqué Abū Bakr.

5. Ce que l'élève peut retenir
- Les parts d'héritage sont fixées par Allah, pas par la famille.
- On exécute d'abord le testament (au plus un tiers, jamais pour un héritier) et on paie les dettes.
- Pas d'héritage entre musulman et non-musulman.
- On donne d'abord les parts fixées, puis le reste au plus proche parent homme.
La leçon suivante donnera des exemples de calcul. Pour un héritage réel, adressez-vous à un savant ou à un juge spécialisé.

Exercice : un homme meurt en laissant son épouse, un fils et une fille. Selon le verset 4:12, quelle est la part de l'épouse ? (Réponse : le huitième, car il a des enfants.) Puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 4::int, 11::int, 11::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 4::int, 12::int, 12::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 4::int, 13::int, 14::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 4::int, 176::int, 176::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6732$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Donnez les parts fixées à ceux qui y ont droit », d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/bukhari:6732$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$2742$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le testament limité au tiers, d'après Saʿd ibn Abī Waqqāṣ$x$, null, null, $x$https://sunnah.com/bukhari:2742$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$2870$x$, $x$Ḥasan ṣaḥīḥ (al-Albānī) ; ḥasan (Shuʿayb al-Arnaʾūṭ)$x$, $x$Jugements affichés sur sunnah.com$x$, $x$« Pas de testament pour un héritier », d'après Abū Umāma$x$, null, null, $x$https://sunnah.com/abudawud:2870$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6764$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Pas d'héritage entre musulman et mécréant, d'après Usāma ibn Zayd$x$, null, null, $x$https://sunnah.com/bukhari:6764$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (9, $x$book$x$::public.reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Taysīr al-Karīm ar-Raḥmān (tafsir d'as-Saʿdī), 4:11-12$x$, $x$ʿAbd ar-Raḥmān as-Saʿdī$x$, $x$Texte de QuranEnc (version 1.0.0), verrouillé dans l'application$x$, $x$https://nour-al-islam.vercel.app/coran/4/tafsir?source=saadi$x$, $x$Deux filles : deux tiers (accord) ; l'enfant comprend les enfants du fils, pas ceux de la fille (accord) ; frères et sœurs utérins en 4:12 (accord) ; définition de la kalāla par Abū Bakr.$x$)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qui a fixé les parts d'héritage ?$x$, array[$x$Allah, dans le Coran$x$, $x$La famille$x$, $x$Le plus âgé$x$]::text[], 0, $x$Sourate an-Nisā’, 4:11.$x$),
  (2, $x$Quelle est la limite du testament ?$x$, array[$x$Le tiers$x$, $x$La moitié$x$, $x$Tout le bien$x$]::text[], 0, $x$Al-Bukhārī n° 2742.$x$),
  (3, $x$Peut-on faire un testament pour un héritier ?$x$, array[$x$Non$x$, $x$Oui$x$, $x$Seulement pour le fils aîné$x$]::text[], 0, $x$Abū Dāwūd n° 2870.$x$),
  (4, $x$Le musulman hérite-t-il du non-musulman ?$x$, array[$x$Non$x$, $x$Oui$x$, $x$Seulement de ses parents$x$]::text[], 0, $x$Al-Bukhārī n° 6764.$x$),
  (5, $x$Quand il y a des fils et des filles, quelle est la part du garçon ?$x$, array[$x$Celle de deux filles$x$, $x$La même que la fille$x$, $x$Tout l'héritage$x$]::text[], 0, $x$Sourate an-Nisā’, 4:11.$x$),
  (6, $x$Quelle est la part de la fille unique sans frère ?$x$, array[$x$La moitié$x$, $x$Le tiers$x$, $x$Le quart$x$]::text[], 0, $x$Sourate an-Nisā’, 4:11.$x$),
  (7, $x$Quelle est la part de l'épouse si le mari a des enfants ?$x$, array[$x$Le huitième$x$, $x$Le quart$x$, $x$La moitié$x$]::text[], 0, $x$Sourate an-Nisā’, 4:12.$x$),
  (8, $x$À qui revient le reste après les parts fixées ?$x$, array[$x$Au plus proche parent homme$x$, $x$À l'État$x$, $x$À la mère toujours$x$]::text[], 0, $x$Al-Bukhārī n° 6732.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Famille 9$x$),
       rv.h = '2c2b97d8305be164ea066dbd0c2e778a' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
