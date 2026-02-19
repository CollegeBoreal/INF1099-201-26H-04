-- Création d’un utilisateur PostgreSQL
CREATE USER utilisateur_1 WITH PASSWORD 'password123';

-- Donner les droits
GRANT CONNECT ON DATABASE Colocation TO utilisateur_1;
GRANT USAGE ON SCHEMA public TO utilisateur_1;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO utilisateur_1;

-- Pour futures tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO utilisateur_1;

