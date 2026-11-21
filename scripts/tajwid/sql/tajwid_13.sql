-- Tajwid 13 : caracteristiques-des-lettres
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$caracteristiques-des-lettres$x$, 'lesson', 'tajwid', 'fr', 13) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Les caractéristiques des lettres (ṣifāt al-ḥurūf)$x$, $x$Ce qui distingue deux lettres sorties du même endroit : les caractéristiques qui ont un opposé (souffle, force, élévation, adhérence, aisance) et celles qui n'en ont pas (sifflement, rebond, douceur, déviation, roulement, diffusion, allongement, discrétion, ghunna).$x$, $x$Le point d'articulation dit d'où sort une lettre ; ses caractéristiques (ṣifāt) disent comment elle sort. Deux lettres du même point, comme le ṭā’ et le tā’, se distinguent par leurs caractéristiques. Les savants n'ont pas compté le même nombre de caractéristiques : dix-sept selon Ibn al-Jazarī, d'autres en ont compté quatorze ou quarante-quatre (al-Wajīz fī ʿilm al-tajwīd). Cette leçon suit al-Wajīz.

1. Les caractéristiques qui ont un opposé
- Le souffle (hams) : l'air continue de passer quand on prononce la lettre. Dix lettres, réunies dans « فحثه شخص سكت ». Son opposé, la sonorité (jahr) : l'air se bloque car la lettre s'appuie fortement sur son point. Ce sont les autres lettres, sauf les trois lettres de prolongation.
- La force (shidda) : la voix se bloque complètement. Huit lettres, réunies dans « أجد قط بكت ». Entre les deux, la modération (tawassuṭ) : la voix n'est ni bloquée ni libre. Cinq lettres, réunies dans « لن عمر ». La mollesse (rakhāwa) : la voix passe librement ; ce sont les autres lettres.
- L'élévation (istiʿlā’) : l'arrière de la langue s'élève vers le palais. Sept lettres, réunies dans « خص ضغط قظ » (voir la leçon sur les lettres épaisses). Son opposé, l'abaissement (istifāl) : les autres lettres.
- L'adhérence (iṭbāq) : la langue se colle au palais. Quatre lettres : ص ض ط ظ. Toute lettre d'adhérence est aussi une lettre d'élévation, mais pas l'inverse. Son opposé, l'ouverture (infitāḥ) : les autres lettres.
- L'aisance (idhlāq) : ces lettres se prononcent vite et facilement, du bout de la langue ou des lèvres. Six lettres, réunies dans « فر من لب ». Son opposé, la retenue (iṣmāt) : les autres lettres, qui ne forment pas seules un mot de quatre ou cinq lettres d'origine.

2. Les caractéristiques qui n'ont pas d'opposé
- Le sifflement (ṣafīr) : un son en plus qui accompagne le ṣād, le sīn et le zāy.
- Le rebond (qalqala) : le point d'articulation vibre quand la lettre porte un sukūn, et l'on entend un son fort. Cinq lettres, réunies dans « قطب جد » (voir la leçon sur la qalqala).
- La douceur (līn) : le wāw et le yā’ sākin précédés d'une fatḥa se prononcent sans effort (voir la leçon sur le madd līn).
- La déviation (inḥirāf) : la lettre penche vers un autre point d'articulation : le lām et le rā’.
- Le roulement (takrīr) : le bout de la langue vibre en prononçant le rā’. Il faut le cacher, surtout quand le rā’ porte une chadda ; le cacher ne veut pas dire le supprimer totalement (al-Wajīz).
- La diffusion (tafashshī) : l'air se répand dans la bouche en prononçant le shīn. La plupart des savants, dont Ibn al-Jazarī, la réservent au shīn ; d'autres y ajoutent quelques lettres ; al-Wajīz retient le premier avis.
- L'allongement (istiṭāla) : la voix s'étend d'un bout à l'autre du bord de la langue : le ḍād seulement.
- La discrétion (khafā’) : le son est discret : les trois lettres de prolongation et le hā’.
- La ghunna : un son nasal agréable placé dans le nūn et le mīm.

