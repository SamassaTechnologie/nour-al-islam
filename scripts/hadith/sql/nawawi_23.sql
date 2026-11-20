-- Hadith 23 d'an-Nawawī : nawawi-23-la-purification-moitie-de-la-foi
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-23-la-purification-moitie-de-la-foi$x$, 'lesson', 'hadith', 'fr', 23) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 23 : la purification est la moitié de la foi$x$, $x$La purification, les paroles de louange, la prière, l'aumône, la patience et le Coran : chaque jour, chacun travaille à libérer son âme ou à la perdre.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:23}}

Traduction du sens : D'après Abū Mālik al-Ḥārith ibn ʿĀṣim al-Ashʿarī : le Messager d'Allah ﷺ a dit : « La purification est la moitié de la foi. Al-ḥamdu li-llāh (louange à Allah) remplit la balance. Subḥāna llāh et al-ḥamdu li-llāh (gloire à Allah et louange à Allah) remplissent — ou : remplit — ce qui est entre le ciel et la terre. La prière est une lumière, l'aumône est une preuve, la patience est une clarté, et le Coran est un argument pour toi ou contre toi. Tous les gens partent le matin : l'un vend son âme et l'affranchit, l'autre la mène à sa perte. » Rapporté par Muslim (n° 223). Hadith authentique.

2. La phrase à retenir
« {{NAWX:23:127:156}} » (aṭ-ṭuhūru shaṭru l-īmān).
Sens : « La purification est la moitié de la foi. »

3. Explication
Selon HadeethEnc :
- La purification extérieure se fait par les ablutions ou le lavage ; c'est une condition de la prière.
- « Al-ḥamdu li-llāh » : louer Allah et Le décrire par des attributs de perfection ; pesée au Jour de la Résurrection, cette parole remplira la balance des œuvres.
- « Subḥāna llāh » affirme qu'Allah est exempt de tout défaut, et « al-ḥamdu li-llāh » Le décrit par la perfection, avec amour et vénération : ensemble, elles remplissent ce qui est entre le ciel et la terre.
- La prière est une lumière pour le serviteur : dans son cœur, sur son visage, dans sa tombe et lors de sa résurrection.
- L'aumône est une preuve : elle montre la sincérité de la foi du croyant.
- La patience est une clarté, et le Coran est un argument en ta faveur si tu le crois et l'appliques, ou contre toi sinon.
- Chacun agit chaque jour : soit il libère son âme par l'obéissance, soit il la perd par la désobéissance.

4. Ce que l'élève peut retenir
- La purification est de deux sortes : apparente (ablutions, lavage) et intérieure (le tawḥīd, la foi et les bonnes œuvres).
- La prière, accomplie avec assiduité, est la lumière du serviteur dans ce monde et le Jour de la Résurrection.
- L'aumône prouve la sincérité de la foi.
- Il faut appliquer le Coran pour qu'il soit un argument pour soi et non contre soi.
- Si on n'occupe pas son âme par l'obéissance, elle nous occupe par la désobéissance.

Exercice : récitez « subḥāna llāh » et « al-ḥamdu li-llāh » et expliquez leur sens, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$23$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$La purification est la moitié de la foi, d'après Abū Mālik al-Ashʿarī$x$, null, null, $x$https://sunnah.com/nawawi40:23$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$223$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la purification$x$, null, null, $x$https://sunnah.com/muslim:223$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66526$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66526$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « aṭ-ṭuhūru shaṭru l-īmān » ?$x$, array[$x$La purification est la moitié de la foi$x$, $x$La prière est la moitié de la foi$x$, $x$Le jeûne est la foi$x$]::text[], 0, $x$C'est la première phrase du hadith.$x$),
  (2, $x$Que remplit la parole « al-ḥamdu li-llāh » ?$x$, array[$x$La balance$x$, $x$La mosquée$x$, $x$Le ciel seul$x$]::text[], 0, $x$Elle remplit la balance des œuvres au Jour de la Résurrection.$x$),
  (3, $x$À quoi la prière est-elle comparée ?$x$, array[$x$À une lumière$x$, $x$À un trésor$x$, $x$À une montagne$x$]::text[], 0, $x$« La prière est une lumière. »$x$),
  (4, $x$Que montre l'aumône selon HadeethEnc ?$x$, array[$x$La sincérité de la foi$x$, $x$La richesse de la personne$x$, $x$Rien de particulier$x$]::text[], 0, $x$« L'aumône est une preuve. »$x$),
  (5, $x$Quand le Coran est-il un argument en ta faveur ?$x$, array[$x$Quand tu le crois et l'appliques$x$, $x$Quand tu le gardes chez toi sans le lire$x$, $x$Toujours, quoi que tu fasses$x$]::text[], 0, $x$Sinon, il est un argument contre toi.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 23 d'an-Nawawī$x$),
       rv.h = '094b7b8ca2fdefca85fd58fcf7ef8a3c' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
