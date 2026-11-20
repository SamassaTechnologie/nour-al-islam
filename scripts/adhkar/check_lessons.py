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
items = call('/rest/v1/content_items?select=slug,section,published_revision_id&published_revision_id=not.is.null&section=in.(aqida,priere,purification,sira,hadith)', token=token)
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
 'jeunesse-khadija-kaaba': [('bukhari', '3432')],
 'debut-de-la-revelation': [('bukhari', '3'), ('bukhari', '3851')],
 'premiers-musulmans-predication-secrete': [('bukhari', '3660'), ('muslim', '832')],
 'debut-predication-publique': [('bukhari', '4770'), ('bukhari', '2753')],
 'persecutions-a-la-mecque': [('bukhari', '3856'), ('ibnmajah', '150'), ('bukhari', '3612')],
 'emigration-en-abyssinie': [('bukhari', '3877'), ('bukhari', '3876')],
 'nawawi-01-les-intentions': [('nawawi', '1')], 'nawawi-02-hadith-de-jibril': [('nawawi', '2')],
 'nawawi-03-les-cinq-piliers': [('nawawi', '3')], 'nawawi-04-creation-et-destin': [('nawawi', '4')],
 'nawawi-05-innovations-rejetees': [('nawawi', '5')],
 'nawawi-06-licite-illicite-et-douteux': [('nawawi', '6')],
 'nawawi-07-la-religion-est-le-bon-conseil': [('nawawi', '7')],
 'nawawi-08-le-sang-et-les-biens-proteges': [('nawawi', '8')],
 'nawawi-09-eviter-l-interdit-faire-ce-que-l-on-peut': [('nawawi', '9')],
 'nawawi-10-allah-n-accepte-que-ce-qui-est-bon': [('nawawi', '10')],
 'nawawi-11-laisser-ce-qui-fait-douter': [('nawawi', '11')],
 'nawawi-12-delaisser-ce-qui-ne-nous-regarde-pas': [('nawawi', '12')],
 'nawawi-13-aimer-pour-son-frere': [('nawawi', '13')],
 'nawawi-14-le-sang-du-musulman-est-sacre': [('nawawi', '14')],
 'nawawi-15-dire-du-bien-ou-se-taire': [('nawawi', '15')],
 'nawawi-16-ne-te-mets-pas-en-colere': [('nawawi', '16')],
 'nawawi-17-l-excellence-en-toute-chose': [('nawawi', '17')],
 'nawawi-18-crains-allah-ou-que-tu-sois': [('nawawi', '18')],
 'nawawi-19-preserve-allah-il-te-preservera': [('nawawi', '19')],
 'nawawi-20-la-pudeur': [('nawawi', '20')],
 'nawawi-21-je-crois-en-allah-puis-sois-droit': [('nawawi', '21')],
 'nawawi-22-les-obligations-menent-au-paradis': [('nawawi', '22')],
 'nawawi-23-la-purification-moitie-de-la-foi': [('nawawi', '23')],
 'nawawi-24-l-injustice-est-interdite': [('nawawi', '24')],
 'nawawi-25-chaque-glorification-est-une-aumone': [('nawawi', '25')],
 'nawawi-26-une-aumone-pour-chaque-articulation': [('nawawi', '26')],
 'nawawi-27-la-bonte-et-le-peche': [('nawawi', '27')],
 'nawawi-28-attachez-vous-a-ma-sunna': [('nawawi', '28')],
 'nawawi-29-l-oeuvre-qui-mene-au-paradis': [('nawawi', '29')],
 'nawawi-30-obligations-limites-interdits': [('nawawi', '30')],
 'nawawi-31-le-detachement-du-bas-monde': [('nawawi', '31')],
 'nawawi-32-pas-de-prejudice': [('nawawi', '32')],
 'nawawi-33-la-preuve-incombe-au-demandeur': [('nawawi', '33')],
 'nawawi-34-changer-le-mal': [('nawawi', '34')],
 'nawawi-35-le-musulman-est-le-frere-du-musulman': [('nawawi', '35')],
 'nawawi-36-soulager-son-frere': [('nawawi', '36')],
 'nawawi-37-la-generosite-d-allah-envers-les-intentions': [('nawawi', '37')],
 'nawawi-38-les-allies-d-allah': [('nawawi', '38')],
 'nawawi-39-l-erreur-l-oubli-et-la-contrainte': [('nawawi', '39')],
 'nawawi-40-sois-comme-un-etranger': [('nawawi', '40')],
 'nawawi-41-que-ses-penchants-suivent-la-revelation': [('nawawi', '41')],
 'nawawi-42-o-fils-d-adam-tant-que-tu-m-invoques': [('nawawi', '42')],
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
        text = m.group(0).strip('، ')  # une virgule arabe en bordure n'appartient pas au passage
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
                while b < len(src) and SKIP.match(src[b]) and src[b] not in '‏"،.,:;؛-': b += 1
                exact = src[a:b]
                entry['found'] = {'collection': c, 'number': num, 'exact': exact, 'identical': exact == text}
                break
            if entry['found']: break
        report.append(entry)
json.dump(report, open('/tmp/h/lessons_check.json', 'w'), ensure_ascii=False, indent=1)
for r in report:
    f = r['found']
    print(r['slug'], r['index'], 'INTROUVABLE' if not f else ('IDENTIQUE' if f['identical'] else 'DIFFERENT'), f and f['collection'], f and f['number'], len(r['lesson']))
