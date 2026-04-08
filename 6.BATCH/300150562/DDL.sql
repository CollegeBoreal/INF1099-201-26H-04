DROP TABLE IF EXISTS LIVRAISON, PAIEMENT, LIGNE_COMMANDE, COMMANDE, MAILLOT, CATEGORIE_MAILLOT, ADRESSE, CLIENT, LIVREUR CASCADE;
-- Table CLIENT
CREATE TABLE CLIENT (
    ID_Client SERIAL PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Prénom VARCHAR(100) NOT NULL,
    PostNom VARCHAR(100),
    Téléphone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    Mot_de_passe VARCHAR(100) NOT NULL
);

-- Table ADRESSE
CREATE TABLE ADRESSE (
    ID_Adresse SERIAL PRIMARY KEY,
    ID_Client INT REFERENCES CLIENT(ID_Client) ON DELETE CASCADE,
    Numéro_rue INT,
    Rue VARCHAR(150),
    Ville VARCHAR(100),
    Province VARCHAR(100),
    Pays VARCHAR(100),
    Code_postal VARCHAR(20),
    Type_adresse VARCHAR(50)
);

-- Table CATEGORIE_MAILLOT
CREATE TABLE CATEGORIE_MAILLOT (
    ID_Categorie SERIAL PRIMARY KEY,
    Nom_catégorie VARCHAR(100) NOT NULL,
    Description TEXT
);

-- Table MAILLOT
CREATE TABLE MAILLOT (
    ID_Maillot SERIAL PRIMARY KEY,
    ID_Categorie INT REFERENCES CATEGORIE_MAILLOT(ID_Categorie) ON DELETE SET NULL,
    ID_Pays_origine INT, -- à relier à une table PAYS si nécessaire
    Nom_maillot VARCHAR(100) NOT NULL,
    Description TEXT,
    Prix DECIMAL(10,2) NOT NULL,
    Statut VARCHAR(50),
    Taille VARCHAR(10),
    Couleur VARCHAR(50),
    Marque VARCHAR(50),
    Saison VARCHAR(20)
);

-- Table COMMANDE
CREATE TABLE COMMANDE (
    ID_Commande SERIAL PRIMARY KEY,
    ID_Client INT REFERENCES CLIENT(ID_Client) ON DELETE CASCADE,
    ID_Adresse_livraison INT REFERENCES ADRESSE(ID_Adresse),
    Date_commande DATE,
    Statut_commande VARCHAR(50),
    Total_commande DECIMAL(10,2)
);

-- Table LIGNE_COMMANDE
CREATE TABLE LIGNE_COMMANDE (
    ID_Ligne SERIAL PRIMARY KEY,
    ID_Commande INT REFERENCES COMMANDE(ID_Commande) ON DELETE CASCADE,
    ID_Maillot INT REFERENCES MAILLOT(ID_Maillot),
    Quantité INT NOT NULL,
    Prix_unitaire DECIMAL(10,2) NOT NULL,
    Total_ligne DECIMAL(10,2) NOT NULL
);

-- Table PAIEMENT
CREATE TABLE PAIEMENT (
    ID_Paiement SERIAL PRIMARY KEY,
    ID_Commande INT REFERENCES COMMANDE(ID_Commande) ON DELETE CASCADE,
    Date_paiement DATE,
    Montant DECIMAL(10,2),
    Mode_paiement VARCHAR(50),
    Statut_paiement VARCHAR(50),
    Référence_paiement VARCHAR(100)
);

-- Table LIVREUR
CREATE TABLE LIVREUR (
    ID_Livreur SERIAL PRIMARY KEY,
    Nom VARCHAR(100),
    Prénom VARCHAR(100),
    PostNom VARCHAR(100),
    Téléphone VARCHAR(20),
    Email VARCHAR(100),
    Statut_livreur VARCHAR(50)
);

-- Table LIVRAISON
CREATE TABLE LIVRAISON (
    ID_Livraison SERIAL PRIMARY KEY,
    ID_Commande INT REFERENCES COMMANDE(ID_Commande) ON DELETE CASCADE,
    ID_Livreur INT REFERENCES LIVREUR(ID_Livreur),
    Date_livraison DATE,
    Statut_livraison VARCHAR(50),
    Frais_livraison DECIMAL(10,2),
    Date_expédition DATE,
    Numéro_suivi VARCHAR(100)
);