"""Construit le SQL des brouillons des leçons « Les 40 hadiths d'an-Nawawī » (rubrique Hadith).

Les leçons sont décrites dans scripts/hadith/nawawi/NN.py (une variable LESSON par fichier).
Le texte arabe n'est jamais écrit ici : le corps contient des repères {{NAW:n}} / {{NAWS:n|début|fin}}
que fill_nawawi.py remplace ensuite par le texte exact de l'édition de sunnah.com.
Usage : python3 build_nawawi_sql.py 5 6 7 > /tmp/naw.sql
"""
import hashlib, importlib.util, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
AUTHOR = 'Claude (assistant IA)'

def q(s):
    """Littéral SQL sûr (dollar-quoting avec une étiquette absente du texte)."""
    if s is None: return 'null'
    if isinstance(s, int): return str(s)
    tag = 'x'
    while f'${tag}$' in s: tag += 'x'
    return f'${tag}${s}${tag}$'

def naw(n, grade, graded_by, title):
    return dict(kind='hadith', collection="Les Quarante hadiths d'an-Nawawī", edition='Numérotation de sunnah.com',
                hadith_number=str(n), grade=grade, graded_by=graded_by, source_title=title,
                url=f'https://sunnah.com/nawawi40:{n}', note="Texte arabe copié tel quel de l'édition de sunnah.com (base hadith-api).")

COLL = {'bukhari': ('Ṣaḥīḥ al-Bukhārī', 'bukhari'), 'muslim': ('Ṣaḥīḥ Muslim', 'muslim'), 'tirmidhi': ('Jāmiʿ at-Tirmidhī', 'tirmidhi'),
        'abudawud': ('Sunan Abī Dāwūd', 'abudawud'), 'nasai': ('Sunan an-Nasāʾī', 'nasai'), 'ibnmajah': ('Sunan Ibn Mājah', 'ibnmajah'),
        'ahmad': ('Musnad Aḥmad', 'ahmad')}

def coll(key, number, grade, graded_by, title, url_number=None, note=None):
    name, path = COLL[key]
    return dict(kind='hadith', collection=name, edition='Numérotation de sunnah.com', hadith_number=str(number), grade=grade,
                graded_by=graded_by, source_title=title, url=f'https://sunnah.com/{path}:{url_number or number}', note=note)

def quran(surah, a, b=None):
    return dict(kind='quran', surah=surah, ayah_from=a, ayah_to=b or a)

def he(heid):
    return dict(kind='book', source_title=f'Encyclopédie des hadiths traduits (HadeethEnc), hadith n° {heid}', author='HadeethEnc',
                locator='Explication et enseignements', url=f'https://hadeethenc.com/fr/browse/hadith/{heid}')

COLS = ['kind', 'surah', 'ayah_from', 'ayah_to', 'collection', 'edition', 'hadith_number', 'grade', 'graded_by', 'source_title', 'author', 'locator', 'url', 'note']

def load(n):
    path = os.path.join(HERE, 'nawawi', f'{n:02d}.py')
    spec = importlib.util.spec_from_file_location(f'naw{n}', path); mod = importlib.util.module_from_spec(spec)
    mod.__dict__.update(naw=naw, coll=coll, he=he, quran=quran); spec.loader.exec_module(mod)
    return mod.LESSON

def check(L):
    assert L['slug'].startswith(f"nawawi-{L['n']:02d}-"), L['slug']
    assert f"{{{{NAW:{L['n']}}}}}" in L['body'], 'texte complet absent'
    assert len(L['questions']) >= 5
    for p, opts, ans, ex in L['questions']:
        assert 2 <= len(opts) <= 5 and 0 <= ans < len(opts) and 3 <= len(p) <= 300 and 3 <= len(ex) <= 600, p
    for r in L['refs']:
        if r['kind'] == 'hadith': assert all(r.get(k) for k in ('collection', 'edition', 'hadith_number', 'source_title', 'grade', 'graded_by')), r

