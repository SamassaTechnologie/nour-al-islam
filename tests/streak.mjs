// Calculs de serie du tableau de bord (src/lib/streak.ts). Placer streak.ts a cote ; lancer avec node --experimental-strip-types.
import { currentStreak, lastWeek, addDays } from "./streak.ts";
let f=0; const eq=(l,a,b)=>{const ok=JSON.stringify(a)===JSON.stringify(b); if(!ok)f++; console.log(ok?"OK  ":"ECHEC",l,a);};
const T="2026-11-20";
eq("vide",currentStreak([],T),0);
eq("aujourd'hui seul",currentStreak([T],T),1);
eq("hier seul (serie en cours)",currentStreak(["2026-11-19"],T),1);
eq("avant-hier seul",currentStreak(["2026-11-18"],T),0);
eq("3 jours avec trou",currentStreak([T,"2026-11-19","2026-11-17"],T),2);
eq("changement de mois",currentStreak(["2026-03-01","2026-02-28","2026-02-27"],"2026-03-01"),3);
eq("annee bissextile",addDays("2028-03-01",-1),"2028-02-29");
eq("changement d'annee",currentStreak(["2027-01-01","2026-12-31"],"2027-01-01"),2);
const w=lastWeek([T,"2026-11-14"],T); eq("semaine 7 jours",w.length,7); eq("premier jour",w[0],{day:"2026-11-14",active:true}); eq("dernier jour",w[6],{day:T,active:true}); eq("milieu",w[3].active,false);
console.log("ECHECS",f); process.exit(f?1:0);
