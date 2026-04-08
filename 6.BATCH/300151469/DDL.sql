-- DDL.sql
-- Auteure : Rabia BOUHALI | Matricule : 300151469
-- Création de la base de données TCF Canada
 
CREATE DATABASE IF NOT EXISTS tcf_canada_300151469;
\c tcf_canada_300151469;
 
CREATE TABLE IF NOT EXISTS candidat (
    id_candidat  SERIAL PRIMARY KEY,
    nom          VARCHAR(50)  NOT NULL,
    prenom       VARCHAR(50)  NOT NULL,
    email        VARCHAR(100) NOT NULL UNIQUE,
    telephone    VARCHAR(20)
);
 
CREATE TABLE IF NOT EXISTS lieu (
    id_lieu   SERIAL PRIMARY KEY,
    nom_lieu  VARCHAR(100) NOT NULL,
    adresse   VARCHAR(150) NOT NULL
);
 
CREATE TABLE IF NOT EXISTS session (
    id_session     SERIAL PRIMARY KEY,
    date_session   DATE        NOT NULL,
    heure_session  TIME        NOT NULL,
    type_test      VARCHAR(50) NOT NULL,
    id_lieu        INT         NOT NULL,
    CONSTRAINT fk_session_lieu
        FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);
 
CREATE TABLE IF NOT EXISTS rendezvous (
    id_rendezvous  SERIAL PRIMARY KEY,
    id_candidat    INT         NOT NULL,
    id_session     INT         NOT NULL,
    statut         VARCHAR(50) NOT NULL,
    CONSTRAINT fk_rendezvous_candidat
        FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat),
    CONSTRAINT fk_rendezvous_session
        FOREIGN KEY (id_session) REFERENCES session(id_session)
);
 
CREATE TABLE IF NOT EXISTS paiement (
    id_paiement    SERIAL PRIMARY KEY,
    montant        DECIMAL(10,2) NOT NULL,
    mode_paiement  VARCHAR(50)   NOT NULL,
    date_paiement  DATE          NOT NULL,
    id_rendezvous  INT           NOT NULL,
    CONSTRAINT fk_paiement_rendezvous
        FOREIGN KEY (id_rendezvous) REFERENCES rendezvous(id_rendezvous)
);
 