MARKS = re.compile('[\u064b-\u0670\u0640\u06d6-\u06ed]')
LETTER = {'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ٱ': 'ا', 'ى': 'ي'}
TEXTS = None
def texts():
    global TEXTS
    if TEXTS is None:
        TEXTS = {h['hadithnumber']: re.sub(r'\s*<[^>]+>\s*', ' ', h['text']) for h in json.load(open('/tmp/h/full-ara-nawawi.json'))['hadiths']}
    return TEXTS
def norm(t):
    out, pos = [], []
    for i, ch in enumerate(t):
        if MARKS.match(ch): continue
        out.append(LETTER.get(ch, ch)); pos.append(i)
    return ''.join(out), pos
def locate(n, start, end):
    """Position (début, fin) du passage dans le texte n : même règle que fill_nawawi.py."""
    t = texts()[n]; nt, pos = norm(t)
    i = nt.find(norm(start)[0]); j = nt.find(norm(end)[0], i) if i >= 0 else -1
    if i < 0 or j < 0: raise SystemExit(f'hadith {n} : passage introuvable ({start} … {end})')
    b = pos[j + len(norm(end)[0]) - 1] + 1
    while b < len(t) and MARKS.match(t[b]): b += 1
    return pos[i], b
def to_offsets(body):
    """{{NAWS:n|début|fin}} devient {{NAWX:n:a:b}} : la base copie elle-même les caractères a..b du texte n."""
    return re.sub(r'\{\{NAWS:(\d+)\|([^|}]+)\|([^}]+)\}\}', lambda m: '{{NAWX:%s:%d:%d}}' % ((m.group(1),) + locate(int(m.group(1)), m.group(2), m.group(3))), body)
def filled(body):
    t = texts()
    body = re.sub(r'\{\{NAWX:(\d+):(\d+):(\d+)\}\}', lambda m: t[int(m.group(1))][int(m.group(2)):int(m.group(3))], body)
    return re.sub(r'\{\{NAW:(\d+)\}\}', lambda m: t[int(m.group(1))], body)

def sql(L):
    check(L)
    body = to_offsets(L['body']); md5 = hashlib.md5(filled(body).encode()).hexdigest()
    refs = ',\n  '.join('(' + ', '.join([str(i + 1)] + [q(r.get(c)) + {'kind': '::reference_kind', 'surah': '::int', 'ayah_from': '::int', 'ayah_to': '::int'}.get(c, '') for c in COLS]) + ')'
                         for i, r in enumerate(L['refs']))
    qs = ',\n  '.join(f"({i + 1}, {q(p)}, array[{', '.join(q(o) for o in opts)}]::text[], {ans}, {q(ex)})"
                       for i, (p, opts, ans, ex) in enumerate(L['questions']))
    return f"""-- Hadith {L['n']} d'an-Nawawī : {L['slug']}
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ({q(L['slug'])}, 'lesson', 'hadith', 'fr', {L['n']}) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, {q(L['title'])}, {q(L['summary'])}, private.nawawi_fill({q(body)}), true, {q(AUTHOR)} from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, ord, {', '.join(COLS)})
      select rv.id, (select coalesce(max(ord), 0) from public.content_references) + v.k, {', '.join('v.' + c for c in COLS)}
      from rv, (values
  {refs}) v(k, {', '.join(COLS)}) returning 1),
qq as (insert into public.content_questions (revision_id, ord, prompt, options, answer, explanation)
       select rv.id, (select coalesce(max(ord), 0) from public.content_questions) + v.k, v.p, v.o, v.a, v.e
       from rv, (values
  {qs}) v(k, p, o, a, e) returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, {q(f"Brouillon rédigé par l'IA : hadith {L['n']} d'an-Nawawī")}),
       rv.h = '{md5}' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
"""

if __name__ == '__main__':
    # Un fichier par leçon dans scripts/hadith/sql/ ; affiche l'empreinte attendue du corps rempli et celle du fichier.
    out = os.path.join(HERE, 'sql'); os.makedirs(out, exist_ok=True)
    for a in sys.argv[1:]:
        L = load(int(a)); text = sql(L); path = os.path.join(out, f'nawawi_{L["n"]:02d}.sql')
        open(path, 'w').write(text)
        print(L['n'], L['slug'], hashlib.md5(filled(to_offsets(L['body'])).encode()).hexdigest(), hashlib.md5(text.encode()).hexdigest())
