// Génère le projet Android (Trusted Web Activity) de NOUR AL-ISLAM à partir du manifeste web en ligne.
// Usage : node generate.mjs <dossier> <versionCode> <versionName>
import { TwaManifest, TwaGenerator, ConsoleLog } from "@bubblewrap/core";

const [dir, code, name] = process.argv.slice(2);
const log = new ConsoleLog("twa");
const m = await TwaManifest.fromWebManifest("https://nour-al-islam.vercel.app/manifest.webmanifest");
m.packageId = "com.samassatechnologie.nouralislam";
m.host = "nour-al-islam.vercel.app";
m.name = "NOUR AL-ISLAM by SAMASSA TECHNOLOGIE";
m.launcherName = "Nour al-Islam";
m.startUrl = "/";
m.appVersionCode = Number(code);
m.appVersionName = name;
m.enableNotifications = true;
m.minSdkVersion = 24;
m.fallbackType = "customtabs";
m.signingKey = { path: "/vercel/keys/upload.jks", alias: "nour" };
await new TwaGenerator().createTwaProject(dir, m, log);
await m.saveToFile(`${dir}/twa-manifest.json`);
console.log("PROJET OK", m.packageId, m.appVersionCode, m.appVersionName);
