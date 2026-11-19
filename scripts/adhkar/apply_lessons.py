"""Remplace dans les brouillons des lecons chaque passage arabe par le texte exact du recueil.

A lancer apres check_lessons.py (qui ecrit /tmp/h/lessons_check.json), avec un compte editeur
(SUPABASE_URL, SUPABASE_KEY, EMAIL, PASSWORD). Une nouvelle version (brouillon) doit exister pour
chaque lecon a corriger. Chaque passage doit apparaitre exactement une fois dans le brouillon.
OVERRIDES : passage absent d'un seul tenant du hadith cite, pris dans un autre numero du meme recueil.
"""
import json, os, re, sys, urllib.request
sys.path.insert(0, '/tmp/h')
from show import idx

URL, KEY = os.environ['SUPABASE_URL'], os.environ['SUPABASE_KEY']
def call(path, data=None, token=None, method=None):
    req = urllib.request.Request(URL + path, data=json.dumps(data).encode() if data is not None else None, method=method or ('POST' if data is not None else 'GET'))
    req.add_header('apikey', KEY); req.add_header('Content-Type', 'application/json'); req.add_header('Prefer', 'return=representation')
    req.add_header('Authorization', 'Bearer ' + (token or KEY))
    return json.load(urllib.request.urlopen(req))
token = call('/auth/v1/token?grant_type=password', {'email': os.environ['EMAIL'], 'password': os.environ['PASSWORD']})['access_token']

SKIP = re.compile('[ً-ٰٟۖ-ۭـ‏‎"،؛؟.,:;«»()\\-]')
LETTER = {'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ٱ': 'ا', 'ى': 'ي'}
def norm_map(t):
    out, pos = [], []
    for i, ch in enumerate(t):
        if SKIP.match(ch): continue
        if ch.isspace():
            if out and out[-1] == ' ': continue
            ch = ' '
        out.append(LETTER.get(ch, ch)); pos.append(i)
    return ''.join(out), pos
def exact_in(c, num, text):
    h, _ = idx[(c, num)]
    src = h['text']; ns, pos = norm_map(src); n = norm_map(text)[0].strip()
    at = ns.find(n)
    if at < 0: return None
    a = pos[at]; b = pos[at + len(n) - 1] + 1
    while b < len(src) and SKIP.match(src[b]) and src[b] not in '‏"،.,:;': b += 1
    return src[a:b]

OVERRIDES = {('tashahhud-et-priere-sur-le-prophete', 0): ('bukhari', '6265')}
report = json.load(open('/tmp/h/lessons_check.json'))
todo = {}
for e in report:
    key = (e['slug'], e['index'])
    if key in OVERRIDES:
        c, num = OVERRIDES[key]
        exact = exact_in(c, num, e['lesson'])
        if exact is None: raise SystemExit(f'{key}: introuvable dans {c} {num}')
        e['found'] = {'collection': c, 'number': num, 'exact': exact, 'identical': exact == e['lesson']}
    f = e['found']
    if not f: raise SystemExit(f'{key}: source introuvable')
    if not f['identical']: todo.setdefault(e['slug'], []).append((e['lesson'], f['exact'], f['collection'], f['number']))

for slug, pairs in todo.items():
    item = call(f'/rest/v1/content_items?select=id&slug=eq.{slug}', token=token)[0]
    drafts = call(f"/rest/v1/content_revisions?select=id,body,status&item_id=eq.{item['id']}&status=eq.draft", token=token)
    if len(drafts) != 1: raise SystemExit(f'{slug}: brouillon introuvable')
    rev = drafts[0]; body = rev['body']
    for old, new, c, num in pairs:
        if body.count(old) != 1: raise SystemExit(f'{slug}: passage present {body.count(old)} fois')
        body = body.replace(old, new)
    saved = call(f"/rest/v1/content_revisions?id=eq.{rev['id']}", {'body': body}, token=token, method='PATCH')
    ok = len(saved) == 1 and all(new in saved[0]['body'] and old not in saved[0]['body'] for old, new, _, _ in pairs)
    print(slug, len(pairs), 'OK' if ok else 'ECHEC', ', '.join(f'{c} {n}' for _, _, c, n in pairs))
