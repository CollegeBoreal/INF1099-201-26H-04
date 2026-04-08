-- Création des tables
DROP TABLE IF EXISTS inscriptions CASCADE;
DROP TABLE IF EXISTS etudiants CASCADE;
DROP TABLE IF EXISTS cours CASCADE;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    date_naissance DATE
);

CREATE TABLE cours (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    titre VARCHAR(200) NOT NULL,
    credits INT CHECK (credits > 0)
);

CREATE TABLE inscriptions (
    id SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id) ON DELETE CASCADE,
    cours_id INT REFERENCES cours(id) ON DELETE CASCADE,
    date_inscription DATE DEFAULT CURRENT_DATE,
    UNIQUE(etudiant_id, cours_id)
);
