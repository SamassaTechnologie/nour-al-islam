-- Hadith 14 d'an-Nawawī : nawawi-14-le-sang-du-musulman-est-sacre
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-14-le-sang-du-musulman-est-sacre$x$, 'lesson', 'hadith', 'fr', 14) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 14 : le sang du musulman est sacré$x$, $x$La vie du musulman est inviolable ; la Loi n'en permet l'atteinte que dans trois cas précis, jugés et appliqués par l'autorité légitime.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:14}}

Traduction du sens : D'après Ibn Masʿūd : le Messager d'Allah ﷺ a dit : « Il n'est permis de verser le sang d'un musulman [qui atteste qu'il n'y a de divinité digne d'adoration qu'Allah et que je suis le Messager d'Allah] que dans l'un de ces trois cas : la personne mariée qui commet l'adultère, la vie pour la vie, et celui qui abandonne sa religion en se séparant de la communauté. » Rapporté par al-Bukhārī (n° 6878) et Muslim (n° 1676). Hadith authentique.

2. La phrase à retenir
« {{NAWX:14:90:123}} » (lā yaḥillu damu mriʾin muslim).
Sens : « Il n'est permis de verser le sang d'un musulman que… »

3. Explication
Le principe posé par ce hadith est que le sang du musulman est interdit et sacré. Le Prophète ﷺ ne cite que trois exceptions (selon HadeethEnc) :
- la personne mariée, liée par un mariage valide, qui commet l'adultère ;
- celui qui tue volontairement et injustement une personne innocente : c'est le talion, avec ses conditions ;
- celui qui quitte la communauté des musulmans en abandonnant sa religion ; HadeethEnc y rattache aussi ceux qui se séparent de la communauté par les armes, comme les brigands et les rebelles qui combattent.

Point essentiel : ces peines font partie des jugements de la Loi islamique. Leur application relève exclusivement du détenteur de l'autorité (selon HadeethEnc) : elles s'appliquent selon des conditions précises fixées par la Loi. Aucun individu n'a le droit de les appliquer lui-même.

4. Ce que l'élève peut retenir
- Le respect du musulman est obligatoire : son sang est inviolable.
- Ce hadith appelle à protéger l'honneur et la pureté des mœurs.
- Il encourage à rester attaché à la communauté des musulmans et à ne pas s'en séparer.
- La méthode du Prophète ﷺ : il énumérait parfois les choses (ici, trois cas), ce qui aide à les retenir.

Exercice : expliquez pourquoi ce hadith commence par une interdiction avant de citer les exceptions, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$14$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī et Muslim$x$, $x$Il n'est permis de verser le sang d'un musulman que dans trois cas, d'après Ibn Masʿūd$x$, null, null, $x$https://sunnah.com/nawawi40:14$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6878$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre des prix du sang$x$, null, null, $x$https://sunnah.com/bukhari:6878$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$1676$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre des serments et du talion$x$, null, null, $x$https://sunnah.com/muslim:1676a$x$, null),
  (4, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 4714$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/4714$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Quel est le principe de base posé par ce hadith ?$x$, array[$x$Le sang du musulman est sacré$x$, $x$Chacun peut se faire justice$x$, $x$La vie n'a pas d'importance$x$]::text[], 0, $x$Le hadith commence par l'interdiction : « Il n'est permis de verser le sang d'un musulman que… »$x$),
  (2, $x$Combien d'exceptions le hadith cite-t-il ?$x$, array[$x$Une$x$, $x$Trois$x$, $x$Dix$x$]::text[], 1, $x$Trois cas précis, et aucun autre.$x$),
  (3, $x$À qui revient l'application de ces peines selon HadeethEnc ?$x$, array[$x$Au détenteur de l'autorité$x$, $x$À n'importe quel individu$x$, $x$À la famille seule, sans jugement$x$]::text[], 0, $x$Elle fait partie des prérogatives exclusives de l'autorité légitime.$x$),
  (4, $x$Que signifie « la vie pour la vie » ?$x$, array[$x$Le talion pour un meurtre volontaire et injuste, avec ses conditions$x$, $x$Venger toute dispute$x$, $x$Le prix d'un achat$x$]::text[], 0, $x$Il s'agit du meurtrier volontaire d'une personne innocente, jugé selon les conditions de la Loi.$x$),
  (5, $x$Ce hadith encourage-t-il à se séparer de la communauté des musulmans ?$x$, array[$x$Oui$x$, $x$Non, il encourage à y rester attaché$x$]::text[], 1, $x$HadeethEnc en tire l'incitation à rester attaché à la communauté.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 14 d'an-Nawawī$x$),
       rv.h = '1ba5738efb8d24edf708a24c0c49a6cf' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
