-- =========================
-- Clients
-- =========================
INSERT INTO cargorent.clients (nom, prenom, telephone, email, numero_permis) VALUES
('Taki', 'Choufa', '5141234567', 'taki@cargorent.com', 'P123456'),
('Houcine', 'Benhaib', '5141111111', 'houcine@cargorent.com', 'P999999'),
('Maya', 'Abd', '5149876543', 'maya@cargorent.com', 'P654321');

-- =========================
-- Voitures
-- =========================
INSERT INTO cargorent.voitures (marque, modele, annee, plaque, disponible) VALUES
('Toyota', 'Corolla', 2021, 'ABC123', TRUE),
('Honda', 'CRV', 2022, 'XYZ789', TRUE),
('BMW', '320i', 2020, 'DEF456', TRUE);

-- =========================
-- Reservations
-- =========================
INSERT INTO cargorent.reservations (date_debut, date_fin, statut, id_client, id_voiture) VALUES
('2026-04-20', '2026-04-25', 'confirmée', 1, 1),
('2026-04-22', '2026-04-24', 'confirmée', 2, 2),
('2026-04-26', '2026-04-28', 'en attente', 3, 3);