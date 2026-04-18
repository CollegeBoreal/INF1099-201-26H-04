DROP TABLE IF EXISTS ServiceSol, Incident, Maintenance, ControleSecurite, Personnel,
Bagage, Billet, Reservation, Passager, Vol, Runway, Gate, Terminal, Avion, CompagnieAerienne CASCADE;

CREATE TABLE CompagnieAerienne (
    id_compagnie SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    pays VARCHAR(50),
    code_IATA VARCHAR(10)
);

CREATE TABLE Avion (
    id_avion SERIAL PRIMARY KEY,
    modele VARCHAR(50),
    capacite INT,
    annee_fabrication INT,
    id_compagnie INT,
    FOREIGN KEY (id_compagnie) REFERENCES CompagnieAerienne(id_compagnie)
);

CREATE TABLE Terminal (
    id_terminal SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    capacite INT
);

CREATE TABLE Gate (
    id_gate SERIAL PRIMARY KEY,
    code_gate VARCHAR(10),
    id_terminal INT,
    FOREIGN KEY (id_terminal) REFERENCES Terminal(id_terminal)
);

CREATE TABLE Runway (
    id_runway SERIAL PRIMARY KEY,
    code_runway VARCHAR(10),
    statut VARCHAR(20)
);

CREATE TABLE Vol (
    id_vol SERIAL PRIMARY KEY,
    numero_vol VARCHAR(20),
    date_depart DATE,
    date_arrivee DATE,
    origine VARCHAR(50),
    destination VARCHAR(50),
    id_avion INT,
    id_gate INT,
    id_runway INT,
    FOREIGN KEY (id_avion) REFERENCES Avion(id_avion),
    FOREIGN KEY (id_gate) REFERENCES Gate(id_gate),
    FOREIGN KEY (id_runway) REFERENCES Runway(id_runway)
);

CREATE TABLE Passager (
    id_passager SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    passeport VARCHAR(50),
    nationalite VARCHAR(50)
);

CREATE TABLE Reservation (
    id_reservation SERIAL PRIMARY KEY,
    date_reservation DATE,
    statut VARCHAR(20),
    id_passager INT,
    id_vol INT,
    FOREIGN KEY (id_passager) REFERENCES Passager(id_passager),
    FOREIGN KEY (id_vol) REFERENCES Vol(id_vol)
);

CREATE TABLE Billet (
    id_billet SERIAL PRIMARY KEY,
    numero_siege VARCHAR(10),
    classe VARCHAR(20),
    id_reservation INT,
    FOREIGN KEY (id_reservation) REFERENCES Reservation(id_reservation)
);

CREATE TABLE Bagage (
    id_bagage SERIAL PRIMARY KEY,
    poids INT,
    type VARCHAR(20),
    id_passager INT,
    FOREIGN KEY (id_passager) REFERENCES Passager(id_passager)
);

CREATE TABLE Personnel (
    id_personnel SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    role VARCHAR(50),
    service VARCHAR(50)
);

CREATE TABLE ControleSecurite (
    id_controle SERIAL PRIMARY KEY,
    date_controle DATE,
    statut VARCHAR(20),
    id_passager INT,
    id_personnel INT,
    FOREIGN KEY (id_passager) REFERENCES Passager(id_passager),
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel)
);

CREATE TABLE Maintenance (
    id_maintenance SERIAL PRIMARY KEY,
    date_intervention DATE,
    type_intervention VARCHAR(50),
    cout INT,
    id_avion INT,
    FOREIGN KEY (id_avion) REFERENCES Avion(id_avion)
);

CREATE TABLE Incident (
    id_incident SERIAL PRIMARY KEY,
    description TEXT,
    type_incident VARCHAR(50),
    date_incident DATE,
    id_vol INT,
    FOREIGN KEY (id_vol) REFERENCES Vol(id_vol)
);

CREATE TABLE ServiceSol (
    id_service SERIAL PRIMARY KEY,
    type_service VARCHAR(50),
    statut VARCHAR(20),
    id_vol INT,
    FOREIGN KEY (id_vol) REFERENCES Vol(id_vol)
);