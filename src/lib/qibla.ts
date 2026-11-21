// Direction de la Qibla : cap initial du grand cercle vers la Kaʿba (calcul geographique).
export const KAABA = { lat: 21.422487, lng: 39.826206 };

const rad = (d: number) => (d * Math.PI) / 180;
const deg = (r: number) => (r * 180) / Math.PI;

/** Angle en degres, mesure depuis le nord dans le sens des aiguilles d'une montre (0 a 360). */
export function qiblaBearing(lat: number, lng: number) {
  const φ1 = rad(lat);
  const φ2 = rad(KAABA.lat);
  const Δλ = rad(KAABA.lng - lng);
  const y = Math.sin(Δλ) * Math.cos(φ2);
  const x = Math.cos(φ1) * Math.sin(φ2) - Math.sin(φ1) * Math.cos(φ2) * Math.cos(Δλ);
  return (deg(Math.atan2(y, x)) + 360) % 360;
}

/** Distance jusqu'a la Kaʿba en kilometres (formule de haversine). */
export function distanceToKaaba(lat: number, lng: number) {
  const dφ = rad(KAABA.lat - lat);
  const dλ = rad(KAABA.lng - lng);
  const a = Math.sin(dφ / 2) ** 2 + Math.cos(rad(lat)) * Math.cos(rad(KAABA.lat)) * Math.sin(dλ / 2) ** 2;
  return 6371.0088 * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

/** Ecart signe le plus court entre deux angles (-180 a 180). */
export function angleDiff(a: number, b: number) {
  return ((a - b + 540) % 360) - 180;
}
