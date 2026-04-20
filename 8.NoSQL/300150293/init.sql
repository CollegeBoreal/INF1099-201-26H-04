-- ============================================================
-- init.sql
-- TP NoSQL — PostgreSQL JSONB + Python
-- Centre Sportif — Gestion de Terrains & Réservations
-- #300150293
-- ============================================================

-- Création de la table
CREATE TABLE terrains (
    id   SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

-- Index GIN pour accélérer les requêtes JSONB
CREATE INDEX idx_terrains_data
ON terrains USING GIN (data);

-- Insertion des données initiales
INSERT INTO terrains (data) VALUES
('{"nom": "Terrain A1", "type": "Gazon synthetique", "tarif": 80, "eclairage": true,  "statut": "Disponible", "ville": "Laval"}'),
('{"nom": "Terrain A2", "type": "Beton",             "tarif": 50, "eclairage": false, "statut": "Disponible", "ville": "Laval"}'),
('{"nom": "Terrain B1", "type": "Parquet",           "tarif": 70, "eclairage": true,  "statut": "Disponible", "ville": "Montreal"}');
