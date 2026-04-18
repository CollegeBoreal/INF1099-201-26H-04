-- ============================================================
-- DDL.sql - BorealFit - Création des tables (PostgreSQL)
-- ============================================================

CREATE TABLE IF NOT EXISTS utilisateurs (
    id      SERIAL PRIMARY KEY,
    nom     VARCHAR(100) NOT NULL,
    prenom  VARCHAR(100) NOT NULL,
    email   VARCHAR(150) NOT NULL UNIQUE,
    age     INT
);

CREATE TABLE IF NOT EXISTS categories (
    id             SERIAL PRIMARY KEY,
    nom_categorie  VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS activites (
    id           SERIAL PRIMARY KEY,
    nom_activite VARCHAR(150) NOT NULL,
    categorie_id INT REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS reservations (
    id                 SERIAL PRIMARY KEY,
    utilisateur_id     INT REFERENCES utilisateurs(id),
    activite_id        INT REFERENCES activites(id),
    date_reservation   DATE NOT NULL,
    statut             VARCHAR(50) DEFAULT 'confirmée'
);
