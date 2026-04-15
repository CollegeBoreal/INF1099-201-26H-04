CREATE TABLE Client (
    IdClient SERIAL PRIMARY KEY,
    Nom TEXT,
    Telephone TEXT
);

CREATE TABLE Immeuble (
    IdImmeuble SERIAL PRIMARY KEY,
    Adresse TEXT,
    Ville TEXT
);

CREATE TABLE Appartement (
    IdAppartement SERIAL PRIMARY KEY,
    NumAppartement INT,
    Surface FLOAT,
    Prix FLOAT,
    IdImmeuble INT REFERENCES Immeuble(IdImmeuble)
);

CREATE TABLE Vente (
    IdVente SERIAL PRIMARY KEY,
    DateVente DATE,
    IdClient INT REFERENCES Client(IdClient),
    IdAppartement INT REFERENCES Appartement(IdAppartement)
);