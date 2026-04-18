DROP TABLE IF EXISTS paiement CASCADE;
DROP TABLE IF EXISTS inscription CASCADE;
DROP TABLE IF EXISTS cours CASCADE;
DROP TABLE IF EXISTS abonnement CASCADE;
DROP TABLE IF EXISTS membre CASCADE;
DROP TABLE IF EXISTS salle CASCADE;
DROP TABLE IF EXISTS coach CASCADE;
DROP TABLE IF EXISTS type_abonnement CASCADE;

CREATE TABLE type_abonnement (
    id_type_abonnement SERIAL PRIMARY KEY,
    nom_type VARCHAR(50) NOT NULL UNIQUE,
    duree_mois INT NOT NULL CHECK (duree_mois > 0),
    prix NUMERIC(10,2) NOT NULL CHECK (prix >= 0)
);

CREATE TABLE coach (
    id_coach SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    specialite VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE salle (
    id_salle SERIAL PRIMARY KEY,
    nom_salle VARCHAR(50) NOT NULL UNIQUE,
    capacite INT NOT NULL CHECK (capacite > 0)
);

CREATE TABLE membre (
    id_membre SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telephone VARCHAR(20),
    date_inscription DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE abonnement (
    id_abonnement SERIAL PRIMARY KEY,
    id_membre INT NOT NULL,
    id_type_abonnement INT NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('actif', 'expiré', 'suspendu')),
    CONSTRAINT fk_abonnement_membre
        FOREIGN KEY (id_membre) REFERENCES membre(id_membre)
        ON DELETE CASCADE,
    CONSTRAINT fk_abonnement_type
        FOREIGN KEY (id_type_abonnement) REFERENCES type_abonnement(id_type_abonnement)
        ON DELETE RESTRICT,
    CONSTRAINT chk_dates_abonnement
        CHECK (date_fin >= date_debut)
);

CREATE TABLE cours (
    id_cours SERIAL PRIMARY KEY,
    nom_cours VARCHAR(100) NOT NULL,
    description TEXT,
    horaire TIMESTAMP NOT NULL,
    capacite_max INT NOT NULL CHECK (capacite_max > 0),
    id_coach INT NOT NULL,
    id_salle INT NOT NULL,
    CONSTRAINT fk_cours_coach
        FOREIGN KEY (id_coach) REFERENCES coach(id_coach)
        ON DELETE RESTRICT,
    CONSTRAINT fk_cours_salle
        FOREIGN KEY (id_salle) REFERENCES salle(id_salle)
        ON DELETE RESTRICT
);

CREATE TABLE inscription (
    id_inscription SERIAL PRIMARY KEY,
    id_membre INT NOT NULL,
    id_cours INT NOT NULL,
    date_inscription DATE NOT NULL DEFAULT CURRENT_DATE,
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('confirmée', 'annulée', 'en attente')),
    CONSTRAINT fk_inscription_membre
        FOREIGN KEY (id_membre) REFERENCES membre(id_membre)
        ON DELETE CASCADE,
    CONSTRAINT fk_inscription_cours
        FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
        ON DELETE CASCADE,
    CONSTRAINT uq_membre_cours UNIQUE (id_membre, id_cours)
);

CREATE TABLE paiement (
    id_paiement SERIAL PRIMARY KEY,
    id_membre INT NOT NULL,
    id_abonnement INT,
    montant NUMERIC(10,2) NOT NULL CHECK (montant >= 0),
    date_paiement DATE NOT NULL DEFAULT CURRENT_DATE,
    mode_paiement VARCHAR(20) NOT NULL CHECK (mode_paiement IN ('cash', 'carte', 'virement')),
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('payé', 'en attente', 'échoué')),
    CONSTRAINT fk_paiement_membre
        FOREIGN KEY (id_membre) REFERENCES membre(id_membre)
        ON DELETE CASCADE,
    CONSTRAINT fk_paiement_abonnement
        FOREIGN KEY (id_abonnement) REFERENCES abonnement(id_abonnement)
        ON DELETE SET NULL
);
