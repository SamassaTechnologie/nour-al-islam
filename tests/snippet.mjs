// Extraits de recherche (src/lib/search.ts, sans la ligne createClient). Lancer avec node --experimental-strip-types.
import { snippet } from "./search.ts";
let f=0; const eq=(l,a,b)=>{const ok=JSON.stringify(a)===JSON.stringify(b); if(!ok)f++; console.log(ok?"OK  ":"ECHEC",l,JSON.stringify(a));};
eq("accent ignoré", snippet("La prière du vendredi est obligatoire.", "priere")?.match, "prière");
eq("majuscules", snippet("Le Tawḥīd est l'unicité.", "tawhid")?.match, "Tawḥīd");
eq("ʿ ignoré", snippet("selon ʿĀ'isha la mère", "aisha")?.match, "Ā'isha");
eq("arabe sans voyelles", snippet("قَالَ مَا أَنَا بِقَارِئٍ ثُمَّ", "ما انا بقارئ")?.match, "مَا أَنَا بِقَارِئٍ");
eq("absent", snippet("abc", "xyz"), null);
const long = "mot ".repeat(60) + "ablutions " + "fin ".repeat(60);
const s = snippet(long, "ablution"); eq("points de suspension", [s.before.startsWith("… "), s.after.endsWith(" …"), s.match], [true,true,"ablution"]);
console.log("ECHECS",f); process.exit(f?1:0);
