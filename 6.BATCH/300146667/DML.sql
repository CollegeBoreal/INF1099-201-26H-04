-- DML.sql - DjaberBenyezza - 300146667

INSERT INTO etudiants (nom, prenom, email, age) VALUES
    ('Tremblay', 'Alice',   'alice@ecole.ca',  20),
    ('Gagnon',   'Bob',     'bob@ecole.ca',    22),
    ('Roy',      'Claire',  'claire@ecole.ca', 21),
    ('Cote',     'David',   'david@ecole.ca',  23),
    ('Bouchard', 'Emma',    'emma@ecole.ca',   19);

INSERT INTO cours (titre, credits) VALUES
    ('Bases de donnees',  3),
    ('Reseaux',           3),
    ('Programmation Web', 3);

INSERT INTO inscriptions (etudiant_id, cours_id) VALUES
    (1,1),(2,1),(3,2),(4,3),(5,1);
