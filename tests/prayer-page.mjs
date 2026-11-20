// Page des horaires de priere (/priere/horaires) : affichage, prochaine priere, reglages gardes, position.
// Placer prayer-times.ts a cote (npm i adhan@4.4.6) ; lancer avec node --experimental-strip-types.
import { chromium } from "playwright";
import { CITIES, computeTimes, localDate, nextPrayer } from "./prayer-times.ts";

const base = process.env.BASE_URL;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const context = await browser.newContext({ viewport: { width: 375, height: 800 }, locale: "fr-FR", timezoneId: "Africa/Bamako", permissions: ["geolocation"], geolocation: { latitude: 14.4469, longitude: -11.4456 } });
const page = await context.newPage();
page.on("pageerror", (e) => errors.push(e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push(m.text()); });

const read = () => page.evaluate(() => {
  const root = document.querySelector("[data-prayer-times]");
  return {
    place: root.dataset.place, method: root.dataset.method, asr: root.dataset.asr,
    times: Object.fromEntries([...document.querySelectorAll("[data-prayer]")].map((e) => [e.dataset.prayer, e.dataset.time])),
    next: document.querySelector("[data-next]").dataset.next,
    countdown: Number(document.querySelector("[data-countdown]").dataset.countdown),
  };
});
const expected = (place, method, asr) => {
  const t = computeTimes(place, localDate(new Date(), place.tz), method, asr);
  return Object.fromEntries(Object.entries(t).map(([k, v]) => [k, v.toISOString()]));
};

await page.goto(`${base}/priere`, { waitUntil: "networkidle" });
await page.click("[data-open-times]");
await page.waitForSelector("[data-prayer-times]");
check("page Prière : le lien ouvre les horaires", page.url().endsWith("/priere/horaires"));

let s = await read();
check("par défaut : Bamako, Ligue islamique mondiale, ʿaṣr majorité", s.place === "Bamako" && s.method === "MuslimWorldLeague" && s.asr === "standard", `${s.place} ${s.method} ${s.asr}`);
check("six horaires affichés (dont le lever du soleil)", Object.keys(s.times).join() === "fajr,sunrise,dhuhr,asr,maghrib,isha");
check("horaires identiques au calcul de référence", JSON.stringify(s.times) === JSON.stringify(expected(CITIES[0], "MuslimWorldLeague", "standard")));
const bamakoTimes = computeTimes(CITIES[0], localDate(new Date(), "Africa/Bamako"), "MuslimWorldLeague", "standard");
check("prochaine prière correcte", s.next === (nextPrayer(bamakoTimes, new Date()) ?? "fajr"), s.next);
check("compte à rebours cohérent (0 à 24 h)", s.countdown >= 0 && s.countdown <= 24 * 60, String(s.countdown));
check("ordre des horaires croissant", Object.values(s.times).every((v, i, a) => i === 0 || v > a[i - 1]));

await page.selectOption("#pt-city", "Paris");
s = await read();
check("ville changée : Paris, horaires recalculés", s.place === "Paris" && JSON.stringify(s.times) === JSON.stringify(expected(CITIES.find((c) => c.label === "Paris"), "MuslimWorldLeague", "standard")));
const parisDhuhr = await page.textContent('[data-prayer="dhuhr"] .tabular-nums');
const parisRef = new Intl.DateTimeFormat("fr-FR", { hour: "2-digit", minute: "2-digit", hour12: false, timeZone: "Europe/Paris" }).format(new Date(s.times.dhuhr));
check("heure affichée dans le fuseau de la ville (Paris)", parisDhuhr.trim() === parisRef, `${parisDhuhr} / ${parisRef}`);

await page.selectOption("#pt-method", "UmmAlQura");
await page.check('input[name="asr"][value="hanafi"]');
const standardAsr = (await read()).times.asr;
s = await read();
check("méthode et école changées", s.method === "UmmAlQura" && s.asr === "hanafi");
const paris = CITIES.find((c) => c.label === "Paris");
check("ʿaṣr hanafite plus tard que la majorité", new Date(s.times.asr) > new Date(expected(paris, "UmmAlQura", "standard").asr), `${s.times.asr}`);
await page.reload({ waitUntil: "networkidle" });
await page.waitForSelector("[data-prayer-times]");
s = await read();
check("réglages gardés après rechargement", s.place === "Paris" && s.method === "UmmAlQura" && s.asr === "hanafi", `${s.place} ${s.method} ${s.asr}`);

await page.click("[data-locate]");
await page.waitForFunction(() => document.querySelector("[data-prayer-times]")?.dataset.place === "Ma position", null, { timeout: 15000 });
s = await read();
check("« Utiliser ma position » : horaires de la position (Kayes simulée)", JSON.stringify(s.times) === JSON.stringify(expected({ lat: 14.4469, lng: -11.4456, tz: "Africa/Bamako" }, "UmmAlQura", "hanafi")));

for (const width of [320, 1280]) {
  await page.setViewportSize({ width, height: 800 });
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
  check(`pas de débordement à ${width} px`, overflow <= 0, String(overflow));
}
await context.addCookies([{ name: "nour_locale", value: "ar", url: base }]);
await page.reload({ waitUntil: "networkidle" });
await page.waitForSelector("[data-prayer-times]");
check("version arabe : « مواقيت الصلاة » et noms des prières", (await page.textContent("h1")).includes("مواقيت") && (await page.textContent('[data-prayer="maghrib"]')).includes("المغرب"));
await page.setViewportSize({ width: 320, height: 800 });
check("version arabe : pas de débordement à 320 px", await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth) <= 0);

// Position refusee : message clair, pas d'erreur.
const denied = await (await browser.newContext({ permissions: [] })).newPage();
await denied.goto(`${base}/priere/horaires`, { waitUntil: "networkidle" });
await denied.click("[data-locate]");
await denied.waitForSelector('[role="alert"]', { timeout: 20000 });
check("position refusée : message invitant à choisir une ville", (await denied.textContent('[role="alert"]')).includes("ville"));

check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
