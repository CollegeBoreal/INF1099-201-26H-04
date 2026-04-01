-- ============================================================
-- DCL.sql — Data Control Language
-- Gestion des droits et accès utilisateurs
-- TP Modélisation SQL — Gestion des Participations à des Événements
-- ============================================================

\c participation_db;

-- ============================================================
-- CRÉATION DES RÔLES (utilisateurs)
-- ============================================================

-- Rôle administrateur : tous les droits
CREATE ROLE admin_participation WITH LOGIN PASSWORD 'admin_password';

-- Rôle lecteur : consultation uniquement (SELECT)
CREATE ROLE lecteur_participation WITH LOGIN PASSWORD 'lecteur_password';

-- Rôle gestionnaire : peut insérer et modifier, mais pas supprimer
CREATE ROLE gestionnaire_participation WITH LOGIN PASSWORD 'gestionnaire_password';

-- ============================================================
-- ATTRIBUTION DES DROITS — Administrateur
-- ============================================================

-- L'admin a tous les droits sur toutes les tables
GRANT ALL PRIVILEGES ON TABLE Personne      TO admin_participation;
GRANT ALL PRIVILEGES ON TABLE Evenement     TO admin_participation;
GRANT ALL PRIVILEGES ON TABLE Participation TO admin_participation;

-- L'admin peut aussi utiliser les séquences (pour SERIAL / auto-incrément)
GRANT USAGE, SELECT, UPDATE ON SEQUENCE personne_id_personne_seq      TO admin_participation;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE evenement_id_evenement_seq     TO admin_participation;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE participation_id_participation_seq TO admin_participation;

-- L'admin peut accéder à la vue
GRANT SELECT ON vue_recap_participation TO admin_participation;

-- ============================================================
-- ATTRIBUTION DES DROITS — Lecteur
-- ============================================================

-- Le lecteur peut seulement consulter les données (SELECT)
GRANT SELECT ON TABLE Personne      TO lecteur_participation;
GRANT SELECT ON TABLE Evenement     TO lecteur_participation;
GRANT SELECT ON TABLE Participation TO lecteur_participation;
GRANT SELECT ON vue_recap_participation TO lecteur_participation;

-- ============================================================
-- ATTRIBUTION DES DROITS — Gestionnaire
-- ============================================================

-- Le gestionnaire peut lire, insérer et modifier (mais pas supprimer)
GRANT SELECT, INSERT, UPDATE ON TABLE Personne      TO gestionnaire_participation;
GRANT SELECT, INSERT, UPDATE ON TABLE Evenement     TO gestionnaire_participation;
GRANT SELECT, INSERT, UPDATE ON TABLE Participation TO gestionnaire_participation;

-- Le gestionnaire peut utiliser les séquences pour INSERT
GRANT USAGE, SELECT ON SEQUENCE personne_id_personne_seq          TO gestionnaire_participation;
GRANT USAGE, SELECT ON SEQUENCE evenement_id_evenement_seq         TO gestionnaire_participation;
GRANT USAGE, SELECT ON SEQUENCE participation_id_participation_seq TO gestionnaire_participation;

GRANT SELECT ON vue_recap_participation TO gestionnaire_participation;

-- ============================================================
-- RÉVOCATION DE DROITS (exemples)
-- ============================================================

-- Révoquer le droit de modification sur Personne pour le gestionnaire
-- REVOKE UPDATE ON TABLE Personne FROM gestionnaire_participation;

-- Révoquer tous les droits du lecteur
-- REVOKE ALL PRIVILEGES ON TABLE Personne      FROM lecteur_participation;
-- REVOKE ALL PRIVILEGES ON TABLE Evenement     FROM lecteur_participation;
-- REVOKE ALL PRIVILEGES ON TABLE Participation FROM lecteur_participation;

-- ============================================================
-- VÉRIFICATION DES DROITS
-- ============================================================

-- Voir les droits sur les tables
\dp Personne
\dp Evenement
\dp Participation

-- Voir les rôles existants
\du
