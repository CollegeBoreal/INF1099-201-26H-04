-- ============================================================
-- DCL.sql — Contrôle des accès
-- Projet : Gestion de Bibliothèque
-- Étudiant : Hocine Adjaoud — 300148450
-- ============================================================

\c gestion_bibliotheque

-- ------------------------------------------------------------
-- Création des utilisateurs
-- ------------------------------------------------------------

-- Membre : lecture seule
CREATE USER membre_user WITH PASSWORD 'membre123';

-- Bibliothécaire : accès complet
CREATE USER bibliothecaire_user WITH PASSWORD 'biblio123';

-- ------------------------------------------------------------
-- GRANT — Attribution des droits
-- ------------------------------------------------------------

-- Connexion à la base
GRANT CONNECT ON DATABASE gestion_bibliotheque TO membre_user, bibliothecaire_user;

-- Accès au schéma
GRANT USAGE ON SCHEMA bibliotheque TO membre_user, bibliothecaire_user;

-- Membre : lecture seule sur toutes les tables
GRANT SELECT ON ALL TABLES IN SCHEMA bibliotheque TO membre_user;

-- Bibliothécaire : lecture + écriture complète
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bibliotheque TO bibliothecaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA bibliotheque TO bibliothecaire_user;

-- ------------------------------------------------------------
-- Tests des droits
-- ------------------------------------------------------------

-- Test membre_user (lecture seule)
\c gestion_bibliotheque membre_user

SELECT * FROM bibliotheque.Emprunt;                         -- OK

INSERT INTO bibliotheque.Livre (Titre, Auteur)
VALUES ('Test', 'Test');                                    -- Doit échouer : permission denied

-- Retour en superutilisateur
\c gestion_bibliotheque postgres

-- Test bibliothecaire_user (accès complet)
\c gestion_bibliotheque bibliothecaire_user

INSERT INTO bibliotheque.Livre (Titre, Auteur, Categorie, Annee_Publication)
VALUES ('Fondation', 'Isaac Asimov', 'Science-fiction', 1951);  -- OK

UPDATE bibliotheque.Exemplaire
SET Statut = 'En réparation'
WHERE ID_Exemplaire = 3;                                        -- OK

SELECT * FROM bibliotheque.Livre;                               -- OK

-- Retour en superutilisateur
\c gestion_bibliotheque postgres

-- ------------------------------------------------------------
-- REVOKE — Retrait des droits
-- ------------------------------------------------------------

REVOKE SELECT ON ALL TABLES IN SCHEMA bibliotheque FROM membre_user;

-- Vérification : doit échouer
\c gestion_bibliotheque membre_user

SELECT * FROM bibliotheque.Emprunt;  -- Doit échouer : permission denied

-- Retour en superutilisateur
\c gestion_bibliotheque postgres

-- ------------------------------------------------------------
-- DROP USER — Suppression des utilisateurs
-- (Révoquer tous les droits avant de supprimer)
-- ------------------------------------------------------------

REVOKE ALL ON ALL TABLES    IN SCHEMA bibliotheque FROM membre_user, bibliothecaire_user;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA bibliotheque FROM membre_user, bibliothecaire_user;
REVOKE USAGE ON SCHEMA bibliotheque FROM membre_user, bibliothecaire_user;
REVOKE CONNECT ON DATABASE gestion_bibliotheque FROM membre_user, bibliothecaire_user;

DROP USER membre_user;
DROP USER bibliothecaire_user;
