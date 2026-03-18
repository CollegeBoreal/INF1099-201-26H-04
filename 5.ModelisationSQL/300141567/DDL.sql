CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    email TEXT UNIQUE,
    telephone TEXT
);

CREATE TABLE categorie (
    id_categorie SERIAL PRIMARY KEY,
    libelle TEXT
);

CREATE TABLE equipe (
    id_equipe SERIAL PRIMARY KEY,
    nom_equipe TEXT
);

CREATE TABLE technicien (
    id_technicien SERIAL PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    email TEXT,
    id_equipe INT REFERENCES equipe(id_equipe)
);

CREATE TABLE ticket (
    id_ticket SERIAL PRIMARY KEY,
    titre TEXT,
    description TEXT,
    date_creation DATE,
    id_utilisateur INT REFERENCES utilisateur(id_utilisateur),
    id_categorie INT REFERENCES categorie(id_categorie),
    id_technicien INT REFERENCES technicien(id_technicien)
);

CREATE TABLE intervention (
    id_intervention SERIAL PRIMARY KEY,
    date_intervention DATE,
    commentaire TEXT,
    id_ticket INT REFERENCES ticket(id_ticket),
    id_technicien INT REFERENCES technicien(id_technicien)
);