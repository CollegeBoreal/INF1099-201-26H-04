-- insert.sql pour BetFormula

-- Villes
INSERT INTO betformula.ville(nom_ville, code_postal) VALUES
('Montréal', 'H2X 1Y4'),
('Toronto', 'M5V 2T6'),
('Vancouver', 'V6B 3L6'),
('Paris', '75001'),
('Londres', 'SW1A 1AA'),
('Berlin', '10115'),
('Rome', '00100'),
('Madrid', '28001'),
('Milan', '20121'),
('Bruxelles', '1000');

-- Utilisateurs
INSERT INTO betformula.utilisateur(nom, email, id_ville) VALUES
('Alice Dupont', 'alice@example.com', 1),
('Bob Martin', 'bob@example.com', 2),
('Charlie Lemoine', 'charlie@example.com', 3),
('David Moreau', 'david@example.com', 4),
('Emma Leroy', 'emma@example.com', 5),
('François Petit', 'francois@example.com', 6),
('Gabriel Rousseau', 'gabriel@example.com', 7),
('Hélène Dubois', 'helene@example.com', 8),
('Isabelle Caron', 'isabelle@example.com', 9),
('Julien Lefebvre', 'julien@example.com', 10);

-- Sponsors
INSERT INTO betformula.sponsor(nom_sponsor) VALUES
('RedBull'),('Mercedes'),('Ferrari'),('McLaren'),('Alpine'),
('Haas'),('AlphaTauri'),('AstonMartin'),('Williams'),('Renault');

-- Equipes
INSERT INTO betformula.equipe(nom_equipe, id_sponsor) VALUES
('Equipe RedBull', 1),
('Equipe Mercedes', 2),
('Equipe Ferrari', 3),
('Equipe McLaren', 4),
('Equipe Alpine', 5),
('Equipe Haas', 6),
('Equipe AlphaTauri', 7),
('Equipe AstonMartin', 8),
('Equipe Williams', 9),
('Equipe Renault', 10);

-- Pilotes
INSERT INTO betformula.pilote(nom_pilote, id_equipe) VALUES
('Max Verstappen', 1),
('Lewis Hamilton', 2),
('Charles Leclerc', 3),
('Lando Norris', 4),
('Esteban Ocon', 5),
('Kevin Magnussen', 6),
('Pierre Gasly', 7),
('Sebastian Vettel', 8),
('George Russell', 9),
('Fernando Alonso', 10);

-- Circuits
INSERT INTO betformula.circuit(nom_circuit, id_ville) VALUES
('Circuit Gilles Villeneuve', 1),
('Circuit de Toronto', 2),
('Circuit de Vancouver', 3),
('Circuit de Monaco', 4),
('Silverstone', 5),
('Hockenheim', 6),
('Monza', 7),
('Circuit de Barcelone', 8),
('Monza2', 9),
('Spa-Francorchamps', 10);

-- Événements
INSERT INTO betformula.evenement(nom_evenement, date_evenement, id_circuit) VALUES
('Grand Prix Canada', '2026-06-15', 1),
('Grand Prix Toronto', '2026-07-10', 2),
('Grand Prix Vancouver', '2026-08-20', 3),
('Grand Prix Monaco', '2026-05-25', 4),
('Grand Prix Angleterre', '2026-06-30', 5),
('Grand Prix Allemagne', '2026-07-20', 6),
('Grand Prix Italie', '2026-09-05', 7),
('Grand Prix Espagne', '2026-06-12', 8),
('Grand Prix Milan', '2026-07-15', 9),
('Grand Prix Belgique', '2026-08-22', 10);

-- Courses
INSERT INTO betformula.course(nom_course, date_course, id_evenement) VALUES
('Course 1', '2026-06-15', 1),
('Course 2', '2026-07-10', 2),
('Course 3', '2026-08-20', 3),
('Course 4', '2026-05-25', 4),
('Course 5', '2026-06-30', 5),
('Course 6', '2026-07-20', 6),
('Course 7', '2026-09-05', 7),
('Course 8', '2026-06-12', 8),
('Course 9', '2026-07-15', 9),
('Course 10', '2026-08-22', 10);

-- Paris
INSERT INTO betformula.pari(id_user, id_course, id_pilote, montant, resultat) VALUES
(1,1,1,100.00,'Gagné'),
(2,2,2,50.00,'Perdu'),
(3,3,3,75.50,'Gagné'),
(4,4,4,200.00,'Perdu'),
(5,5,5,125.25,'Gagné'),
(6,6,6,60.00,'Perdu'),
(7,7,7,80.00,'Gagné'),
(8,8,8,90.00,'Perdu'),
(9,9,9,110.00,'Gagné'),
(10,10,10,150.00,'Perdu');

