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

-- Procédure : ajouter un étudiant avec validation
CREATE OR REPLACE PROCEDURE ajouter_etudiant(
    p_nom  TEXT,
    p_age  INT,
    p_email TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation de l'âge minimum
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Âge invalide : % (minimum 18 ans)', p_age;
    END IF;

    -- Insertion de l'étudiant
    INSERT INTO etudiants (nom, age, email)
    VALUES (p_nom, p_age, p_email);

    -- Log de l'action
    INSERT INTO logs (action)
    VALUES ('Ajout étudiant : ' || p_nom);
END;
$$;
