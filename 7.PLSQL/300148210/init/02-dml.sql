-- ==================================================================================
-- 02-dml.sql
-- Données initiales : étudiants et cours de test
-- ==================================================================================

-- Étudiants de départ (bypass trigger : insertion directe avant création du trigger)
INSERT INTO etudiants (nom, age, email)
VALUES
    ('Test',    20, 'test@email.com'),
    ('Marie',   23, 'marie@email.com'),
    ('Jean',    25, 'jean@email.com');

-- Cours disponibles
INSERT INTO cours (nom, description)
VALUES
    ('Bases de données',   'Introduction aux SGBD et au SQL'),
    ('Algorithmique',      'Structures de données et algorithmes fondamentaux'),
    ('Développement Web',  'HTML, CSS, JavaScript et frameworks modernes');
