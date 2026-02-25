-- ============================================================
-- DDL - Data Definition Language
-- Boutique de réparation de smartphones
-- #300150205
-- ============================================================

-- Connexion à PostgreSQL et création de la base
-- psql -U postgres
-- CREATE DATABASE reparation_smartphones;
-- \c reparation_smartphones

CREATE SCHEMA IF NOT EXISTS boutique;

-- ------------------------------------------------------------
-- Table : Marque
-- ------------------------------------------------------------
CREATE TABLE boutique.Marque (
    ID_Marque  SERIAL PRIMARY KEY,
    Nom_Marque TEXT NOT NULL
);

-- ------------------------------------------------------------
-- Table : Modele
-- ------------------------------------------------------------
CREATE TABLE boutique.Modele (
    ID_Modele    SERIAL PRIMARY KEY,
    Nom_Modele   TEXT NOT NULL,
    Annee_Sortie INT,
    ID_Marque    INT NOT NULL REFERENCES boutique.Marque(ID_Marque)
);

-- ------------------------------------------------------------
-- Table : Client
-- ------------------------------------------------------------
CREATE TABLE boutique.Client (
    ID_Client SERIAL PRIMARY KEY,
    Nom       TEXT NOT NULL,
    Prenom    TEXT NOT NULL,
    Telephone TEXT,
    Email     TEXT
);

-- ------------------------------------------------------------
-- Table : Adresse
-- ------------------------------------------------------------
CREATE TABLE boutique.Adresse (
    ID_Adresse  SERIAL PRIMARY KEY,
    Numero_rue  TEXT,
    Rue         TEXT NOT NULL,
    Ville       TEXT NOT NULL,
    Code_Postal TEXT NOT NULL,
    ID_Client   INT  NOT NULL REFERENCES boutique.Client(ID_Client)
);

-- ------------------------------------------------------------
-- Table : Technicien
-- ------------------------------------------------------------
CREATE TABLE boutique.Technicien (
    ID_Technicien SERIAL PRIMARY KEY,
    Nom           TEXT NOT NULL,
    Prenom        TEXT NOT NULL,
    Specialite    TEXT
);

-- ------------------------------------------------------------
-- Table : Appareil
-- ------------------------------------------------------------
CREATE TABLE boutique.Appareil (
    Num_IMEI     TEXT PRIMARY KEY,
    Couleur      TEXT,
    Etat_General TEXT,
    ID_Modele    INT  NOT NULL REFERENCES boutique.Modele(ID_Modele),
    ID_Client    INT  NOT NULL REFERENCES boutique.Client(ID_Client)
);

-- ------------------------------------------------------------
-- Table : Reparation
-- ------------------------------------------------------------
CREATE TABLE boutique.Reparation (
    ID_Reparation SERIAL PRIMARY KEY,
    Date_Depot    DATE NOT NULL,
    Statut        TEXT NOT NULL,
    Num_IMEI      TEXT NOT NULL REFERENCES boutique.Appareil(Num_IMEI),
    ID_Technicien INT  NOT NULL REFERENCES boutique.Technicien(ID_Technicien)
);

-- ------------------------------------------------------------
-- Table : Piece_Rechange
-- ------------------------------------------------------------
CREATE TABLE boutique.Piece_Rechange (
    ID_Piece      SERIAL PRIMARY KEY,
    Nom_Piece     TEXT          NOT NULL,
    Prix_Unitaire NUMERIC(10,2) NOT NULL
);

-- ------------------------------------------------------------
-- Table : Ligne_Reparation
-- ------------------------------------------------------------
CREATE TABLE boutique.Ligne_Reparation (
    ID_Ligne          SERIAL PRIMARY KEY,
    Description_Tache TEXT,
    Prix_MO           NUMERIC(10,2),
    ID_Reparation     INT NOT NULL REFERENCES boutique.Reparation(ID_Reparation),
    ID_Piece          INT NOT NULL REFERENCES boutique.Piece_Rechange(ID_Piece)
);

-- ------------------------------------------------------------
-- Table : Paiement
-- ------------------------------------------------------------
CREATE TABLE boutique.Paiement (
    ID_Paiement   SERIAL PRIMARY KEY,
    Date_Paiement DATE          NOT NULL,
    Montant_Total NUMERIC(10,2) NOT NULL,
    Mode_Paiement TEXT          NOT NULL,
    ID_Reparation INT           NOT NULL REFERENCES boutique.Reparation(ID_Reparation)
);

-- ------------------------------------------------------------
-- Table : Garantie
-- ------------------------------------------------------------
CREATE TABLE boutique.Garantie (
    ID_Garantie   SERIAL PRIMARY KEY,
    Date_Fin      DATE NOT NULL,
    Conditions    TEXT,
    ID_Reparation INT  NOT NULL REFERENCES boutique.Reparation(ID_Reparation)
);
