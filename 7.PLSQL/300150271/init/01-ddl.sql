-- ==================================================================================
-- 01-ddl.sql
-- TP PostgreSQL : Structure des tables — Domaine Immobilier
-- ==================================================================================

CREATE TABLE client (
    IdClient   SERIAL PRIMARY KEY,
    Nom        TEXT NOT NULL,
    Telephone  TEXT
);

CREATE TABLE immeuble (
    IdImmeuble SERIAL PRIMARY KEY,
    Adresse    TEXT NOT NULL,
    Ville      TEXT NOT NULL
);

CREATE TABLE appartement (
    IdAppartement  SERIAL PRIMARY KEY,
    NumAppartement INT NOT NULL,
    Surface        FLOAT NOT NULL,
    Prix           FLOAT NOT NULL,
    IdImmeuble     INT REFERENCES immeuble(IdImmeuble)
);

CREATE TABLE vente (
    IdVente       SERIAL PRIMARY KEY,
    DateVente     DATE DEFAULT CURRENT_DATE,
    IdClient      INT REFERENCES client(IdClient),
    IdAppartement INT REFERENCES appartement(IdAppartement)
);

CREATE TABLE logs (
    id          SERIAL PRIMARY KEY,
    action      TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
