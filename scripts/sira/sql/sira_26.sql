-- Sira 26 : maladie-et-mort-du-prophete
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$maladie-et-mort-du-prophete$x$, 'lesson', 'sira', 'fr', 26) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$La maladie et la mort du Prophète ﷺ$x$, $x$La dernière maladie, Abū Bakr à la tête de la prière, le dernier regard sur les fidèles, les dernières paroles, la mort un lundi à soixante-trois ans, et le discours d'Abū Bakr, d'après le Coran et Ṣaḥīḥ al-Bukhārī.$x$, $x$1. La dernière maladie
Après le pèlerinage d'adieu, le Prophète ﷺ tomba malade. ʿĀʾisha rapporte qu'il disait, pendant la maladie dont il mourut, qu'il sentait encore la douleur de la nourriture empoisonnée mangée à Khaybar (en substance ; al-Bukhārī n° 4428). ʿĀʾisha rapporte aussi qu'il mourut chez elle, la tête appuyée contre elle (al-Bukhārī n° 4449).

2. Abū Bakr dirige la prière
ʿĀʾisha rapporte que, lorsque la maladie s'aggrava et que l'heure de la prière arriva, le Prophète ﷺ dit à trois reprises : ordonnez à Abū Bakr de diriger la prière des gens. Un jour qu'il se sentit mieux, il sortit soutenu par deux hommes, les pieds traînant sur le sol, et s'assit à côté d'Abū Bakr (en substance ; al-Bukhārī n° 664 ; hadith authentique).
Anas rapporte que le lundi, pendant que les gens priaient en rangs derrière Abū Bakr, le Prophète ﷺ souleva le rideau de sa chambre et les regarda en souriant ; son visage était comme une page du Mushaf. Il leur fit signe de terminer leur prière, baissa le rideau, et mourut ce jour-là (en substance ; al-Bukhārī n° 680 ; hadith authentique).

3. Les dernières paroles
ʿĀʾisha rapporte qu'il trempait ses mains dans l'eau et se les passait sur le visage en disant :
« لاَ إِلَهَ إِلاَّ اللَّهُ، إِنَّ لِلْمَوْتِ سَكَرَاتٍ » (lā ilāha illa llāh, inna li-l-mawti sakarāt).
Sens : « Il n'y a de divinité qu'Allah ; la mort a ses agonies. » Puis il leva la main en disant : avec le Compagnon suprême (fi r-rafīqi l-aʿlā), jusqu'à ce que son âme soit reprise et que sa main retombe (al-Bukhārī n° 4449 ; hadith authentique).
Elle rapporte qu'il disait, en bonne santé, qu'aucun prophète ne meurt avant d'avoir vu sa place au Paradis et d'avoir reçu le choix ; sa dernière parole fut :
« اللَّهُمَّ الرَّفِيقَ الأَعْلَى » (allāhumma r-rafīqa l-aʿlā).
Sens : « Ô Allah, le Compagnon suprême. » (al-Bukhārī n° 4463 ; hadith authentique). Elle l'entendit aussi demander : ô Allah, pardonne-moi, fais-moi miséricorde et réunis-moi au Compagnon (en substance ; al-Bukhārī n° 4440).
Quand la souffrance devint forte, Fāṭima dit : quelle souffrance pour mon père ! Il lui répondit :
« لَيْسَ عَلَى أَبِيكِ كَرْبٌ بَعْدَ الْيَوْمِ » (laysa ʿalā abīki karbun baʿda l-yawm).
Sens : « Ton père ne souffrira plus après aujourd'hui. » (al-Bukhārī n° 4462 ; hadith authentique).

4. Un lundi, à soixante-trois ans
ʿĀʾisha rapporte qu'il mourut un lundi (al-Bukhārī n° 1387) et qu'il avait alors soixante-trois ans (al-Bukhārī n° 4466 ; hadith authentique). Il fut enveloppé dans trois étoffes blanches, sans chemise ni turban (al-Bukhārī n° 1387).

5. Le discours d'Abū Bakr
ʿĀʾisha rapporte qu'à l'annonce de sa mort, ʿUmar refusa d'y croire. Abū Bakr arriva, découvrit le visage du Prophète ﷺ, l'embrassa et dit : tu as été bon vivant et mort. Puis il sortit, loua Allah et dit :
« أَلاَ مَنْ كَانَ يَعْبُدُ مُحَمَّدًا صلى الله عليه وسلم فَإِنَّ مُحَمَّدًا قَدْ مَاتَ، وَمَنْ كَانَ يَعْبُدُ اللَّهَ فَإِنَّ اللَّهَ حَىٌّ لاَ يَمُوتُ » (a-lā man kāna yaʿbudu Muḥammadan ṣalla llāhu ʿalayhi wa sallama fa-inna Muḥammadan qad māt, wa man kāna yaʿbudu llāha fa-inna llāha ḥayyun lā yamūt).
Sens : « Que celui qui adorait Muḥammad sache que Muḥammad est mort ; et que celui qui adorait Allah sache qu'Allah est Vivant et ne meurt pas. » Il récita ensuite le verset 30 de la sourate al-Zumar et le verset 144 de la sourate Āl ʿImrān, qui rappellent que le Prophète ﷺ devait mourir et que Muḥammad n'est qu'un messager, comme d'autres messagers avant lui (al-Bukhārī n° 3667 ; hadith authentique).

