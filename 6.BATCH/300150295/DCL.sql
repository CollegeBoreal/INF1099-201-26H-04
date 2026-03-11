-- Création d'un utilisateur lecture seule
DROP ROLE IF EXISTS lecteur_ecole;
CREATE ROLE lecteur_ecole WITH LOGIN PASSWORD 'lecteur123';

-- Permissions
GRANT CONNECT ON DATABASE ecole TO lecteur_ecole;
GRANT USAGE ON SCHEMA public TO lecteur_ecole;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lecteur_ecole;

-- Pour les futures tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO lecteur_ecole;
