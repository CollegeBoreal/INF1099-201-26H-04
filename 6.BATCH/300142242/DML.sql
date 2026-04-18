INSERT INTO ETUDIANT (nom, email) VALUES 
    ('Tremblay', 'luc@moodle.ca'),
    ('Gagnon', 'sophie@moodle.ca');

INSERT INTO COURS (titre) VALUES 
    ('Bases de donnees'),
    ('Programmation Web');

INSERT INTO INSCRIPTION (id_etudiant, id_cours) VALUES 
    (1, 1), (2, 2), (1, 2);