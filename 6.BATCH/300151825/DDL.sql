-- ============================================================
-- DDL.sql — Définition de la structure de la base de données
-- Projet : Gestion de la vente de crampons ⚽👟
-- ============================================================

-- Suppression des tables dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS Avis;
DROP TABLE IF EXISTS Livraison;
DROP TABLE IF EXISTS Paiement;
DROP TABLE IF EXISTS LigneCommande;
DROP TABLE IF EXISTS Commande;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Crampon;
DROP TABLE IF EXISTS Categorie;
DROP TABLE IF EXISTS Marque;
DROP TABLE IF EXISTS Adresse;
DROP TABLE IF EXISTS Client;

-- ============================================================
-- Table : Client
-- Représente une personne qui achète des crampons.
-- ============================================================
CREATE TABLE Client (
    id_client        SERIAL          PRIMARY KEY,
    nom              VARCHAR(100)    NOT NULL,
    prenom           VARCHAR(100)    NOT NULL,
    email            VARCHAR(150)    NOT NULL UNIQUE,
    telephone        VARCHAR(20),
    date_inscription DATE            NOT NULL DEFAULT CURRENT_DATE
);

-- ============================================================
-- Table : Adresse
-- Adresses postales associées à un client.
-- ============================================================
CREATE TABLE Adresse (
    id_adresse   SERIAL          PRIMARY KEY,
    type_adresse VARCHAR(20)     NOT NULL CHECK (type_adresse IN ('domicile', 'livraison', 'facturation')),
    rue          VARCHAR(200)    NOT NULL,
    ville        VARCHAR(100)    NOT NULL,
    code_postal  VARCHAR(10)     NOT NULL,
    pays         VARCHAR(50)     NOT NULL DEFAULT 'France',
    id_client    INT             NOT NULL,
    CONSTRAINT fk_adresse_client FOREIGN KEY (id_client)
        REFERENCES Client(id_client)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : Marque
-- Représente un fabricant de crampons.
-- ============================================================
CREATE TABLE Marque (
    id_marque    SERIAL          PRIMARY KEY,
    nom          VARCHAR(100)    NOT NULL UNIQUE,
    pays_origine VARCHAR(100),
    site_web     VARCHAR(150),
    description  TEXT
);

-- ============================================================
-- Table : Categorie
-- Représente le type de surface adapté au crampon.
-- ============================================================
CREATE TABLE Categorie (
    id_categorie SERIAL          PRIMARY KEY,
    code         VARCHAR(10)     NOT NULL UNIQUE,
    libelle      VARCHAR(100)    NOT NULL,
    description  TEXT
);

-- ============================================================
-- Table : Crampon
-- Représente un modèle de crampon disponible à la vente.
-- ============================================================
CREATE TABLE Crampon (
    id_crampon   SERIAL          PRIMARY KEY,
    modele       VARCHAR(100)    NOT NULL,
    pointure     DECIMAL(4,1)    NOT NULL CHECK (pointure BETWEEN 30 AND 50),
    couleur      VARCHAR(50)     NOT NULL,
    prix         DECIMAL(10,2)   NOT NULL CHECK (prix > 0),
    description  TEXT,
    id_marque    INT             NOT NULL,
    id_categorie INT             NOT NULL,
    CONSTRAINT fk_crampon_marque    FOREIGN KEY (id_marque)
        REFERENCES Marque(id_marque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_crampon_categorie FOREIGN KEY (id_categorie)
        REFERENCES Categorie(id_categorie)
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
    seuil_alerte        INT         NOT NULL DEFAULT 5,
    date_maj            TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_stock_crampon FOREIGN KEY (id_crampon)
        REFERENCES Crampon(id_crampon)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : Commande
-- Représente un achat effectué par un client.
-- ============================================================
CREATE TABLE Commande (
    id_commande   SERIAL          PRIMARY KEY,
    date_commande DATE            NOT NULL DEFAULT CURRENT_DATE,
    statut        VARCHAR(20)     NOT NULL DEFAULT 'EN_ATTENTE'
                                  CHECK (statut IN ('EN_ATTENTE', 'CONFIRMEE', 'EXPEDIEE', 'LIVREE', 'ANNULEE')),
    montant_total DECIMAL(10,2)   NOT NULL DEFAULT 0,
    id_client     INT             NOT NULL,
    id_adresse    INT,
    CONSTRAINT fk_commande_client  FOREIGN KEY (id_client)
        REFERENCES Client(id_client)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_commande_adresse FOREIGN KEY (id_adresse)
        REFERENCES Adresse(id_adresse)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : LigneCommande
-- Détail de chaque crampon dans une commande.
-- ============================================================
CREATE TABLE LigneCommande (
    id_ligne      SERIAL          PRIMARY KEY,
    quantite      INT             NOT NULL CHECK (quantite > 0),
    prix_unitaire DECIMAL(10,2)   NOT NULL CHECK (prix_unitaire > 0),
    id_commande   INT             NOT NULL,
    id_crampon    INT             NOT NULL,
    CONSTRAINT fk_ligne_commande FOREIGN KEY (id_commande)
        REFERENCES Commande(id_commande)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_ligne_crampon  FOREIGN KEY (id_crampon)
        REFERENCES Crampon(id_crampon)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : Paiement
-- Représente le règlement associé à une commande.
-- ============================================================
CREATE TABLE Paiement (
    id_paiement     SERIAL          PRIMARY KEY,
    mode_paiement   VARCHAR(20)     NOT NULL CHECK (mode_paiement IN ('carte', 'virement', 'paypal', 'cheque', 'especes')),
    statut_paiement VARCHAR(20)     NOT NULL DEFAULT 'EN_ATTENTE'
                                    CHECK (statut_paiement IN ('EN_ATTENTE', 'VALIDE', 'REFUSE', 'REMBOURSE')),
    montant_paye    DECIMAL(10,2)   NOT NULL CHECK (montant_paye > 0),
    date_paiement   TIMESTAMP,
    reference       VARCHAR(100),
    id_commande     INT             NOT NULL UNIQUE,
    CONSTRAINT fk_paiement_commande FOREIGN KEY (id_commande)
        REFERENCES Commande(id_commande)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : Livraison
-- Représente le suivi d'expédition d'une commande.
-- ============================================================
CREATE TABLE Livraison (
    id_livraison          SERIAL          PRIMARY KEY,
    transporteur          VARCHAR(100)    NOT NULL,
    numero_suivi          VARCHAR(100)    UNIQUE,
    date_expedition       DATE,
    date_livraison_prevue DATE,
    date_livraison_reelle DATE,
    statut_livraison      VARCHAR(20)     NOT NULL DEFAULT 'EN_PREPARATION'
                                          CHECK (statut_livraison IN ('EN_PREPARATION', 'EXPEDIE', 'EN_TRANSIT', 'LIVRE', 'ECHEC')),
    id_commande           INT             NOT NULL UNIQUE,
    CONSTRAINT fk_livraison_commande FOREIGN KEY (id_commande)
        REFERENCES Commande(id_commande)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- Table : Avis
-- Représente l'évaluation d'un crampon par un client.
-- ============================================================
CREATE TABLE Avis (
    id_avis     SERIAL          PRIMARY KEY,
    note        SMALLINT        NOT NULL CHECK (note BETWEEN 1 AND 5),
    titre       VARCHAR(150),
    commentaire TEXT,
    date_avis   DATE            NOT NULL DEFAULT CURRENT_DATE,
    verifie     BOOLEAN         NOT NULL DEFAULT FALSE,
    id_client   INT             NOT NULL,
    id_crampon  INT             NOT NULL,
    CONSTRAINT fk_avis_client  FOREIGN KEY (id_client)
        REFERENCES Client(id_client)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_avis_crampon FOREIGN KEY (id_crampon)
        REFERENCES Crampon(id_crampon)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- Index pour améliorer les performances des requêtes fréquentes
-- ============================================================
CREATE INDEX idx_adresse_client      ON Adresse(id_client);
CREATE INDEX idx_crampon_marque      ON Crampon(id_marque);
CREATE INDEX idx_crampon_categorie   ON Crampon(id_categorie);
CREATE INDEX idx_commande_client     ON Commande(id_client);
CREATE INDEX idx_commande_adresse    ON Commande(id_adresse);
CREATE INDEX idx_ligne_commande      ON LigneCommande(id_commande);
CREATE INDEX idx_ligne_crampon       ON LigneCommande(id_crampon);
CREATE INDEX idx_paiement_commande   ON Paiement(id_commande);
CREATE INDEX idx_livraison_commande  ON Livraison(id_commande);
CREATE INDEX idx_avis_client         ON Avis(id_client);
CREATE INDEX idx_avis_crampon        ON Avis(id_crampon);
