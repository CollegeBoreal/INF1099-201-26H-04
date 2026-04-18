-- ==================================================================================
-- 02-dml.sql — Données initiales
-- ==================================================================================

INSERT INTO etudiants (nom, age, email)
VALUES
    ('Test',   20, 'test@email.com'),
    ('Marie',  22, 'marie@email.com'),
    ('Thomas', 25, 'thomas@email.com');

INSERT INTO cours (nom)
VALUES
    ('Mathématiques'),
    ('Bases de données'),
    ('Algorithmique');
