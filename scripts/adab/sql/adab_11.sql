-- Bonnes manières 11 : l-humilite-et-la-modestie
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$l-humilite-et-la-modestie$x$, 'lesson', $x$adab$x$, 'fr', 11) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$L'humilité et la modestie$x$, $x$Les serviteurs du Tout Miséricordieux marchent humblement ; Luqman et la démarche ; « celui qui s'humilie pour Allah, Allah l'élève » ; Allah a révélé : soyez humbles, que nul ne se vante ; l'humilité du Prophète ﷺ dans sa maison et son refus d'être exagérément louangé ; la fin de l'homme orgueilleux.$x$, $x$1. L'humilité dans le Coran
Allah décrit les serviteurs du Tout Miséricordieux : ils marchent sur la terre avec humilité, et quand les ignorants leur adressent la parole, ils répondent par la paix (sourate al-Furqān, 25:63). Luqmān conseilla à son fils de ne pas détourner son visage des gens par orgueil, de ne pas marcher sur terre avec arrogance, d'être mesuré dans sa démarche et de baisser la voix (sourate Luqmān, 31:18-19). Allah dit aussi : ne marche pas sur terre avec arrogance, tu ne fendras pas la terre et n'atteindras pas la hauteur des montagnes (sourate al-Isrā’, 17:37). Et la demeure de l'au-delà est pour ceux qui ne cherchent ni à s'élever sur terre ni à y semer le désordre (sourate al-Qaṣaṣ, 28:83).

2. Celui qui s'humilie pour Allah est élevé
Le Prophète ﷺ a dit :
« مَا نَقَصَتْ صَدَقَةٌ مِنْ مَالٍ وَمَا زَادَ اللَّهُ عَبْدًا بِعَفْوٍ إِلاَّ عِزًّا وَمَا تَوَاضَعَ أَحَدٌ لِلَّهِ إِلاَّ رَفَعَهُ اللَّهُ » (mā naqaṣat ṣadaqatun min māl, wa mā zāda llāhu ʿabdan bi-ʿafwin illā ʿizzā, wa mā tawāḍaʿa aḥadun li-llāhi illā rafaʿahu llāh).
Sens : « Une aumône ne diminue en rien un bien ; Allah n'augmente le serviteur qui pardonne qu'en honneur ; et nul ne s'humilie pour Allah sans qu'Allah l'élève. » (Muslim n° 2588, d'après Abū Hurayra ; hadith authentique).

3. Que nul ne se vante
Dans un sermon, le Prophète ﷺ a dit qu'Allah lui a révélé :
« أَنْ تَوَاضَعُوا حَتَّى لاَ يَفْخَرَ أَحَدٌ عَلَى أَحَدٍ وَلاَ يَبْغِي أَحَدٌ عَلَى أَحَدٍ » (an tawāḍaʿū ḥattā lā yafkhara aḥadun ʿalā aḥad, wa lā yabghī aḥadun ʿalā aḥad).
Sens : « Soyez humbles, afin que nul ne se vante devant un autre et que nul ne soit injuste envers un autre. » (Muslim n° 2865, d'après ʿIyāḍ ibn Ḥimār ; hadith authentique).
Rappel : l'orgueil, c'est rejeter la vérité et mépriser les gens (Muslim n° 91 ; voir la leçon « La propreté, la tenue et l'humilité dans l'habit »).

4. L'humilité du Prophète ﷺ
On demanda à ʿĀ’isha ce que faisait le Prophète ﷺ chez lui ; elle répondit qu'il était au service de sa famille, et que lorsque venait l'heure de la prière, il sortait pour prier (al-Bukhārī n° 676).
Il a dit : ne m'exagérez pas dans la louange comme les chrétiens l'ont fait pour le fils de Maryam ; je ne suis que Son serviteur : dites « le serviteur d'Allah et Son Messager » (al-Bukhārī n° 3445, d'après ʿUmar).

5. La fin de l'orgueilleux
Le Prophète ﷺ raconta qu'un homme marchait dans un bel habit, admiratif de lui-même, les cheveux bien peignés, quand Allah le fit engloutir par la terre ; il s'y enfonce jusqu'au Jour de la Résurrection (al-Bukhārī n° 5789, d'après Abū Hurayra).

6. Ce que l'élève peut retenir
- Le croyant marche avec humilité et répond à l'ignorant par la paix.
- Celui qui s'humilie pour Allah, Allah l'élève.
- Nul ne se vante devant les autres ni n'est injuste envers eux.
- Le Prophète ﷺ aidait sa famille et refusait l'exagération dans sa louange.
- L'admiration de soi et l'orgueil mènent à la perte.

