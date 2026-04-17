-- =========================
DROP ROLE IF EXISTS user_read;
DROP ROLE IF EXISTS user_admin;

-- =========================
-- Création des utilisateurs
-- =========================
CREATE ROLE user_read LOGIN PASSWORD 'read123';
CREATE ROLE user_admin LOGIN PASSWORD 'admin123';

-- =========================
-- Accès au schéma
-- =========================
GRANT USAGE ON SCHEMA aeroport TO user_read;
GRANT USAGE ON SCHEMA aeroport TO user_admin;

-- =========================
-- Permissions lecture seule
-- =========================
GRANT SELECT ON ALL TABLES IN SCHEMA aeroport TO user_read;

-- =========================
-- Permissions complètes
-- =========================
GRANT SELECT, INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA aeroport 
TO user_admin;

-- =========================
-- Pour les futures tables
-- =========================
ALTER DEFAULT PRIVILEGES IN SCHEMA aeroport
GRANT SELECT ON TABLES TO user_read;

ALTER DEFAULT PRIVILEGES IN SCHEMA aeroport
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO user_admin;

-- =========================
-- TEST DES PERMISSIONS
-- =========================

-- Passer en utilisateur lecture seule
SET ROLE user_read;

-- Autorisé
SELECT * FROM aeroport.Passager;

-- Interdit (doit échouer)
-- INSERT INTO aeroport.Passager VALUES (...);

RESET ROLE;

-- Passer en admin
SET ROLE user_admin;

-- Autorisé
INSERT INTO aeroport.Passager (nom, prenom, passeport, nationalite)
VALUES ('Test', 'Admin', 'P00000', 'Test');

RESET ROLE;

-- =========================
-- REVOKE (retirer droits)
-- =========================
REVOKE INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA aeroport 
FROM user_admin;

-- =========================
-- Suppression utilisateurs
-- =========================
DROP ROLE user_read;
DROP ROLE user_admin;