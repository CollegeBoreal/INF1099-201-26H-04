-- ==================================================================================
-- 01-ddl.sql
-- TP PostgreSQL : Définition des tables (DDL)
-- ==================================================================================

-- Table des étudiants
CREATE TABLE etudiants (
    id            SERIAL PRIMARY KEY,
    nom           TEXT NOT NULL,
    age           INT,
    email         TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des cours
CREATE TABLE cours (
    id          SERIAL PRIMARY KEY,
    nom         TEXT NOT NULL UNIQUE,
    description TEXT,
    credits     INT DEFAULT 3
);

-- Table des inscriptions (relation etudiants <-> cours)
CREATE TABLE inscriptions (
    id           SERIAL PRIMARY KEY,
    etudiant_id  INT NOT NULL REFERENCES etudiants(id) ON DELETE CASCADE,
    cours_id     INT NOT NULL REFERENCES cours(id) ON DELETE CASCADE,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (etudiant_id, cours_id)
);

-- Table des logs (journalisation des actions)
CREATE TABLE logs (
    id          SERIAL PRIMARY KEY,
    action      TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

