-- Création d’un utilisateur
CREATE USER app_user WITH PASSWORD 'password123';

-- Donner accès en lecture
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_user;

-- Donner accès en écriture
GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO app_user;

-- Retirer un droit
REVOKE DELETE ON ALL TABLES IN SCHEMA public FROM app_user;
