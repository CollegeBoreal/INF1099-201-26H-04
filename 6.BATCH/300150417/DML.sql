INSERT INTO exchange.client (id_client, nom, prenom, telephone, email) VALUES
(1,'Rahmani','Chakib','6471112222','chakib@gmail.com'),
(2,'Benali','Sofiane','6473334444','sofiane@gmail.com'),
(3,'Dupont','Marie','4165556666','marie.dupont@gmail.com'),
(4,'Martin','Paul','4377778888','paul.martin@gmail.com'),
(5,'Haddad','Yasmine','9059990000','yasmine@gmail.com'),
(6,'Khelifi','Amine','6471234567','amine@gmail.com'),
(7,'Bouraoui','Akrem','6472223333','akrem@gmail.com'),
(8,'Nathalie','Robert','4168889999','nathalie@gmail.com'),
(9,'Mahfuzur','Rahman','9054445555','mahfuzur@gmail.com'),
(10,'Kero','Slimani','6475556666','kero@gmail.com');

INSERT INTO exchange.adresse (id_adresse, numero_rue, rue, ville, code_postal, pays, id_client) VALUES
(1,'12','Rue King','Toronto','M5V 1A1','Canada',1),
(2,'45','Rue Queen','Toronto','M4B 2B2','Canada',2),
(3,'88','Rue Bloor','Toronto','M3C 3C3','Canada',3),
(4,'101','Rue Yonge','Toronto','M2D 4D4','Canada',4),
(5,'22','Rue Front','Toronto','M1E 5E5','Canada',5),
(6,'17','Rue Lakeshore','Toronto','M6F 6F6','Canada',6),
(7,'9','Rue Danforth','Toronto','M7G 7G7','Canada',7),
(8,'63','Rue Bay','Toronto','M8H 8H8','Canada',8),
(9,'74','Rue Spadina','Toronto','M9J 9J9','Canada',9),
(10,'99','Rue Dundas','Toronto','M5K 0K0','Canada',10);

INSERT INTO exchange.compte_client (id_compte, date_creation, statut, id_client) VALUES
(1,'2026-01-01','ACTIF',1),
(2,'2026-01-02','ACTIF',2),
(3,'2026-01-03','ACTIF',3),
(4,'2026-01-04','SUSPENDU',4),
(5,'2026-01-05','ACTIF',5),
(6,'2026-01-06','ACTIF',6),
(7,'2026-01-07','ACTIF',7),
(8,'2026-01-08','ACTIF',8),
(9,'2026-01-09','INACTIF',9),
(10,'2026-01-10','ACTIF',10);

INSERT INTO exchange.devise (id_devise, code_devise, nom_devise, symbole) VALUES
(1,'CAD','Dollar Canadien','$'),
(2,'USD','Dollar Americain','$'),
(3,'EUR','Euro','€'),
(4,'GBP','Livre Sterling','£'),
(5,'JPY','Yen Japonais','¥'),
(6,'CHF','Franc Suisse','CHF'),
(7,'DZD','Dinar Algerien','DA'),
(8,'CNY','Yuan Chinois','¥'),
(9,'AUD','Dollar Australien','$'),
(10,'MAD','Dirham Marocain','DH');

INSERT INTO exchange.mode_paiement (id_mode_paiement, nom_mode) VALUES
(1,'Carte bancaire'),
(2,'Virement bancaire'),
(3,'PayPal'),
(4,'Crypto'),
(5,'Apple Pay'),
(6,'Google Pay'),
(7,'Interac'),
(8,'Especes'),
(9,'Cheque'),
(10,'Carte prepayee');

INSERT INTO exchange.prestataire_paiement (id_prestataire, nom_prestataire, type_service) VALUES
(1,'Stripe','Paiement en ligne'),
(2,'PayPal','Paiement en ligne'),
(3,'Moneris','Paiement bancaire'),
(4,'Square','Paiement mobile'),
(5,'Interac','Transfert'),
(6,'Visa','Carte bancaire'),
(7,'Mastercard','Carte bancaire'),
(8,'Wise','Transfert international'),
(9,'Revolut','Banque digitale'),
(10,'Western Union','Transfert international');

