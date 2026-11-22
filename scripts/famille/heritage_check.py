"""Vérification des exemples de la leçon « L'héritage (2) ».

Chaque cas applique seulement les règles de la leçon 1 :
parts fixées de 4:11-12, puis le reste au plus proche parent homme
(al-Bukhārī 6732), le garçon recevant la part de deux filles.
Le programme vérifie que la somme des parts vaut exactement 1
et calcule le montant pour une succession donnée.
Usage : python3 heritage_check.py
"""
from fractions import Fraction as F

CASES = {
    1: dict(titre="Épouse, un fils et une fille", total=2_400_000,
            fixes={"Épouse": F(1, 8)}, reste=[("Fils", 2), ("Fille", 1)]),
    2: dict(titre="Épouse, père, mère et un fils", total=2_400_000,
            fixes={"Épouse": F(1, 8), "Père": F(1, 6), "Mère": F(1, 6)}, reste=[("Fils", 1)]),
    3: dict(titre="Mari et un fils", total=1_200_000,
            fixes={"Mari": F(1, 4)}, reste=[("Fils", 1)]),
    4: dict(titre="Une fille et le père", total=1_200_000,
            fixes={"Fille": F(1, 2), "Père (part fixée)": F(1, 6)}, reste=[("Père (reste)", 1)]),
    5: dict(titre="Le père et la mère seuls (ni enfant, ni frère, ni conjoint)", total=900_000,
            fixes={"Mère": F(1, 3)}, reste=[("Père", 1)]),
    6: dict(titre="Deux filles et un frère germain (ni fils, ni père)", total=1_500_000,
            fixes={"Deux filles ensemble": F(2, 3)}, reste=[("Frère germain", 1)]),
}


def compute(case):
    shares = dict(case["fixes"])
    rest = 1 - sum(shares.values(), F(0))
    assert rest >= 0, "les parts fixées dépassent la totalité"
    units = sum(w for _, w in case["reste"])
    for name, w in case["reste"]:
        shares[name] = rest * F(w, units)
    assert sum(shares.values(), F(0)) == 1, "la somme n'est pas égale à 1"
    return shares


if __name__ == "__main__":
    for n, case in CASES.items():
        shares = compute(case)
        print(f"Cas {n} : {case['titre']} — succession de " + f"{case['total']:,}".replace(",", " ") + " FCFA")
        for name, part in shares.items():
            montant = part * case["total"]
            assert montant.denominator == 1, "montant non entier"
            print(f"   {name} : {part} -> " + f"{int(montant):,}".replace(",", " ") + " FCFA")
        print("   somme = 1 : vérifiée")
    print("Tous les cas sont vérifiés.")
