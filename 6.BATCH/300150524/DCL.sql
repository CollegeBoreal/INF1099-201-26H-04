-- ==========================================
-- CarGoRent - DCL (Data Control Language)
-- Étudiant : Taki Eddine Choufa
-- Projet : Modélisation SQL CarGoRent
-- ==========================================

-- Création des utilisateurs
CREATE USER client WITH PASSWORD 'client123';
CREATE USER admin WITH PASSWORD 'admin123';
CREATE USER agent WITH PASSWORD 'agent123';

-- Création du rôle
CREATE ROLE gestionnaire;

-- Permissions sur la base
GRANT CONNECT ON DATABASE cargorent_model TO client, admin, agent;

-- Permissions sur le schéma
GRANT USAGE ON SCHEMA cargorent TO client, admin;
GRANT USAGE ON SCHEMA cargorent TO gestionnaire;

-- Permissions sur les tables
GRANT SELECT ON cargorent.client TO client;

GRANT SELECT, INSERT, UPDATE, DELETE ON cargorent.client TO admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON cargorent.client TO gestionnaire;

-- Permissions sur la séquence SERIAL de la table client
GRANT USAGE, SELECT ON SEQUENCE cargorent.client_id_client_seq TO admin;
GRANT USAGE, SELECT ON SEQUENCE cargorent.client_id_client_seq TO gestionnaire;

-- Attribution du rôle gestionnaire à l'utilisateur agent
GRANT gestionnaire TO agent;

-- Révocation d'exemple
REVOKE ALL PRIVILEGES ON cargorent.client FROM client;
