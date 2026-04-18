-- =========================
-- INSERT DATA
-- =========================

-- Compagnies
INSERT INTO aeroport.CompagnieAerienne (nom, pays, code_IATA) VALUES
('Air France', 'France', 'AF'),
('Air Algérie', 'Algérie', 'AH');

-- Avions
INSERT INTO aeroport.Avion (modele, capacite, annee_fabrication, id_compagnie) VALUES
('Boeing 737', 180, 2015, 1),
('Airbus A320', 150, 2018, 2);

-- Terminals
INSERT INTO aeroport.Terminal (nom, capacite) VALUES
('Terminal 1', 1000),
('Terminal 2', 800);

-- Gates
INSERT INTO aeroport.Gate (code_gate, id_terminal) VALUES
('G1', 1),
('G2', 2);

-- Runways
INSERT INTO aeroport.Runway (code_runway, statut) VALUES
('RW1', 'Disponible'),
('RW2', 'Occupé');

-- Vols
INSERT INTO aeroport.Vol (numero_vol, date_depart, date_arrivee, origine, destination, id_avion, id_gate, id_runway) VALUES
('AF123', '2026-05-01', '2026-05-01', 'Paris', 'Alger', 1, 1, 1),
('AH456', '2026-05-02', '2026-05-02', 'Alger', 'Oran', 2, 2, 2);

-- Passagers
INSERT INTO aeroport.Passager (nom, prenom, passeport, nationalite) VALUES
('Bouraoui', 'Akram', 'P12345', 'Algérienne'),
('Dupont', 'Jean', 'P67890', 'Française');

-- Réservations
INSERT INTO aeroport.Reservation (date_reservation, statut, id_passager, id_vol) VALUES
('2026-04-20', 'Confirmée', 1, 1),
('2026-04-21', 'Confirmée', 2, 2);

-- Billets
INSERT INTO aeroport.Billet (numero_siege, classe, id_reservation) VALUES
('12A', 'Economy', 1),
('1B', 'Business', 2);

-- Bagages
INSERT INTO aeroport.Bagage (poids, type, id_passager) VALUES
(20.5, 'Valise', 1),
(15.0, 'Sac', 2);

-- Personnel
INSERT INTO aeroport.Personnel (nom, prenom, role, service) VALUES
('Martin', 'Paul', 'Agent sécurité', 'Sécurité'),
('Ali', 'Karim', 'Technicien', 'Maintenance');

-- Contrôle sécurité
INSERT INTO aeroport.ControleSecurite (date_controle, statut, id_passager, id_personnel) VALUES
('2026-05-01', 'Validé', 1, 1),
('2026-05-02', 'Validé', 2, 1);

-- Maintenance
INSERT INTO aeroport.Maintenance (date_intervention, type_intervention, cout, id_avion) VALUES
('2026-04-10', 'Inspection', 5000, 1),
('2026-04-15', 'Réparation', 8000, 2);

-- Incidents
INSERT INTO aeroport.Incident (description, type_incident, date_incident, id_vol) VALUES
('Retard technique', 'Retard', '2026-05-01', 1),
('Problème météo', 'Météo', '2026-05-02', 2);

-- Services au sol
INSERT INTO aeroport.ServiceSol (type_service, statut, id_vol) VALUES
('Nettoyage', 'Terminé', 1),
('Chargement bagages', 'En cours', 2);

-- =========================
-- UPDATE DATA
-- =========================

-- Modifier le statut d'une réservation
UPDATE aeroport.Reservation
SET statut = 'Annulée'
WHERE id_reservation = 2;

-- Modifier la capacité d’un avion
UPDATE aeroport.Avion
SET capacite = 200
WHERE id_avion = 1;

-- Mise à jour d’un passager
UPDATE aeroport.Passager
SET nationalite = 'Canadienne'
WHERE id_passager = 2;

-- =========================
-- DELETE DATA
-- =========================

-- Supprimer un bagage
DELETE FROM aeroport.Bagage
WHERE id_bagage = 2;

-- Supprimer un incident
DELETE FROM aeroport.Incident
WHERE id_incident = 2;

-- Supprimer un service au sol
DELETE FROM aeroport.ServiceSol
WHERE id_service = 2;

-- =========================
-- INSERT SUPPLÉMENTAIRE
-- =========================

INSERT INTO aeroport.Passager (nom, prenom, passeport, nationalite)
VALUES ('Smith', 'John', 'P99999', 'Canadienne');

INSERT INTO aeroport.Reservation (date_reservation, statut, id_passager, id_vol)
VALUES ('2026-04-25', 'Confirmée', 3, 1);