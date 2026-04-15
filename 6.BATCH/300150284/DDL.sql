DROP TABLE IF EXISTS etudiants;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    age INT,
    programme VARCHAR(100)
);
