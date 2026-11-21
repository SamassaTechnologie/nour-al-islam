"""Construit le SQL des leçons de Jeûne (rubrique « jeune »), décrites dans scripts/jeune/NN.py (variable LESSON).

Même moteur que la Sira (scripts/sira/build_sql.py) : textes arabes insérés depuis l'édition de sunnah.com par des repères.
Usage : python3 -I build.py 1   (écrit scripts/jeune/sql/jeune_01.sql)
"""
import hashlib, importlib.util, os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location('sira_build', os.path.join(HERE, '..', 'sira', 'build_sql.py'))
eng = importlib.util.module_from_spec(spec); spec.loader.exec_module(eng)

def load(n):
    path = os.path.join(HERE, f'{n:02d}.py')
    sp = importlib.util.spec_from_file_location(f'jeune{n}', path); mod = importlib.util.module_from_spec(sp)
    mod.__dict__.update(coll=eng.coll, quran=eng.quran, book=eng.book); sp.loader.exec_module(mod)
    L = mod.LESSON; L.setdefault('section', 'jeune'); L.setdefault('label', 'Jeûne')
    return L

if __name__ == '__main__':
    out = os.path.join(HERE, 'sql'); os.makedirs(out, exist_ok=True)
    for a in sys.argv[1:]:
        L = load(int(a)); md5, text = eng.sql(L); path = os.path.join(out, f'jeune_{L["position"]:02d}.sql')
        open(path, 'w').write(text)
        print(L['position'], L['slug'], md5, hashlib.md5(text.encode()).hexdigest(), len(text))
