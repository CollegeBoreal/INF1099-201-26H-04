-- ============================================================
-- DCL.sql - BorealFit - Contrôle des accès
-- ============================================================

USE borealfit;

-- ============================================================
-- CRÉATION DES UTILISATEURS DE BASE DE DONNÉES
-- ============================================================

-- Administrateur : accès complet
CREATE USER IF NOT EXISTS 'admin_borealfit'@'localhost' IDENTIFIED BY 'AdminBF2025!';

-- Responsable des réservations : lecture/écriture sur les tables opérationnelles
CREATE USER IF NOT EXISTS 'gestionnaire'@'localhost' IDENTIFIED BY 'GestBF2025!';

-- Utilisateur en lecture seule (ex. rapports, analytics)
CREATE USER IF NOT EXISTS 'lecteur'@'localhost' IDENTIFIED BY 'LectureBF2025!';

-- Coach : peut consulter ses séances
CREATE USER IF NOT EXISTS 'coach_app'@'localhost' IDENTIFIED BY 'CoachBF2025!';

-- ============================================================
-- ATTRIBUTION DES PRIVILÈGES
-- ============================================================

-- Admin : tous les droits
GRANT ALL PRIVILEGES ON borealfit.* TO 'admin_borealfit'@'localhost';

-- Gestionnaire : lecture et écriture sur les tables opérationnelles
GRANT SELECT, INSERT, UPDATE ON borealfit.RESERVATION TO 'gestionnaire'@'localhost';
GRANT SELECT, INSERT, UPDATE ON borealfit.LIGNE_RESERVATION TO 'gestionnaire'@'localhost';
GRANT SELECT, INSERT, UPDATE ON borealfit.PAIEMENT TO 'gestionnaire'@'localhost';
GRANT SELECT ON borealfit.UTILISATEUR TO 'gestionnaire'@'localhost';
GRANT SELECT ON borealfit.SEANCE TO 'gestionnaire'@'localhost';
GRANT SELECT ON borealfit.ACTIVITE TO 'gestionnaire'@'localhost';
GRANT SELECT ON borealfit.CATEGORIE TO 'gestionnaire'@'localhost';

-- Lecteur : accès en lecture seulement
GRANT SELECT ON borealfit.* TO 'lecteur'@'localhost';

-- Coach : consulter uniquement les séances et les activités
GRANT SELECT ON borealfit.SEANCE TO 'coach_app'@'localhost';
GRANT SELECT ON borealfit.ACTIVITE TO 'coach_app'@'localhost';
GRANT SELECT ON borealfit.CATEGORIE TO 'coach_app'@'localhost';
GRANT SELECT ON borealfit.COACH TO 'coach_app'@'localhost';

-- ============================================================
-- APPLICATION DES PRIVILÈGES
-- ============================================================

FLUSH PRIVILEGES;

-- ============================================================
-- RÉVOCATION D'UN PRIVILÈGE (exemple)
-- ============================================================

-- Si on doit révoquer un droit (exemple : retirer UPDATE à gestionnaire sur PAIEMENT)
-- REVOKE UPDATE ON borealfit.PAIEMENT FROM 'gestionnaire'@'localhost';

-- ============================================================
-- SUPPRESSION D'UN UTILISATEUR (exemple)
-- ============================================================

-- DROP USER IF EXISTS 'lecteur'@'localhost';
