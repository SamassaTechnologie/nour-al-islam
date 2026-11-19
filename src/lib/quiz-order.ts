/**
 * Ordre d'affichage des propositions d'un exercice.
 * Le melange depend de l'identifiant de la question et du numero de la tentative :
 * il est identique sur le serveur et dans le navigateur (pas de decalage a l'affichage),
 * et change a chaque nouvelle tentative. La bonne reponse garde son numero d'origine.
 */
export function optionOrder(questionId: string, count: number, attempt: number): number[] {
  let seed = 2166136261;
  for (const char of `${questionId}:${attempt}`) {
    seed ^= char.codePointAt(0)!;
    seed = Math.imul(seed, 16777619) >>> 0;
  }
  const random = () => {
    seed = (Math.imul(seed ^ (seed >>> 15), 2246822519) + 3266489917) >>> 0;
    seed = (seed ^ (seed >>> 13)) >>> 0;
    return seed / 4294967296;
  };
  const order = Array.from({ length: count }, (_, n) => n);
  for (let i = count - 1; i > 0; i--) {
    const j = Math.floor(random() * (i + 1));
    [order[i], order[j]] = [order[j], order[i]];
  }
  return order;
}
