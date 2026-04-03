-- ==================================================================================
-- 01-ddl.sql
-- Création des tables : etudiants, cours, inscriptions, logs
-- ==================================================================================

CREATE TABLE etudiants (
    id    SERIAL PRIMARY KEY,
    nom   TEXT NOT NULL,
    age   INT,
    email TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cours (
    id          SERIAL PRIMARY KEY,
    nom         TEXT NOT NULL UNIQUE,
    description TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE inscriptions (
    id           SERIAL PRIMARY KEY,
    etudiant_id  INT NOT NULL REFERENCES etudiants(id) ON DELETE CASCADE,
    cours_id     INT NOT NULL REFERENCES cours(id)     ON DELETE CASCADE,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (etudiant_id, cours_id)
);

CREATE TABLE logs (
    id          SERIAL PRIMARY KEY,
    action      TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
