-- ============================================================
-- DML.sql - BorealFit - Insertion des données
-- ============================================================

USE borealfit;

-- Insertion des UTILISATEURS
INSERT INTO UTILISATEUR (nom, prenom, telephone, email) VALUES
('Tremblay', 'Marie', '514-555-0101', 'marie.tremblay@email.com'),
('Bouchard', 'Jean', '438-555-0202', 'jean.bouchard@email.com'),
('Gagnon', 'Sophie', '450-555-0303', 'sophie.gagnon@email.com'),
('Lavoie', 'Mathieu', '514-555-0404', 'mathieu.lavoie@email.com'),
('Côté', 'Isabelle', '438-555-0505', 'isabelle.cote@email.com');

-- Insertion des ADRESSES
INSERT INTO ADRESSE (utilisateur_id, rue, ville, province, code_postal) VALUES
(1, '123 Rue Saint-Denis', 'Montréal', 'Québec', 'H2X 3K8'),
(2, '456 Avenue du Parc', 'Montréal', 'Québec', 'H2V 4G5'),
(3, '789 Boul. Laurier', 'Laval', 'Québec', 'H7P 2N2'),
(4, '321 Rue Sherbrooke', 'Montréal', 'Québec', 'H3A 1G9'),
(5, '654 Rue Jean-Talon', 'Montréal', 'Québec', 'H2R 1S5');

-- Insertion des CATEGORIES
INSERT INTO CATEGORIE (nom_categorie) VALUES
('Cardio'),
('Musculation'),
('Yoga & Bien-être'),
('Arts martiaux'),
('Danse');

-- Insertion des ACTIVITES
INSERT INTO ACTIVITE (nom_activite, categorie_id) VALUES
('Spinning', 1),
('HIIT', 1),
('Bench Press', 2),
('Deadlift', 2),
('Hatha Yoga', 3),
('Méditation guidée', 3),
('Boxe', 4),
('Kickboxing', 4),
('Zumba', 5),
('Hip-Hop Dance', 5);

-- Insertion des COACHES
INSERT INTO COACH (nom, telephone) VALUES
('Lemieux, Patrick', '514-555-1001'),
('Paradis, Julie', '514-555-1002'),
('Bergeron, Alex', '438-555-1003'),
('Fortin, Camille', '450-555-1004');

-- Insertion des SEANCES
INSERT INTO SEANCE (activite_id, coach_id, date_seance, heure_debut, heure_fin, salle, capacite_max) VALUES
(1, 1, '2025-05-05', '08:00:00', '09:00:00', 'Salle A', 15),
(2, 2, '2025-05-05', '10:00:00', '11:00:00', 'Salle B', 20),
(5, 3, '2025-05-06', '09:00:00', '10:00:00', 'Salle C', 12),
(7, 4, '2025-05-06', '18:00:00', '19:30:00', 'Salle D', 10),
(9, 2, '2025-05-07', '17:00:00', '18:00:00', 'Salle A', 25),
(3, 1, '2025-05-07', '06:00:00', '07:00:00', 'Salle B', 8);

-- Insertion des RESERVATIONS
INSERT INTO RESERVATION (utilisateur_id, date_reservation, statut_reservation) VALUES
(1, '2025-05-01', 'confirmée'),
(2, '2025-05-01', 'confirmée'),
(3, '2025-05-02', 'annulée'),
(4, '2025-05-02', 'confirmée'),
(5, '2025-05-03', 'terminée');

-- Insertion des LIGNES_RESERVATION
INSERT INTO LIGNE_RESERVATION (reservation_id, seance_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(4, 5),
(5, 6);

-- Insertion des PAIEMENTS
INSERT INTO PAIEMENT (reservation_id, montant, mode_paiement, statut_paiement) VALUES
(1, 30.00, 'carte crédit', 'complété'),
(2, 20.00, 'PayPal', 'complété'),
(3, 25.00, 'carte débit', 'remboursé'),
(4, 20.00, 'carte crédit', 'complété'),
(5, 15.00, 'carte débit', 'complété');
