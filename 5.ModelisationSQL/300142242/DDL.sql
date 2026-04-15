-- ============================================================
--  DDL.sql — Définition des données (Data Definition Language)
--  Projet  : Gestion Scolaire (Moodle)
--  SGBD    : PostgreSQL
--  Auteur  : [Ton Nom/ID 300142242]
-- ============================================================

-- Suppression des tables si elles existent déjà (ordre inverse des clés étrangères)
DROP TABLE IF EXISTS DETAIL_INSCRIPTION CASCADE;
DROP TABLE IF EXISTS INSCRIPTION CASCADE;
DROP TABLE IF EXISTS COURS CASCADE;
DROP TABLE IF EXISTS STATUT CASCADE;
DROP TABLE IF EXISTS SESSION_SCOLAIRE CASCADE;
DROP TABLE IF EXISTS ETUDIANT CASCADE;
DROP TABLE IF EXISTS PROFESSEUR CASCADE;
DROP TABLE IF EXISTS DEPARTEMENT CASCADE;

-- ------------------------------------------------------------
--  Tables de Référence
-- ------------------------------------------------------------
CREATE TABLE DEPARTEMENT (
    id_departement  SERIAL PRIMARY KEY,
    nom_departement VARCHAR(255) NOT NULL
);

CREATE TABLE STATUT (
    id_statut SERIAL PRIMARY KEY,
    libelle   VARCHAR(50) NOT NULL
);

CREATE TABLE SESSION_SCOLAIRE (
    id_session  SERIAL PRIMARY KEY,
    nom_session VARCHAR(50) NOT NULL,
    date_debut  DATE NOT NULL,
    date_fin    DATE NOT NULL
);

-- ------------------------------------------------------------
--  Entités Principales
-- ------------------------------------------------------------
CREATE TABLE PROFESSEUR (
    id_professeur  SERIAL PRIMARY KEY,
    nom            VARCHAR(100) NOT NULL,
    prenom         VARCHAR(100) NOT NULL,
    email          VARCHAR(255) UNIQUE NOT NULL,
    id_departement INTEGER REFERENCES DEPARTEMENT(id_departement)
);

CREATE TABLE ETUDIANT (
    id_etudiant SERIAL PRIMARY KEY,
    nom         VARCHAR(100) NOT NULL,
    prenom      VARCHAR(100) NOT NULL,
    email       VARCHAR(255) UNIQUE NOT NULL,
    telephone   VARCHAR(20)
);

CREATE TABLE COURS (
    id_cours      SERIAL PRIMARY KEY,
    titre         VARCHAR(255) NOT NULL,
    description   TEXT,
    credits       INTEGER NOT NULL CHECK (credits > 0),
    id_professeur INTEGER REFERENCES PROFESSEUR(id_professeur)
);

-- ------------------------------------------------------------
--  Tables de Jonction (Relations)
-- ------------------------------------------------------------
CREATE TABLE INSCRIPTION (
    id_inscription   SERIAL PRIMARY KEY,
    date_inscription DATE NOT NULL,
    id_etudiant      INTEGER NOT NULL REFERENCES ETUDIANT(id_etudiant),
    id_session       INTEGER NOT NULL REFERENCES SESSION_SCOLAIRE(id_session),
    id_statut        INTEGER NOT NULL REFERENCES STATUT(id_statut)
);

CREATE TABLE DETAIL_INSCRIPTION (
    id_detail      SERIAL PRIMARY KEY,
    id_inscription INTEGER NOT NULL REFERENCES INSCRIPTION(id_inscription),
    id_cours       INTEGER NOT NULL REFERENCES COURS(id_cours),
    note_finale    NUMERIC(5,2) CHECK (note_finale >= 0 AND note_finale <= 100)
);

-- ------------------------------------------------------------
--  Index pour optimisation des performances
-- ------------------------------------------------------------
CREATE INDEX idx_etudiant_nom      ON ETUDIANT(nom);
CREATE INDEX idx_cours_titre       ON COURS(titre);
CREATE INDEX idx_fk_prof_dept      ON PROFESSEUR(id_departement);
CREATE INDEX idx_fk_cours_prof     ON COURS(id_professeur);
CREATE INDEX idx_insc_etudiant     ON INSCRIPTION(id_etudiant);
CREATE INDEX idx_detail_insc_cours ON DETAIL_INSCRIPTION(id_cours);