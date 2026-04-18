-- =========================================
-- DDL.sql
-- Création de la structure de la base
-- =========================================

CREATE SCHEMA IF NOT EXISTS tp_sql;

CREATE TABLE IF NOT EXISTS tp_sql.etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    programme VARCHAR(100) NOT NULL,
    note_finale NUMERIC(5,2) CHECK (note_finale >= 0 AND note_finale <= 100)
);
