"""Construit le SQL de la leçon de Tajwid n° 5 (madd badal, madd ʿiwaḍ, madd līn).

Aucun mot du Coran n'est écrit ici : le corps contient des repères {{Q:sourate:verset:mot}} que la base remplace,
au moment de l'insertion, par le mot lu dans le texte verrouillé (table ayahs, découpage par espaces comme dans
src/lib/quiz.ts). Les exercices désignent eux aussi les mots par sourate, verset et numéro de mot.
Usage : python3 -I build_05.py   (écrit scripts/tajwid/sql/tajwid_05.sql)
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

WAJIZ_30 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/30'
WAJIZ_31 = 'https://usul.ai/t/al-wajeez-fi-ilm-al-tajweed/31'
MUKHT_11 = 'https://usul.ai/hi/t/the-concise-guide-to-tajweed-rulings/11'
MUKHT_13 = 'https://usul.ai/hi/t/the-concise-guide-to-tajweed-rulings/13'

L = dict(
    slug='madd-badal-iwad-lin', position=5,
    title="Le madd badal, le madd ʿiwaḍ et le madd līn",
    summary="Trois prolongations à connaître : la hamza avant la lettre de prolongation (badal), le tanwīn fatḥ à l'arrêt (ʿiwaḍ) et les lettres douces wāw et yā’ à l'arrêt (līn), avec leurs durées dans la lecture de Ḥafṣ.",
    body="""Cette leçon complète « Les prolongations dues à la hamza et au sukūn ». Les trois prolongations présentées ici se tiennent deux temps, comme la prolongation naturelle, sauf le madd līn à l'arrêt, qui suit les règles du madd dû à l'arrêt. Les durées sont celles de la lecture de Ḥafṣ ʿan ʿĀṣim, d'après les deux ouvrages cités.

1. Le madd badal (prolongation de substitution)
La hamza vient avant la lettre de prolongation, dans le même mot, et aucune hamza ni aucun sukūn ne vient après. On l'appelle badal (substitution) car, à l'origine, le mot avait deux hamzas : la seconde a été remplacée par une lettre de prolongation (al-Wajīz fī ʿilm al-tajwīd).
Durée : Ḥafṣ le raccourcit à deux temps. D'autres lecteurs l'allongent : c'est pourquoi les livres le classent parmi les prolongations permises (jā’iz).
Exemples : « {{Q:2:9:4}} » (āmanū), sourate 2, verset 9 ; « {{Q:3:173:12}} » (īmānan), sourate 3, verset 173 ; « {{Q:2:136:16}} » (ūtiya), sourate 2, verset 136.

2. Le madd ʿiwaḍ (prolongation de compensation)
Quand on s'arrête sur un mot terminé par un tanwīn fatḥ (deux fatḥa), on ne prononce pas le tanwīn : on le remplace par un alif tenu deux temps. En lecture continue, on prononce le tanwīn normalement (al-Mukhtaṣar al-mufīd).
Exemples, à l'arrêt : « {{Q:110:2:7}} » (afwājā), sourate 110, verset 2 ; « {{Q:110:3:8}} » (tawwābā), sourate 110, verset 3.

3. Le madd līn (prolongation des lettres douces)
Les lettres douces sont le wāw et le yā’ portant un sukūn et précédés d'une fatḥa. Si l'on s'arrête sur la lettre qui les suit, celle-ci prend un sukūn dû à l'arrêt, et la lettre douce peut être prolongée. En lecture continue, il n'y a pas de prolongation (al-Mukhtaṣar al-mufīd).
Durée à l'arrêt : comme le madd dû à l'arrêt, deux, quatre ou six temps ; al-Wajīz précise que les six temps sont peu employés pour le madd līn.
Exemples, à l'arrêt : « {{Q:106:3:4}} » (al-bayt), sourate 106, verset 3 ; « {{Q:106:4:7}} » (khawf), sourate 106, verset 4.

Comme pour le madd séparé, l'élève suit la manière de son enseignant pour la durée du madd līn et la garde tout au long de sa lecture.

