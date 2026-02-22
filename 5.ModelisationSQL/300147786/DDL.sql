-- Suppression des tables (ordre inverse des dépendances)
DROP TABLE IF EXISTS message CASCADE;
DROP TABLE IF EXISTS match CASCADE;
DROP TABLE IF EXISTS preference CASCADE;
DROP TABLE IF EXISTS annonce CASCADE;
DROP TABLE IF EXISTS profil CASCADE;
DROP TABLE IF EXISTS utilisateur CASCADE;

-- =========================
-- Table UTILISATEUR
-- =========================
CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    telephone VARCHAR(20),
    date_inscription DATE DEFAULT CURRENT_DATE
);

-- =========================
-- Table PROFIL
-- =========================
CREATE TABLE profil (
    id_profil SERIAL PRIMARY KEY,
    description TEXT,
    age INT CHECK (age > 0),
    genre VARCHAR(50),
    ville VARCHAR(100),
    budget_max NUMERIC(10,2),
    date_disponibilite DATE,
    id_utilisateur INT UNIQUE,
    CONSTRAINT fk_profil_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur(id_utilisateur)
        ON DELETE CASCADE
);

-- =========================
-- Table ANNONCE
-- =========================
CREATE TABLE annonce (
    id_annonce SERIAL PRIMARY KEY,
    type_annonce VARCHAR(50),
    ville VARCHAR(100),
    loyer NUMERIC(10,2),
    date_disponibilite DATE,
    description TEXT,
    statut VARCHAR(50),
    id_utilisateur INT,
    CONSTRAINT fk_annonce_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur(id_utilisateur)
        ON DELETE CASCADE
);

-- =========================
-- Table PREFERENCE
-- =========================
CREATE TABLE preference (
    id_preference SERIAL PRIMARY KEY,
    budget_min NUMERIC(10,2),
    budget_max NUMERIC(10,2),
    ville_souhaitee VARCHAR(100),
    age_min INT,
    age_max INT,
    fumeur_accepte BOOLEAN,
    animaux_acceptes BOOLEAN,
    id_utilisateur INT UNIQUE,
    CONSTRAINT fk_preference_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur(id_utilisateur)
        ON DELETE CASCADE
);

-- =========================
-- Table MATCH
-- =========================
CREATE TABLE match (
    id_match SERIAL PRIMARY KEY,
    date_match DATE DEFAULT CURRENT_DATE,
    statut VARCHAR(50),
    id_utilisateur_1 INT,
    id_utilisateur_2 INT,
    CONSTRAINT fk_match_user1
        FOREIGN KEY (id_utilisateur_1)
        REFERENCES utilisateur(id_utilisateur)
        ON DELETE CASCADE,
    CONSTRAINT fk_match_user2
        FOREIGN KEY (id_utilisateur_2)
        REFERENCES utilisateur(id_utilisateur)
        ON DELETE CASCADE
);

-- =========================
-- Table MESSAGE
-- =========================
CREATE TABLE message (
    id_message SERIAL PRIMARY KEY,
    contenu TEXT NOT NULL,
    date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_match INT,
    id_expediteur INT,
    CONSTRAINT fk_message_match
        FOREIGN KEY (id_match)
        REFERENCES match(id_match)
        ON DELETE CASCADE,
    CONSTRAINT fk_message_expediteur
        FOREIGN KEY (id_expediteur)
        REFERENCES utilisateur(id_utilisateur)
        ON DELETE CASCADE
);

