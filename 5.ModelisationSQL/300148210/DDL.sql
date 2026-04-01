CREATE TABLE ADRESSE (
    id_adresse SERIAL PRIMARY KEY,
    rue VARCHAR(100),
    ville VARCHAR(50),
    province VARCHAR(50),
    code_postal VARCHAR(10),
    pays VARCHAR(50)
);

CREATE TABLE CLIENT (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    telephone VARCHAR(20),
    email VARCHAR(150),
    id_adresse INT REFERENCES ADRESSE(id_adresse)
);

CREATE TABLE LABORATOIRE (
    id_laboratoire SERIAL PRIMARY KEY,
    nom_labo VARCHAR(150),
    telephone VARCHAR(20),
    email VARCHAR(150),
    id_adresse INT REFERENCES ADRESSE(id_adresse)
);

CREATE TABLE ANALYSTE (
    id_analyste SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    specialite VARCHAR(100),
    email VARCHAR(150),
    id_laboratoire INT REFERENCES LABORATOIRE(id_laboratoire)
);

CREATE TABLE PRODUIT_ALIMENTAIRE (
    id_produit SERIAL PRIMARY KEY,
    nom_produit VARCHAR(150),
    categorie VARCHAR(100),
    marque VARCHAR(100)
);

CREATE TABLE LOT (
    id_lot SERIAL PRIMARY KEY,
    code_lot VARCHAR(100),
    date_fabrication DATE,
    date_expiration DATE,
    id_produit INT REFERENCES PRODUIT_ALIMENTAIRE(id_produit)
);

CREATE TABLE ECHANTILLON (
    id_echantillon SERIAL PRIMARY KEY,
    code_echantillon VARCHAR(100),
    date_prelevement DATE,
    quantite INT,
    id_lot INT REFERENCES LOT(id_lot)
);

CREATE TABLE TYPE_ANALYSE (
    id_type_analyse SERIAL PRIMARY KEY,
    nom_analyse VARCHAR(150),
    methode VARCHAR(150),
    duree INT
);

CREATE TABLE ANALYSE_LAB (
    id_analyse SERIAL PRIMARY KEY,
    date_analyse DATE,
    statut_analyse VARCHAR(50),
    id_client INT REFERENCES CLIENT(id_client),
    id_echantillon INT REFERENCES ECHANTILLON(id_echantillon),
    id_type_analyse INT REFERENCES TYPE_ANALYSE(id_type_analyse),
    id_analyste INT REFERENCES ANALYSTE(id_analyste)
);

CREATE TABLE RESULTAT_ANALYSE (
    id_resultat SERIAL PRIMARY KEY,
    valeur_mesuree DECIMAL(10,2),
    unite VARCHAR(50),
    commentaire TEXT,
    id_analyse INT REFERENCES ANALYSE_LAB(id_analyse)
);

CREATE TABLE NORME (
    id_norme SERIAL PRIMARY KEY,
    code_norme VARCHAR(100),
    description TEXT,
    seuil_min DECIMAL(10,2),
    seuil_max DECIMAL(10,2)
);

CREATE TABLE CONFORMITE (
    id_conformite SERIAL PRIMARY KEY,
    statut_conformite VARCHAR(50),
    observation TEXT,
    id_resultat INT REFERENCES RESULTAT_ANALYSE(id_resultat),
    id_norme INT REFERENCES NORME(id_norme)
);

CREATE TABLE RAPPORT (
    id_rapport SERIAL PRIMARY KEY,
    date_rapport DATE,
    conclusion TEXT,
    id_analyse INT UNIQUE REFERENCES ANALYSE_LAB(id_analyse)
);

CREATE TABLE FACTURE (
    id_facture SERIAL PRIMARY KEY,
    num_facture VARCHAR(100),
    date_facture DATE,
    montant DECIMAL(10,2),
    id_client INT REFERENCES CLIENT(id_client)
);

CREATE TABLE PAIEMENT (
    id_paiement SERIAL PRIMARY KEY,
    mode_paiement VARCHAR(50),
    date_paiement DATE,
    statut VARCHAR(50),
    id_facture INT REFERENCES FACTURE(id_facture)
);
