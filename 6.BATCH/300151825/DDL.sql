-- ============================================================
-- DDL.sql — Définition de la structure de la base de données
-- Projet : Gestion de la vente de crampons ⚽👟
-- ============================================================

-- Suppression des tables si elles existent déjà (ordre inverse des dépendances)
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Ligne_Commande;
DROP TABLE IF EXISTS Commande;
DROP TABLE IF EXISTS Crampon;
DROP TABLE IF EXISTS Client;

-- ============================================================
-- Table : Client
-- Représente une personne qui achète des crampons.
-- ============================================================
CREATE TABLE Client (
    id_client      SERIAL          PRIMARY KEY,
    nom            VARCHAR(100)    NOT NULL,
    prenom         VARCHAR(100)    NOT NULL,
    email          VARCHAR(150)    NOT NULL UNIQUE
);

-- ============================================================
-- Table : Crampon
-- Représente un modèle de crampon disponible à la vente.
-- ============================================================
CREATE TABLE Crampon (
    id_crampon     SERIAL          PRIMARY KEY,
    marque         VARCHAR(100)    NOT NULL,
    modele         VARCHAR(100)    NOT NULL,
    pointure       DECIMAL(4,1)    NOT NULL CHECK (pointure BETWEEN 30 AND 50),
    couleur        VARCHAR(50)     NOT NULL,
    prix           DECIMAL(10,2)   NOT NULL CHECK (prix > 0)
);

-- ============================================================
-- Table : Commande
-- Représente un achat effectué par un client.
-- ============================================================
CREATE TABLE Commande (
    id_commande    SERIAL          PRIMARY KEY,
    date_commande  DATE            NOT NULL DEFAULT CURRENT_DATE,
    statut         VARCHAR(50)     NOT NULL DEFAULT 'EN_ATTENTE'
                                   CHECK (statut IN ('EN_ATTENTE', 'CONFIRMEE', 'EXPEDIEE', 'LIVREE', 'ANNULEE')),
    id_client      INT             NOT NULL,
    CONSTRAINT fk_commande_client FOREIGN KEY (id_client)
        REFERENCES Client(id_client)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : Ligne_Commande
-- Détail de chaque crampon dans une commande (table de jonction).
-- ============================================================
CREATE TABLE Ligne_Commande (
    id_ligne_commande  SERIAL      PRIMARY KEY,
    id_commande        INT         NOT NULL,
    id_crampon         INT         NOT NULL,
    quantite           INT         NOT NULL CHECK (quantite > 0),
    CONSTRAINT fk_ligne_commande   FOREIGN KEY (id_commande)
        REFERENCES Commande(id_commande)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_ligne_crampon    FOREIGN KEY (id_crampon)
        REFERENCES Crampon(id_crampon)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : Stock
-- Représente la disponibilité de chaque crampon en magasin.
-- ============================================================
CREATE TABLE Stock (
    id_crampon          INT         PRIMARY KEY,
    quantite_disponible INT         NOT NULL DEFAULT 0 CHECK (quantite_disponible >= 0),
    CONSTRAINT fk_stock_crampon FOREIGN KEY (id_crampon)
        REFERENCES Crampon(id_crampon)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- Index pour améliorer les performances des requêtes fréquentes
-- ============================================================
CREATE INDEX idx_commande_client   ON Commande(id_client);
CREATE INDEX idx_ligne_commande    ON Ligne_Commande(id_commande);
CREATE INDEX idx_ligne_crampon     ON Ligne_Commande(id_crampon);
CREATE INDEX idx_crampon_marque    ON Crampon(marque);
