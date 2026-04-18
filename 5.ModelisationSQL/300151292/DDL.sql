-- ============================================================
-- DDL.sql - BorealFit - Création de la base de données
-- ============================================================

CREATE DATABASE IF NOT EXISTS borealfit;
USE borealfit;

-- Table UTILISATEUR
CREATE TABLE UTILISATEUR (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(150) NOT NULL UNIQUE
);

-- Table ADRESSE
CREATE TABLE ADRESSE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id INT NOT NULL,
    rue VARCHAR(200) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    code_postal VARCHAR(10) NOT NULL,
    FOREIGN KEY (utilisateur_id) REFERENCES UTILISATEUR(id) ON DELETE CASCADE
);

-- Table CATEGORIE
CREATE TABLE CATEGORIE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(100) NOT NULL
);

-- Table ACTIVITE
CREATE TABLE ACTIVITE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_activite VARCHAR(150) NOT NULL,
    categorie_id INT NOT NULL,
    FOREIGN KEY (categorie_id) REFERENCES CATEGORIE(id) ON DELETE RESTRICT
);

-- Table COACH
CREATE TABLE COACH (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20)
);

-- Table SEANCE
CREATE TABLE SEANCE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    activite_id INT NOT NULL,
    coach_id INT NOT NULL,
    date_seance DATE NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    salle VARCHAR(100) NOT NULL,
    capacite_max INT NOT NULL DEFAULT 20,
    FOREIGN KEY (activite_id) REFERENCES ACTIVITE(id) ON DELETE RESTRICT,
    FOREIGN KEY (coach_id) REFERENCES COACH(id) ON DELETE RESTRICT
);

-- Table RESERVATION
CREATE TABLE RESERVATION (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id INT NOT NULL,
    date_reservation DATE NOT NULL,
    statut_reservation VARCHAR(50) NOT NULL DEFAULT 'confirmée',
    CONSTRAINT chk_statut CHECK (statut_reservation IN ('confirmée', 'annulée', 'terminée')),
    FOREIGN KEY (utilisateur_id) REFERENCES UTILISATEUR(id) ON DELETE CASCADE
);

-- Table LIGNE_RESERVATION
CREATE TABLE LIGNE_RESERVATION (
    reservation_id INT NOT NULL,
    seance_id INT NOT NULL,
    PRIMARY KEY (reservation_id, seance_id),
    FOREIGN KEY (reservation_id) REFERENCES RESERVATION(id) ON DELETE CASCADE,
    FOREIGN KEY (seance_id) REFERENCES SEANCE(id) ON DELETE RESTRICT
);

-- Table PAIEMENT
CREATE TABLE PAIEMENT (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    montant DECIMAL(10, 2) NOT NULL,
    mode_paiement VARCHAR(50) NOT NULL,
    statut_paiement VARCHAR(50) NOT NULL DEFAULT 'en attente',
    CONSTRAINT chk_statut_paiement CHECK (statut_paiement IN ('en attente', 'complété', 'remboursé')),
    FOREIGN KEY (reservation_id) REFERENCES RESERVATION(id) ON DELETE CASCADE
);
