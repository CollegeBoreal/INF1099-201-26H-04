 -- Création des utilisateurs
CREATE ROLE player_user LOGIN PASSWORD 'player123';
CREATE ROLE admin_user LOGIN PASSWORD 'admin123';

-- Donner accès à la base
GRANT CONNECT ON DATABASE ecole TO player_user, admin_user;

-- Donner accès au schéma
GRANT USAGE ON SCHEMA esport TO player_user, admin_user;

-- Droits de lecture pour player_user
GRANT SELECT ON ALL TABLES IN SCHEMA esport TO player_user;

-- Tous les droits pour admin_user
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA esport TO admin_user;

-- Droits sur les séquences
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA esport TO admin_user;

-- Retirer le droit SELECT à player_user
REVOKE SELECT ON ALL TABLES IN SCHEMA esport FROM player_user;
