-- ========================
-- DDL.sql - Data Definition Language
-- Création des tables
-- ========================

CREATE TABLE IF NOT EXISTS etudiants (
    id      SERIAL PRIMARY KEY,
    nom     VARCHAR(100) NOT NULL,
    prenom  VARCHAR(100) NOT NULL,
    email   VARCHAR(150) UNIQUE,
    age     INT
);

CREATE TABLE IF NOT EXISTS cours (
    id          SERIAL PRIMARY KEY,
    titre       VARCHAR(200) NOT NULL,
    description TEXT,
    credits     INT DEFAULT 3
);

CREATE TABLE IF NOT EXISTS inscriptions (
    id          SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id),
    cours_id    INT REFERENCES cours(id),
    date_insc   DATE DEFAULT CURRENT_DATE
);
