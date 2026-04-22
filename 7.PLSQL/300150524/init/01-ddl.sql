-- =========================
-- Création du schéma
-- =========================
CREATE SCHEMA IF NOT EXISTS cargorent;

-- =========================
-- Table clients
-- =========================
CREATE TABLE cargorent.clients (
    id_client SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    telephone TEXT,
    email TEXT UNIQUE,
    numero_permis TEXT UNIQUE
);

-- =========================
-- Table voitures
-- =========================
CREATE TABLE cargorent.voitures (
    id_voiture SERIAL PRIMARY KEY,
    marque TEXT,
    modele TEXT,
    annee INT,
    plaque TEXT UNIQUE,
    disponible BOOLEAN DEFAULT TRUE
);

-- =========================
-- Table reservations
-- =========================
CREATE TABLE cargorent.reservations (
    id_reservation SERIAL PRIMARY KEY,
    date_debut DATE,
    date_fin DATE,
    statut TEXT,
    id_client INT REFERENCES cargorent.clients(id_client),
    id_voiture INT REFERENCES cargorent.voitures(id_voiture)
);

-- =========================
-- Table logs (IMPORTANT)
-- =========================
CREATE TABLE cargorent.logs (
    id_log SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);