-- DDL.sql : Création de la structure de la base de données

CREATE TABLE IF NOT EXISTS etudiants (
    id   SERIAL PRIMARY KEY,
    nom  VARCHAR(100) NOT NULL,
    age  INT
);
