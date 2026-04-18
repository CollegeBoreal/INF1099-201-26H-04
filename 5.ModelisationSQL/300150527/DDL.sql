DROP SCHEMA IF EXISTS aeroport CASCADE;

-- Création du schéma
CREATE SCHEMA aeroport;

-- =========================
-- Tables
-- =========================

CREATE TABLE aeroport.CompagnieAerienne (
    id_compagnie SERIAL PRIMARY KEY,
    nom TEXT,
    pays TEXT,
    code_IATA TEXT
);

CREATE TABLE aeroport.Avion (
    id_avion SERIAL PRIMARY KEY,
    modele TEXT,
    capacite INT,
    annee_fabrication INT,
    id_compagnie INT REFERENCES aeroport.CompagnieAerienne(id_compagnie)
);

CREATE TABLE aeroport.Terminal (
    id_terminal SERIAL PRIMARY KEY,
    nom TEXT,
    capacite INT
);

CREATE TABLE aeroport.Gate (
    id_gate SERIAL PRIMARY KEY,
    code_gate TEXT,
    id_terminal INT REFERENCES aeroport.Terminal(id_terminal)
);

CREATE TABLE aeroport.Runway (
    id_runway SERIAL PRIMARY KEY,
    code_runway TEXT,
    statut TEXT
);

CREATE TABLE aeroport.Vol (
    id_vol SERIAL PRIMARY KEY,
    numero_vol TEXT,
    date_depart DATE,
    date_arrivee DATE,
    origine TEXT,
    destination TEXT,
    id_avion INT REFERENCES aeroport.Avion(id_avion),
    id_gate INT REFERENCES aeroport.Gate(id_gate),
    id_runway INT REFERENCES aeroport.Runway(id_runway)
);

CREATE TABLE aeroport.Passager (
    id_passager SERIAL PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    passeport TEXT,
    nationalite TEXT
);

CREATE TABLE aeroport.Reservation (
    id_reservation SERIAL PRIMARY KEY,
    date_reservation DATE,
    statut TEXT,
    id_passager INT REFERENCES aeroport.Passager(id_passager),
    id_vol INT REFERENCES aeroport.Vol(id_vol)
);

CREATE TABLE aeroport.Billet (
    id_billet SERIAL PRIMARY KEY,
    numero_siege TEXT,
    classe TEXT,
    id_reservation INT REFERENCES aeroport.Reservation(id_reservation)
);

CREATE TABLE aeroport.Bagage (
    id_bagage SERIAL PRIMARY KEY,
    poids FLOAT,
    type TEXT,
    id_passager INT REFERENCES aeroport.Passager(id_passager)
);

CREATE TABLE aeroport.Personnel (
    id_personnel SERIAL PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    role TEXT,
    service TEXT
);

CREATE TABLE aeroport.ControleSecurite (
    id_controle SERIAL PRIMARY KEY,
    date_controle DATE,
    statut TEXT,
    id_passager INT REFERENCES aeroport.Passager(id_passager),
    id_personnel INT REFERENCES aeroport.Personnel(id_personnel)
);

CREATE TABLE aeroport.Maintenance (
    id_maintenance SERIAL PRIMARY KEY,
    date_intervention DATE,
    type_intervention TEXT,
    cout FLOAT,
    id_avion INT REFERENCES aeroport.Avion(id_avion)
);

CREATE TABLE aeroport.Incident (
    id_incident SERIAL PRIMARY KEY,
    description TEXT,
    type_incident TEXT,
    date_incident DATE,
    id_vol INT REFERENCES aeroport.Vol(id_vol)
);

CREATE TABLE aeroport.ServiceSol (
    id_service SERIAL PRIMARY KEY,
    type_service TEXT,
    statut TEXT,
    id_vol INT REFERENCES aeroport.Vol(id_vol)
);