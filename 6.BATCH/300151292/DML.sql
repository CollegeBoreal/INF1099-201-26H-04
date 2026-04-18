-- ============================================================
-- DML.sql - BorealFit - Insertion des données (PostgreSQL)
-- ============================================================

INSERT INTO utilisateurs (nom, prenom, email, age) VALUES
('Tremblay', 'Marie',    'marie.tremblay@borealfit.ca',  22),
('Bouchard', 'Jean',     'jean.bouchard@borealfit.ca',   25),
('Gagnon',   'Sophie',   'sophie.gagnon@borealfit.ca',   21),
('Lavoie',   'Mathieu',  'mathieu.lavoie@borealfit.ca',  28),
('Côté',     'Isabelle', 'isabelle.cote@borealfit.ca',   23);

INSERT INTO categories (nom_categorie) VALUES
('Cardio'),
('Musculation'),
('Yoga & Bien-être');

INSERT INTO activites (nom_activite, categorie_id) VALUES
('Spinning',    1),
('HIIT',        1),
('Bench Press', 2),
('Hatha Yoga',  3),
('Zumba',       1);

INSERT INTO reservations (utilisateur_id, activite_id, date_reservation, statut) VALUES
(1, 1, '2025-05-05', 'confirmée'),
(2, 2, '2025-05-05', 'confirmée'),
(3, 4, '2025-05-06', 'annulée'),
(4, 5, '2025-05-07', 'confirmée'),
(5, 3, '2025-05-07', 'terminée');
