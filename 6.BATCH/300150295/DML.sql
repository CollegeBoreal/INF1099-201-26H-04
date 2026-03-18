-- Insertion des étudiants
INSERT INTO etudiants (nom, prenom, email, date_naissance) VALUES
('Dupont', 'Marie', 'marie.dupont@email.com', '2000-05-15'),
('Martin', 'Jean', 'jean.martin@email.com', '1999-08-22'),
('Bernard', 'Sophie', 'sophie.bernard@email.com', '2001-03-10');

-- Insertion des cours
INSERT INTO cours (code, titre, credits) VALUES
('INF1099', 'Bases de données', 3),
('INF1010', 'Programmation I', 4),
('MAT1000', 'Mathématiques', 3);

-- Insertion des inscriptions
INSERT INTO inscriptions (etudiant_id, cours_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3);
