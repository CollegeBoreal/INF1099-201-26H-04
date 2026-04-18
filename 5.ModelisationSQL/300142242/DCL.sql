-- ============================================================
--  DCL.sql — Contrôle des données (Data Control Language)
--  Projet  : Gestion Scolaire (Moodle)
-- ============================================================

-- ============================================================
--  1. CRÉATION DES RÔLES
-- ============================================================
CREATE ROLE admin_moodle LOGIN PASSWORD 'Admin@2026!' SUPERUSER;
CREATE ROLE prof_moodle LOGIN PASSWORD 'Prof@2026!';
CREATE ROLE etudiant_moodle LOGIN PASSWORD 'Etudiant@2026!';
CREATE ROLE lecteur_moodle LOGIN PASSWORD 'Lecteur@2026!';

-- ============================================================
--  2. ATTRIBUTION DES PRIVILÈGES (GRANT)
-- ============================================================
-- Le professeur peut lire et modifier les notes et les cours
GRANT SELECT ON DEPARTEMENT, STATUT, SESSION_SCOLAIRE, ETUDIANT TO prof_moodle;
GRANT SELECT, INSERT, UPDATE ON COURS, INSCRIPTION, DETAIL_INSCRIPTION TO prof_moodle;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO prof_moodle;

-- L'étudiant a un accès en lecture seule
GRANT SELECT ON COURS, DEPARTEMENT, SESSION_SCOLAIRE TO etudiant_moodle;

-- ============================================================
--  3. RÉVOCATION DE PRIVILÈGES (REVOKE)
-- ============================================================
-- S'assurer que l'étudiant ne peut pas voir les données des autres
REVOKE SELECT ON ETUDIANT FROM etudiant_moodle;
REVOKE SELECT ON DETAIL_INSCRIPTION FROM etudiant_moodle;