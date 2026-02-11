-- Création de la base et du schéma
CREATE DATABASE cours;
\c cours
CREATE SCHEMA tp_dcl;

-- Création de la table etudiants
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);

-- Insertion de données de test
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Karim', 75);
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Sarah', 88);

-- Création des utilisateurs
CREATE USER etudiant WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';

-- Attribution des droits
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;

-- Droits sur la table
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;

-- Droits sur la séquence SERIAL
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;

-- Retirer un droit
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;

-- Suppression des utilisateurs (superuser requis)
DROP USER etudiant;
DROP USER professeur;

-- Bonus : création d’un rôle enseignant et utilisateur prof2
CREATE ROLE enseignant;
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO enseignant;
CREATE USER prof2 WITH PASSWORD 'prof2';
GRANT enseignant TO prof2;

-- Correction permissions pour prof2
GRANT USAGE ON SCHEMA tp_dcl TO enseignant;
GRANT USAGE, SELECT ON SEQUENCE tp_dcl.etudiants_id_seq TO enseignant;
