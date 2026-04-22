-- ============================================================
-- DCL - Data Control Language
-- Bibliothèque Universitaire
-- Prérequis : DDL.sql et DML.sql doivent avoir été exécutés
-- ============================================================

-- ------------------------------------------------------------
-- Étape 1 : Créer les utilisateurs
-- ------------------------------------------------------------

-- Employé : lecture seule
CREATE USER employe_user WITH PASSWORD 'emp123';

-- Gestionnaire : accès complet
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';

-- ------------------------------------------------------------
-- Étape 2 : Donner les droits (GRANT)
-- ------------------------------------------------------------

-- Connexion à la base
GRANT CONNECT ON DATABASE gestion_bibliotheque TO employe_user, gestionnaire_user;

-- Accès au schéma
GRANT USAGE ON SCHEMA bibliotheque TO employe_user, gestionnaire_user;

-- Employé : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA bibliotheque TO employe_user;

-- Gestionnaire : lecture + écriture complète
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bibliotheque TO gestionnaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA bibliotheque TO gestionnaire_user;

-- ------------------------------------------------------------
-- Étape 3 : Tester les droits de l'employé
-- Se connecter avec : psql -U employe_user -d gestion_bibliotheque
-- ------------------------------------------------------------

-- SELECT * FROM bibliotheque.Emprunt;                                    -- OK
-- INSERT INTO bibliotheque.Auteur (Nom, Prenom) VALUES ('Test', 'X');   -- ERREUR attendue

-- ------------------------------------------------------------
-- Étape 4 : Tester les droits du gestionnaire
-- Se connecter avec : psql -U gestionnaire_user -d gestion_bibliotheque
-- ------------------------------------------------------------

-- INSERT INTO bibliotheque.Categorie (Nom_Categorie) VALUES ('Biographie');          -- OK
-- UPDATE bibliotheque.Livre SET Annee_Publication = 1863 WHERE ID_Livre = 1;         -- OK
-- SELECT * FROM bibliotheque.Categorie;                                               -- OK

-- ------------------------------------------------------------
-- Étape 5 : Retirer les droits (REVOKE)
-- Se reconnecter en postgres : psql -U postgres -d gestion_bibliotheque
-- ------------------------------------------------------------

REVOKE SELECT ON ALL TABLES IN SCHEMA bibliotheque FROM employe_user;

-- Vérifier : \c - employe_user
-- SELECT * FROM bibliotheque.Emprunt;   -- ERREUR attendue : permission denied

-- ------------------------------------------------------------
-- Étape 6 : Supprimer les utilisateurs (DROP USER)
-- Se reconnecter en postgres
-- ------------------------------------------------------------

-- NOTE : PostgreSQL ne permet pas de supprimer un utilisateur
-- qui possède encore des privilèges. Il faut d'abord révoquer
-- tous ses droits avant d'exécuter les commandes suivantes.

DROP USER employe_user;
DROP USER gestionnaire_user;
