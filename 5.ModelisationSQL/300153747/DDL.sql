CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    telephone VARCHAR(20),
    email VARCHAR(100),
    mot_de_passe VARCHAR(100),
    type_utilisateur VARCHAR(30)
);

CREATE TABLE vendeur (
    id_vendeur SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE acheteur (
    id_acheteur SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE transporteur (
    id_transporteur SERIAL PRIMARY KEY,
    nom_transporteur VARCHAR(100),
    telephone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE pays (
    id_pays SERIAL PRIMARY KEY,
    nom_pays VARCHAR(100)
);

CREATE TABLE port (
    id_port SERIAL PRIMARY KEY,
    nom_port VARCHAR(100),
    id_pays INT REFERENCES pays(id_pays)
);

CREATE TABLE vehicule (
    id_vehicule SERIAL PRIMARY KEY,
    marque VARCHAR(50),
    modele VARCHAR(50),
    annee INT,
    kilometrage INT,
    etat VARCHAR(50),
    statut VARCHAR(50),
    id_vendeur INT REFERENCES vendeur(id_vendeur)
);

CREATE TABLE transit (
    id_transit SERIAL PRIMARY KEY,
    date_demande DATE,
    date_depart DATE,
    date_arrivee_estimee DATE,
    statut_transit VARCHAR(50),
    cout_transport NUMERIC(10,2),
    id_vehicule INT REFERENCES vehicule(id_vehicule),
    id_acheteur INT REFERENCES acheteur(id_acheteur),
    id_port_depart INT REFERENCES port(id_port),
    id_port_arrivee INT REFERENCES port(id_port),
    id_transporteur INT REFERENCES transporteur(id_transporteur)
);

CREATE TABLE document (
    id_document SERIAL PRIMARY KEY,
    type_document VARCHAR(50),
    date_document DATE,
    chemin_fichier VARCHAR(255),
    id_transit INT REFERENCES transit(id_transit)
);

CREATE TABLE paiement (
    id_paiement SERIAL PRIMARY KEY,
    date_paiement DATE,
    montant NUMERIC(10,2),
    mode_paiement VARCHAR(50),
    statut_paiement VARCHAR(50),
    reference_paiement VARCHAR(100),
    id_transit INT REFERENCES transit(id_transit)
);
