<<<<<<< HEAD
INSERT INTO etudiants (nom, age, email)
VALUES ('Test', 20, 'test@email.com');

INSERT INTO cours (nom) VALUES
('Math'),
('Informatique'),
('Physique');
=======
-- ============================================================
-- 02-dml.sql
-- TP PostgreSQL — Procédures, Fonctions et Triggers
-- Étudiante : Aroua Mohand Tahar
-- Matricule : 300150284
-- Rôle : insertion des données de départ
-- ============================================================

-- Insertion des étudiants de test
INSERT INTO etudiants (nom, age, email) VALUES
    ('Sara Belkacem', 21, 'sara.belkacem@email.com'),
    ('Nadia Touati', 24, 'nadia.touati@email.com'),
    ('Yanis Merabet', 19, 'yanis.merabet@email.com'),
    ('Karim Bensaid', 26, 'karim.bensaid@email.com');

-- Insertion des cours
INSERT INTO cours (nom, credits) VALUES
    ('Bases de donnees', 3),
    ('Administration reseau', 3),
    ('Programmation Python', 3),
    ('Securite informatique', 3);
>>>>>>> f650d2d5a543182bc73855a0024af6ff9f85c796
