-- =========================================
-- Insertion des données (DML)
-- =========================================

-- Compagnie
INSERT INTO CompagnieAerienne(nom, pays, code_IATA)
VALUES ('Air Algerie', 'Algerie', 'AH');

-- Avion
INSERT INTO Avion(modele, capacite, annee_fabrication, id_compagnie)
VALUES ('Boeing 737', 180, 2015, 1);

-- Terminal
INSERT INTO Terminal(nom, capacite)
VALUES ('Terminal 1', 500);

-- Gate
INSERT INTO Gate(code_gate, id_terminal)
VALUES ('G1', 1);

-- Runway
INSERT INTO Runway(code_runway, statut)
VALUES ('R1', 'Disponible');

-- Vol
INSERT INTO Vol(numero_vol, date_depart, date_arrivee, origine, destination, id_avion, id_gate, id_runway)
VALUES ('AH100', NOW(), NOW() + INTERVAL '2 hours', 'Alger', 'Paris', 1, 1, 1);

-- Passager
INSERT INTO Passager(nom, prenom, passeport, nationalite)
VALUES ('Ali', 'Ahmed', 'AA12345', 'Algerienne');

-- Reservation
INSERT INTO Reservation(date_reservation, statut, id_passager, id_vol)
VALUES (NOW(), 'Confirmee', 1, 1);

-- Billet
INSERT INTO Billet(numero_siege, classe, id_reservation)
VALUES ('12A', 'Economique', 1);

-- Bagage
INSERT INTO Bagage(poids, type, id_passager)
VALUES (20, 'Cabine', 1);

-- Personnel
INSERT INTO Personnel(nom, prenom, role, service)
VALUES ('Karim', 'Said', 'Agent securite', 'Securite');

-- Controle Securite
INSERT INTO ControleSecurite(date_controle, statut, id_passager, id_personnel)
VALUES (NOW(), 'OK', 1, 1);

-- Maintenance
INSERT INTO Maintenance(date_intervention, type_intervention, cout, id_avion)
VALUES (NOW(), 'Verification', 1000, 1);

-- Incident
INSERT INTO Incident(description, type_incident, date_incident, id_vol)
VALUES ('Retard mineur', 'Retard', NOW(), 1);

-- ServiceSol
INSERT INTO ServiceSol(type_service, statut, id_vol)
VALUES ('Nettoyage', 'Termine', 1);