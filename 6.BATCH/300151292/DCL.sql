-- ============================================================
-- DCL.sql - BorealFit - Gestion des accès (PostgreSQL)
-- ============================================================

-- Création des rôles
CREATE USER lecteur_bf WITH PASSWORD 'lecteur123';
CREATE USER admin_bf   WITH PASSWORD 'admin123';

-- Connexion à la base
GRANT CONNECT ON DATABASE borealfit TO lecteur_bf, admin_bf;

-- Accès au schéma
GRANT USAGE ON SCHEMA public TO lecteur_bf, admin_bf;

-- lecteur_bf : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lecteur_bf;

-- admin_bf : accès complet
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO admin_bf;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO admin_bf;
