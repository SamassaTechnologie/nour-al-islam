-- Tajwid 12 : points-d-articulation
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$points-d-articulation$x$, 'lesson', 'tajwid', 'fr', 12) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Les points d'articulation des lettres (makhārij al-ḥurūf)$x$, $x$D'où sort chaque lettre : comment trouver le point d'articulation d'une lettre, les cinq grandes zones et les dix-sept points retenus par al-Wajīz, de la gorge aux lèvres et au nez.$x$, $x$Bien prononcer une lettre commence par la faire sortir de son point d'articulation (makhraj). Al-Wajīz fī ʿilm al-tajwīd compare les points d'articulation à des balances qui donnent à chaque lettre sa juste mesure. Les savants les ont rangés en suivant l'air qui monte des poumons vers la bouche.

1. Comment trouver le point d'articulation d'une lettre
On met la lettre avec un sukūn ou une chadda, on la fait précéder d'un alif de liaison, et l'on écoute : l'endroit où la voix s'arrête est le point d'articulation de la lettre. Par exemple : ab, at, ath… (al-Wajīz).

2. Les cinq grandes zones
La cavité (al-jawf), la gorge (al-ḥalq), la langue (al-lisān), les deux lèvres (ash-shafatān) et le nez (al-khayshūm). Al-Wajīz y distingue dix-sept points précis.

3. La cavité (1 point)
1. La cavité de la bouche et de la gorge : les trois lettres de prolongation, l'alif, le wāw sākin après une ḍamma et le yā’ sākin après une kasra.

4. La gorge (3 points)
2. Le fond de la gorge : la hamza (ء) et le hā’ (هـ).
3. Le milieu de la gorge : le ʿayn (ع) puis le ḥā’ (ح).
4. Le haut de la gorge, près de la bouche : le ghayn (غ) puis le khā’ (خ).
Ces six lettres sont appelées les lettres de la gorge (ḥalqiyya).

5. La langue (10 points)
5. L'arrière de la langue avec le palais : le qāf (ق).
6. Un peu plus bas que le qāf : le kāf (ك).
7. Le milieu de la langue : le jīm (ج), le shīn (ش) et le yā’ qui n'est pas de prolongation (ي).
8. Un des bords de la langue : le ḍād (ض) ; le côté gauche est plus facile que le droit.
9. Les deux bords de la langue, vers l'avant : le lām (ل).
10. Le bout de la langue : le nūn (ن).
11. Le bout de la langue avec un peu de son dos : le rā’ (ر). Le lām, le nūn et le rā’ sont appelées lettres de la pointe (dhalaqiyya).
12. Le bout de la langue contre la racine des incisives supérieures : le ṭā’ (ط), le dāl (د) et le tā’ (ت).
13. Le bout de la langue au-dessus des incisives inférieures : le ṣād (ص), le sīn (س) et le zāy (ز).
14. Le bout de la langue contre le bout des incisives supérieures : le ẓā’ (ظ), le dhāl (ذ) et le thā’ (ث).

6. Les lèvres (2 points)
15. L'intérieur de la lèvre inférieure contre le bout des incisives supérieures : le fā’ (ف).
16. Les deux lèvres ensemble : le bā’ (ب), le mīm (م) et le wāw qui n'est pas de prolongation (و). Pour le wāw, les lèvres restent un peu ouvertes ; pour le bā’, elles se ferment plus fort que pour le mīm.

7. Le nez (1 point)
17. Le fond du nez (al-khayshūm) : c'est de là que sort la ghunna (nasalisation) du nūn et du mīm. Pendant l'ikhfā’ et l'idghām avec ghunna, ils passent entièrement par le nez ; avec une chadda, ils sortent de leur point d'origine et du nez ; avec une voyelle ou un sukūn clair, seulement de leur point d'origine (al-Wajīz).

Cette leçon suit la répartition en dix-sept points d'al-Wajīz.

