<<<<<<< HEAD
CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT,
    email TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tables ajoutées pour le TP
CREATE TABLE cours (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL
);

CREATE TABLE inscriptions (
    id SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id),
    cours_id INT REFERENCES cours(id)
);
=======
-- ============================================================
-- 01-ddl.sql
-- TP PostgreSQL — Procédures, Fonctions et Triggers
-- Étudiante : Aroua Mohand Tahar
-- Matricule : 300150284
-- Rôle : création de la structure de base
-- ============================================================

DROP TABLE IF EXISTS inscriptions CASCADE;
DROP TABLE IF EXISTS logs CASCADE;
DROP TABLE IF EXISTS cours CASCADE;
DROP TABLE IF EXISTS etudiants CASCADE;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT,
    email TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cours (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL UNIQUE,
    credits INT DEFAULT 3
);

CREATE TABLE inscriptions (
    id SERIAL PRIMARY KEY,
    etudiant_id INT NOT NULL REFERENCES etudiants(id),
    cours_id INT NOT NULL REFERENCES cours(id),
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_inscription UNIQUE (etudiant_id, cours_id)
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
>>>>>>> f650d2d5a543182bc73855a0024af6ff9f85c796
