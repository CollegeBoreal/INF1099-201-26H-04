-- ============================================================
-- DCL.sql — Contrôle des accès (GRANT, REVOKE, ROLES)
-- Projet : Gestion de la vente de crampons ⚽👟
-- ============================================================

-- ============================================================
-- 1. Création des rôles utilisateurs
-- ============================================================

-- Rôle administrateur : accès complet à toutes les tables
CREATE ROLE admin_crampon;

-- Rôle vendeur : peut consulter et modifier les commandes/stock
CREATE ROLE vendeur_crampon;

-- Rôle lecture seule : consultation uniquement (ex: rapport, audit)
CREATE ROLE lecteur_crampon;

-- ============================================================
-- 2. Attribution des privilèges — Administrateur
-- Accès total sur toutes les tables
-- ============================================================
GRANT ALL PRIVILEGES ON TABLE Client         TO admin_crampon;
GRANT ALL PRIVILEGES ON TABLE Crampon        TO admin_crampon;
GRANT ALL PRIVILEGES ON TABLE Commande       TO admin_crampon;
GRANT ALL PRIVILEGES ON TABLE Ligne_Commande TO admin_crampon;
GRANT ALL PRIVILEGES ON TABLE Stock          TO admin_crampon;

-- Accès aux séquences (pour les SERIAL / auto-incrément)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO admin_crampon;

-- ============================================================
-- 3. Attribution des privilèges — Vendeur
-- Peut lire toutes les tables, modifier commandes et stock
-- ============================================================
GRANT SELECT ON TABLE Client         TO vendeur_crampon;
GRANT SELECT ON TABLE Crampon        TO vendeur_crampon;
GRANT SELECT, INSERT, UPDATE
              ON TABLE Commande       TO vendeur_crampon;
GRANT SELECT, INSERT, UPDATE
              ON TABLE Ligne_Commande TO vendeur_crampon;
GRANT SELECT, UPDATE
              ON TABLE Stock          TO vendeur_crampon;

-- Accès aux séquences nécessaires pour INSERT
GRANT USAGE, SELECT ON SEQUENCE commande_id_commande_seq       TO vendeur_crampon;
GRANT USAGE, SELECT ON SEQUENCE ligne_commande_id_ligne_commande_seq TO vendeur_crampon;

-- ============================================================
-- 4. Attribution des privilèges — Lecteur (lecture seule)
-- ============================================================
GRANT SELECT ON TABLE Client         TO lecteur_crampon;
GRANT SELECT ON TABLE Crampon        TO lecteur_crampon;
GRANT SELECT ON TABLE Commande       TO lecteur_crampon;
GRANT SELECT ON TABLE Ligne_Commande TO lecteur_crampon;
GRANT SELECT ON TABLE Stock          TO lecteur_crampon;

-- ============================================================
-- 5. Création des utilisateurs et attribution des rôles
-- ============================================================

-- Utilisateur administrateur
CREATE USER alice WITH PASSWORD 'MotDePasse_Alice123!';
GRANT admin_crampon TO alice;

-- Utilisateur vendeur
CREATE USER bob WITH PASSWORD 'MotDePasse_Bob456!';
GRANT vendeur_crampon TO bob;

-- Utilisateur lecture seule (ex: comptable, analyste)
CREATE USER charlie WITH PASSWORD 'MotDePasse_Charlie789!';
GRANT lecteur_crampon TO charlie;

-- ============================================================
-- 6. Révocation d'un privilège (exemple)
-- Retirer le droit de suppression à un vendeur si nécessaire
-- ============================================================
-- (Le rôle vendeur n'a pas DELETE, aucune révocation nécessaire)
-- Exemple : retirer SELECT sur Client à un lecteur
-- REVOKE SELECT ON TABLE Client FROM lecteur_crampon;

-- ============================================================
-- 7. Suppression d'un accès utilisateur (exemple)
-- ============================================================
-- REVOKE vendeur_crampon FROM bob;
-- DROP USER bob;
