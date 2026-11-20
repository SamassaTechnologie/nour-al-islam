// Application Android : fichier d'association du domaine (assetlinks.json) conforme, vérifié par l'API de Google,
// page de téléchargement (lien, empreinte, étapes), fichier téléchargeable identique, 320 px, arabe.
import { createHash } from "node:crypto";
import { chromium } from "playwright";

const { BASE_URL: base } = process.env;
const PACKAGE = "com.samassatechnologie.nouralislam";
const CERT = "03:AE:99:40:5E:F5:68:23:EE:64:0F:C8:81:79:A8:1F:07:85:D8:AF:9A:FA:3C:BD:F6:D2:8D:82:CD:15:5F:15";
const APK = "https://zkrjqmirszwjuepmccvd.supabase.co/storage/v1/object/public/downloads/android/nour-al-islam-1.0.0.apk";
const SHA = "53c09a1a2f05bbe14a8d8fefb11b0f5ae18f1cfda450ad629c2c6ce92926da38";
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };

const links = await fetch(`${base}/.well-known/assetlinks.json`, { redirect: "manual" });
check("assetlinks.json servi directement (200, JSON)", links.status === 200 && (links.headers.get("content-type") ?? "").includes("json"), `${links.status} ${links.headers.get("content-type")}`);
const statements = await links.json().catch(() => []);
check("assetlinks.json : paquet et empreinte de la clé", statements[0]?.target?.package_name === PACKAGE && statements[0]?.target?.sha256_cert_fingerprints?.[0] === CERT);

const google = await fetch(`https://digitalassetlinks.googleapis.com/v1/statements:list?source.web.site=${encodeURIComponent(base)}&relation=delegate_permission/common.handle_all_urls`).then((r) => r.json()).catch((e) => ({ error: e.message }));
const found = (google.statements ?? []).some((s) => s.target?.androidApp?.packageName === PACKAGE && s.target?.androidApp?.certificate?.sha256Fingerprint === CERT);
check("API Digital Asset Links de Google : association reconnue", found, JSON.stringify(google).slice(0, 200));

const apk = await fetch(APK);
const bytes = Buffer.from(await apk.arrayBuffer());
check("fichier de l'application téléchargeable", apk.status === 200 && apk.headers.get("content-type") === "application/vnd.android.package-archive", `${apk.status} ${apk.headers.get("content-type")}`);
check("fichier identique à la compilation (SHA-256)", createHash("sha256").update(bytes).digest("hex") === SHA);

const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const context = await browser.newContext({ locale: "fr-FR", viewport: { width: 320, height: 700 } });
const page = await context.newPage();
page.on("pageerror", (e) => errors.push(e.message));
await page.goto(`${base}/application-android`, { waitUntil: "networkidle" });
check("page : lien de téléchargement", (await page.getAttribute("[data-android-download]", "href")) === APK);
check("page : empreinte affichée", (await page.textContent("[data-android-sha]")).trim() === SHA);
check("page : 4 étapes d'installation", (await page.locator("[data-android-page] ol li").count()) === 4);
const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
check("page : pas de débordement à 320 px", overflow <= 0, String(overflow));
await context.addCookies([{ name: "nour_locale", value: "ar", url: base }]);
await page.goto(`${base}/application-android`, { waitUntil: "networkidle" });
check("page en arabe : de droite à gauche", (await page.getAttribute("html", "dir")) === "rtl" && (await page.textContent("h1")).includes("أندرويد"));
check("aucune erreur JavaScript", errors.length === 0, errors.join(" | "));
await browser.close();
console.log(failed ? `ECHECS ${failed}` : "ECHECS 0");
process.exit(failed ? 1 : 0);
