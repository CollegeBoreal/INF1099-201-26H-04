-- ============================================================
--  DML.sql — Manipulation des données (Data Manipulation Language)
--  Projet  : Gestion Scolaire (Moodle)
--  SGBD    : PostgreSQL
-- ============================================================

-- ------------------------------------------------------------
--  Insertion (INSERT)
-- ------------------------------------------------------------
INSERT INTO DEPARTEMENT (nom_departement) VALUES 
    ('Informatique'), ('Mathématiques'), ('Sciences');

INSERT INTO STATUT (libelle) VALUES 
    ('Inscrit'), ('Complété'), ('Abandon');

INSERT INTO SESSION_SCOLAIRE (nom_session, date_debut, date_fin) VALUES 
    ('Hiver 2026', '2026-01-05', '2026-05-15'),
    ('Automne 2026', '2026-08-25', '2026-12-20');

INSERT INTO PROFESSEUR (nom, prenom, email, id_departement) VALUES 
    ('Durand', 'Marie', 'm.durand@ecole.ca', 1),
    ('Lavoie', 'Jean', 'j.lavoie@ecole.ca', 2),
    ('Cote', 'Pierre', 'p.cote@ecole.ca', 1);

INSERT INTO ETUDIANT (nom, prenom, email, telephone) VALUES 
    ('Tremblay', 'Luc', 'luc.t@etudiant.ca', '514-555-0101'),
    ('Gagnon', 'Sophie', 'sophie.g@etudiant.ca', '514-555-0102'),
    ('Roy', 'Alain', 'alain.r@etudiant.ca', '514-555-0103');

INSERT INTO COURS (titre, description, credits, id_professeur) VALUES 
    ('Base de Données', 'PostgreSQL et modélisation', 3, 1),
    ('Algèbre Linéaire', 'Vecteurs et matrices', 3, 2),
    ('Programmation Web', 'HTML, CSS, JS', 3, 3);

INSERT INTO INSCRIPTION (date_inscription, id_etudiant, id_session, id_statut) VALUES 
    ('2026-01-06', 1, 1, 1),
    ('2026-01-07', 2, 1, 1),
    ('2026-01-10', 3, 1, 2);

INSERT INTO DETAIL_INSCRIPTION (id_inscription, id_cours, note_finale) VALUES 
    (1, 1, 90.00),
    (1, 3, 85.50),
    (2, 2, 92.00),
    (3, 1, 75.00);

-- ------------------------------------------------------------
--  Mise à jour (UPDATE)
-- ------------------------------------------------------------
-- Mettre à jour la note finale d'un étudiant
UPDATE DETAIL_INSCRIPTION
SET note_finale = 95.00
WHERE id_inscription = 1 AND id_cours = 1;

-- ------------------------------------------------------------
--  Suppression (DELETE)
-- ------------------------------------------------------------
-- Exemple de suppression (commenté pour préserver les données)
-- DELETE FROM DETAIL_INSCRIPTION WHERE id_inscription = 3;