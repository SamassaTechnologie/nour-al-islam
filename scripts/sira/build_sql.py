"""Construit le SQL d'une leçon de Sira (rubrique « sira »).

Les leçons sont décrites dans scripts/sira/NN.py (variable LESSON). Le texte arabe n'est jamais écrit ici :
le corps contient des repères {{AR:recueil:numéro|début|fin}} remplacés au moment de la construction par
les caractères exacts de l'édition de sunnah.com (base hadith-api, fichiers /tmp/h/full-ara-<recueil>.json).
Usage : python3 -I build_sql.py 8   (écrit scripts/sira/sql/sira_08.sql et affiche l'empreinte du corps)
"""
import hashlib, importlib.util, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
AUTHOR = 'Claude (assistant IA)'
COLS = ['kind', 'surah', 'ayah_from', 'ayah_to', 'collection', 'edition', 'hadith_number', 'grade', 'graded_by', 'source_title', 'author', 'locator', 'url', 'note']
COLL = {'bukhari': ('Ṣaḥīḥ al-Bukhārī', 'bukhari'), 'muslim': ('Ṣaḥīḥ Muslim', 'muslim'), 'tirmidhi': ('Jāmiʿ at-Tirmidhī', 'tirmidhi'),
        'abudawud': ('Sunan Abī Dāwūd', 'abudawud'), 'ibnmajah': ('Sunan Ibn Mājah', 'ibnmajah')}

def q(s):
    if s is None: return 'null'
    if isinstance(s, int): return str(s)
    tag = 'x'
    while f'${tag}$' in s: tag += 'x'
    return f'${tag}${s}${tag}$'

def coll(key, number, grade, graded_by, title, note=None):
    name, path = COLL[key]
    return dict(kind='hadith', collection=name, edition='Numérotation de sunnah.com', hadith_number=str(number), grade=grade,
                graded_by=graded_by, source_title=title, url=f'https://sunnah.com/{path}:{number}', note=note)

def quran(surah, a, b=None):
    return dict(kind='quran', surah=surah, ayah_from=a, ayah_to=b or a)

def book(title, author, locator, url, note=None):
    return dict(kind='book', source_title=title, author=author, locator=locator, url=url, note=note)

MARKS = re.compile('[ً-ٰـۖ-ۭ]')
LETTER = {'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ٱ': 'ا', 'ى': 'ي'}
CACHE = {}
def texts(c):
    if c not in CACHE:
        CACHE[c] = {h['hadithnumber']: re.sub(r'\s*<[^>]+>\s*', ' ', h['text']) for h in json.load(open(f'/tmp/h/full-ara-{c}.json'))['hadiths']}
    return CACHE[c]
def norm(t):
    out, pos = [], []
    for i, ch in enumerate(t):
        if MARKS.match(ch): continue
        out.append(LETTER.get(ch, ch)); pos.append(i)
    return ''.join(out), pos
def passage(c, n, start, end):
    t = texts(c)[n]; nt, pos = norm(t)
    i = nt.find(norm(start)[0]); j = nt.find(norm(end)[0], i) if i >= 0 else -1
    if i < 0 or j < 0: raise SystemExit(f'{c} {n} : passage introuvable ({start} … {end})')
    b = pos[j + len(norm(end)[0]) - 1] + 1
    while b < len(t) and MARKS.match(t[b]): b += 1
    return t[pos[i]:b]
def filled(body):
    return re.sub(r'\{\{AR:(\w+):(\d+)\|([^|}]+)\|([^}]+)\}\}', lambda m: passage(m.group(1), int(m.group(2)), m.group(3), m.group(4)), body)

def load(n):
    path = os.path.join(HERE, f'{n:02d}.py')
    spec = importlib.util.spec_from_file_location(f'sira{n}', path); mod = importlib.util.module_from_spec(spec)
    mod.__dict__.update(coll=coll, quran=quran, book=book); spec.loader.exec_module(mod)
    return mod.LESSON

def check(L):
    assert len(L['questions']) >= 5
    for p, opts, ans, ex in L['questions']:
        assert 2 <= len(opts) <= 5 and 0 <= ans < len(opts) and 3 <= len(p) <= 300 and 3 <= len(ex) <= 600, p
    for r in L['refs']:
        if r['kind'] == 'hadith': assert all(r.get(k) for k in ('collection', 'edition', 'hadith_number', 'source_title', 'grade', 'graded_by')), r

def sql(L):
    check(L)
    body = filled(L['body']); md5 = hashlib.md5(body.encode()).hexdigest()
    refs = ',\n  '.join('(' + ', '.join([str(i + 1)] + [q(r.get(c)) + {'kind': '::public.reference_kind', 'surah': '::int', 'ayah_from': '::int', 'ayah_to': '::int'}.get(c, '') for c in COLS]) + ')'
                         for i, r in enumerate(L['refs']))
    qs = ',\n  '.join(f"({i + 1}, {q(p)}, array[{', '.join(q(o) for o in opts)}]::text[], {ans}, {q(ex)})" for i, (p, opts, ans, ex) in enumerate(L['questions']))
    return md5, f"""-- Sira {L['position']} : {L['slug']}
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ({q(L['slug'])}, 'lesson', 'sira', 'fr', {L['position']}) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, {q(L['title'])}, {q(L['summary'])}, {q(body)}, true, {q(AUTHOR)} from it returning id, item_id, md5(body) as h),
r as (insert into public.content_references (revision_id, {', '.join(COLS)})
      select rv.id, {', '.join('v.' + c for c in COLS)}
      from rv, (values
  {refs}) v(k, {', '.join(COLS)}) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, options, answer, explanation)
       select rv.id, v.p, v.o, v.a, v.e
       from rv, (values
  {qs}) v(k, p, o, a, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, {q(f"Brouillon rédigé par l'IA : Sira {L['position']}")}),
       rv.h = '{md5}' as arabe_identique,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
"""

if __name__ == '__main__':
    out = os.path.join(HERE, 'sql'); os.makedirs(out, exist_ok=True)
    for a in sys.argv[1:]:
        L = load(int(a)); md5, text = sql(L); path = os.path.join(out, f'sira_{L["position"]:02d}.sql')
        open(path, 'w').write(text)
        print(L['position'], L['slug'], md5, hashlib.md5(text.encode()).hexdigest(), len(text))