INSERT INTO exchange.taux_change (id_taux, valeur_taux, date_mise_a_jour, id_devise_source, id_devise_cible) VALUES
(1,0.740000,'2026-02-18 17:57:42',1,2),
(2,0.680000,'2026-02-18 17:57:42',1,3),
(3,1.470000,'2026-02-18 17:57:42',2,1),
(4,0.920000,'2026-02-18 17:57:42',2,3),
(5,160.500000,'2026-02-18 17:57:42',2,5),
(6,1.080000,'2026-02-18 17:57:42',3,2),
(7,1.600000,'2026-02-18 17:57:42',3,4),
(8,0.007200,'2026-02-18 17:57:42',7,2),
(9,0.140000,'2026-02-18 17:57:42',10,3),
(10,0.660000,'2026-02-18 17:57:42',9,2);

INSERT INTO exchange.transaction (id_transaction, date_transaction, montant_initial, montant_converti, statut, id_client, id_devise_source, id_devise_cible, id_taux) VALUES
(1,'2026-02-01 10:00:00',1000.00,740.00,'PAYEE',1,1,2,1),
(2,'2026-02-01 11:00:00',2000.00,1360.00,'PAYEE',2,1,3,2),
(3,'2026-02-02 09:30:00',500.00,735.00,'PAYEE',3,2,1,3),
(4,'2026-02-02 15:00:00',1000.00,920.00,'EN_ATTENTE',4,2,3,4),
(5,'2026-02-03 08:20:00',300.00,48150.00,'PAYEE',5,2,5,5),
(6,'2026-02-03 12:00:00',700.00,756.00,'PAYEE',6,3,2,6),
(7,'2026-02-04 14:10:00',600.00,960.00,'ANNULEE',7,3,4,7),
(8,'2026-02-04 16:00:00',10000.00,72.00,'PAYEE',8,7,2,8),
(9,'2026-02-05 10:45:00',1500.00,210.00,'PAYEE',9,10,3,9),
(10,'2026-02-05 18:30:00',800.00,528.00,'PAYEE',10,9,2,10);

INSERT INTO exchange.paiement (id_paiement, date_paiement, montant_paye, id_transaction, id_mode_paiement, id_prestataire) VALUES
(1,'2026-02-01 10:05:00',1000.00,1,1,1),
(2,'2026-02-01 11:05:00',2000.00,2,3,2),
(3,'2026-02-02 09:35:00',500.00,3,2,8),
(4,'2026-02-02 15:05:00',1000.00,4,1,6),
(5,'2026-02-03 08:25:00',300.00,5,5,4),
(6,'2026-02-03 12:05:00',700.00,6,4,9),
(7,'2026-02-04 14:15:00',600.00,7,7,5),
(8,'2026-02-04 16:05:00',10000.00,8,2,10),
(9,'2026-02-05 10:50:00',1500.00,9,6,3),
(10,'2026-02-05 18:35:00',800.00,10,9,7);

INSERT INTO exchange.historique_transaction (id_historique, date_action, action, id_transaction) VALUES
(1,'2026-02-01 10:00:00','Transaction creee',1),
(2,'2026-02-01 10:05:00','Paiement effectue',1),
(3,'2026-02-01 11:00:00','Transaction creee',2),
(4,'2026-02-01 11:05:00','Paiement effectue',2),
(5,'2026-02-02 09:30:00','Transaction creee',3),
(6,'2026-02-02 09:35:00','Paiement effectue',3),
(7,'2026-02-02 15:00:00','Transaction creee',4),
(8,'2026-02-03 08:20:00','Transaction creee',5),
(9,'2026-02-04 14:10:00','Transaction annulee',7),
(10,'2026-02-05 18:30:00','Transaction validee',10);

SELECT setval(pg_get_serial_sequence('exchange.client','id_client'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.adresse','id_adresse'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.compte_client','id_compte'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.devise','id_devise'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.mode_paiement','id_mode_paiement'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.prestataire_paiement','id_prestataire'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.taux_change','id_taux'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.transaction','id_transaction'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.paiement','id_paiement'), 10, true);
SELECT setval(pg_get_serial_sequence('exchange.historique_transaction','id_historique'), 10, true);