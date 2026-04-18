-- ============================================================
-- 01-ddl.sql
-- Data Definition Language
-- TP PostgreSQL — Stored Procedures
-- #300150205
-- ============================================================

CREATE TABLE etudiants (
    id             SERIAL PRIMARY KEY,
    nom            TEXT NOT NULL,
    age            INT,
    email          TEXT UNIQUE,
    date_creation  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cours (
    id        SERIAL PRIMARY KEY,
    nom       TEXT NOT NULL UNIQUE,
    credits   INT DEFAULT 3
);

CREATE TABLE inscriptions (
    id           SERIAL PRIMARY KEY,
    etudiant_id  INT NOT NULL REFERENCES etudiants(id),
    cours_id     INT NOT NULL REFERENCES cours(id),
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (etudiant_id, cours_id)
);

CREATE TABLE logs (
    id          SERIAL PRIMARY KEY,
    action      TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
