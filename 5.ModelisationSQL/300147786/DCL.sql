-- Création d’un utilisateur PostgreSQL
CREATE USER utilisateur_app WITH PASSWORD 'password123';

-- Donner les droits
GRANT CONNECT ON DATABASE votre_base TO utilisateur_app;
GRANT USAGE ON SCHEMA public TO utilisateur_app;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO utilisateur_app;

-- Pour futures tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO utilisateur_app;

