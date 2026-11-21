"""Construit le SQL des catégories d'invocations 5 à 8 (voyage, repas, maison, épreuves).

Le texte arabe n'est jamais écrit ici : chaque invocation donne la clé d'un passage découpé par extract.py
dans /tmp/h/adhkar.json (caractères exacts de l'édition de sunnah.com). L'empreinte md5 de l'ensemble des
textes arabes est vérifiée par la base au moment de l'insertion.
Usage : python3 extract.py && python3 build_sql.py   (écrit scripts/adhkar/sql/adhkar_05_08.sql)
"""
import hashlib, json, os

HERE = os.path.dirname(os.path.abspath(__file__))
AUTHOR = 'Claude (assistant IA)'
SRC = json.load(open('/tmp/h/adhkar.json'))
NAMES = {'bukhari': 'Ṣaḥīḥ al-Bukhārī', 'muslim': 'Ṣaḥīḥ Muslim', 'abudawud': 'Sunan Abī Dāwūd'}
SAHIH = 'Authentique (ṣaḥīḥ)'
BY = {'bukhari': "Recueil authentique d'al-Bukhārī", 'muslim': 'Recueil authentique de Muslim'}
ALBANI = 'Al-Albānī (jugement affiché sur sunnah.com)'

def num(c, n):
    """Numéro affiché par sunnah.com : 918.01 -> 918a."""
    if '.' in n:
        a, b = n.split('.'); return a + 'abcdefghij'[int(b) - 1]
    return n

def d(key, title, translit, meaning, when=None, virtue=None, note=None, grade=SAHIH, by=None, repeat=1):
    s = SRC[key]; c, n = s['collection'], s['number']
    return dict(title=title, arabic=s['arabic'], transliteration=translit, meaning=meaning, repeat_count=repeat,
                when_to_say=when, virtue=virtue, collection=NAMES[c], hadith_number=num(c, n), grade=grade,
                graded_by=by or BY.get(c, ALBANI), url=f'https://sunnah.com/{c}:{num(c, n)}', note=note)

def ref(c, n, grade=SAHIH, by=None, note=None):
    return dict(kind='hadith', collection=NAMES[c], edition='Numérotation de sunnah.com', hadith_number=n, grade=grade,
                graded_by=by or BY.get(c, ALBANI), source_title=NAMES[c], url=f'https://sunnah.com/{c}:{n}', note=note)

def quran(s, a, b=None):
    return dict(kind='quran', surah=s, ayah_from=a, ayah_to=b or a)