Exercice : pour chacune des lettres ع, ح, غ, خ, ق et ك, faites-la précéder d'un alif de liaison avec un sukūn (aʿ, aḥ, agh, akh, aq, ak) et sentez où la voix s'arrête.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, body),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.source_title, v.author, v.locator, v.url, v.note from rv, (values
  (1, $x$book$x$::public.reference_kind, null::int, null::int, null::int, $x$al-Wajīz fī ʿilm al-tajwīd$x$, $x$Maḥmūd Sībawayh al-Badawī (1415 H)$x$, $x$Chapitre des points d'articulation : méthode, cinq zones, points 1 à 6$x$, $x$https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/8$x$, $x$Méthode : sukūn ou chadda précédé d'un alif de liaison ; cinq zones générales ; dix-sept points. Pagination du site, pas de l'édition imprimée.$x$),
  (2, $x$book$x$::public.reference_kind, null::int, null::int, null::int, $x$al-Wajīz fī ʿilm al-tajwīd$x$, $x$Maḥmūd Sībawayh al-Badawī (1415 H)$x$, $x$Points 7 à 15$x$, $x$https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/9$x$, $x$Milieu de la langue (ج ش ي), bord (ض), lām, nūn, rā’, ط د ت, ص س ز, ظ ذ ث, fā’.$x$),
  (3, $x$book$x$::public.reference_kind, null::int, null::int, null::int, $x$al-Wajīz fī ʿilm al-tajwīd$x$, $x$Maḥmūd Sībawayh al-Badawī (1415 H)$x$, $x$Points 16 et 17 ; introduction aux caractéristiques$x$, $x$https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/10$x$, $x$Les deux lèvres (ب م و) ; le khayshūm, lieu de la ghunna du nūn et du mīm selon leur état ; comparaison des points d'articulation à des balances.$x$)) v(k, kind, surah, ayah_from, ayah_to, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, surah, ayah, word_from, word_to, options, answer, explanation)
       select rv.id, v.p, v.s, v.a, v.wf, v.wt, v.o, v.ans, v.e from rv, (values
  (1, $x$Comment trouve-t-on le point d'articulation d'une lettre ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$On la met avec un sukūn après un alif de liaison et l'on écoute où la voix s'arrête$x$, $x$On la prononce très fort$x$, $x$On regarde sa forme écrite$x$]::text[], 0, $x$Par exemple : ab, at, aq…$x$),
  (2, $x$Combien de grandes zones d'articulation y a-t-il ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Cinq$x$, $x$Trois$x$, $x$Dix-sept$x$]::text[], 0, $x$La cavité, la gorge, la langue, les lèvres et le nez.$x$),
  (3, $x$Combien de points précis al-Wajīz retient-il ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Dix-sept$x$, $x$Cinq$x$, $x$Vingt-huit$x$]::text[], 0, $x$Al-Wajīz retient dix-sept points précis, regroupés en cinq zones.$x$),
  (4, $x$Quelles lettres sortent de la cavité (al-jawf) ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Les trois lettres de prolongation$x$, $x$La hamza et le hā’$x$, $x$Le bā’ et le mīm$x$]::text[], 0, $x$L'alif, le wāw sākin après une ḍamma et le yā’ sākin après une kasra.$x$),
  (5, $x$D'où sortent le ʿayn et le ḥā’ ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Du milieu de la gorge$x$, $x$Du fond de la gorge$x$, $x$Des lèvres$x$]::text[], 0, $x$Le fond de la gorge donne la hamza et le hā’ ; le haut, le ghayn et le khā’.$x$),
  (6, $x$Quelle lettre sort d'un des bords de la langue ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Le ḍād$x$, $x$Le dāl$x$, $x$Le ẓā’$x$]::text[], 0, $x$Le côté gauche est plus facile que le droit, selon al-Wajīz.$x$),
  (7, $x$Quelles lettres sortent des deux lèvres ensemble ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Le bā’, le mīm et le wāw non prolongé$x$, $x$Le fā’ seul$x$, $x$Le nūn et le lām$x$]::text[], 0, $x$Le fā’ sort de la lèvre inférieure avec les incisives supérieures.$x$),
  (8, $x$D'où sort la ghunna du nūn et du mīm ?$x$, null::smallint, null::smallint, null::smallint, null::smallint, array[$x$Du fond du nez (al-khayshūm)$x$, $x$Du milieu de la gorge$x$, $x$Du bout de la langue$x$]::text[], 0, $x$Al-khayshūm est le dix-septième point.$x$)) v(k, p, s, a, wf, wt, o, ans, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Tajwid 12$x$),
       rv.body !~ '\{\{Q:' as reperes_remplaces,
       '' as mots,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
