-- Tables principales
CREATE TABLE IF NOT EXISTS etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT,
    email TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cours (
    id SERIAL PRIMARY KEY,
    nom TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS inscriptions (
    id SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id),
    cours_id INT REFERENCES cours(id),
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
