-- Hadith 35 d'an-Nawawī : nawawi-35-le-musulman-est-le-frere-du-musulman
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-35-le-musulman-est-le-frere-du-musulman$x$, 'lesson', 'hadith', 'fr', 35) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 35 : le musulman est le frère du musulman$x$, $x$Ne vous enviez pas, ne vous haïssez pas, ne vous tournez pas le dos : soyez des serviteurs d'Allah, frères. Le sang, les biens et l'honneur du musulman sont sacrés.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:35}}

Traduction du sens : D'après Abū Hurayra : le Messager d'Allah ﷺ a dit : « Ne vous enviez pas, ne surenchérissez pas les uns sur les autres pour tromper, ne vous haïssez pas, ne vous tournez pas le dos, et que l'un de vous ne vende pas par-dessus la vente de son frère. Soyez, ô serviteurs d'Allah, des frères. Le musulman est le frère du musulman : il ne lui fait pas d'injustice, il ne l'abandonne pas, il ne lui ment pas et il ne le méprise pas. La piété est ici — et il montrait sa poitrine, trois fois. Il suffit comme mal à une personne de mépriser son frère musulman. Tout le musulman est sacré pour le musulman : son sang, ses biens et son honneur. » Rapporté par Muslim (n° 2564). Hadith authentique.

2. La phrase à retenir
« {{NAWX:35:247:276}} » (al-muslimu akhū l-muslim).
Sens : « Le musulman est le frère du musulman. »

3. Explication
Le Prophète ﷺ recommande au musulman le bien envers son frère et lui explique ses devoirs (selon HadeethEnc) :
- Ne pas s'envier : ne pas souhaiter que le bienfait d'un autre disparaisse.
- Ne pas surenchérir : ne pas faire monter le prix d'une marchandise que l'on ne veut pas acheter, pour avantager le vendeur ou nuire à l'acheteur.
- Ne pas se haïr ; la seule exception est la haine pour Allah.
- « La piété est ici » : la base de la piété est dans le cœur : la connaissance d'Allah, Sa crainte et la conscience qu'Il nous voit.

4. Ce que l'élève peut retenir
- Il faut accomplir tout ce qu'implique la fraternité en Allah, et éviter ce qui s'y oppose en paroles et en actes.
- La piété du cœur produit les bonnes œuvres ; les écarts visibles montrent une faiblesse de la piété du cœur.
- Il est interdit de nuire au musulman sous toutes ses formes.
- Souhaiter avoir le même bien qu'un autre, sans vouloir qu'il le perde, n'est pas de l'envie : c'est une saine émulation (selon HadeethEnc).

Exercice : citez trois interdits de ce hadith et expliquez pourquoi ils abîment la fraternité, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$35$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Muslim$x$, $x$Ne vous enviez pas… le musulman est le frère du musulman, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:35$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2564$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la bonté et des liens de parenté$x$, null, null, $x$https://sunnah.com/muslim:2564a$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4706$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4706$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « al-muslimu akhū l-muslim » ?$x$, array[$x$Le musulman est le frère du musulman$x$, $x$Le musulman est le voisin du musulman$x$, $x$Le musulman est le maître du musulman$x$]::text[], 0, $x$C'est le cœur de ce hadith.$x$),
  (2, $x$Où se trouve la piété selon ce hadith ?$x$, array[$x$Dans le cœur$x$, $x$Dans les vêtements$x$, $x$Dans la richesse$x$]::text[], 0, $x$Le Prophète ﷺ montrait sa poitrine : « La piété est ici. »$x$),
  (3, $x$Qu'est-ce que l'envie interdite ?$x$, array[$x$Souhaiter que le bienfait d'un autre disparaisse$x$, $x$Souhaiter avoir le même bien sans qu'il le perde$x$, $x$Admirer quelqu'un$x$]::text[], 0, $x$Souhaiter le même bien sans vouloir qu'il disparaisse est une saine émulation.$x$),
  (4, $x$Qu'est-ce qui est sacré pour le musulman chez son frère ?$x$, array[$x$Son sang, ses biens et son honneur$x$, $x$Seulement ses biens$x$, $x$Rien$x$]::text[], 0, $x$« Son sang, ses biens et son honneur. »$x$),
  (5, $x$Que suffit-il comme mal à une personne ?$x$, array[$x$Mépriser son frère musulman$x$, $x$Être pauvre$x$, $x$Être malade$x$]::text[], 0, $x$« Il suffit comme mal à une personne de mépriser son frère musulman. »$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 35 d'an-Nawawī$x$),
       rv.h = 'dcb4491b0122ffd2b6d86baf6025eeb2' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
