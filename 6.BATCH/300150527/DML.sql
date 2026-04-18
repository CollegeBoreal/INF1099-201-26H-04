-- CompagnieAerienne
INSERT INTO CompagnieAerienne (nom, pays, code_IATA) VALUES
('Air Canada','Canada','AC'),
('Air France','France','AF'),
('Lufthansa','Germany','LH'),
('Emirates','UAE','EK'),
('Qatar Airways','Qatar','QR');

-- Avion (référence CompagnieAerienne 1..5)
INSERT INTO Avion (modele, capacite, annee_fabrication, id_compagnie) VALUES
('Boeing 737',180,2015,1),
('Airbus A320',160,2018,2),
('Boeing 777',300,2012,3),
('Airbus A380',500,2016,4),
('Boeing 787',250,2020,5);

-- Terminal
INSERT INTO Terminal (nom, capacite) VALUES
('T1',1000),
('T2',1200),
('T3',1500),
('T4',900),
('T5',800);

-- Gate (référence Terminal 1..5)
INSERT INTO Gate (code_gate, id_terminal) VALUES
('G1',1),
('G2',2),
('G3',3),
('G4',4),
('G5',5);

-- Runway
INSERT INTO Runway (code_runway, statut) VALUES
('R1','Active'),
('R2','Active'),
('R3','Maintenance'),
('R4','Active'),
('R5','Closed');

-- Vol (référence Avion, Gate, Runway 1..5)
INSERT INTO Vol (numero_vol, date_depart, date_arrivee, origine, destination, id_avion, id_gate, id_runway) VALUES
('AC101','2026-01-01','2026-01-01','Toronto','Montreal',1,1,1),
('AF202','2026-01-02','2026-01-02','Paris','Rome',2,2,2),
('LH303','2026-01-03','2026-01-03','Berlin','Madrid',3,3,3),
('EK404','2026-01-04','2026-01-04','Dubai','Doha',4,4,4),
('QR505','2026-01-05','2026-01-05','Doha','London',5,5,5);

-- Passager
INSERT INTO Passager (nom, prenom, passeport, nationalite) VALUES
('Ali','Ahmed','P001','Algerian'),
('Sara','Ben','P002','French'),
('John','Doe','P003','Canadian'),
('Anna','Smith','P004','British'),
('Omar','Khan','P005','Qatari');

-- Reservation (référence Passager & Vol 1..5)
INSERT INTO Reservation (date_reservation, statut, id_passager, id_vol) VALUES
('2026-01-01','Confirmée',1,1),
('2026-01-02','Confirmée',2,2),
('2026-01-03','Annulée',3,3),
('2026-01-04','Confirmée',4,4),
('2026-01-05','Confirmée',5,5);

-- Billet (référence Reservation 1..5)
INSERT INTO Billet (numero_siege, classe, id_reservation) VALUES
('12A','Eco',1),
('14B','Business',2),
('10C','Eco',3),
('1A','First',4),
('22D','Eco',5);

-- Bagage (référence Passager 1..5)
INSERT INTO Bagage (poids, type, id_passager) VALUES
(20,'Cabine',1),
(25,'Soute',2),
(18,'Cabine',3),
(30,'Soute',4),
(22,'Cabine',5);

-- Personnel
INSERT INTO Personnel (nom, prenom, role, service) VALUES
('Paul','Martin','Agent','Sol'),
('Marie','Dupont','Sécurité','Aéroport'),
('Ahmed','Ali','Technicien','Maintenance'),
('John','Lee','Pilote','Vol'),
('Sophie','Clark','Hôtesse','Cabine');

-- ControleSecurite (référence Passager & Personnel 1..5)
INSERT INTO ControleSecurite (date_controle, statut, id_passager, id_personnel) VALUES
('2026-01-01','OK',1,1),
('2026-01-02','OK',2,2),
('2026-01-03','OK',3,3),
('2026-01-04','OK',4,4),
('2026-01-05','OK',5,5);

-- Maintenance (référence Avion 1..5)
INSERT INTO Maintenance (date_intervention, type_intervention, cout, id_avion) VALUES
('2026-01-01','Check',5000,1),
('2026-01-02','Repair',7000,2),
('2026-01-03','Inspection',3000,3),
('2026-01-04','Upgrade',8000,4),
('2026-01-05','Check',4500,5);

-- Incident (référence Vol 1..5)
INSERT INTO Incident (description, type_incident, date_incident, id_vol) VALUES
('Delay','Mineur','2026-01-01',1),
('Technical issue','Majeur','2026-01-02',2),
('Weather','Mineur','2026-01-03',3),
('Late boarding','Mineur','2026-01-04',4),
('Fuel issue','Majeur','2026-01-05',5);

-- ServiceSol (référence Vol 1..5)
INSERT INTO ServiceSol (type_service, statut, id_vol) VALUES
('Nettoyage','Terminé',1),
('Carburant','Terminé',2),
('Bagages','En cours',3),
('Catering','Terminé',4),
('Maintenance','En cours',5);