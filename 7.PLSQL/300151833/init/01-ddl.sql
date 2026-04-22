CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT,
    email TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cours (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL UNIQUE
);

CREATE TABLE inscriptions (
    id SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id),
    cours_id INT REFERENCES cours(id),
    UNIQUE(etudiant_id, cours_id)
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
