-- ============================================================
-- DCL - Data Control Language
-- Boutique de réparation de smartphones
-- #300150205
-- Prérequis : ddl.sql et dml.sql doivent avoir été exécutés
-- À exécuter en tant que superutilisateur (postgres)
-- ============================================================

-- ------------------------------------------------------------
-- CREATE USER — Création des utilisateurs
-- ------------------------------------------------------------

CREATE USER technicien_user  WITH PASSWORD 'tech123';
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';

-- ------------------------------------------------------------
-- GRANT — Attribution des droits
-- ------------------------------------------------------------

-- Connexion à la base
GRANT CONNECT ON DATABASE reparation_smartphones TO technicien_user, gestionnaire_user;

-- Accès au schéma
GRANT USAGE ON SCHEMA boutique TO technicien_user, gestionnaire_user;

-- Technicien : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA boutique TO technicien_user;

-- Gestionnaire : lecture + écriture complète
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA boutique TO gestionnaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA boutique TO gestionnaire_user;

-- ------------------------------------------------------------
-- TEST technicien_user
-- Se connecter dans un nouveau terminal :
--   psql -U technicien_user -d reparation_smartphones
-- ------------------------------------------------------------

-- SELECT * FROM boutique.Reparation;                           -- ✅ OK
-- INSERT INTO boutique.Marque (Nom_Marque) VALUES ('OnePlus'); -- ❌ permission denied

-- ------------------------------------------------------------
-- TEST gestionnaire_user
-- Se connecter dans un nouveau terminal :
--   psql -U gestionnaire_user -d reparation_smartphones
-- ------------------------------------------------------------

-- INSERT INTO boutique.Marque (Nom_Marque) VALUES ('OnePlus');                 -- ✅ OK
-- UPDATE boutique.Piece_Rechange SET Prix_Unitaire = 54.99 WHERE ID_Piece = 2; -- ✅ OK
-- SELECT * FROM boutique.Marque;                                                -- ✅ OK

-- ------------------------------------------------------------
-- REVOKE — Retrait des droits du technicien
-- À exécuter en tant que postgres
-- ------------------------------------------------------------

REVOKE SELECT ON ALL TABLES IN SCHEMA boutique FROM technicien_user;

-- Vérifier (connecté en technicien_user) :
-- SELECT * FROM boutique.Reparation; -- ❌ permission denied

-- ------------------------------------------------------------
-- DROP USER — Suppression des utilisateurs
-- ⚠️ Génère une erreur intentionnelle : les privilèges sont
--    encore actifs sur la base, le schéma et les tables.
-- ------------------------------------------------------------

DROP USER technicien_user;
DROP USER gestionnaire_user;