6. Ce que l'élève peut retenir
- Le Prophète ﷺ désigna Abū Bakr pour diriger la prière pendant sa maladie.
- Ses dernières paroles furent une invocation : « Ô Allah, le Compagnon suprême. »
- Il mourut un lundi, à soixante-trois ans.
- Abū Bakr rappela que seul Allah est Vivant et ne meurt pas : on adore Allah, et l'on suit Son Messager ﷺ.

Exercice : répétez la dernière parole du Prophète ﷺ et la parole d'Abū Bakr avec leur sens, et répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4428$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La douleur de la nourriture de Khaybar, d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:4428$x$, null),
  (2, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$664$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ordonnez à Abū Bakr de diriger la prière », d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:664$x$, null),
  (3, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$680$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le dernier regard sur les fidèles, un lundi, d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:680$x$, null),
  (4, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4449$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Les derniers instants chez ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:4449$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4463$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$La dernière parole : « Ô Allah, le Compagnon suprême », d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:4463$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4440$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Pardonne-moi, fais-moi miséricorde », d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:4440$x$, null),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4462$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ton père ne souffrira plus après aujourd'hui », d'après Anas$x$, null, null, $x$https://sunnah.com/bukhari:4462$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$1387$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Mort un lundi ; trois étoffes blanches, d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:1387$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$4466$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Mort à soixante-trois ans, d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:4466$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$3667$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le discours d'Abū Bakr, d'après ʿĀʾisha$x$, null, null, $x$https://sunnah.com/bukhari:3667$x$, $x$Parole d'Abū Bakr copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (11, $x$quran$x$::public.reference_kind, 39::int, 30::int, 30::int, null, null, null, null, null, null, null, null, null, null),
  (12, $x$quran$x$::public.reference_kind, 3::int, 144::int, 144::int, null, null, null, null, null, null, null, null, null, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qui le Prophète ﷺ désigna-t-il pour diriger la prière pendant sa maladie ?$x$, array[$x$Abū Bakr$x$, $x$ʿUmar$x$, $x$ʿAlī$x$]::text[], 0, $x$Al-Bukhārī n° 664.$x$),
  (2, $x$À quoi Anas compara-t-il le visage du Prophète ﷺ le jour de sa mort ?$x$, array[$x$À une page du Mushaf$x$, $x$Au soleil$x$, $x$À la lune$x$]::text[], 0, $x$Al-Bukhārī n° 680.$x$),
  (3, $x$Quelle fut la dernière parole du Prophète ﷺ selon ʿĀʾisha ?$x$, array[$x$« Ô Allah, le Compagnon suprême »$x$, $x$« Ô gens, écoutez-moi »$x$, $x$« Préparez l'armée »$x$]::text[], 0, $x$Al-Bukhārī n° 4463.$x$),
  (4, $x$Quel jour mourut le Prophète ﷺ ?$x$, array[$x$Un lundi$x$, $x$Un vendredi$x$, $x$Un jeudi$x$]::text[], 0, $x$Al-Bukhārī n° 1387 et 680.$x$),
  (5, $x$Quel âge avait-il à sa mort selon ʿĀʾisha ?$x$, array[$x$Soixante-trois ans$x$, $x$Quarante ans$x$, $x$Soixante-dix ans$x$]::text[], 0, $x$Al-Bukhārī n° 4466.$x$),
  (6, $x$Que dit-il à Fāṭima qui s'affligeait de sa souffrance ?$x$, array[$x$Ton père ne souffrira plus après aujourd'hui$x$, $x$Ne pleure pas$x$, $x$Appelle ʿAlī$x$]::text[], 0, $x$Al-Bukhārī n° 4462.$x$),
  (7, $x$Quel était le sens du discours d'Abū Bakr ?$x$, array[$x$Muḥammad est mort, mais Allah est Vivant et ne meurt pas$x$, $x$Le Prophète ﷺ reviendra bientôt$x$, $x$Il fallait quitter Médine$x$]::text[], 0, $x$Al-Bukhārī n° 3667 ; versets 39:30 et 3:144.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Sira 26$x$),
       rv.h = 'd67a412a284d428089a9b8e6667fb7f4' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
