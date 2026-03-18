-- Création de la base
CREATE DATABASE maillotsdb;

\c maillotsdb

-- Création du schéma
CREATE SCHEMA boutique;

-- Table Client
CREATE TABLE boutique.client (
    id_client SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    telephone TEXT,
    email TEXT UNIQUE,
    date_inscription DATE DEFAULT CURRENT_DATE
);

-- Table Adresse
CREATE TABLE boutique.adresse (
    id_adresse SERIAL PRIMARY KEY,
    numero_rue TEXT,
    rue TEXT NOT NULL,
    ville TEXT NOT NULL,
    code_postal TEXT NOT NULL,
    pays TEXT,
    id_client INT REFERENCES boutique.client(id_client)
);

-- Table Compte Client
CREATE TABLE boutique.compte_client (
    id_compte SERIAL PRIMARY KEY,
    date_creation DATE DEFAULT CURRENT_DATE,
    statut TEXT,
    id_client INT REFERENCES boutique.client(id_client)
);

-- Table Equipe
CREATE TABLE boutique.equipe (
    id_equipe SERIAL PRIMARY KEY,
    nom_equipe TEXT NOT NULL,
    pays TEXT
);

-- Table Produit
CREATE TABLE boutique.produit (
    id_produit SERIAL PRIMARY KEY,
    nom_produit TEXT NOT NULL,
    saison TEXT,
    taille TEXT,
    etat TEXT,
    prix NUMERIC(10,2),
    stock INT,
    id_equipe INT REFERENCES boutique.equipe(id_equipe)
);

-- Table Commande
CREATE TABLE boutique.commande (
    id_commande SERIAL PRIMARY KEY,
    date_commande DATE DEFAULT CURRENT_DATE,
    statut TEXT,
    total NUMERIC(10,2),
    id_client INT REFERENCES boutique.client(id_client),
    id_adresse_livraison INT REFERENCES boutique.adresse(id_adresse)
);

-- Ligne commande
CREATE TABLE boutique.ligne_commande (
    id_ligne SERIAL PRIMARY KEY,
    quantite INT,
    prix_unitaire NUMERIC(10,2),
    id_commande INT REFERENCES boutique.commande(id_commande),
    id_produit INT REFERENCES boutique.produit(id_produit)
);

-- Mode paiement
CREATE TABLE boutique.mode_paiement (
    id_mode_paiement SERIAL PRIMARY KEY,
    nom_mode TEXT
);

-- Prestataire paiement
CREATE TABLE boutique.prestataire_paiement (
    id_prestataire SERIAL PRIMARY KEY,
    nom_prestataire TEXT,
    type_service TEXT
);

-- Paiement
CREATE TABLE boutique.paiement (
    id_paiement SERIAL PRIMARY KEY,
    date_paiement DATE,
    montant_paye NUMERIC(10,2),
    statut TEXT,
    id_commande INT REFERENCES boutique.commande(id_commande),
    id_mode_paiement INT REFERENCES boutique.mode_paiement(id_mode_paiement),
    id_prestataire INT REFERENCES boutique.prestataire_paiement(id_prestataire)
);

-- Historique commande
CREATE TABLE boutique.historique_commande (
    id_historique SERIAL PRIMARY KEY,
    date_action DATE,
    action TEXT,
    id_commande INT REFERENCES boutique.commande(id_commande)
);
