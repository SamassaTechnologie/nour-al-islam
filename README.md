# NOUR AL-ISLAM by SAMASSA TECHNOLOGIE

Plateforme éducative islamique : apprendre, comprendre et pratiquer l'Islam à la lumière du Coran et de la Sounnah.

## État actuel : phase 1 (socle)

- Next.js, TypeScript et Tailwind CSS
- Comptes, profils et rôles avec Supabase
- Français et arabe, sens de lecture de droite à gauche
- Mode clair, sombre et automatique
- Interface conçue pour l'iPhone 13 mini (375 × 812), puis élargie

Les sections Coran, Apprendre et Prière indiquent clairement qu'elles ne sont pas encore ouvertes.

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