Exercice : cette semaine, rendez un service à la maison sans qu'on vous le demande, et saluez le premier ceux que vous rencontrez, puis répondez aux questions.$x$, true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$quran$x$::public.reference_kind, 25::int, 63::int, 63::int, null, null, null, null, null, null, null, null, null, null),
  (2, $x$quran$x$::public.reference_kind, 31::int, 18::int, 19::int, null, null, null, null, null, null, null, null, null, null),
  (3, $x$quran$x$::public.reference_kind, 17::int, 37::int, 37::int, null, null, null, null, null, null, null, null, null, null),
  (4, $x$quran$x$::public.reference_kind, 28::int, 83::int, 83::int, null, null, null, null, null, null, null, null, null, null),
  (5, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2588$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Nul ne s'humilie pour Allah sans qu'Allah l'élève », d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/muslim:2588$x$, $x$Parole du Prophète ﷺ copiée telle quelle de l'édition de sunnah.com (base hadith-api).$x$),
  (6, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$2865d$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$« Soyez humbles, afin que nul ne se vante », d'après ʿIyāḍ ibn Ḥimār$x$, null, null, $x$https://sunnah.com/muslim:2865d$x$, $x$Passage copié tel quel de l'édition de sunnah.com (base hadith-api) ; cette phrase figure dans cette voie du hadith.$x$),
  (7, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ Muslim$x$, $x$Numérotation de sunnah.com$x$, $x$91a$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique de Muslim$x$, $x$La définition de l'orgueil, d'après Ibn Masʿūd$x$, null, null, $x$https://sunnah.com/muslim:91a$x$, null),
  (8, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$676$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Le Prophète ﷺ au service de sa famille, d'après ʿĀ’isha$x$, null, null, $x$https://sunnah.com/bukhari:676$x$, null),
  (9, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$3445$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$« Ne m'exagérez pas dans la louange », d'après ʿUmar$x$, null, null, $x$https://sunnah.com/bukhari:3445$x$, null),
  (10, $x$hadith$x$::public.reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$5789$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$L'homme admiratif de lui-même englouti par la terre, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/bukhari:5789$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Comment marchent les serviteurs du Tout Miséricordieux ?$x$, array[$x$Avec humilité$x$, $x$Avec arrogance$x$, $x$En se pressant$x$]::text[], 0, $x$Sourate al-Furqān, 25:63.$x$),
  (2, $x$Que conseilla Luqmān à son fils ?$x$, array[$x$De ne pas marcher avec arrogance et de baisser la voix$x$, $x$De crier pour se faire entendre$x$, $x$De se détourner des gens$x$]::text[], 0, $x$Sourate Luqmān, 31:18-19.$x$),
  (3, $x$Que fait Allah pour celui qui s'humilie pour Lui ?$x$, array[$x$Il l'élève$x$, $x$Il l'abaisse$x$, $x$Rien$x$]::text[], 0, $x$Muslim n° 2588.$x$),
  (4, $x$L'aumône diminue-t-elle le bien selon le hadith ?$x$, array[$x$Non$x$, $x$Oui, toujours$x$, $x$Seulement le vendredi$x$]::text[], 0, $x$Muslim n° 2588.$x$),
  (5, $x$Pourquoi Allah a-t-il ordonné l'humilité dans le hadith de ʿIyāḍ ibn Ḥimār ?$x$, array[$x$Pour que nul ne se vante ni ne soit injuste envers un autre$x$, $x$Pour s'enrichir$x$, $x$Pour être célèbre$x$]::text[], 0, $x$Muslim n° 2865.$x$),
  (6, $x$Que faisait le Prophète ﷺ dans sa maison selon ʿĀ’isha ?$x$, array[$x$Il était au service de sa famille$x$, $x$Il se faisait tout servir$x$, $x$Il dormait$x$]::text[], 0, $x$Al-Bukhārī n° 676.$x$),
  (7, $x$Comment le Prophète ﷺ a-t-il demandé qu'on l'appelle ?$x$, array[$x$Le serviteur d'Allah et Son Messager$x$, $x$Le fils d'Allah$x$, $x$Un ange$x$]::text[], 0, $x$Al-Bukhārī n° 3445.$x$),
  (8, $x$Qu'arriva-t-il à l'homme admiratif de lui-même dans le hadith ?$x$, array[$x$La terre l'engloutit$x$, $x$Il devint roi$x$, $x$Rien$x$]::text[], 0, $x$Al-Bukhārī n° 5789.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : Bonnes manières 11$x$),
       rv.h = '14203e8fdb9e1df0e6fe28a94db58ec3' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
