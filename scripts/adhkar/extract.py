import json, re, sys
sys.path.insert(0, '/tmp/h')
from show import get
DIAC = re.compile('[ً-ٰٟۖ-ۭـ‏]')
def norm_map(t):
    out, idx = [], []
    for i, ch in enumerate(t):
        if DIAC.match(ch):
            continue
        ch = {'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ٱ': 'ا', 'ى': 'ي'}.get(ch, ch)
        out.append(ch); idx.append(i)
    return ''.join(out), idx
SPECS = [
 ('m1','bukhari','6306','اللهم انت ربي','يغفر الذنوب الا انت',1),
 ('m2','abudawud','5088','بسم الله الذي لا يضر','السميع العليم',1),
 ('m3','abudawud','5068','اللهم بك اصبحنا','واليك النشور',1),
 ('m4','abudawud','5068','اللهم بك امسينا','واليك النشور',1),
 ('m5','muslim','2692','سبحان الله وبحمده','سبحان الله وبحمده',1),
 ('s1','bukhari','247','اللهم اسلمت وجهي','بنبيك الذي ارسلت',1),
 ('s2','bukhari','6324','باسمك اللهم اموت واحيا','باسمك اللهم اموت واحيا',1),
 ('s3','bukhari','6324','الحمد لله الذي احيانا','واليه النشور',1),
 ('q1','muslim','713.01','اللهم افتح لي ابواب رحمتك','اللهم افتح لي ابواب رحمتك',1),
 ('q2','muslim','713.01','اللهم اني اسالك من فضلك','اللهم اني اسالك من فضلك',1),
 ('p1','muslim','591','استغفر الله','استغفر الله',1),
 ('p2','muslim','591','اللهم انت السلام','والاكرام',1),
 ('p3','bukhari','844','لا اله الا الله وحده','منك الجد',1),
 ('p4','muslim','597.01','لا اله الا الله وحده','قدير',1),
 ('v1','muslim','1342','سبحان الذي سخر','في المال والاهل',1),
 ('v2','muslim','1342','ايبون','حامدون',1),
 ('v3','muslim','2708.01','اعوذ بكلمات الله','من شر ما خلق',1),
 ('r1','abudawud','3767','بسم الله اوله','واخره',1),
 ('r2','bukhari','5458','الحمد لله كثيرا','ربنا',1),
 ('h1','abudawud','5095','بسم الله توكلت','الا بالله',1),
 ('h2','abudawud','5094','اللهم اني اعوذ بك ان اضل','يجهل علي',1),
 ('e1','bukhari','6346','لا اله الا الله العظيم','العرش الكريم',1),
 ('e2','abudawud','1525','الله الله ربي','شيئا',1),
 ('e3','muslim','918.01','انا لله','خيرا منها',1),
 ('e4','abudawud','5090','اللهم رحمتك ارجو','لا اله الا انت',1),
]
res = {}
for key, c, n, start, end, occ in SPECS:
    h, e = get(c, n)
    t = h['text']
    nt, idx = norm_map(t)
    s = -1
    for _ in range(occ):
        s = nt.find(start, s + 1)
    if s < 0: raise SystemExit(f'{key}: debut introuvable')
    en = nt.find(end, s)
    if en < 0: raise SystemExit(f'{key}: fin introuvable')
    a = idx[s]; b = idx[en + len(end) - 1] + 1
    # inclure les signes diacritiques qui suivent la derniere lettre
    while b < len(t) and DIAC.match(t[b]) and t[b] != '‏': b += 1
    frag = t[a:b]
    assert '‏' not in frag and '"' not in frag, key
    res[key] = {'collection': c, 'number': n, 'arabic': frag, 'grades': (e or {}).get('grades')}
json.dump(res, open('/tmp/h/adhkar.json', 'w'), ensure_ascii=False, indent=1)
for k, v in res.items(): print(k, v['collection'], v['number'], v['grades'], '|', v['arabic'])
