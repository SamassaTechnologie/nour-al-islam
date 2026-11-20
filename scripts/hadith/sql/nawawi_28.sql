-- Hadith 28 d'an-Nawawī : nawawi-28-attachez-vous-a-ma-sunna
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-28-attachez-vous-a-ma-sunna$x$, 'lesson', 'hadith', 'fr', 28) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 28 : attachez-vous à ma Sunna$x$, $x$Une exhortation d'adieu : craindre Allah, écouter et obéir aux dirigeants dans le bien, s'attacher à la Sunna du Prophète ﷺ et des califes bien guidés, et se garder des innovations.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:28}}

Traduction du sens : D'après Abū Najīḥ al-ʿIrbāḍ ibn Sāriya, qui a dit : le Messager d'Allah ﷺ nous a fait une exhortation qui a fait trembler les cœurs et couler les larmes. Nous avons dit : « Ô Messager d'Allah ! On dirait l'exhortation de quelqu'un qui fait ses adieux : fais-nous donc une recommandation. » Il a dit : « Je vous recommande la crainte d'Allah, l'écoute et l'obéissance, même si c'est un esclave qui est placé à votre tête. Celui d'entre vous qui vivra verra de nombreuses divergences : attachez-vous alors à ma Sunna et à la Sunna des califes bien guidés et guidants ; serrez-la avec les molaires. Et gardez-vous des choses nouvelles, car toute innovation est un égarement. » Rapporté par Abū Dāwūd (n° 4607) et at-Tirmidhī (n° 2676), qui a dit : hadith ḥasan ṣaḥīḥ.

2. La phrase à retenir
« {{NAWX:28:429:503}} » (fa-ʿalaykum bi-sunnatī wa sunnati l-khulafāʾi r-rāshidīna l-mahdiyyīn).
Sens : « Attachez-vous à ma Sunna et à la Sunna des califes bien guidés. »

3. Explication
Le Prophète ﷺ a fait une exhortation si éloquente que les Compagnons ont pensé à des adieux ; ils lui ont alors demandé une recommandation à laquelle s'accrocher après lui (selon HadeethEnc) :
- La crainte d'Allah : accomplir les obligations et laisser les interdits.
- L'écoute et l'obéissance aux dirigeants, même si celui qui commande est de condition modeste, pour éviter les troubles — sauf s'il ordonne une désobéissance à Allah.
- Lors des divergences : revenir à la Sunna du Prophète ﷺ et à celle des quatre califes bien guidés : Abū Bakr, ʿUmar, ʿUthmān et ʿAlī.
- Se garder des innovations dans la religion : toute innovation est un égarement.

4. Ce que l'élève peut retenir
- L'attachement à la Sunna et son suivi sont essentiels.
- Les exhortations qui adoucissent les cœurs ont leur importance.
- La divergence surviendra dans la communauté ; le devoir est alors de revenir à la Sunna.
- Ce hadith rejoint le hadith 5 : les nouveautés dans la religion sont rejetées.

Exercice : citez les quatre recommandations du Prophète ﷺ dans ce hadith, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$28$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Attachez-vous à ma Sunna, d'après al-ʿIrbāḍ ibn Sāriya$x$, null, null, $x$https://sunnah.com/nawawi40:28$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan Abī Dāwūd$x$, $x$Numérotation de sunnah.com$x$, $x$4607$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$HadeethEnc$x$, $x$Livre de la Sunna$x$, null, null, $x$https://sunnah.com/abudawud:4607$x$, null),
  (3, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Jāmiʿ at-Tirmidhī$x$, $x$Numérotation de sunnah.com$x$, $x$2676$x$, $x$Ḥasan ṣaḥīḥ$x$, $x$At-Tirmidhī$x$, $x$Livre de la science$x$, null, null, $x$https://sunnah.com/tirmidhi:2676$x$, $x$Le texte d'an-Nawawī indique « 266 », probable erreur de numérotation dans l'édition.$x$),
  (4, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Sunan Ibn Mājah$x$, $x$Numérotation de sunnah.com$x$, $x$42$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$HadeethEnc$x$, $x$Introduction$x$, null, null, $x$https://sunnah.com/ibnmajah:42$x$, null),
  (5, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66529$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66529$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Comment les Compagnons ont-ils décrit l'exhortation du Prophète ﷺ ?$x$, array[$x$Comme une exhortation d'adieu$x$, $x$Comme une plaisanterie$x$, $x$Comme un récit historique$x$]::text[], 0, $x$« On dirait l'exhortation de quelqu'un qui fait ses adieux. »$x$),
  (2, $x$Que faut-il faire lors des divergences ?$x$, array[$x$S'attacher à la Sunna du Prophète ﷺ et des califes bien guidés$x$, $x$Suivre chacun son avis$x$, $x$Abandonner la religion$x$]::text[], 0, $x$« Attachez-vous à ma Sunna… serrez-la avec les molaires. »$x$),
  (3, $x$Qui sont les quatre califes bien guidés ?$x$, array[$x$Abū Bakr, ʿUmar, ʿUthmān et ʿAlī$x$, $x$Abū Hurayra, Anas, Ibn ʿAbbās et ʿĀʾisha$x$, $x$Les quatre imams des écoles de jurisprudence$x$]::text[], 0, $x$HadeethEnc les nomme dans les enseignements du hadith.$x$),
  (4, $x$Doit-on obéir au dirigeant s'il ordonne une désobéissance à Allah ?$x$, array[$x$Non$x$, $x$Oui, toujours$x$]::text[], 0, $x$L'obéissance est due sauf en cas de désobéissance à Allah.$x$),
  (5, $x$Que dit le hadith de toute innovation dans la religion ?$x$, array[$x$C'est un égarement$x$, $x$C'est une bonne chose$x$, $x$C'est obligatoire$x$]::text[], 0, $x$« Toute innovation est un égarement. »$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 28 d'an-Nawawī$x$),
       rv.h = 'c4ef8783d9c4dc5e42984c7de96f9028' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
