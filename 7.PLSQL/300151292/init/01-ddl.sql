-- ============================================================
-- 01-ddl.sql - BorealFit - Création des tables
-- ============================================================

CREATE TABLE IF NOT EXISTS utilisateurs (
    id             SERIAL PRIMARY KEY,
    nom            TEXT NOT NULL,
    age            INT,
    email          TEXT UNIQUE,
    date_creation  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS activites (
    id          SERIAL PRIMARY KEY,
    nom         TEXT NOT NULL,
    categorie   TEXT NOT NULL,
    credits     INT DEFAULT 1
);

CREATE TABLE IF NOT EXISTS reservations (
    id              SERIAL PRIMARY KEY,
    utilisateur_id  INT REFERENCES utilisateurs(id),
    activite_id     INT REFERENCES activites(id),
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut          TEXT DEFAULT 'confirmee'
);

CREATE TABLE IF NOT EXISTS logs (
    id          SERIAL PRIMARY KEY,
    action      TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
