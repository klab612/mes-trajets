# Mes Trajets — Guide de mise en ligne

Ce projet est un site indépendant (pas lié à Claude). Il te faut 2 comptes gratuits :
**Supabase** (base de données + mots de passe) et **Vercel** (hébergement du site).
Compte-15 minutes, aucune carte bancaire nécessaire.

## Étape 1 — Créer la base de données (Supabase)

1. Va sur https://supabase.com et crée un compte gratuit (avec GitHub ou email).
2. Clique **New project**. Choisis un nom (ex. `mes-trajets`), un mot de passe de base de données (à garder de côté, différent des mots de passe des profils), et une région proche de toi (ex. `West EU`).
3. Attends ~2 minutes que le projet soit prêt.
4. Dans le menu de gauche, va sur **SQL Editor** → **New query**.
5. Ouvre le fichier `supabase-setup.sql` fourni avec ce projet, colle tout son contenu, puis clique **Run**.
   → Cela crée les tables et le système de mot de passe chiffré.
6. Va sur **Project Settings** (icône engrenage) → **API**.
   - Copie **Project URL** → tu en auras besoin (`VITE_SUPABASE_URL`)
   - Copie la clé **anon public** → tu en auras besoin (`VITE_SUPABASE_ANON_KEY`)

## Étape 2 — Mettre le code sur GitHub

1. Crée un compte gratuit sur https://github.com si tu n'en as pas.
2. Crée un nouveau dépôt (repository), par exemple `mes-trajets`.
3. Mets tous les fichiers de ce projet dedans (glisser-déposer sur github.com fonctionne, ou via `git push` si tu connais).

## Étape 3 — Déployer le site (Vercel)

1. Va sur https://vercel.com et connecte-toi avec ton compte GitHub.
2. Clique **Add New… → Project**, choisis ton dépôt `mes-trajets`.
3. Dans **Environment Variables**, ajoute :
   - `VITE_SUPABASE_URL` → colle l'URL copiée à l'étape 1
   - `VITE_SUPABASE_ANON_KEY` → colle la clé copiée à l'étape 1
4. Clique **Deploy**. Après 1-2 minutes, ton site est en ligne à une adresse du type
   `https://mes-trajets.vercel.app` — accessible à tout le monde, disponible en permanence.

## Étape 4 — Créer tes 2 profils

Ouvre ton site en ligne : la première fois, aucun profil n'existe.
Clique **Ajouter un utilisateur**, choisis un prénom et un mot de passe (les mots de passe
sont chiffrés dans la base, jamais stockés en clair). Fais-le pour les 2 utilisateurs (max 2).

## Et après ?

- Les données (trajets, favoris, progression) sont sauvegardées indéfiniment dans Supabase,
  indépendamment de Claude ou de ton compte personnel.
- Le plan gratuit de Supabase et Vercel n'expire pas tant que le projet reste actif
  (Supabase peut mettre en pause un projet gratuit après 7 jours d'inactivité totale —
  il suffit de rouvrir le tableau de bord Supabase pour le réactiver, aucune donnée n'est perdue).
- Pour modifier le design ou ajouter des fonctionnalités plus tard, reviens me voir avec
  le code du projet et je pourrai le faire évoluer.

## Limite de sécurité à connaître

Le mot de passe par profil protège contre les manipulations occasionnelles (quelqu'un qui
changerait tes données par curiosité), mais ce n'est pas un système de sécurité de niveau
bancaire : quelqu'un de très déterminé et technique pourrait le contourner. Pour un usage
familial de suivi de conduite accompagnée, c'est largement suffisant.
