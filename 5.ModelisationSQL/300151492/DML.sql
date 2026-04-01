-- ============================================================
-- DML.sql — Data Manipulation Language
-- Insertion des données dans les tables
-- TP Modélisation SQL — Gestion des Participations à des Événements
-- ============================================================

\c participation_db;

-- ============================================================
-- INSERTION : Personnes
-- ============================================================
INSERT INTO Personne (nom, prenom, email) VALUES
    ('Dupont',  'Marie',  'marie.dupont@email.com'),
    ('Martin',  'Lucas',  'lucas.martin@email.com'),
    ('Bernard', 'Sophie', 'sophie.bernard@email.com'),
    ('Petit',   'Thomas', 'thomas.petit@email.com');

-- ============================================================
-- INSERTION : Événements
-- ============================================================
INSERT INTO Evenement (titre, date_debut) VALUES
    ('Atelier SQL Avancé',               '2024-03-10'),
    ('Conférence Big Data & IA',         '2024-03-15'),
    ('Workshop Modélisation ER',         '2024-03-20'),
    ('Formation PostgreSQL Performance', '2024-04-05');

-- ============================================================
-- INSERTION : Participations
-- ============================================================
-- Marie Dupont → Atelier SQL Avancé (présente, note 16.5)
INSERT INTO Participation (id_personne, id_evenement, statut_participation, note)
    VALUES (1, 1, 'présent', 16.5);

-- Marie Dupont → Formation PostgreSQL Performance (inscrite, pas encore de note)
INSERT INTO Participation (id_personne, id_evenement, statut_participation, note)
    VALUES (1, 4, 'inscrit', NULL);

-- Lucas Martin → Atelier SQL Avancé (inscrit, pas encore de note)
INSERT INTO Participation (id_personne, id_evenement, statut_participation, note)
    VALUES (2, 1, 'inscrit', NULL);

-- Lucas Martin → Conférence Big Data & IA (absent, pas de note)
INSERT INTO Participation (id_personne, id_evenement, statut_participation, note)
    VALUES (2, 2, 'absent', NULL);

-- Sophie Bernard → Conférence Big Data & IA (présente, note 18)
INSERT INTO Participation (id_personne, id_evenement, statut_participation, note)
    VALUES (3, 2, 'présent', 18.0);

-- Thomas Petit → Workshop Modélisation ER (présent, note 14)
INSERT INTO Participation (id_personne, id_evenement, statut_participation, note)
    VALUES (4, 3, 'présent', 14.0);

-- ============================================================
-- EXEMPLES DE MISE À JOUR (UPDATE)
-- ============================================================

-- Mettre à jour le statut de Lucas Martin pour l'Atelier SQL Avancé
-- UPDATE Participation
-- SET statut_participation = 'présent', note = 15.0
-- WHERE id_personne = 2 AND id_evenement = 1;

-- ============================================================
-- EXEMPLES DE SUPPRESSION (DELETE)
-- ============================================================

-- Supprimer une participation
-- DELETE FROM Participation
-- WHERE id_personne = 2 AND id_evenement = 4;
