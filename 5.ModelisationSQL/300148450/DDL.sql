-- ============================================================
-- DDL.sql — Définition des structures
-- Projet : Gestion de Bibliothèque
-- Étudiant : Hocine Adjaoud — 300148450
-- ============================================================

-- Création de la base de données
CREATE DATABASE gestion_bibliotheque;

-- Connexion à la base
\c gestion_bibliotheque

-- Création du schéma
CREATE SCHEMA bibliotheque;

-- ------------------------------------------------------------
-- Table : Membre
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Membre (
    ID_Membre  SERIAL PRIMARY KEY,
    Nom        TEXT NOT NULL,
    Prenom     TEXT NOT NULL,
    Telephone  TEXT,
    Email      TEXT
);

-- ------------------------------------------------------------
-- Table : Adresse
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Adresse (
    ID_Adresse  SERIAL PRIMARY KEY,
    Numero_Rue  TEXT,
    Rue         TEXT NOT NULL,
    Ville       TEXT NOT NULL,
    Code_Postal TEXT NOT NULL,
    ID_Membre   INT NOT NULL REFERENCES bibliotheque.Membre(ID_Membre)
);

-- ------------------------------------------------------------
-- Table : Livre
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Livre (
    ID_Livre          SERIAL PRIMARY KEY,
    Titre             TEXT NOT NULL,
    Auteur            TEXT NOT NULL,
    Categorie         TEXT,
    Annee_Publication INT
);

-- ------------------------------------------------------------
-- Table : Exemplaire
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Exemplaire (
    ID_Exemplaire SERIAL PRIMARY KEY,
    Statut        TEXT NOT NULL,
    ID_Livre      INT NOT NULL REFERENCES bibliotheque.Livre(ID_Livre)
);

-- ------------------------------------------------------------
-- Table : Emprunt
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Emprunt (
    ID_Emprunt         SERIAL PRIMARY KEY,
    Date_Emprunt       DATE NOT NULL,
    Date_Retour_Prevue DATE NOT NULL,
    Date_Retour        DATE,
    ID_Exemplaire      INT NOT NULL REFERENCES bibliotheque.Exemplaire(ID_Exemplaire),
    ID_Membre          INT NOT NULL REFERENCES bibliotheque.Membre(ID_Membre)
);

-- Vérification
\dt bibliotheque.*
