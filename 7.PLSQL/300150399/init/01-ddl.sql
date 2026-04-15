DROP TABLE IF EXISTS inscriptions CASCADE;
DROP TABLE IF EXISTS logs CASCADE;
DROP TABLE IF EXISTS cours CASCADE;
DROP TABLE IF EXISTS etudiants CASCADE;

CREATE TABLE etudiants (
    id_etudiant SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE cours (
    id_cours SERIAL PRIMARY KEY,
    nom_cours VARCHAR(150) NOT NULL UNIQUE,
    credits INT NOT NULL
);

CREATE TABLE inscriptions (
    id_inscription SERIAL PRIMARY KEY,
    id_etudiant INT NOT NULL,
    id_cours INT NOT NULL,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_inscription_etudiant
        FOREIGN KEY (id_etudiant) REFERENCES etudiants(id_etudiant)
        ON DELETE CASCADE,
    CONSTRAINT fk_inscription_cours
        FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
        ON DELETE CASCADE,
    CONSTRAINT uq_inscription UNIQUE (id_etudiant, id_cours)
);

CREATE TABLE logs (
    id_log SERIAL PRIMARY KEY,
    table_concernee VARCHAR(50) NOT NULL,
    operation VARCHAR(20) NOT NULL,
    ancienne_valeur TEXT,
    nouvelle_valeur TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);