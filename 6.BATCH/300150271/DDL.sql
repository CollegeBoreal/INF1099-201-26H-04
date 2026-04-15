CREATE TABLE IF NOT EXISTS client (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    telephone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS immeuble (
    id_immeuble SERIAL PRIMARY KEY,
    adresse VARCHAR(200),
    ville VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS appartement (
    id_appartement SERIAL PRIMARY KEY,
    num_appartement INT,
    surface FLOAT,
    prix FLOAT,
    id_immeuble INT REFERENCES immeuble(id_immeuble)
);

CREATE TABLE IF NOT EXISTS vente (
    id_vente SERIAL PRIMARY KEY,
    date_vente DATE,
    id_client INT REFERENCES client(id_client),
    id_appartement INT REFERENCES appartement(id_appartement)
);