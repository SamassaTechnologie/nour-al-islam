-- Hadith 7 d'an-Nawawī : nawawi-07-la-religion-est-le-bon-conseil
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-07-la-religion-est-le-bon-conseil$x$, 'lesson', 'hadith', 'fr', 7) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 7 : la religion, c'est le bon conseil (an-naṣīḥa)$x$, $x$La religion repose sur la sincérité et le fait de vouloir le bien : envers Allah, Son Livre, Son Messager, les dirigeants et tous les musulmans.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:7}}

Traduction du sens : D'après Abū Ruqayya Tamīm ibn Aws ad-Dārī : le Prophète ﷺ a dit : « La religion, c'est le bon conseil (an-naṣīḥa). » Nous avons demandé : « Envers qui ? » Il a répondu : « Envers Allah, Son Livre, Son Messager, les dirigeants des musulmans et l'ensemble des musulmans. » Rapporté par Muslim (n° 55). Hadith authentique.

2. La phrase à retenir
« {{NAWX:7:117:138}} » (ad-dīnu n-naṣīḥa).
Sens : « La religion, c'est le bon conseil. »
Le mot naṣīḥa réunit la sincérité, la loyauté et le fait de vouloir sincèrement le bien pour l'autre, sans tromperie.

3. Explication
Le Prophète ﷺ indique que la religion repose sur la sincérité : la pratiquer comme Allah l'a prescrite, pleinement, sans manquement ni tromperie. Puis il détaille envers qui (selon HadeethEnc) :
- Envers Allah : Lui vouer les œuvres exclusivement, ne rien Lui associer dans Sa seigneurie, Sa divinité, Ses noms et Ses attributs, magnifier Ses ordres et appeler à croire en Lui.
- Envers Son Livre : croire que le Coran est la Parole d'Allah, le respecter, le réciter comme il se doit, appliquer ses versets clairs, croire à ceux dont le sens nous échappe, le défendre contre les déformations, tirer profit de ses exhortations et diffuser ses sciences.
- Envers Son Messager ﷺ : croire en sa mission, suivre sa Sunna, obéir à ses ordres, éviter ce qu'il a interdit, n'adorer Allah que selon ce qu'il a enseigné, le respecter et défendre son honneur.
- Envers les dirigeants des musulmans : les aider dans la vérité, ne pas leur contester l'autorité, et leur obéir dans ce qui est obéissance à Allah.
- Envers l'ensemble des musulmans : leur faire du bien, les appeler au bien, ne pas leur nuire, aimer pour eux le bien et coopérer avec eux dans la piété.

4. Ce que l'élève peut retenir
- Le bon conseil est demandé envers tous.
- Il a une place immense dans la religion, qui comprend des croyances, des paroles et des actes.
- Bien conseiller, c'est vouloir le bien de l'autre et ne jamais le tromper.
- La méthode du Prophète ﷺ : il annonce d'abord une phrase générale, puis il la détaille, en commençant par le plus important (selon HadeethEnc).

Exercice : citez les cinq destinataires du bon conseil dans l'ordre du hadith, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$7$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$La religion, c'est le bon conseil, d'après Tamīm ad-Dārī$x$, null, null, $x$https://sunnah.com/nawawi40:7$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$55$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la foi$x$, null, null, $x$https://sunnah.com/muslim:55a$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66516$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66516$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « ad-dīnu n-naṣīḥa » ?$x$, array[$x$La religion, c'est le bon conseil$x$, $x$La religion, c'est la prière$x$, $x$La religion, c'est le savoir$x$]::text[], 0, $x$La naṣīḥa est la sincérité et la volonté sincère du bien.$x$),
  (2, $x$Qui a rapporté ce hadith du Prophète ﷺ ?$x$, array[$x$Tamīm ad-Dārī$x$, $x$Abū Hurayra$x$, $x$Anas ibn Mālik$x$]::text[], 0, $x$Abū Ruqayya Tamīm ibn Aws ad-Dārī.$x$),
  (3, $x$Envers qui le bon conseil est-il cité en premier ?$x$, array[$x$Envers les musulmans$x$, $x$Envers Allah$x$, $x$Envers les dirigeants$x$]::text[], 1, $x$Le Prophète ﷺ commence par le plus important : Allah.$x$),
  (4, $x$Que comprend le bon conseil envers le Livre d'Allah ?$x$, array[$x$Croire qu'il est la Parole d'Allah, le réciter et l'appliquer$x$, $x$Le garder fermé sur une étagère$x$, $x$Le lire seulement en Ramaḍān$x$]::text[], 0, $x$Croire, respecter, réciter, appliquer et diffuser ses enseignements.$x$),
  (5, $x$Quel est le contraire du bon conseil ?$x$, array[$x$La tromperie$x$, $x$Le silence$x$, $x$La patience$x$]::text[], 0, $x$Bien conseiller, c'est vouloir le bien sans tromper.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 7 d'an-Nawawī$x$),
       rv.h = 'db1868b8afec143302bc5f304ac26445' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
