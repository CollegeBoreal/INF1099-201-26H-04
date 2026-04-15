-- Initialisation du schéma de test DCL
CREATE SCHEMA tp_dcl;

CREATE TABLE tp_dcl.notes_examen (
    id SERIAL PRIMARY KEY,
    nom_etudiant TEXT,
    resultat NUMERIC
);

-- Création des utilisateurs
CREATE USER etudiant_moodle WITH PASSWORD 'eleve123';
CREATE USER prof_moodle WITH PASSWORD 'prof123';

-- Gestion des droits (DCL)
GRANT CONNECT ON DATABASE moodle_db TO etudiant_moodle, prof_moodle;
GRANT USAGE ON SCHEMA tp_dcl TO etudiant_moodle, prof_moodle;

-- Permissions spécifiques
GRANT SELECT ON tp_dcl.notes_examen TO etudiant_moodle;
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.notes_examen TO prof_moodle;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.notes_examen_id_seq TO prof_moodle;