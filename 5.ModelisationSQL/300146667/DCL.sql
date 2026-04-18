-- DCL - Modélisation SQL - DjaberBenyezza - 300146667

\c reparation_smartphones

-- Étape 8 : Créer les utilisateurs
CREATE USER technicien_user WITH PASSWORD 'tech123';
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';

-- Étape 9 : Donner les droits (GRANT)
GRANT CONNECT ON DATABASE reparation_smartphones TO technicien_user, gestionnaire_user;
GRANT USAGE ON SCHEMA boutique TO technicien_user, gestionnaire_user;
GRANT SELECT ON ALL TABLES IN SCHEMA boutique TO technicien_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA boutique TO gestionnaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA boutique TO gestionnaire_user;

-- Étape 10 : Tester technicien (lecture seule)
\c reparation_smartphones technicien_user
SELECT * FROM boutique.Reparation;
INSERT INTO boutique.Marque (Nom_Marque) VALUES ('OnePlus');

-- Étape 11 : Tester gestionnaire (acces complet)
\c reparation_smartphones gestionnaire_user
INSERT INTO boutique.Marque (Nom_Marque) VALUES ('OnePlus');
UPDATE boutique.Piece_Rechange SET Prix_Unitaire = 54.99 WHERE ID_Piece = 2;
SELECT * FROM boutique.Marque;

-- Étape 12 : Retirer des droits (REVOKE)
\c reparation_smartphones postgres
REVOKE SELECT ON ALL TABLES IN SCHEMA boutique FROM technicien_user;
\c reparation_smartphones technicien_user
SELECT * FROM boutique.Reparation;

-- Étape 13 : Supprimer les utilisateurs (DROP USER)
\c reparation_smartphones postgres
DROP USER technicien_user;
DROP USER gestionnaire_user;
