-- DML.sql
-- Auteure : Rabia BOUHALI | Matricule : 300151469
-- Insertion des données TCF Canada

INSERT INTO candidat (nom, prenom, email, telephone) VALUES
('Bouhali',  'Rabia', 'rabia.bouhali@email.com', '6471111111'),
('Ali',      'Sami',  'sami.ali@email.com',      '6472222222'),
('Ben',      'Nora',  'nora.ben@email.com',       '6473333333');

INSERT INTO lieu (nom_lieu, adresse) VALUES
('Centre TCF Toronto',  '123 Rue Bloor, Toronto'),
('Centre TCF Ottawa',   '456 Avenue King, Ottawa'),
('Centre TCF Montreal', '789 Boulevard Rene-Levesque, Montreal');

INSERT INTO session (date_session, heure_session, type_test, id_lieu) VALUES
('2026-04-15', '09:00:00', 'TCF Canada', 1),
('2026-04-18', '13:30:00', 'TCF Canada', 2),
('2026-04-22', '10:15:00', 'TCF Canada', 3);

INSERT INTO rendezvous (id_candidat, id_session, statut) VALUES
(1, 1, 'Confirme'),
(2, 2, 'En attente'),
(3, 3, 'Confirme');

INSERT INTO paiement (montant, mode_paiement, date_paiement, id_rendezvous) VALUES
(150.00, 'Carte bancaire', '2026-04-10', 1),
(150.00, 'Virement',       '2026-04-12', 2),
(150.00, 'Especes',        '2026-04-14', 3);
