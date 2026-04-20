-- ============================================================
-- 02-dml.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- Centre Sportif — Gestion de Terrains & Réservations
-- #300150293
-- Prérequis : 01-ddl.sql doit avoir été exécuté
-- ============================================================

-- ------------------------------------------------------------
-- Données initiales : Terrains
-- ------------------------------------------------------------
INSERT INTO terrains (nom_terrain, type_surface, tarif_horaire, statut) VALUES
    ('Terrain A1', 'Gazon synthetique', 80.00, 'Disponible'),
    ('Terrain A2', 'Beton',             50.00, 'Disponible'),
    ('Terrain B1', 'Parquet',           70.00, 'Disponible');

-- ------------------------------------------------------------
-- Données initiales : Clients
-- ------------------------------------------------------------
INSERT INTO clients (nom, prenom, email, telephone) VALUES
    ('Test', 'Client', 'test@email.com', '514-000-0000');
