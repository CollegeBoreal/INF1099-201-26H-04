-- ==========================================
-- CarGoRent - DDL (Data Definition Language)
-- Étudiant : Taki Eddine Choufa
-- Projet : Modélisation SQL CarGoRent
-- ==========================================

CREATE DATABASE cargorent_model;

-- Se connecter ensuite avec :
-- \c cargorent_model

CREATE SCHEMA IF NOT EXISTS cargorent;

CREATE TABLE IF NOT EXISTS cargorent.client (
    id_client SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    telephone TEXT,
    email TEXT UNIQUE,
    numero_permis TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS cargorent.categorie (
    id_categorie SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    prix_jour DECIMAL(10,2) NOT NULL CHECK (prix_jour >= 0)
);

CREATE TABLE IF NOT EXISTS cargorent.agence (
    id_agence SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    ville TEXT NOT NULL,
    adresse TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS cargorent.voiture (
    id_voiture SERIAL PRIMARY KEY,
    marque TEXT NOT NULL,
    modele TEXT NOT NULL,
    annee INT CHECK (annee >= 1900),
    plaque TEXT UNIQUE NOT NULL,
    kilometrage INT DEFAULT 0 CHECK (kilometrage >= 0),
    id_categorie INT NOT NULL REFERENCES cargorent.categorie(id_categorie),
    id_agence INT NOT NULL REFERENCES cargorent.agence(id_agence)
);

CREATE TABLE IF NOT EXISTS cargorent.reservation (
    id_reservation SERIAL PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    statut TEXT NOT NULL,
    id_client INT NOT NULL REFERENCES cargorent.client(id_client),
    id_voiture INT NOT NULL REFERENCES cargorent.voiture(id_voiture),
    CHECK (date_fin >= date_debut)
);

CREATE TABLE IF NOT EXISTS cargorent.employe (
    id_employe SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    poste TEXT NOT NULL,
    id_agence INT NOT NULL REFERENCES cargorent.agence(id_agence)
);

CREATE TABLE IF NOT EXISTS cargorent.contrat_location (
    id_contrat SERIAL PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    km_depart INT NOT NULL CHECK (km_depart >= 0),
    id_reservation INT NOT NULL REFERENCES cargorent.reservation(id_reservation),
    id_employe INT NOT NULL REFERENCES cargorent.employe(id_employe),
    CHECK (date_fin >= date_debut)
);

CREATE TABLE IF NOT EXISTS cargorent.paiement (
    id_paiement SERIAL PRIMARY KEY,
    montant DECIMAL(10,2) NOT NULL CHECK (montant >= 0),
    date_paiement DATE NOT NULL,
    mode TEXT NOT NULL,
    id_contrat INT NOT NULL REFERENCES cargorent.contrat_location(id_contrat)
);

-- Index d'optimisation
CREATE INDEX IF NOT EXISTS idx_client_email
    ON cargorent.client(email);

CREATE INDEX IF NOT EXISTS idx_reservation_client
    ON cargorent.reservation(id_client);

CREATE INDEX IF NOT EXISTS idx_reservation_voiture
    ON cargorent.reservation(id_voiture);

CREATE INDEX IF NOT EXISTS idx_contrat_reservation
    ON cargorent.contrat_location(id_reservation);

CREATE INDEX IF NOT EXISTS idx_paiement_contrat
    ON cargorent.paiement(id_contrat);

CREATE INDEX IF NOT EXISTS idx_voiture_categorie
    ON cargorent.voiture(id_categorie);

CREATE INDEX IF NOT EXISTS idx_voiture_agence
    ON cargorent.voiture(id_agence);
