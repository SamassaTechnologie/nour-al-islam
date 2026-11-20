"""Insere dans les brouillons le texte arabe exact des 40 hadiths d'an-Nawawi (edition de sunnah.com, base hadith-api).

Le texte n'est jamais recopie a la main : le brouillon contient des reperes que ce script remplace.
  {{NAW:n}}                 : texte complet du hadith n (avec la mention de la source par an-Nawawi)
  {{NAWS:n|debut|fin}}      : passage du hadith n, du mot « debut » au mot « fin » (voyelles ignorees pour chercher)
Variables : SUPABASE_URL, SUPABASE_KEY, EMAIL, PASSWORD (compte editeur). Arguments : slugs des lecons.
Fichier attendu : /tmp/h/full-ara-nawawi.json (https://raw.githubusercontent.com/fawazahmed0/hadith-api/1/editions/ara-nawawi.min.json).
"""
import json, os, re, sys, urllib.request

URL, KEY = os.environ.get('SUPABASE_URL', ''), os.environ.get('SUPABASE_KEY', '')
def call(path, data=None, token=None, method=None):
    req = urllib.request.Request(URL + path, data=json.dumps(data).encode() if data is not None else None, method=method or ('POST' if data is not None else 'GET'))
    req.add_header('apikey', KEY); req.add_header('Content-Type', 'application/json'); req.add_header('Prefer', 'return=representation')
    req.add_header('Authorization', 'Bearer ' + (token or KEY))
    return json.load(urllib.request.urlopen(req))

MARKS = re.compile('[ً-ٰـۖ-ۭ]')
LETTER = {'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ٱ': 'ا', 'ى': 'ي'}
def norm(t):
    out, pos = [], []
    for i, ch in enumerate(t):
        if MARKS.match(ch): continue
        out.append(LETTER.get(ch, ch)); pos.append(i)
    return ''.join(out), pos

# Les balises HTML de l'édition (<br>) sont remplacées par une espace : aucun mot n'est modifié.
texts = {h['hadithnumber']: re.sub(r'\s*<[^>]+>\s*', ' ', h['text']) for h in json.load(open('/tmp/h/full-ara-nawawi.json'))['hadiths']}
def fragment(n, start, end):
    t = texts[n]; nt, pos = norm(t)
    i = nt.find(norm(start)[0]); j = nt.find(norm(end)[0], i) if i >= 0 else -1
    if i < 0 or j < 0: raise SystemExit(f'hadith {n} : passage introuvable ({start} … {end})')
    b = pos[j + len(norm(end)[0]) - 1] + 1
    while b < len(t) and MARKS.match(t[b]): b += 1
    return t[pos[i]:b]

def fill(body):
    body = re.sub(r'\{\{NAW:(\d+)\}\}', lambda m: texts[int(m.group(1))], body)
    return re.sub(r'\{\{NAWS:(\d+)\|([^|}]+)\|([^}]+)\}\}', lambda m: fragment(int(m.group(1)), m.group(2), m.group(3)), body)

if os.environ.get('DRY'):
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__))); from build_nawawi_sql import load
    for a in sys.argv[1:]:
        new = fill(load(int(a))['body']); assert '{{NAW' not in new and '<' not in new; print(a, 'OK', [m for m in re.findall(r'« ([^»]*[؀-ۿ][^»]*) »', new)])
    raise SystemExit
token = call('/auth/v1/token?grant_type=password', {'email': os.environ['EMAIL'], 'password': os.environ['PASSWORD']})['access_token']
for slug in sys.argv[1:]:
    item = call(f'/rest/v1/content_items?select=id&slug=eq.{slug}', token=token)[0]
    drafts = call(f"/rest/v1/content_revisions?select=id,body&item_id=eq.{item['id']}&status=eq.draft", token=token)
    if len(drafts) != 1: raise SystemExit(f'{slug} : brouillon introuvable')
    new = fill(drafts[0]['body'])
    if '{{NAW' in new: raise SystemExit(f'{slug} : repere non remplace')
    call(f"/rest/v1/content_revisions?id=eq.{drafts[0]['id']}", {'body': new}, token=token, method='PATCH')
    print(slug, 'OK', len(drafts[0]['body']), '->', len(new))
