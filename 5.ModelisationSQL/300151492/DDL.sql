-- ============================================================
-- DDL.sql — Data Definition Language
-- Création de la base de données et des tables
-- TP Modélisation SQL — Gestion des Participations à des Événements
-- ============================================================

-- Création de la base de données
CREATE DATABASE participation_db;

-- Se connecter à la base
\c participation_db;

-- ============================================================
-- TABLE : Personne
-- ============================================================
CREATE TABLE Personne (
    id_personne SERIAL       PRIMARY KEY,
    nom         TEXT         NOT NULL,
    prenom      TEXT         NOT NULL,
    email       TEXT         NOT NULL UNIQUE
);

-- ============================================================
-- TABLE : Evenement
-- ============================================================
CREATE TABLE Evenement (
    id_evenement SERIAL  PRIMARY KEY,
    titre        TEXT    NOT NULL,
    date_debut   DATE    NOT NULL
);

-- ============================================================
-- TABLE : Participation (table de liaison)
-- ============================================================
CREATE TABLE Participation (
    id_participation     SERIAL  PRIMARY KEY,
    id_personne          INT     NOT NULL REFERENCES Personne(id_personne)  ON DELETE CASCADE,
    id_evenement         INT     NOT NULL REFERENCES Evenement(id_evenement) ON DELETE CASCADE,
    statut_participation TEXT    NOT NULL
                                 CHECK (statut_participation IN ('présent', 'absent', 'inscrit')),
    note                 NUMERIC CHECK (note >= 0 AND note <= 20)
);

-- ============================================================
-- INDEX — Optimisation des performances
-- ============================================================

-- Accélérer les recherches par personne dans Participation
CREATE INDEX idx_participation_personne
    ON Participation(id_personne);

-- Accélérer les jointures entre Participation et Evenement
CREATE INDEX idx_participation_evenement
    ON Participation(id_evenement);

-- Accélérer les recherches par date dans Evenement
CREATE INDEX idx_evenement_date
    ON Evenement(date_debut);

-- Accélérer les recherches par email dans Personne
CREATE INDEX idx_personne_email
    ON Personne(email);

-- Index composite : optimise les requêtes filtrant sur personne ET événement
CREATE INDEX idx_participation_personne_evenement
    ON Participation(id_personne, id_evenement);

-- ============================================================
-- VUE : vue_recap_participation
-- ============================================================
CREATE VIEW vue_recap_participation AS
SELECT
    e.titre                                                               AS evenement,
    COUNT(pa.id_participation)                                            AS total_inscrits,
    SUM(CASE WHEN pa.statut_participation = 'présent' THEN 1 ELSE 0 END) AS presents,
    ROUND(AVG(pa.note), 2)                                                AS moyenne_note
FROM Evenement e
LEFT JOIN Participation pa ON e.id_evenement = pa.id_evenement
GROUP BY e.id_evenement, e.titre
ORDER BY total_inscrits DESC;
