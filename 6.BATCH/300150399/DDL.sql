CREATE SCHEMA IF NOT EXISTS boutique;

CREATE TABLE boutique.equipe (
id_equipe SERIAL PRIMARY KEY,
nom_equipe VARCHAR(100),
pays VARCHAR(100)
);

CREATE TABLE boutique.client (
id_client SERIAL PRIMARY KEY,
nom VARCHAR(100),
prenom VARCHAR(100),
email VARCHAR(150)
);

CREATE TABLE boutique.produit (
id_produit SERIAL PRIMARY KEY,
nom_produit VARCHAR(150),
saison VARCHAR(20),
taille VARCHAR(10),
etat VARCHAR(50),
prix DECIMAL(10,2),
id_equipe INT REFERENCES boutique.equipe(id_equipe)
);