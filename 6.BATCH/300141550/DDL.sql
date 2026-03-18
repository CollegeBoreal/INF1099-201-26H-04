-- Suppression si existe (évite les erreurs)
DROP TABLE IF EXISTS LIGNE_COMMANDE, PAIEMENT, LIVRAISON, COMMANDE, ADRESSE, CLIENT, PLAT, CATEGORIE, PAYS_ORIGINE, LIVREUR CASCADE;

-- CLIENT
CREATE TABLE CLIENT (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    post_nom VARCHAR(50),
    telephone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    date_creation DATE
);

-- ADRESSE
CREATE TABLE ADRESSE (
    id_adresse SERIAL PRIMARY KEY,
    id_client INT REFERENCES CLIENT(id_client),
    numero_rue INT,
    rue VARCHAR(100),
    ville VARCHAR(50),
    province VARCHAR(50),
    pays VARCHAR(50),
    code_postal VARCHAR(10)
);

-- COMMANDE
CREATE TABLE COMMANDE (
    id_commande SERIAL PRIMARY KEY,
    id_client INT REFERENCES CLIENT(id_client),
    id_adresse INT REFERENCES ADRESSE(id_adresse),
    date_commande DATE,
    statut_commande VARCHAR(50),
    total_commande FLOAT
);

-- CATEGORIE
CREATE TABLE CATEGORIE (
    id_categorie SERIAL PRIMARY KEY,
    nom_categorie VARCHAR(50)
);

-- PAYS_ORIGINE
CREATE TABLE PAYS_ORIGINE (
    id_pays SERIAL PRIMARY KEY,
    nom_pays VARCHAR(50)
);

-- PLAT
CREATE TABLE PLAT (
    id_plat SERIAL PRIMARY KEY,
    id_categorie INT REFERENCES CATEGORIE(id_categorie),
    id_pays INT REFERENCES PAYS_ORIGINE(id_pays),
    nom_plat VARCHAR(100),
    description TEXT,
    prix FLOAT,
    statut VARCHAR(50)
);

-- LIGNE_COMMANDE
CREATE TABLE LIGNE_COMMANDE (
    id_commande INT REFERENCES COMMANDE(id_commande),
    id_plat INT REFERENCES PLAT(id_plat),
    quantite INT,
    prix_unitaire FLOAT,
    PRIMARY KEY (id_commande, id_plat)
);

-- PAIEMENT
CREATE TABLE PAIEMENT (
    id_paiement SERIAL PRIMARY KEY,
    id_commande INT REFERENCES COMMANDE(id_commande),
    date_paiement DATE,
    montant FLOAT,
    mode_paiement VARCHAR(50),
    statut_paiement VARCHAR(50)
);

-- LIVREUR
CREATE TABLE LIVREUR (
    id_livreur SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    post_nom VARCHAR(50),
    telephone VARCHAR(20),
    email VARCHAR(100)
);

-- LIVRAISON
CREATE TABLE LIVRAISON (
    id_livraison SERIAL PRIMARY KEY,
    id_commande INT REFERENCES COMMANDE(id_commande),
    id_livreur INT REFERENCES LIVREUR(id_livreur),
    date_livraison DATE,
    statut_livraison VARCHAR(50),
    frais_livraison FLOAT
);
