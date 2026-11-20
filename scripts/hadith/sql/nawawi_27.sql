-- Hadith 27 d'an-Nawawī : nawawi-27-la-bonte-et-le-peche
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-27-la-bonte-et-le-peche$x$, 'lesson', 'hadith', 'fr', 27) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 27 : la bonté, c'est le bon caractère$x$, $x$La bonté (al-birr) est le bon caractère ; le péché est ce qui trouble le cœur et que l'on n'aimerait pas voir découvert par les gens.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:27}}

Traduction du sens : D'après an-Nawwās ibn Samʿān : le Prophète ﷺ a dit : « La bonté, c'est le bon caractère ; et le péché, c'est ce qui te trouble intérieurement et que tu détesterais que les gens découvrent. » Rapporté par Muslim (n° 2553). Hadith authentique.
Et d'après Wābiṣa ibn Maʿbad, qui a dit : je suis venu voir le Messager d'Allah ﷺ et il a dit : « Tu es venu demander ce qu'est la bonté ? » J'ai répondu : « Oui. » Il a dit : « Consulte ton cœur. La bonté, c'est ce qui apaise l'âme et tranquillise le cœur ; et le péché, c'est ce qui trouble l'âme et fait hésiter le cœur, même si les gens te donnent un avis, encore et encore. » An-Nawawī a dit : hadith ḥasan, rapporté dans les Musnad des imams Aḥmad et ad-Dārimī avec une chaîne ḥasan.

2. La phrase à retenir
« {{NAWX:27:96:121}} » (al-birru ḥusnu l-khuluq).
Sens : « La bonté, c'est le bon caractère. »

3. Explication
Selon HadeethEnc :
- La plus haute des œuvres de bien est le bon caractère : la belle parole, le maintien des liens, l'obéissance, la douceur, la bienfaisance et la bonne compagnie.
- Le péché est ce qui agite l'âme dans les choses ambiguës et laisse le cœur hésitant, au point qu'on n'aimerait pas être vu par les gens de bien en le faisant ; car l'âme aime que les gens voient ses belles œuvres, et non ses laideurs.
- « Même si les gens te donnent un avis » : l'avis des gens n'enlève pas ce doute lorsqu'il est donné sans science. HadeethEnc cite as-Sindī : cela concerne les affaires ambiguës ; lorsqu'une preuve claire de la Loi existe, c'est elle que l'on suit.

4. Ce que l'élève peut retenir
- Ce hadith encourage aux nobles caractères, qui font partie des plus grandes formes de bonté.
- Le croyant reconnaît la vérité grâce à la lumière de son cœur, et il s'éloigne du faux.
- Parmi les signes du péché : l'inquiétude du cœur et le fait de ne pas vouloir que les gens le sachent.
- Consulter son cœur ne remplace pas une preuve claire du Coran ou de la Sunna.

Exercice : expliquez avec vos mots ce que signifie « consulte ton cœur » et sa limite, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$27$x$, $x$Authentique (Muslim) ; ḥasan selon an-Nawawī pour la version de Wābiṣa$x$, $x$Muslim ; an-Nawawī$x$, $x$La bonté, c'est le bon caractère, d'après an-Nawwās ibn Samʿān et Wābiṣa ibn Maʿbad$x$, null, null, $x$https://sunnah.com/nawawi40:27$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2553$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$Livre de la bonté et des liens de parenté$x$, null, null, $x$https://sunnah.com/muslim:2553a$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66540$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66540$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Que signifie « al-birru ḥusnu l-khuluq » ?$x$, array[$x$La bonté, c'est le bon caractère$x$, $x$La bonté, c'est la richesse$x$, $x$La bonté, c'est le silence$x$]::text[], 0, $x$Le bon caractère est la plus haute des œuvres de bien.$x$),
  (2, $x$Quel est un signe du péché selon ce hadith ?$x$, array[$x$Il trouble le cœur et l'on n'aimerait pas que les gens le découvrent$x$, $x$Il rend heureux en public$x$, $x$Il est toujours facile$x$]::text[], 0, $x$« Ce qui te trouble intérieurement et que tu détesterais que les gens découvrent. »$x$),
  (3, $x$Qui a rapporté la seconde version (« consulte ton cœur ») ?$x$, array[$x$Wābiṣa ibn Maʿbad$x$, $x$Abū Bakr$x$, $x$Anas ibn Mālik$x$]::text[], 0, $x$An-Nawawī la mentionne d'après les Musnad d'Aḥmad et d'ad-Dārimī.$x$),
  (4, $x$Quel grade an-Nawawī donne-t-il à la version de Wābiṣa ?$x$, array[$x$Ḥasan$x$, $x$Faible$x$, $x$Inventé$x$]::text[], 0, $x$Il dit : hadith ḥasan, avec une chaîne ḥasan.$x$),
  (5, $x$Quand une preuve claire de la Loi existe, que suit-on ?$x$, array[$x$La preuve$x$, $x$Seulement son impression$x$, $x$L'avis de la majorité sans preuve$x$]::text[], 0, $x$HadeethEnc cite as-Sindī : « consulte ton cœur » concerne les affaires ambiguës.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 27 d'an-Nawawī$x$),
       rv.h = 'acffc432d769586115b1581a6cf2b386' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
