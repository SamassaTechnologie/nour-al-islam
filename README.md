# NOUR AL-ISLAM by SAMASSA TECHNOLOGIE

Plateforme éducative islamique : apprendre, comprendre et pratiquer l'Islam à la lumière du Coran et de la Sounnah.

Application en ligne : https://nour-al-islam.vercel.app

## État actuel : phase 1 (socle)

- Next.js, TypeScript et Tailwind CSS
- Comptes, profils et rôles avec Supabase
- Français et arabe, sens de lecture de droite à gauche
- Mode clair, sombre et automatique
- Interface conçue pour l'iPhone 13 mini (375 × 812), puis élargie

## Phase 3 : administration et validation

- Rôles : éditeur, réviseur religieux, administrateur. La double authentification est obligatoire pour les réviseurs et administrateurs
- Circuit : brouillon, vérification des sources par une autre personne, relecture, publication par un réviseur seulement
- Versions verrouillées après envoi, journal inaltérable, références obligatoires et contrôlées par la base
- Test : `tests/phase3.mjs` (comptes d'essai à créer puis supprimer)

## Phase 2 : lecture du Coran

- Texte Tanzil Uthmani 1.1 et traduction de Rachid Maach (QuranEnc, version 1.0.3), importés sans saisie et verrouillés dans la base
- Sourates, juz, hizb et rubʿ, recherche, signets, dernière lecture, taille du texte et lecture plein écran
- Mushaf de Médine de 1405 H en 604 pages (police QCF V1 du Complexe du Roi Fahd, via Quran Foundation), avec passage automatique à la page suivante
- Récitation verset par verset avec Quran Foundation : choix du récitant, répétition, vitesse et suivi du verset

Les sections Apprendre et Prière indiquent clairement qu'elles ne sont pas encore ouvertes.

## Installation

Prérequis : Node.js 22 ou plus récent et un projet Supabase.

```bash
npm install
cp .env.example .env.local   # puis renseigner les valeurs
npm run dev
```

Appliquer ensuite `supabase/migrations/` au projet Supabase.

## Réglages Supabase requis

Dans Authentication, URL Configuration :

- Site URL : l'adresse publique de l'application
- Redirect URLs : `https://VOTRE-DOMAINE/auth/callback`

Pour ouvrir les inscriptions au public, configurer un service d'envoi d'e-mails (SMTP) dans Authentication.

## Déploiement

Le projet se déploie sur Vercel avec ces variables : `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` et `NEXT_PUBLIC_SITE_URL`.

## Vérifications

```bash
npm run typecheck
npm run build
npm run test:e2e   # avec BASE_URL, CHROME_PATH et les comptes de test
```

## Rôles

`user`, `editor`, `reviewer`, `admin`. Un utilisateur ne peut pas modifier son propre rôle : la base de données le refuse.