CATS = [
 dict(slug='adhkar-voyage', position=5, title='Le voyage',
  summary='Les invocations du départ, du retour et des haltes en voyage.',
  body="Au départ d'un voyage, le Prophète ﷺ disait trois fois « Allāhu akbar » en s'installant sur sa monture, puis il prononçait "
       "l'invocation du voyage. Son début reprend les versets 13 et 14 de la sourate az-Zukhruf (43). Au retour, il redisait la même "
       "invocation en y ajoutant quelques mots. Jābir rapporte aussi que les Compagnons disaient « Allāhu akbar » en montant et "
       "« Subḥāna llāh » en descendant (al-Bukhārī n° 2993).",
  refs=[ref('muslim', '1342', note="D'après ʿAbd Allāh ibn ʿUmar."), quran(43, 13, 14), ref('muslim', '2708a', note="D'après Khawla bint Ḥakīm."),
        ref('bukhari', '2993', note="D'après Jābir ibn ʿAbd Allāh.")],
  adhkar=[
   d('v1', "L'invocation du voyage",
     "Subḥāna lladhī sakhkhara lanā hādhā wa mā kunnā lahu muqrinīn, wa innā ilā rabbinā la-munqalibūn. Allāhumma innā nas’aluka fī safarinā "
     "hādha l-birra wa t-taqwā, wa mina l-ʿamali mā tarḍā. Allāhumma hawwin ʿalaynā safaranā hādhā wa-ṭwi ʿannā buʿdah. Allāhumma anta "
     "ṣ-ṣāḥibu fi s-safar, wa l-khalīfatu fi l-ahl. Allāhumma innī aʿūdhu bika min waʿthā’i s-safar, wa ka’ābati l-manẓar, wa sū’i "
     "l-munqalabi fi l-māli wa l-ahl.",
     "« Gloire à Celui qui a mis ceci à notre service alors que nous n'étions pas capables de le maîtriser, et c'est vers notre Seigneur que "
     "nous retournerons. Ô Allah, nous Te demandons, dans ce voyage, la bonté et la piété, et des œuvres qui Te plaisent. Ô Allah, facilite-nous "
     "ce voyage et raccourcis-nous sa distance. Ô Allah, Tu es le Compagnon dans le voyage et Celui qui veille sur la famille. Ô Allah, je "
     "cherche refuge auprès de Toi contre les fatigues du voyage, contre tout spectacle attristant et contre un mauvais retour, dans les biens "
     "et dans la famille. »",
     when="En s'installant sur sa monture au départ d'un voyage, après avoir dit trois fois « Allāhu akbar »",
     note="D'après ʿAbd Allāh ibn ʿUmar."),
   d('v2', 'Nous revenons, repentants',
     "Āyibūna tā’ibūna ʿābidūna li-rabbinā ḥāmidūn.",
     "« Nous revenons, repentants, adorant notre Seigneur et Le louant. »",
     when="Au retour du voyage : on redit l'invocation du départ et on y ajoute ces paroles",
     note="D'après ʿAbd Allāh ibn ʿUmar, dans le même hadith que l'invocation du départ."),
   d('v3', 'En faisant halte',
     "Aʿūdhu bi-kalimāti llāhi t-tāmmāti min sharri mā khalaq.",
     "« Je cherche refuge dans les paroles parfaites d'Allah contre le mal de ce qu'Il a créé. »",
     when="En faisant halte dans un lieu",
     virtue="Rien ne lui nuit jusqu'à ce qu'il quitte ce lieu.",
     note="D'après Khawla bint Ḥakīm."),
  ]),
 dict(slug='adhkar-repas', position=6, title='Le repas',
  summary='Ce que l’on dit avant et après avoir mangé.',
  body="Le Prophète ﷺ a dit à ʿUmar ibn Abī Salama, qui était alors un enfant : mentionne le nom d'Allah, mange de ta main droite et "
       "mange de ce qui est devant toi (al-Bukhārī n° 5376). Mentionner le nom d'Allah avant de manger, c'est dire « Bismillāh ». "
       "Celui qui a oublié de le dire au début du repas le dit dès qu'il s'en souvient, avec la formule ci-dessous. À la fin du repas, on loue Allah.",
  refs=[ref('bukhari', '5376', note="D'après ʿUmar ibn Abī Salama."),
        ref('abudawud', '3767', by=ALBANI, note="D'après ʿĀʾisha."), ref('bukhari', '5458', note="D'après Abū Umāma.")],
  adhkar=[
   d('r1', 'Au nom d’Allah, au début et à la fin',
     "Bismi llāhi awwalahu wa ākhirah.",
     "« Au nom d'Allah, au début et à la fin. »",
     when="Si l'on a oublié de dire « Bismillāh » au début du repas",
     note="D'après ʿĀʾisha. Shuʿayb al-Arnaʾūṭ l'a jugé authentique par ses autres voies (ṣaḥīḥ li-ghayrihi)."),
   d('r2', 'Louange abondante, bonne et bénie',
     "Al-ḥamdu li-llāhi kathīran ṭayyiban mubārakan fīh, ghayra makfiyyin wa lā muwaddaʿin wa lā mustaghnan ʿanhu, rabbanā.",
     "« Louange à Allah, une louange abondante, bonne et bénie, louange qui n'est jamais suffisante, que l'on ne délaisse pas et dont on ne "
     "peut se passer, ô notre Seigneur. »",
     when="À la fin du repas",
     note="D'après Abū Umāma. Les commentateurs expliquent de plusieurs façons le sens exact de certains mots de cette invocation."),
  ]),
 dict(slug='adhkar-maison', position=7, title='Entrer et sortir de chez soi',
  summary='Mentionner Allah en entrant chez soi, et les invocations de la sortie.',
  body="Le Prophète ﷺ a enseigné que celui qui mentionne Allah en entrant chez lui et au moment de son repas empêche le diable d'y passer "
       "la nuit et d'y manger (Muslim n° 2018a). Pour la sortie, deux invocations sont rapportées ci-dessous. Une formule précise pour "
       "l'entrée, rapportée par Abū Dāwūd (n° 5096), a été jugée faible par al-Albānī : elle n'est donc pas présentée ici comme une invocation à dire.",
  refs=[ref('muslim', '2018a', note="D'après Jābir ibn ʿAbd Allāh."), ref('abudawud', '5095', by=ALBANI, note="D'après Anas ibn Mālik."),
        ref('abudawud', '5094', by=ALBANI, note="D'après Umm Salama."),
        ref('abudawud', '5096', grade='Faible (ḍaʿīf)', by=ALBANI, note="Cité seulement pour signaler sa faiblesse.")],
  adhkar=[
   d('h1', 'Au nom d’Allah, je place ma confiance en Allah',
     "Bismi llāh, tawakkaltu ʿala llāh, lā ḥawla wa lā quwwata illā bi-llāh.",
     "« Au nom d'Allah, je place ma confiance en Allah ; il n'y a de force ni de puissance qu'en Allah. »",
     when="En sortant de chez soi",
     virtue="On lui dit alors : tu es guidé, tu es suffi et tu es protégé, et les diables s'écartent de lui.",
     note="D'après Anas ibn Mālik."),
   d('h2', 'Contre l’égarement et l’injustice',
     "Allāhumma innī aʿūdhu bika an aḍilla aw uḍall, aw azilla aw uzall, aw aẓlima aw uẓlam, aw ajhala aw yujhala ʿalayy.",
     "« Ô Allah, je cherche refuge auprès de Toi contre le fait de m'égarer ou d'être égaré, de faire un faux pas ou d'y être poussé, "
     "d'être injuste ou de subir l'injustice, d'agir en ignorant ou que l'on agisse envers moi en ignorant. »",
     when="En sortant de chez soi ; le Prophète ﷺ levait alors le regard vers le ciel",
     note="D'après Umm Salama. Shuʿayb al-Arnaʾūṭ l'a jugé ḥasan ṣaḥīḥ ; Zubayr ʿAlī Zaʾī l'a jugé faible (jugements affichés sur sunnah.com)."),
  ]),
 dict(slug='adhkar-epreuves', position=8, title='L’angoisse et le malheur',
  summary='Les invocations de la détresse et celle que l’on dit quand un malheur frappe.',
  body="Le Prophète ﷺ a enseigné plusieurs invocations pour les moments d'angoisse et de détresse, et une autre pour le moment où un "
       "malheur frappe. Cette dernière commence par les paroles mentionnées dans le verset 156 de la sourate al-Baqara (2), que le hadith "
       "appelle « ce qu'Allah lui a ordonné ».",
  refs=[ref('bukhari', '6346', note="D'après Ibn ʿAbbās."), ref('abudawud', '1525', by=ALBANI, note="D'après Asmāʾ bint ʿUmays."),
        ref('muslim', '918a', note="D'après Umm Salama."), quran(2, 156),
        ref('abudawud', '5090', grade='Chaîne bonne (ḥasan al-isnād)', by=ALBANI, note="D'après Abū Bakra. Zubayr ʿAlī Zaʾī l'a jugé faible.")],
  adhkar=[
   d('e1', 'Allah, l’Immense, le Longanime',
     "Lā ilāha illa llāhu l-ʿaẓīmu l-ḥalīm, lā ilāha illa llāhu rabbu l-ʿarshi l-ʿaẓīm, lā ilāha illa llāhu rabbu s-samāwāti wa rabbu "
     "l-arḍi wa rabbu l-ʿarshi l-karīm.",
     "« Nul ne mérite d'être adoré si ce n'est Allah, l'Immense, le Longanime ; nul ne mérite d'être adoré si ce n'est Allah, le Seigneur "
     "du Trône immense ; nul ne mérite d'être adoré si ce n'est Allah, le Seigneur des cieux, le Seigneur de la terre et le Seigneur du noble Trône. »",
     when="Dans l'angoisse et la détresse", note="D'après Ibn ʿAbbās."),
   d('e2', 'Allah est mon Seigneur',
     "Allāhu Allāhu rabbī, lā ushriku bihi shay’ā.",
     "« Allah, Allah est mon Seigneur, je ne Lui associe rien. »",
     when="Dans l'angoisse ou la détresse",
     note="D'après Asmāʾ bint ʿUmays. Shuʿayb al-Arnaʾūṭ l'a aussi jugé authentique."),
   d('e4', 'C’est Ta miséricorde que j’espère',
     "Allāhumma raḥmataka arjū, fa-lā takilnī ilā nafsī ṭarfata ʿayn, wa aṣliḥ lī sha’nī kullah, lā ilāha illā ant.",
     "« Ô Allah, c'est Ta miséricorde que j'espère ; ne me laisse pas à moi-même, ne serait-ce que le temps d'un clin d'œil, et améliore "
     "toutes mes affaires. Nul ne mérite d'être adoré si ce n'est Toi. »",
     when="Dans l'angoisse ; le Prophète ﷺ les a appelées les invocations de celui qui est angoissé",
     grade='Chaîne bonne (ḥasan al-isnād)', by=ALBANI,
     note="D'après Abū Bakra. Zubayr ʿAlī Zaʾī l'a jugé faible (jugements affichés sur sunnah.com)."),
   d('e3', 'Quand un malheur frappe',
     "Innā li-llāhi wa innā ilayhi rājiʿūn, allāhumma’jurnī fī muṣībatī wa akhlif lī khayran minhā.",
     "« Nous appartenons à Allah et c'est vers Lui que nous retournerons. Ô Allah, récompense-moi pour mon malheur et remplace-le-moi par mieux. »",
     when="Quand on est frappé par un malheur",
     virtue="Allah lui donne en échange mieux que ce qu'il a perdu. Umm Salama l'a dite à la mort de son mari Abū Salama, et Allah lui a "
            "donné le Prophète ﷺ pour époux.",
     note="D'après Umm Salama."),
  ]),
]

