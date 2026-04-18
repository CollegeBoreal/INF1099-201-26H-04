-- TP DCL - DjaberBenyezza - 300146667

-- Etape 1
CREATE DATABASE cours;
\c cours
CREATE SCHEMA tp_dcl;

-- Etape 2
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);

-- Etape 3
CREATE USER etudiant WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';

-- Etape 4
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;

-- Etape 5
\c cours etudiant
SELECT * FROM tp_dcl.etudiants;
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 85);

-- Etape 6
\c cours professeur
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Khaled', 90);
UPDATE tp_dcl.etudiants SET moyenne=95 WHERE nom='Khaled';
SELECT * FROM tp_dcl.etudiants;

-- Etape 7
\c cours postgres
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
\c cours etudiant
SELECT * FROM tp_dcl.etudiants;

-- Etape 8
\c cours postgres
DROP USER etudiant;
DROP USER professeur;
