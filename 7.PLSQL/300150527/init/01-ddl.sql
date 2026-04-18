-- =========================================
-- Base de données Compagnie Aérienne
-- PostgreSQL version
-- =========================================

-- Table logs (important pour TP)
CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Compagnie
CREATE TABLE CompagnieAerienne (
    id_compagnie SERIAL PRIMARY KEY,
    nom TEXT,
    pays TEXT,
    code_IATA TEXT
);

-- Avion
CREATE TABLE Avion (
    id_avion SERIAL PRIMARY KEY,
    modele TEXT,
    capacite INT,
    annee_fabrication INT,
    id_compagnie INT REFERENCES CompagnieAerienne(id_compagnie)
);

-- Terminal
CREATE TABLE Terminal (
    id_terminal SERIAL PRIMARY KEY,
    nom TEXT,
    capacite INT
);

-- Gate
CREATE TABLE Gate (
    id_gate SERIAL PRIMARY KEY,
    code_gate TEXT,
    id_terminal INT REFERENCES Terminal(id_terminal)
);

-- Runway
CREATE TABLE Runway (
    id_runway SERIAL PRIMARY KEY,
    code_runway TEXT,
    statut TEXT
);

-- Vol
CREATE TABLE Vol (
    id_vol SERIAL PRIMARY KEY,
    numero_vol TEXT,
    date_depart TIMESTAMP,
    date_arrivee TIMESTAMP,
    origine TEXT,
    destination TEXT,
    id_avion INT REFERENCES Avion(id_avion),
    id_gate INT REFERENCES Gate(id_gate),
    id_runway INT REFERENCES Runway(id_runway)
);

-- Passager
CREATE TABLE Passager (
    id_passager SERIAL PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    passeport TEXT UNIQUE,
    nationalite TEXT
);

-- Reservation
CREATE TABLE Reservation (
    id_reservation SERIAL PRIMARY KEY,
    date_reservation TIMESTAMP,
    statut TEXT,
    id_passager INT REFERENCES Passager(id_passager),
    id_vol INT REFERENCES Vol(id_vol)
);

-- Billet
CREATE TABLE Billet (
    id_billet SERIAL PRIMARY KEY,
    numero_siege TEXT,
    classe TEXT,
    id_reservation INT REFERENCES Reservation(id_reservation)
);

-- Bagage
CREATE TABLE Bagage (
    id_bagage SERIAL PRIMARY KEY,
    poids FLOAT,
    type TEXT,
    id_passager INT REFERENCES Passager(id_passager)
);

-- Personnel
CREATE TABLE Personnel (
    id_personnel SERIAL PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    role TEXT,
    service TEXT
);

-- Controle Securite
CREATE TABLE ControleSecurite (
    id_controle SERIAL PRIMARY KEY,
    date_controle TIMESTAMP,
    statut TEXT,
    id_passager INT REFERENCES Passager(id_passager),
    id_personnel INT REFERENCES Personnel(id_personnel)
);

-- Maintenance
CREATE TABLE Maintenance (
    id_maintenance SERIAL PRIMARY KEY,
    date_intervention TIMESTAMP,
    type_intervention TEXT,
    cout FLOAT,
    id_avion INT REFERENCES Avion(id_avion)
);

-- Incident
CREATE TABLE Incident (
    id_incident SERIAL PRIMARY KEY,
    description TEXT,
    type_incident TEXT,
    date_incident TIMESTAMP,
    id_vol INT REFERENCES Vol(id_vol)
);

-- ServiceSol
CREATE TABLE ServiceSol (
    id_service SERIAL PRIMARY KEY,
    type_service TEXT,
    statut TEXT,
    id_vol INT REFERENCES Vol(id_vol)
);