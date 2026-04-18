-- ==================================================================================
-- 02-dml.sql
-- TP PostgreSQL : Insertion des données initiales (DML)
-- ==================================================================================

-- Données initiales : étudiants
INSERT INTO etudiants (nom, age, email)
VALUES
    ('Test',    20, 'test@email.com'),
    ('Marie',   21, 'marie@email.com'),
    ('Jean',    25, 'jean@email.com');

-- Données initiales : cours
INSERT INTO cours (nom, description, credits)
VALUES
    ('Bases de données',   'Introduction aux SGBD relationnels',   3),
    ('Programmation Web',  'HTML, CSS, JavaScript et PHP',          3),
    ('Réseaux',            'Fondements des réseaux informatiques',  3);

-- Données initiales : inscriptions
INSERT INTO inscriptions (etudiant_id, cours_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 3);
