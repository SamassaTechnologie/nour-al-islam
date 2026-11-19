"""Decoupe un passage exact dans un hadith et l'affiche en base64 (pour l'inserer sans recopie).

Usage : python3 snippet.py recueil numero "debut sans voyelles" "fin sans voyelles" [occurrence]
Affiche aussi la traduction anglaise du hadith (pour verifier le contenu) et le jugement.
"""
import base64, re, sys
sys.path.insert(0, '/tmp/h')
from show import get
SKIP = re.compile('[ً-ٰٟۖ-ۭـ‏]')
LETTER = {'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ٱ': 'ا', 'ى': 'ي'}
def norm_map(t):
    out, pos = [], []
    for i, ch in enumerate(t):
        if SKIP.match(ch): continue
        out.append(LETTER.get(ch, ch)); pos.append(i)
    return ''.join(out), pos
c, n, start, end = sys.argv[1:5]
occ = int(sys.argv[5]) if len(sys.argv) > 5 else 1
h, e = get(c, n)
t = h['text']; nt, pos = norm_map(t)
s = -1
for _ in range(occ): s = nt.find(start, s + 1)
if s < 0: raise SystemExit('debut introuvable')
en = nt.find(end, s)
if en < 0: raise SystemExit('fin introuvable')
a = pos[s]; b = pos[en + len(end) - 1] + 1
while b < len(t) and SKIP.match(t[b]) and t[b] != '‏': b += 1
frag = t[a:b]
assert '‏' not in frag and '"' not in frag
print('B64', base64.b64encode(frag.encode()).decode())
print('LEN', len(frag), 'GRADES', (e or {}).get('grades'))
print('EN', (e or {}).get('text', '')[:700])
