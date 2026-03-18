-- ============================================================
--  DCL.sql — Contrôle des données (Data Control Language)
--  Projet  : Gestion d'un Salon de Coiffure
--  SGBD    : PostgreSQL
--  Auteur  : Jesmina
-- ============================================================

-- ============================================================
--  1. CRÉATION DES RÔLES
-- ============================================================

-- Rôle administrateur (accès complet)
CREATE ROLE admin_coiffure
    LOGIN
    PASSWORD 'Admin@2025!'
    SUPERUSER;

-- Rôle gérant (lecture + écriture, sans suppression)
CREATE ROLE gerant_coiffure
    LOGIN
    PASSWORD 'Gerant@2025!';

-- Rôle coiffeuse (lecture seule sur les données métier)
CREATE ROLE coiffeuse_role
    LOGIN
    PASSWORD 'Coiff@2025!';

-- Rôle lecture seule (rapports, statistiques)
CREATE ROLE lecteur_coiffure
    LOGIN
    PASSWORD 'Lecteur@2025!';

-- ============================================================
--  2. ATTRIBUTION DES PRIVILÈGES — Rôle GÉRANT
-- ============================================================

-- Le gérant peut tout lire et écrire
GRANT SELECT, INSERT, UPDATE ON CLIENT       TO gerant_coiffure;
GRANT SELECT, INSERT, UPDATE ON COIFFEUSE    TO gerant_coiffure;
GRANT SELECT, INSERT, UPDATE ON SERVICE      TO gerant_coiffure;
GRANT SELECT, INSERT, UPDATE ON MODELE       TO gerant_coiffure;
GRANT SELECT, INSERT, UPDATE ON RENDEZ_VOUS  TO gerant_coiffure;
GRANT SELECT, INSERT, UPDATE ON PAYEMENT     TO gerant_coiffure;

-- Accès aux séquences SERIAL pour les INSERT
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO gerant_coiffure;

-- ============================================================
--  3. ATTRIBUTION DES PRIVILÈGES — Rôle COIFFEUSE
-- ============================================================

-- La coiffeuse peut consulter les RDV et les services uniquement
GRANT SELECT ON RENDEZ_VOUS  TO coiffeuse_role;
GRANT SELECT ON CLIENT       TO coiffeuse_role;
GRANT SELECT ON SERVICE      TO coiffeuse_role;
GRANT SELECT ON MODELE       TO coiffeuse_role;

-- Pas d'accès aux paiements
REVOKE ALL ON PAYEMENT FROM coiffeuse_role;

-- ============================================================
--  4. ATTRIBUTION DES PRIVILÈGES — Rôle LECTEUR
-- ============================================================

-- Accès lecture seule sur toutes les tables
GRANT SELECT ON CLIENT       TO lecteur_coiffure;
GRANT SELECT ON COIFFEUSE    TO lecteur_coiffure;
GRANT SELECT ON SERVICE      TO lecteur_coiffure;
GRANT SELECT ON MODELE       TO lecteur_coiffure;
GRANT SELECT ON RENDEZ_VOUS  TO lecteur_coiffure;
GRANT SELECT ON PAYEMENT     TO lecteur_coiffure;

-- ============================================================
--  5. RÉVOCATION DE PRIVILÈGES (exemples)
-- ============================================================

-- Révoquer la modification des prix de service au gérant
REVOKE UPDATE ON SERVICE FROM gerant_coiffure;

-- Révoquer l'accès aux informations personnelles du client au lecteur
REVOKE SELECT ON CLIENT FROM lecteur_coiffure;

-- ============================================================
--  6. SUPPRESSION DES RÔLES (nettoyage — utiliser avec précaution)
-- ============================================================

-- DROP ROLE IF EXISTS lecteur_coiffure;
-- DROP ROLE IF EXISTS coiffeuse_role;
-- DROP ROLE IF EXISTS gerant_coiffure;
-- DROP ROLE IF EXISTS admin_coiffure;