RCOLS = ['kind', 'surah', 'ayah_from', 'ayah_to', 'collection', 'edition', 'hadith_number', 'grade', 'graded_by', 'source_title', 'url', 'note']
ACOLS = ['title', 'arabic', 'transliteration', 'meaning', 'repeat_count', 'when_to_say', 'virtue', 'collection', 'hadith_number', 'grade', 'graded_by', 'url', 'note']
CAST = {'kind': '::public.reference_kind', 'surah': '::int', 'ayah_from': '::int', 'ayah_to': '::int', 'repeat_count': '::smallint'}

def q(s):
    if s is None: return 'null'
    if isinstance(s, int): return str(s)
    tag = 'x'
    while f'${tag}$' in s: tag += 'x'
    return f'${tag}${s}${tag}$'

def values(rows, cols):
    return ',\n  '.join('(' + ', '.join([str(i + 1)] + [q(r.get(c)) + CAST.get(c, '') for c in cols]) + ')' for i, r in enumerate(rows))

def cat_sql(C):
    sums = ', '.join(f"'{hashlib.md5(a['arabic'].encode()).hexdigest()}'" for a in C['adhkar'])
    return f"""with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ({q(C['slug'])}, 'lesson', 'adhkar', 'fr', {C['position']}) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, {q(C['title'])}, {q(C['summary'])}, {q(C['body'])}, true, {q(AUTHOR)} from it returning id, item_id),
r as (insert into public.content_references (revision_id, {', '.join(RCOLS)})
      select rv.id, {', '.join('v.' + c for c in RCOLS)} from rv, (values
  {values(C['refs'], RCOLS)}) v(k, {', '.join(RCOLS)}) order by v.k returning 1),
a as (insert into public.content_adhkar (revision_id, {', '.join(ACOLS)})
      select rv.id, {', '.join('v.' + c for c in ACOLS)} from rv, (values
  {values(C['adhkar'], ACOLS)}) v(k, {', '.join(ACOLS)}) order by v.k returning arabic)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, {q("Brouillon rédigé par l'IA : invocations, " + C['title'])}),
       rv.id as revision, (select bool_and(md5(arabic) = any(array[{sums}])) and count(*) = {len(C['adhkar'])} from a) as arabe_ok,
       (select count(*) from r) as refs, (select count(*) from a) as adhkar from rv"""

if __name__ == '__main__':
    os.makedirs(os.path.join(HERE, 'sql'), exist_ok=True)
    # Une requête par catégorie, séparées par la ligne « -- @@ » (une requête avec insertions ne peut pas être imbriquée).
    body = '-- Invocations 5 à 8 : voyage, repas, maison, angoisse et malheur\n' + '\n-- @@\n'.join(cat_sql(C) for C in CATS) + '\n'
    path = os.path.join(HERE, 'sql', 'adhkar_05_08.sql'); open(path, 'w').write(body)
    print(path, hashlib.md5(body.encode()).hexdigest(), len(body))
