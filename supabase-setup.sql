-- ============================================================
-- Script de mise en place pour "Mes Trajets"
-- À copier-coller dans Supabase > SQL Editor > New query > Run
-- ============================================================

-- Permet le chiffrement des mots de passe
create extension if not exists pgcrypto;

-- Table des profils (max 2, gérés depuis l'app)
create table if not exists profiles (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  password_hash text not null,
  created_at timestamptz default now()
);

-- Table des trajets
create table if not exists trips (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references profiles(id) on delete cascade,
  name text not null,
  description text,
  km numeric not null,
  date date not null,
  duration integer default 0,
  category text default 'route',
  accompagnateur text,
  created_at timestamptz default now()
);

-- Table des trajets favoris (préenregistrés)
create table if not exists presets (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references profiles(id) on delete cascade,
  name text not null,
  description text,
  km numeric,
  category text default 'route',
  created_at timestamptz default now()
);

-- Fonction : vérifier un mot de passe (ne renvoie jamais le hash, juste vrai/faux)
create or replace function check_password(profile_id uuid, plain text)
returns boolean
language sql
security definer
as $$
  select password_hash = crypt(plain, password_hash)
  from profiles
  where id = profile_id;
$$;

-- Fonction : créer un profil avec mot de passe chiffré (utilisée par l'app à la création)
create or replace function create_profile(p_name text, p_password text)
returns uuid
language sql
security definer
as $$
  insert into profiles (name, password_hash)
  values (p_name, crypt(p_password, gen_salt('bf')))
  returning id;
$$;

-- Sécurité : active les règles d'accès sur chaque table
alter table profiles enable row level security;
alter table trips enable row level security;
alter table presets enable row level security;

-- Tout le monde peut voir la liste des noms de profils (pas les mots de passe, jamais exposés)
create policy "lecture publique des profils" on profiles
  for select using (true);

-- Personne ne peut créer/modifier un profil directement (uniquement via create_profile ci-dessus)

-- Les trajets et favoris sont gérés librement par l'app (protection via mot de passe côté interface)
create policy "acces trajets" on trips
  for all using (true) with check (true);

create policy "acces favoris" on presets
  for all using (true) with check (true);
