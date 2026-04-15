
-- Création de la base
CREATE DATABASE ecole;

-- Connexion à la base ecole (TRÈS IMPORTANT)
\c ecole

CREATE SCHEMA tp_dcl;

CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);

-- Création
CREATE USER etudiant_test WITH PASSWORD 'etudiant123';
CREATE USER prof_test WITH PASSWORD 'prof123';

-- Droits de connexion
GRANT CONNECT ON DATABASE ecole TO etudiant_test, prof_test;
GRANT USAGE ON SCHEMA tp_dcl TO etudiant_test, prof_test;

-- Droits sur la table
GRANT SELECT ON tp_dcl.etudiants TO etudiant_test; -- Lecture seule
GRANT ALL PRIVILEGES ON tp_dcl.etudiants TO prof_test; -- Tout faire

-- Mon projet-----------
CREATE SCHEMA eduhome;

CREATE TABLE eduhome.enfant (
    id_enfant SERIAL PRIMARY KEY,
    nom TEXT,
    id_parent INTEGER REFERENCES eduhome.parent(id_parent)
);

CREATE TABLE eduhome.note (
    id_note SERIAL PRIMARY KEY,
    valeur NUMERIC,
    commentaire TEXT,
    id_enfant INTEGER REFERENCES eduhome.enfant(id_enfant)
);

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA eduhome TO prof_test;
GRANT SELECT ON eduhome.note TO etudiant_test;