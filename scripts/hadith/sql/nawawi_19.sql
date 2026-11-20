-- Hadith 19 d'an-Nawawī : nawawi-19-preserve-allah-il-te-preservera
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-19-preserve-allah-il-te-preservera$x$, 'lesson', 'hadith', 'fr', 19) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 19 : préserve Allah, Il te préservera$x$, $x$Les conseils du Prophète ﷺ au jeune Ibn ʿAbbās : respecter les ordres d'Allah, ne demander qu'à Lui, et savoir que rien n'arrive sans Son décret.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:19}}

Traduction du sens : D'après ʿAbd Allāh ibn ʿAbbās, qui a dit : j'étais un jour derrière le Messager d'Allah ﷺ, et il m'a dit : « Ô jeune garçon ! Je vais t'enseigner des paroles : préserve Allah, Il te préservera ; préserve Allah, tu Le trouveras devant toi. Quand tu demandes, demande à Allah ; quand tu cherches de l'aide, cherche-la auprès d'Allah. Sache que si la communauté entière se réunissait pour te faire profiter d'une chose, elle ne te ferait profiter que de ce qu'Allah a déjà écrit pour toi ; et si elle se réunissait pour te nuire, elle ne te nuirait que par ce qu'Allah a déjà écrit contre toi. Les plumes ont été levées et les feuilles ont séché. » Rapporté par at-Tirmidhī (n° 2516), qui a dit : hadith ḥasan ṣaḥīḥ.
Dans une version autre que celle d'at-Tirmidhī : « Préserve Allah, tu Le trouveras devant toi. Fais-toi connaître d'Allah dans l'aisance, Il te connaîtra dans la difficulté. Sache que ce qui t'a manqué ne pouvait pas t'atteindre, et que ce qui t'a atteint ne pouvait pas te manquer. Sache que la victoire vient avec la patience, que le soulagement vient avec l'épreuve, et qu'avec la difficulté vient la facilité. »

2. La phrase à retenir
« {{NAWX:19:175:200}} » (iḥfaẓi llāha yaḥfaẓk).
Sens : « Préserve Allah, Il te préservera. »

3. Explication
Ibn ʿAbbās était jeune et se trouvait derrière le Prophète ﷺ sur sa monture lorsqu'il a reçu ces conseils (selon HadeethEnc) :
- « Préserve Allah » : respecte Ses ordres et évite Ses interdits, de sorte qu'Il te trouve là où Il t'a ordonné d'être, et non là où Il te l'a interdit. Allah te préservera alors des maux de ce monde et de l'au-delà.
- « Quand tu demandes, demande à Allah » : Lui seul exauce ceux qui L'invoquent. De même, l'aide se cherche auprès d'Allah.
- Rien ne peut t'être utile ou te nuire, même si tous les gens s'unissaient pour cela, sauf ce qu'Allah a décrété : tout a été écrit par Allah.

4. Ce que l'élève peut retenir
- Il est important d'enseigner la religion aux enfants : l'unicité d'Allah, les bonnes manières…
- La récompense est de la même nature que l'œuvre : qui préserve Allah, Allah le préserve.
- Il faut compter sur Allah seul et placer sa confiance en Lui.
- Il faut croire au destin et l'accepter pleinement.
- Bonne nouvelle : après la difficulté, le croyant attend la facilité.

Exercice : apprenez par cœur la phrase « préserve Allah, Il te préservera » avec sa traduction, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$19$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Préserve Allah, Il te préservera, d'après Ibn ʿAbbās$x$, null, null, $x$https://sunnah.com/nawawi40:19$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2516$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Livre de la description de la Résurrection$x$, null, null, $x$https://sunnah.com/tirmidhi:2516$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66522$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66522$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « iḥfaẓi llāha yaḥfaẓk » ?$x$, array[$x$Préserve Allah, Il te préservera$x$, $x$Prie Allah, Il te répondra$x$, $x$Remercie Allah, Il te donnera$x$]::text[], 0, $x$Celui qui respecte les ordres d'Allah est protégé par Allah.$x$),
  (2, $x$Quel âge avait Ibn ʿAbbās lorsqu'il a reçu ces conseils ?$x$, array[$x$Il était jeune$x$, $x$Il était très âgé$x$, $x$Il n'était pas encore né$x$]::text[], 0, $x$Le Prophète ﷺ l'appelle « ô jeune garçon ».$x$),
  (3, $x$À qui le croyant demande-t-il ce dont il a besoin ?$x$, array[$x$À Allah$x$, $x$Aux astrologues$x$, $x$À personne$x$]::text[], 0, $x$« Quand tu demandes, demande à Allah. »$x$),
  (4, $x$Que peuvent faire les gens réunis contre toi sans le décret d'Allah ?$x$, array[$x$Rien$x$, $x$Tout ce qu'ils veulent$x$, $x$La moitié de ce qu'ils veulent$x$]::text[], 0, $x$Ils ne nuisent que par ce qu'Allah a déjà écrit.$x$),
  (5, $x$Quelle bonne nouvelle donne la version longue ?$x$, array[$x$Avec la difficulté vient la facilité$x$, $x$Il n'y aura plus jamais d'épreuve$x$, $x$La richesse vient sans effort$x$]::text[], 0, $x$« Qu'avec la difficulté vient la facilité. »$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 19 d'an-Nawawī$x$),
       rv.h = 'b6b8daa1adfe407e9a6e636f6e38d8e9' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
