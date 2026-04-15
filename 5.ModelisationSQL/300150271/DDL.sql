CREATE TABLE Client (
    IdClient SERIAL PRIMARY KEY,
    Nom TEXT NOT NULL,
    Telephone TEXT NOT NULL
);

CREATE TABLE Immeuble (
    IdImmeuble SERIAL PRIMARY KEY,
    Adresse TEXT NOT NULL,
    Ville TEXT NOT NULL
);

CREATE TABLE Appartement (
    IdAppartement SERIAL PRIMARY KEY,
    NumAppartement INT NOT NULL,
    Surface FLOAT NOT NULL,
    Prix FLOAT NOT NULL,
    IdImmeuble INT REFERENCES Immeuble(IdImmeuble)
);

CREATE TABLE Vente (
    IdVente SERIAL PRIMARY KEY,
    DateVente DATE NOT NULL,
    IdClient INT REFERENCES Client(IdClient),
    IdAppartement INT REFERENCES Appartement(IdAppartement)
);
