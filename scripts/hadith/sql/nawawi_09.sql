-- Hadith 9 d'an-Nawawī : nawawi-09-eviter-l-interdit-faire-ce-que-l-on-peut
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-09-eviter-l-interdit-faire-ce-que-l-on-peut$x$, 'lesson', 'hadith', 'fr', 9) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 9 : évitez ce qui est interdit, faites ce qui est ordonné selon vos capacités$x$, $x$L'interdit s'évite entièrement ; l'ordre s'accomplit selon ses capacités. Le Prophète ﷺ met en garde contre l'excès de questions et les divergences.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:9}}

Traduction du sens : D'après Abū Hurayra ʿAbd ar-Raḥmān ibn Ṣakhr, qui a dit : j'ai entendu le Messager d'Allah ﷺ dire : « Ce que je vous ai interdit, évitez-le ; et ce que je vous ai ordonné, faites-en ce que vous pouvez. Ce qui a fait périr ceux qui étaient avant vous, ce sont leurs nombreuses questions et leurs divergences avec leurs prophètes. » Rapporté par al-Bukhārī (n° 7288) et Muslim (n° 1337). Hadith authentique.

2. La phrase à retenir
« {{NAWX:9:133:230}} » (mā nahaytukum ʿanhu fa-jtanibūhu, wa mā amartukum bihi fa-ʾtū minhu mā staṭaʿtum).
Sens : « Ce que je vous ai interdit, évitez-le ; et ce que je vous ai ordonné, faites-en ce que vous pouvez. »

3. Explication
Lorsque le Prophète ﷺ interdit une chose, il faut s'en abstenir entièrement ; lorsqu'il ordonne une chose, on en accomplit ce que l'on peut. Puis il met en garde contre l'attitude de certaines communautés passées, qui ont multiplié les questions et se sont opposées à leurs prophètes, ce qui a causé leur perte (selon HadeethEnc).
- Pourquoi cette différence ? S'abstenir est à la portée de tous, alors qu'agir demande une capacité. L'interdit ne laisse donc aucune part permise, tandis que l'ordre dépend de ce que l'on peut faire.
- L'interdit concerne le peu comme le beaucoup : l'usure (ribā), par exemple, est interdite, qu'elle soit petite ou grande.
- Les questions sont de deux sortes : celles qui servent à apprendre ce dont on a besoin dans sa religion, qui sont demandées — c'étaient les questions des Compagnons — ; et celles posées par entêtement ou pour se compliquer les choses, qui sont blâmées.

4. Ce que l'élève peut retenir
- Ce hadith pose une règle : accomplir ce qui est ordonné et éviter ce qui est interdit.
- L'accomplissement de l'ordre est lié à la capacité de chacun.
- Poser des questions pour apprendre est une bonne chose ; poser des questions pour compliquer ou contredire est blâmable.
- La communauté doit se garder de s'opposer à son Prophète ﷺ, comme l'ont fait des communautés avant elle.

Exercice : donnez un exemple d'ordre que l'on accomplit selon sa capacité, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, ord, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, (select coalesce(max(ord), 0) from public.content_references) + v.k, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$9$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Ce que je vous ai interdit, évitez-le, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:9$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$7288$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre de l'attachement au Coran et à la Sunna$x$, null, null, $x$https://sunnah.com/bukhari:7288$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1337$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre du pèlerinage$x$, null, null, $x$https://sunnah.com/muslim:1337a$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66517$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66517$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) returning 1),
qq as (insert into public.content_questions (revision_id, ord, prompt, options, answer, explanation)
       select rv.id, (select coalesce(max(ord), 0) from public.content_questions) + v.k, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que faut-il faire de ce que le Prophète ﷺ a interdit ?$x$, array[$x$L'éviter entièrement$x$, $x$En faire un peu$x$, $x$Le faire selon ses capacités$x$]::text[], 0, $x$« Ce que je vous ai interdit, évitez-le. »$x$),
  (2, $x$Comment accomplit-on ce qui est ordonné ?$x$, array[$x$Selon ses capacités$x$, $x$Seulement si on en a envie$x$, $x$Jamais$x$]::text[], 0, $x$« Faites-en ce que vous pouvez. »$x$),
  (3, $x$Pourquoi l'interdit et l'ordre sont-ils traités différemment ?$x$, array[$x$S'abstenir est à la portée de tous, agir demande une capacité$x$, $x$L'ordre est moins important$x$, $x$L'interdit est facultatif$x$]::text[], 0, $x$L'ordre est lié à la capacité, l'abstention est possible pour tous.$x$),
  (4, $x$Qu'est-ce qui a fait périr des communautés passées ?$x$, array[$x$Leurs nombreuses questions et leurs divergences avec leurs prophètes$x$, $x$Leur pauvreté$x$, $x$Leurs voyages$x$]::text[], 0, $x$C'est la mise en garde de la fin du hadith.$x$),
  (5, $x$Quelle sorte de questions est louable ?$x$, array[$x$Celles qui servent à apprendre sa religion$x$, $x$Celles posées par entêtement$x$, $x$Celles qui compliquent les choses$x$]::text[], 0, $x$C'était la manière de questionner des Compagnons.$x$)) v(k, p, o, a, e) returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 9 d'an-Nawawī$x$),
       rv.h = 'aa0b36d91109f5a98183bfe9f0255841' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
