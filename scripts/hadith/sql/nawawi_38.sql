-- Hadith 38 d'an-Nawawī : nawawi-38-les-allies-d-allah
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ($x$nawawi-38-les-allies-d-allah$x$, 'lesson', 'hadith', 'fr', 38) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, $x$Hadith 38 : les alliés d'Allah (hadith qudsī)$x$, $x$Allah déclare la guerre à qui s'attaque à Ses alliés ; le serviteur se rapproche de Lui d'abord par les obligations, puis par les œuvres volontaires, jusqu'à ce qu'Allah l'aime.$x$, private.nawawi_fill($x$1. Le texte du hadith

{{NAW:38}}

Traduction du sens : D'après Abū Hurayra : le Messager d'Allah ﷺ a dit : « Allah, le Très-Haut, a dit : Quiconque se montre hostile à l'un de Mes alliés, Je lui déclare la guerre. Mon serviteur ne se rapproche pas de Moi par une chose que J'aime davantage que ce que Je lui ai rendu obligatoire. Et Mon serviteur ne cesse de se rapprocher de Moi par les œuvres surérogatoires jusqu'à ce que Je l'aime. Et lorsque Je l'aime, Je suis son ouïe par laquelle il entend, sa vue par laquelle il voit, sa main avec laquelle il saisit et son pied avec lequel il marche. S'il Me demande, Je lui donnerai certes ; et s'il cherche refuge auprès de Moi, Je lui accorderai certes refuge. » Rapporté par al-Bukhārī (n° 6502). Hadith authentique.

2. La phrase à retenir
« {{NAWX:38:118:169}} » (man ʿādā lī waliyyan fa-qad ādhantuhu bi-l-ḥarb).
Sens : « Quiconque se montre hostile à l'un de Mes alliés, Je lui déclare la guerre. »

3. Explication
Selon HadeethEnc :
- L'allié d'Allah (al-walī) est le croyant pieux. Chaque serviteur a une part de l'alliance d'Allah à la mesure de sa foi et de sa piété.
- Rien n'est plus aimé d'Allah que ce qu'Il a rendu obligatoire : accomplir les obligations et laisser les interdits. Viennent ensuite les œuvres volontaires, par lesquelles le serviteur continue de se rapprocher d'Allah.
- « Je suis son ouïe… » : Allah guide ce serviteur dans son ouïe, sa vue, ses mains et ses pieds. Il n'écoute alors que ce qui plaît à Allah, ne regarde que ce qu'Il aime, n'agit de ses mains que pour ce qui Le satisfait et ne marche que vers ce qui Lui plaît.

4. Ce que l'élève peut retenir
- C'est un hadith qudsī : le Prophète ﷺ le rapporte de son Seigneur, mais il ne fait pas partie du Coran et n'en a pas les caractéristiques.
- Il est interdit de nuire aux alliés d'Allah ; il faut les aimer et reconnaître leur mérite.
- Les obligations passent avant les œuvres volontaires.
- Les œuvres volontaires sont une cause de l'amour d'Allah.

Exercice : citez une obligation et une œuvre volontaire par lesquelles on se rapproche d'Allah, puis répondez aux questions.$x$), true, $x$Claude (assistant IA)$x$ from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note)
      select rv.id, v.kind, v.surah, v.ayah_from, v.ayah_to, v.collection, v.edition, v.hadith_number, v.grade, v.graded_by, v.source_title, v.author, v.locator, v.url, v.note
      from rv, (values
  (1, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Les Quarante hadiths d'an-Nawawī$x$, $x$Numérotation de sunnah.com$x$, $x$38$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Al-Bukhārī$x$, $x$Quiconque se montre hostile à l'un de Mes alliés, d'après Abū Hurayra$x$, null, null, $x$https://sunnah.com/nawawi40:38$x$, $x$Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).$x$),
  (2, $x$hadith$x$::reference_kind, null::int, null::int, null::int, $x$Ṣaḥīḥ al-Bukhārī$x$, $x$Numérotation de sunnah.com$x$, $x$6502$x$, $x$Authentique (ṣaḥīḥ)$x$, $x$Recueil authentique d'al-Bukhārī$x$, $x$Livre des choses qui attendrissent les cœurs$x$, null, null, $x$https://sunnah.com/bukhari:6502$x$, null),
  (3, $x$book$x$::reference_kind, null::int, null::int, null::int, null, null, null, null, null, $x$Encyclopédie des hadiths traduits (HadeethEnc), hadith n° 66534$x$, $x$HadeethEnc$x$, $x$Explication et enseignements$x$, $x$https://hadeethenc.com/fr/browse/hadith/66534$x$, null)) v(k, kind, surah, ayah_from, ayah_to, collection, edition, hadith_number, grade, graded_by, source_title, author, locator, url, note) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  (1, $x$Qui est l'allié d'Allah (al-walī) selon HadeethEnc ?$x$, array[$x$Le croyant pieux$x$, $x$Toute personne riche$x$, $x$Celui qui fait des miracles$x$]::text[], 0, $x$Chacun a une part de l'alliance d'Allah selon sa foi et sa piété.$x$),
  (2, $x$Qu'est-ce qu'Allah aime le plus pour se rapprocher de Lui ?$x$, array[$x$Ce qu'Il a rendu obligatoire$x$, $x$Les œuvres volontaires seulement$x$, $x$Les voyages$x$]::text[], 0, $x$« Par une chose que J'aime davantage que ce que Je lui ai rendu obligatoire. »$x$),
  (3, $x$Que produisent les œuvres volontaires accomplies avec constance ?$x$, array[$x$L'amour d'Allah$x$, $x$La richesse$x$, $x$La célébrité$x$]::text[], 0, $x$« Jusqu'à ce que Je l'aime. »$x$),
  (4, $x$Que signifie « Je suis son ouïe par laquelle il entend » selon HadeethEnc ?$x$, array[$x$Allah le guide : il n'écoute que ce qui Lui plaît$x$, $x$Il entend tout ce qui se passe dans le monde$x$, $x$Il devient sourd$x$]::text[], 0, $x$Allah guide ses sens et ses membres vers ce qui Lui plaît.$x$),
  (5, $x$Quel type de hadith est-ce ?$x$, array[$x$Un hadith qudsī$x$, $x$Un verset du Coran$x$, $x$Une parole d'un savant$x$]::text[], 0, $x$Le Prophète ﷺ le rapporte de son Seigneur.$x$)) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, $x$Brouillon rédigé par l'IA : hadith 38 d'an-Nawawī$x$),
       rv.h = 'ff4714ed169159ae218cefba71cc956b' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
