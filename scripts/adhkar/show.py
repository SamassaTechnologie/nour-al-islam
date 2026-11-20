import json, os, sys
idx = {}
# nawawi : les 40 hadiths d'an-Nawawi (edition de sunnah.com), si le fichier a ete telecharge.
for c in ['muslim','bukhari','abudawud','tirmidhi','nasai','ibnmajah','nawawi']:
    if not os.path.exists('/tmp/h/full-ara-'+c+'.json'): continue
    d = json.load(open('/tmp/h/full-ara-'+c+'.json'))
    e = json.load(open('/tmp/h/full-eng-'+c+'.json'))
    eg = {h['hadithnumber']: h for h in e['hadiths']}
    for h in d['hadiths']:
        idx[(c, str(h.get('arabicnumber', h['hadithnumber'])))] = (h, eg.get(h['hadithnumber']))
def get(c, n):
    return idx[(c, n)]
if __name__ == '__main__':
    for arg in sys.argv[1:]:
        c, n = arg.split(':')
        h, e = get(c, n)
        t = h['text'].replace('‏', '')
        q = t.find('"')
        print(arg, h['hadithnumber'], h.get('reference'), (e or {}).get('grades'))
        print(t[max(0, q-60):][:1200])
        print('==')