Exercice : récitez la sourate Quraysh (106) en vous arrêtant à la fin de chaque verset, et repérez le madd līn des versets 3 et 4 ; puis récitez la sourate al-Naṣr (110) et repérez les deux madd ʿiwaḍ.""",
    refs=[
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Chapitre des prolongations : le madd badal', url=WAJIZ_30,
             note="Madd badal : hamza avant la lettre de prolongation ; deux temps ; Ḥafṣ fait partie de ceux qui le raccourcissent ; exemples 2:9, 3:173. Pagination du site, pas de l'édition imprimée."),
        dict(kind='book', source_title='al-Wajīz fī ʿilm al-tajwīd', author='Maḥmūd Sībawayh al-Badawī (1415 H)',
             locator='Chapitre des prolongations : le madd līn rattaché au madd dû à l’arrêt', url=WAJIZ_31,
             note="À l'arrêt, le līn a trois durées (deux, quatre, six temps), « mais la longueur dans le līn est peu employée » ; exemples khawf et al-bayt."),
        dict(kind='book', source_title='al-Mukhtaṣar al-mufīd fī aḥkām al-tajwīd', author='Muḥammad Ḥasan al-Ḥimṣī',
             locator='Les prolongations rattachées au madd naturel', url=MUKHT_11,
             note="Madd ʿiwaḍ : à l'arrêt, en compensation des deux fatḥa, deux temps ; madd badal : deux temps."),
        dict(kind='book', source_title='al-Mukhtaṣar al-mufīd fī aḥkām al-tajwīd', author='Muḥammad Ḥasan al-Ḥimṣī',
             locator='Le madd līn', url=MUKHT_13,
             note="Wāw et yā’ sākin précédés d'une fatḥa, suivis d'un sukūn dû à l'arrêt ; pas de prolongation en lecture continue."),
        dict(kind='quran', surah=2, ayah_from=9, ayah_to=9),
        dict(kind='quran', surah=2, ayah_from=136, ayah_to=136),
        dict(kind='quran', surah=3, ayah_from=173, ayah_to=173),
        dict(kind='quran', surah=106, ayah_from=3, ayah_to=4),
        dict(kind='quran', surah=110, ayah_from=2, ayah_to=3),
    ],
    questions=[
        ("Dans le madd badal, où se trouve la hamza ?", None, ["Avant la lettre de prolongation, dans le même mot", "Après la lettre de prolongation", "Dans le mot suivant"], 0,
         "Madd badal : la hamza précède la lettre de prolongation."),
        ("Combien de temps Ḥafṣ tient-il le madd badal ?", None, ["Deux temps", "Quatre temps", "Six temps"], 0,
         "Ḥafṣ le raccourcit à deux temps ; d'autres lecteurs l'allongent."),
        ("Quand y a-t-il un madd ʿiwaḍ ?", None, ["À l'arrêt sur un tanwīn fatḥ", "En lecture continue sur un tanwīn kasr", "Sur toute lettre portant une chadda"], 0,
         "À l'arrêt, le tanwīn fatḥ est remplacé par un alif de deux temps."),
        ("Quelles sont les lettres du madd līn ?", None, ["Le wāw et le yā’ sākin précédés d'une fatḥa", "L'alif, le wāw et le yā’ de prolongation", "Le nūn et le mīm"], 0,
         "Les lettres douces : wāw et yā’ portant un sukūn, avec une fatḥa avant."),
        ("Le madd līn existe-t-il en lecture continue ?", None, ["Non, seulement à l'arrêt", "Oui, toujours"], 0,
         "Il n'apparaît que si l'on s'arrête sur la lettre qui suit la lettre douce."),
        ("Quel madd se trouve dans ce mot ?", (2, 9, 4, 4), ["Madd badal : 2 temps", "Madd ʿiwaḍ : 2 temps à l'arrêt", "Madd līn : 2, 4 ou 6 temps à l'arrêt", "Madd lié : 4 ou 5 temps"], 0,
         "Āmanū : la hamza vient avant l'alif de prolongation, dans le même mot."),
        ("Quel madd se trouve à la fin de ce mot quand on s'arrête ?", (110, 2, 7, 7), ["Madd badal : 2 temps", "Madd ʿiwaḍ : 2 temps à l'arrêt", "Madd līn : 2, 4 ou 6 temps à l'arrêt", "Madd lié : 4 ou 5 temps"], 1,
         "Afwājā : le tanwīn fatḥ est remplacé par un alif de deux temps à l'arrêt."),
        ("Quel madd se trouve dans ce mot quand on s'arrête ?", (106, 4, 7, 7), ["Madd badal : 2 temps", "Madd ʿiwaḍ : 2 temps à l'arrêt", "Madd līn : 2, 4 ou 6 temps à l'arrêt", "Madd lié : 4 ou 5 temps"], 2,
         "Khawf : le wāw sākin est précédé d'une fatḥa ; à l'arrêt, le fā’ prend un sukūn et le wāw peut être prolongé."),
    ],
)

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

def sql():
    refs = ',\n  '.join('(' + ', '.join([str(i + 1)] + [q(r.get(c)) + CAST.get(c, '') for c in RCOLS]) + ')' for i, r in enumerate(L['refs']))
    qs = []
    for i, (p, ex, opts, ans, expl) in enumerate(L['questions']):
        s, a, wf, wt = ex if ex else (None, None, None, None)
        qs.append(f"({i + 1}, {q(p)}, {q(s)}::smallint, {q(a)}::smallint, {q(wf)}::smallint, {q(wt)}::smallint, array[{', '.join(q(o) for o in opts)}]::text[], {ans}, {q(expl)})")
    marks = sorted(set(MARK.findall(L['body'])))
    check = ' || '.join(f"{q(':'.join(m) + '=')} || {word_sql(*m)} || ' | '" for m in marks)
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

if __name__ == '__main__':
    os.makedirs(os.path.join(HERE, 'sql'), exist_ok=True)
    text = sql(); path = os.path.join(HERE, 'sql', 'tajwid_05.sql'); open(path, 'w').write(text)
    print(path, hashlib.md5(text.encode()).hexdigest(), len(text))