Exercice : prononcez lentement le ṭā’ puis le tā’ avec un sukūn (aṭ, at) et sentez la différence d'élévation et d'adhérence ; puis prononcez un rā’ doublé en évitant de le faire rouler plusieurs fois.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, body),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.source_title, v.author, v.locator, v.url, v.note from rv, (values
  (1, $x$book$x$::public.reference_kind, null::int, null::int, null::int, $x$al-Wajīz fī ʿilm al-tajwīd$x$, $x$Maḥmūd Sībawayh al-Badawī (1415 H)$x$, $x$Chapitre des caractéristiques des lettres : nombre, souffle et sonorité, force$x$, $x$https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/11$x$, $x$Nombre discuté : dix-sept selon Ibn al-Jazarī, quatorze ou quarante-quatre selon d'autres ; hams (فحثه شخص سكت), jahr, shidda (أجد قط بكت) ; cinq caractéristiques avec cinq opposées. Pagination du site, pas de l'édition imprimée.$x$),
  (2, $x$book$x$::public.reference_kind, null::int, null::int, null::int, $x$al-Wajīz fī ʿilm al-tajwīd$x$, $x$Maḥmūd Sībawayh al-Badawī (1415 H)$x$, $x$Modération, mollesse, élévation, adhérence, aisance$x$, $x$https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/12$x$, $x$Tawassuṭ (لن عمر), rakhāwa, istiʿlā’ (خص ضغط قظ), istifāl, iṭbāq (ص ض ط ظ), infitāḥ, idhlāq (فر من لب), iṣmāt.$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, $x$al-Wajīz fī ʿilm al-tajwīd$x$, $x$Maḥmūd Sībawayh al-Badawī (1415 H)$x$, $x$Sifflement, rebond, douceur, déviation, roulement$x$, $x$https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/13$x$, $x$Ṣafīr (ص س ز), qalqala (قطب جد), līn, inḥirāf (ل ر), takrīr (ر) à cacher surtout avec chadda, sans le supprimer.$x$),
  (4, $x$book$x$::public.reference_kind, null::int, null::int, null::int, $x$al-Wajīz fī ʿilm al-tajwīd$x$, $x$Maḥmūd Sībawayh al-Badawī (1415 H)$x$, $x$Diffusion, allongement, discrétion, ghunna$x$, $x$https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/14$x$, $x$Tafashshī : shīn selon la plupart, dont Ibn al-Jazarī (avis retenu) ; istiṭāla : ḍād ; khafā’ : lettres de prolongation et hā’ ; ghunna : nūn et mīm.$x$)) v(k, kind, surah, ayah_from, ayah_to, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, surah, ayah, word_from, word_to, options, answer, explanation)
       select rv.id, v.p, v.s, v.a, v.wf, v.wt, v.o, v.ans, v.e from rv, (values
  (1, $x$Quelle est la différence entre le point d'articulation et les caractéristiques d'une lettre ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Le point dit d'où sort la lettre, les caractéristiques disent comment elle sort$x$, $x$C'est la même chose$x$, $x$Les caractéristiques concernent l'écriture$x$]::text[], 0, $x$Deux lettres du même point, comme ṭā’ et tā’, se distinguent par leurs caractéristiques.$x$),
  (2, $x$Combien de caractéristiques Ibn al-Jazarī a-t-il comptées ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Dix-sept$x$, $x$Cinq$x$, $x$Cent$x$]::text[], 0, $x$D'autres savants en ont compté quatorze ou quarante-quatre.$x$),
  (3, $x$Que signifie le souffle (hams) ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$L'air continue de passer quand on prononce la lettre$x$, $x$La voix se bloque complètement$x$, $x$La langue se colle au palais$x$]::text[], 0, $x$Ses dix lettres sont réunies dans « فحثه شخص سكت ».$x$),
  (4, $x$Quelles sont les quatre lettres d'adhérence (iṭbāq) ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$ṣād, ḍād, ṭā’, ẓā’$x$, $x$qāf, ṭā’, bā’, jīm$x$, $x$lām, nūn, rā’, mīm$x$]::text[], 0, $x$Toute lettre d'adhérence est aussi une lettre d'élévation.$x$),
  (5, $x$Quelle caractéristique faut-il cacher dans le rā’, surtout avec une chadda ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Le roulement (takrīr)$x$, $x$Le sifflement$x$, $x$La ghunna$x$]::text[], 0, $x$Le cacher ne veut pas dire le supprimer totalement.$x$),
  (6, $x$Quelle lettre a la caractéristique d'allongement (istiṭāla) ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Le ḍād$x$, $x$Le shīn$x$, $x$Le sīn$x$]::text[], 0, $x$La voix s'étend d'un bout à l'autre du bord de la langue.$x$),
  (7, $x$Quelles lettres ont le sifflement (ṣafīr) ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$ṣād, sīn, zāy$x$, $x$shīn, fā’, thā’$x$, $x$bā’, mīm, wāw$x$]::text[], 0, $x$Un son en plus accompagne ces trois lettres.$x$),
  (8, $x$Dans quelles lettres se trouve la ghunna ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Le nūn et le mīm$x$, $x$Le lām et le rā’$x$, $x$Les lettres de prolongation$x$]::text[], 0, $x$Un son nasal agréable placé dans le nūn et le mīm.$x$)) v(k, p, s, a, wf, wt, o, ans, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Tajwid 13$x$),
       rv.body !~ '\{\{Q:' as reperes_remplaces,
       '' as mots,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
