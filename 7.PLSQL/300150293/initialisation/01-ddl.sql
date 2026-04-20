-- ============================================================
-- 01-ddl.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- Centre Sportif — Gestion de Terrains & Réservations
-- #300150293
-- ============================================================

-- ------------------------------------------------------------
-- Table : clients
-- ------------------------------------------------------------
CREATE TABLE clients (
    id              SERIAL PRIMARY KEY,
    nom             TEXT NOT NULL,
    prenom          TEXT NOT NULL,
    email           TEXT UNIQUE NOT NULL,
    telephone       TEXT,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- Table : terrains
-- ------------------------------------------------------------
CREATE TABLE terrains (
    id            SERIAL PRIMARY KEY,
    nom_terrain   TEXT NOT NULL,
    type_surface  TEXT NOT NULL,
    tarif_horaire NUMERIC(10,2) NOT NULL,
    statut        TEXT DEFAULT 'Disponible'
);

-- ------------------------------------------------------------
-- Table : reservations
-- ------------------------------------------------------------
CREATE TABLE reservations (
    id             SERIAL PRIMARY KEY,
    client_id      INT NOT NULL REFERENCES clients(id),
    terrain_id     INT NOT NULL REFERENCES terrains(id),
    date_debut     TIMESTAMP NOT NULL,
    date_fin       TIMESTAMP NOT NULL,
    montant_total  NUMERIC(10,2),
    statut         TEXT DEFAULT 'Confirmee',
    date_creation  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- Table : logs
-- ------------------------------------------------------------
CREATE TABLE logs (
    id          SERIAL PRIMARY KEY,
    action      TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
