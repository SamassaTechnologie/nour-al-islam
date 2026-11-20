-- Hadith 17 d'an-Nawawī : nawawi-17-l-excellence-en-toute-chose
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-17-l-excellence-en-toute-chose$x$, 'lesson', 'hadith', 'fr', 17) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 17 : Allah a prescrit l'excellence en toute chose$x$, $x$Allah a prescrit l'iḥsān — bien faire — en toute chose, jusque dans la manière d'égorger une bête : avec douceur et sans la faire souffrir.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:17}}

Traduction du sens : D'après Abū Yaʿlā Shaddād ibn Aws : le Messager d'Allah ﷺ a dit : « Allah a prescrit l'excellence (al-iḥsān) en toute chose. Lorsque vous tuez, faites-le de la meilleure manière ; lorsque vous égorgez, égorgez de la meilleure manière. Que chacun de vous aiguise sa lame et épargne la souffrance à sa bête. » Rapporté par Muslim (n° 1955). Hadith authentique.

2. La phrase à retenir
« {{NAWX:17:108:159}} » (inna llāha kataba l-iḥsāna ʿalā kulli shayʾ).
Sens : « Allah a prescrit l'excellence en toute chose. »

3. Explication
Allah nous a demandé de bien faire en toute chose. Cette excellence consiste à garder à l'esprit qu'Allah nous voit, dans l'adoration qu'on Lui voue, dans le bien que l'on fait et dans le fait d'éviter tout tort envers les créatures (selon HadeethEnc).
- Bien faire lors de l'application du talion : choisir la manière la plus rapide et la plus légère.
- Bien faire en égorgeant une bête : être doux avec elle, aiguiser la lame sans le faire devant elle, et ne pas l'égorger sous le regard des autres bêtes.

4. Ce que l'élève peut retenir
- Ce hadith montre la miséricorde d'Allah et Sa bonté envers les créatures.
- La Loi islamique englobe tout bien, y compris la douceur envers les animaux.
- Il est interdit de mutiler un être humain après sa mort.
- Il est interdit de faire souffrir un animal.

Exercice : citez trois domaines de la vie où l'on peut appliquer « l'excellence en toute chose », puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$17$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Allah a prescrit l'excellence en toute chose, d'après Shaddād ibn Aws$x$, null, null, $x$https://sunnah.com/nawawi40:17$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1955$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la chasse et des bêtes égorgées$x$, null, null, $x$https://sunnah.com/muslim:1955$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66521$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66521$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « al-iḥsān » dans ce hadith ?$x$, array[$x$L'excellence : bien faire$x$, $x$La richesse$x$, $x$La vitesse$x$]::text[], 0, $x$Allah a prescrit de bien faire en toute chose.$x$),
  (2, $x$Que doit faire celui qui égorge une bête ?$x$, array[$x$Aiguiser sa lame et lui épargner la souffrance$x$, $x$Aiguiser la lame devant elle$x$, $x$L'égorger devant les autres bêtes$x$]::text[], 0, $x$Le hadith ordonne d'aiguiser la lame et de soulager la bête.$x$),
  (3, $x$Que nous apprend ce hadith sur les animaux ?$x$, array[$x$Il est interdit de les faire souffrir$x$, $x$On peut les traiter comme on veut$x$, $x$Ils n'ont aucun droit$x$]::text[], 0, $x$La Loi islamique englobe la douceur envers les animaux.$x$),
  (4, $x$Qui a rapporté ce hadith ?$x$, array[$x$Shaddād ibn Aws$x$, $x$Abū Dharr$x$, $x$Ibn ʿAbbās$x$]::text[], 0, $x$Abū Yaʿlā Shaddād ibn Aws.$x$),
  (5, $x$Sur quoi repose l'excellence selon HadeethEnc ?$x$, array[$x$Garder à l'esprit qu'Allah nous voit$x$, $x$Être vu par les gens$x$, $x$Être rapide$x$]::text[], 0, $x$Dans l'adoration, dans le bien et dans le fait d'éviter tout tort.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 17 d'an-Nawawī$x$),
       rv.h = '9dff238332155e8711323891d0c51e67' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
