"""Construit le SQL des leçons de Tajwid décrites dans scripts/tajwid/NN.py (variable L).

Aucun mot du Coran n'est écrit ici : le corps contient des repères {{Q:sourate:verset:mot}} que la base remplace,
au moment de l'insertion, par le mot lu dans le texte verrouillé (table ayahs, découpage par espaces comme dans
src/lib/quiz.ts). Les exercices désignent eux aussi les mots par sourate, verset et numéro de mot.
Usage : python3 -I build.py 5 6   (écrit scripts/tajwid/sql/tajwid_05.sql, tajwid_06.sql)
"""
import hashlib, os, re

HERE = os.path.dirname(os.path.abspath(__file__))
AUTHOR = 'Claude (assistant IA)'

def q(s):
    if s is None: return 'null'
    if isinstance(s, int): return str(s)
    tag = 'x'
    while f'${tag}$' in s: tag += 'x'
    return f'${tag}${s}${tag}$'

MARK = re.compile(r'\{\{Q:(\d+):(\d+):(\d+)\}\}')
RCOLS = ['kind', 'surah', 'ayah_from', 'ayah_to', 'source_title', 'author', 'locator', 'url', 'note']
CAST = {'kind': '::public.reference_kind', 'surah': '::int', 'ayah_from': '::int', 'ayah_to': '::int'}

def word_sql(s, a, w):
    return (f"(select split_part(btrim(substr(text_uthmani, bismillah_length + 1)), ' ', {w}) "
            f"from public.ayahs where surah = {s} and number = {a})")

def body_sql(body):
    expr = q(body)
    for m in sorted(set(MARK.findall(body))):
        expr = f"replace({expr}, {q('{{Q:' + ':'.join(m) + '}}')}, {word_sql(*m)})"
    return expr

def sql(L):
    refs = ',\n  '.join('(' + ', '.join([str(i + 1)] + [q(r.get(c)) + CAST.get(c, '') for c in RCOLS]) + ')' for i, r in enumerate(L['refs']))
    qs = []
    for i, (p, ex, opts, ans, expl) in enumerate(L['questions']):
        s, a, wf, wt = ex if ex else (None, None, None, None)
        qs.append(f"({i + 1}, {q(p)}, {q(s)}::smallint, {q(a)}::smallint, {q(wf)}::smallint, {q(wt)}::smallint, array[{', '.join(q(o) for o in opts)}]::text[], {ans}, {q(expl)})")
    marks = sorted(set(MARK.findall(L['body'])))
    check = ' || '.join(f"{q(':'.join(m) + '=')} || {word_sql(*m)} || ' | '" for m in marks)
    check = check or "''"
    return f"""-- Tajwid {L['position']} : {L['slug']}
with it as (insert into public.content_items (slug, kind, section, locale, position)
            values ({q(L['slug'])}, 'lesson', 'tajwid', 'fr', {L['position']}) returning id),
rv as (insert into public.content_revisions (item_id, number, title, summary, body, ai_assisted, author_name)
       select id, 1, {q(L['title'])}, {q(L['summary'])}, {body_sql(L['body'])}, true, {q(AUTHOR)} from it returning id, item_id, body),
r as (insert into public.content_references (revision_id, {', '.join(RCOLS)})
      select rv.id, {', '.join('v.' + c for c in RCOLS)} from rv, (values
  {refs}) v(k, {', '.join(RCOLS)}) order by v.k returning 1),
qq as (insert into public.content_questions (revision_id, prompt, surah, ayah, word_from, word_to, options, answer, explanation)
       select rv.id, v.p, v.s, v.a, v.wf, v.wt, v.o, v.ans, v.e from rv, (values
  {',\n  '.join(qs)}) v(k, p, s, a, wf, wt, o, ans, e) order by v.k returning 1)
select private.ai_log(rv.item_id, rv.id, 'created', null, null, {q("Brouillon rédigé par l'IA : Tajwid " + str(L['position']))}),
       rv.body !~ '\\{{\\{{Q:' as reperes_remplaces,
       {check} as mots,
       (select count(*) from r) as refs, (select count(*) from qq) as questions from rv;
"""

def load(n):
    import importlib.util
    path = os.path.join(HERE, f'{n:02d}.py')
    spec = importlib.util.spec_from_file_location(f'tajwid{n}', path); mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod.L

if __name__ == '__main__':
    import sys
    os.makedirs(os.path.join(HERE, 'sql'), exist_ok=True)
    for arg in sys.argv[1:]:
        L = load(int(arg)); text = sql(L); path = os.path.join(HERE, 'sql', f'tajwid_{L["position"]:02d}.sql'); open(path, 'w').write(text)
        print(path, hashlib.md5(text.encode()).hexdigest(), len(text))
