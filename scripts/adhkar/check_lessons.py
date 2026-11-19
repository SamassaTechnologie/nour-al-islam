"""Compare chaque passage arabe (hors Coran) des lecons publiees au texte du recueil cite.

Lit les lecons avec un compte de l'equipe (variables SUPABASE_URL, SUPABASE_KEY, EMAIL, PASSWORD),
cherche chaque passage dans les recueils (/tmp/h/full-ara-*.json, texte et numerotation de sunnah.com)
apres retrait des voyelles et de la ponctuation, puis indique si le texte est identique au caractere pres.
Ecrit /tmp/h/lessons_check.json : pour chaque passage, la source trouvee et le texte exact de la source.
"""
import json, os, re, sys, urllib.request
sys.path.insert(0, '/tmp/h')
from show import idx

URL, KEY = os.environ['SUPABASE_URL'], os.environ['SUPABASE_KEY']
def call(path, data=None, token=None):
    req = urllib.request.Request(URL + path, data=json.dumps(data).encode() if data else None, method='POST' if data else 'GET')
    req.add_header('apikey', KEY); req.add_header('Content-Type', 'application/json')
    req.add_header('Authorization', 'Bearer ' + (token or KEY))
    return json.load(urllib.request.urlopen(req))
token = call('/auth/v1/token?grant_type=password', {'email': os.environ['EMAIL'], 'password': os.environ['PASSWORD']})['access_token']
items = call('/rest/v1/content_items?select=slug,section,published_revision_id&published_revision_id=not.is.null&section=in.(aqida,priere,purification,sira)', token=token)
bodies = {}
for it in items:
    rev = call(f"/rest/v1/content_revisions?select=body&id=eq.{it['published_revision_id']}", token=token)[0]
    bodies[it['slug']] = rev['body']

CANDIDATES = {
 'priere-place-et-conditions': [('bukhari', '8')], 'prosternation-de-l-oubli': [('muslim', '571')],
 'moments-interdits-pour-prier': [('bukhari', '586'), ('muslim', '827')], 'six-piliers-de-la-foi': [('muslim', '2996')],
 'reunion-de-deux-prieres': [('bukhari', '1111')], 'priere-en-groupe': [('bukhari', '645')],
 'awra-dans-la-priere': [('bukhari', '359'), ('abudawud', '641')], 'raccourcir-la-priere-en-voyage': [('muslim', '686')],
 'priere-du-vendredi': [('muslim', '865'), ('bukhari', '934')], 'priere-description': [('bukhari', '631')],
 'tashahhud-et-priere-sur-le-prophete': [('bukhari', '6265'), ('bukhari', '831'), ('bukhari', '3370')],
 'ablutions': [('bukhari', '135')], 'ablutions-obligations-et-avis': [('bukhari', '1')],
 'horaires-des-prieres': [('muslim', '612')], 'islam-iman-ihsan': [('muslim', '8')],
 'sommeil-conscience-et-toucher': [('abudawud', '203'), ('nasai', '447'), ('ibnmajah', '483')],
 'naissance-et-enfance': [('muslim', '2276'), ('muslim', '1162'), ('bukhari', '2262')],
}
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
def norm(t): return norm_map(t)[0].strip()

RUN = re.compile('[؀-ۿ][؀-ۿ ،ۖۗۚ]*[؀-ۿ]')
report = []
for slug, body in sorted(bodies.items()):
    for k, m in enumerate(RUN.finditer(body)):
        text = m.group(0)
        if len(text) <= 8: continue
        entry = {'slug': slug, 'index': k, 'lesson': text, 'found': None}
        n = norm(text)
        for c, base in CANDIDATES.get(slug, []):
            for (cc, num), (h, e) in idx.items():
                if cc != c or num.split('.')[0] != base: continue
                src = h['text']; ns, pos = norm_map(src)
                at = ns.find(n)
                if at < 0: continue
                a = pos[at]; b = pos[at + len(n) - 1] + 1
                while b < len(src) and SKIP.match(src[b]) and src[b] not in '‏"،.,:;': b += 1
                exact = src[a:b]
                entry['found'] = {'collection': c, 'number': num, 'exact': exact, 'identical': exact == text}
                break
            if entry['found']: break
        report.append(entry)
json.dump(report, open('/tmp/h/lessons_check.json', 'w'), ensure_ascii=False, indent=1)
for r in report:
    f = r['found']
    print(r['slug'], r['index'], 'INTROUVABLE' if not f else ('IDENTIQUE' if f['identical'] else 'DIFFERENT'), f and f['collection'], f and f['number'], len(r['lesson']))
