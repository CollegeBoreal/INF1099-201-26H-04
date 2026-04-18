-- ==========================================
-- CarGoRent - DML (Data Manipulation Language)
-- Étudiant : Taki Eddine Choufa
-- Projet : Modélisation SQL CarGoRent
-- ==========================================

-- Optionnel : nettoyer les tables avant réinsertion
TRUNCATE TABLE cargorent.paiement RESTART IDENTITY CASCADE;
TRUNCATE TABLE cargorent.contrat_location RESTART IDENTITY CASCADE;
TRUNCATE TABLE cargorent.reservation RESTART IDENTITY CASCADE;
TRUNCATE TABLE cargorent.employe RESTART IDENTITY CASCADE;
TRUNCATE TABLE cargorent.voiture RESTART IDENTITY CASCADE;
TRUNCATE TABLE cargorent.agence RESTART IDENTITY CASCADE;
TRUNCATE TABLE cargorent.categorie RESTART IDENTITY CASCADE;
TRUNCATE TABLE cargorent.client RESTART IDENTITY CASCADE;

INSERT INTO cargorent.client (nom, prenom, telephone, email, numero_permis) VALUES
('Taki', 'Choufa', '5141234567', 'taki@cargorent.com', 'P123456'),
('Houcine', 'Benchaib', '5141111111', 'houcine@cargorent.com', 'P999999'),
('Maya', 'Abd', '5149876543', 'maya@cargorent.com', 'P654321');

INSERT INTO cargorent.categorie (nom, prix_jour) VALUES
('Economique', 45),
('SUV', 80),
('Berline', 65);

INSERT INTO cargorent.agence (nom, ville, adresse) VALUES
('CarGoRent Centre', 'Montreal', '123 Rue Sainte-Catherine'),
('CarGoRent Nord', 'Laval', '456 Boulevard Cure-Labelle');

INSERT INTO cargorent.voiture (marque, modele, annee, plaque, kilometrage, id_categorie, id_agence) VALUES
('Toyota', 'Corolla', 2021, 'ABC123', 25000, 1, 1),
('Honda', 'CRV', 2022, 'XYZ789', 18000, 2, 1),
('BMW', '320i', 2020, 'DEF456', 30000, 3, 2);

INSERT INTO cargorent.employe (nom, prenom, poste, id_agence) VALUES
('Lidia', 'Afi', 'Agent', 1),
('Chawki', 'Sou', 'Gestionnaire', 2);

INSERT INTO cargorent.reservation (date_debut, date_fin, statut, id_client, id_voiture) VALUES
('2026-04-20', '2026-04-25', 'confirmee', 1, 1),
('2026-04-22', '2026-04-24', 'confirmee', 2, 2),
('2026-04-26', '2026-04-28', 'en attente', 3, 3);

INSERT INTO cargorent.contrat_location (date_debut, date_fin, km_depart, id_reservation, id_employe) VALUES
('2026-04-20', '2026-04-25', 25000, 1, 1),
('2026-04-22', '2026-04-24', 18000, 2, 1),
('2026-04-26', '2026-04-28', 30000, 3, 2);

INSERT INTO cargorent.paiement (montant, date_paiement, mode, id_contrat) VALUES
(225, '2026-04-20', 'Carte', 1),
(160, '2026-04-22', 'Especes', 2),
(130, '2026-04-26', 'Carte', 3);
