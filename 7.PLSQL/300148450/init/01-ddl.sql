-- =========================================================
-- 01-ddl.sql
-- Création des tables du TP PostgreSQL
-- =========================================================

DROP TABLE IF EXISTS inscriptions CASCADE;
DROP TABLE IF EXISTS cours CASCADE;
DROP TABLE IF EXISTS logs CASCADE;
DROP TABLE IF EXISTS etudiants CASCADE;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cours (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE inscriptions (
    id SERIAL PRIMARY KEY,
    etudiant_id INT NOT NULL,
    cours_id INT NOT NULL,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_etudiant
        FOREIGN KEY (etudiant_id) REFERENCES etudiants(id) ON DELETE CASCADE,
    CONSTRAINT fk_cours
        FOREIGN KEY (cours_id) REFERENCES cours(id) ON DELETE CASCADE,
    CONSTRAINT uq_inscription UNIQUE (etudiant_id, cours_id)
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT NOT NULL,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
