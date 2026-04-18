CREATE DATABASE IF NOT EXISTS tcf_canada_300151469;
USE tcf_canada_300151469;

CREATE TABLE candidat (
    id_candidat INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telephone VARCHAR(20)
);

CREATE TABLE lieu (
    id_lieu INT AUTO_INCREMENT PRIMARY KEY,
    nom_lieu VARCHAR(100) NOT NULL,
    adresse VARCHAR(150) NOT NULL
);

CREATE TABLE session (
    id_session INT AUTO_INCREMENT PRIMARY KEY,
    date_session DATE NOT NULL,
    heure_session TIME NOT NULL,
    type_test VARCHAR(50) NOT NULL,
    id_lieu INT NOT NULL,
    CONSTRAINT fk_session_lieu
        FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);

CREATE TABLE rendezvous (
    id_rendezvous INT AUTO_INCREMENT PRIMARY KEY,
    id_candidat INT NOT NULL,
    id_session INT NOT NULL,
    statut VARCHAR(50) NOT NULL,
    CONSTRAINT fk_rendezvous_candidat
        FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat),
    CONSTRAINT fk_rendezvous_session
        FOREIGN KEY (id_session) REFERENCES session(id_session)
);

CREATE TABLE paiement (
    id_paiement INT AUTO_INCREMENT PRIMARY KEY,
    montant DECIMAL(10,2) NOT NULL,
    mode_paiement VARCHAR(50) NOT NULL,
    date_paiement DATE NOT NULL,
    id_rendezvous INT NOT NULL,
    CONSTRAINT fk_paiement_rendezvous
        FOREIGN KEY (id_rendezvous) REFERENCES rendezvous(id_rendezvous)
);
