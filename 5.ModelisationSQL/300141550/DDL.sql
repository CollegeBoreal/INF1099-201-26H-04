CREATE TABLE CLIENT (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    post_nom VARCHAR(50),
    telephone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    date_creation DATE
);

CREATE TABLE ADRESSE (
    id_adresse SERIAL PRIMARY KEY,
    id_client INT,
    numero_rue VARCHAR(10),
    rue VARCHAR(100),
    ville VARCHAR(50),
    province VARCHAR(50),
    pays VARCHAR(50),
    code_postal VARCHAR(10),
    FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);

CREATE TABLE CATEGORIE (
    id_categorie SERIAL PRIMARY KEY,
    nom_categorie VARCHAR(50) UNIQUE
);

CREATE TABLE PAYS_ORIGINE (
    id_pays SERIAL PRIMARY KEY,
    nom_pays VARCHAR(50) UNIQUE
);

CREATE TABLE PLAT (
    id_plat SERIAL PRIMARY KEY,
    id_categorie INT,
    id_pays INT,
    nom_plat VARCHAR(100),
    description TEXT,
    prix DECIMAL(10,2),
    statut VARCHAR(20),
    FOREIGN KEY (id_categorie) REFERENCES CATEGORIE(id_categorie),
    FOREIGN KEY (id_pays) REFERENCES PAYS_ORIGINE(id_pays)
);

CREATE TABLE COMMANDE (
    id_commande SERIAL PRIMARY KEY,
    id_client INT,
    id_adresse INT,
    date_commande DATE,
    statut_commande VARCHAR(20),
    total_commande DECIMAL(10,2),
    FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
    FOREIGN KEY (id_adresse) REFERENCES ADRESSE(id_adresse)
);

CREATE TABLE LIGNE_COMMANDE (
    id_commande INT,
    id_plat INT,
    quantite INT,
    prix_unitaire DECIMAL(10,2),
    PRIMARY KEY (id_commande, id_plat),
    FOREIGN KEY (id_commande) REFERENCES COMMANDE(id_commande),
    FOREIGN KEY (id_plat) REFERENCES PLAT(id_plat)
);

CREATE TABLE PAIEMENT (
    id_paiement SERIAL PRIMARY KEY,
    id_commande INT UNIQUE,
    date_paiement DATE,
    montant DECIMAL(10,2),
    mode_paiement VARCHAR(50),
    statut_paiement VARCHAR(20),
    FOREIGN KEY (id_commande) REFERENCES COMMANDE(id_commande)
);

CREATE TABLE LIVREUR (
    id_livreur SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    post_nom VARCHAR(50),
    telephone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE LIVRAISON (
    id_livraison SERIAL PRIMARY KEY,
    id_commande INT UNIQUE,
    id_livreur INT,
    date_livraison DATE,
    statut_livraison VARCHAR(20),
    frais_livraison DECIMAL(10,2),
    FOREIGN KEY (id_commande) REFERENCES COMMANDE(id_commande),
    FOREIGN KEY (id_livreur) REFERENCES LIVREUR(id_livreur)
);
