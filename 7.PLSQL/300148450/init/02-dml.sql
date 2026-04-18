-- =========================================================
-- 02-dml.sql
-- Insertion des données de départ
-- =========================================================

INSERT INTO etudiants (nom, age, email)
VALUES
('Test', 20, 'test@email.com'),
('Sara', 23, 'sara@email.com');

INSERT INTO cours (nom, description)
VALUES
('Base de donnees', 'Cours sur les concepts fondamentaux des bases de donnees'),
('Programmation', 'Cours d introduction a la programmation'),
('Reseautique', 'Cours sur les notions de reseaux informatiques');
