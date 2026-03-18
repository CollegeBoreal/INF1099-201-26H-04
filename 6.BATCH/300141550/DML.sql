-- CLIENT
INSERT INTO CLIENT (nom, prenom, post_nom, telephone, email, date_creation)
VALUES
('Doe', 'John', '', '123456789', 'john@email.com', CURRENT_DATE),
('Smith', 'Anna', '', '987654321', 'anna@email.com', CURRENT_DATE);

-- ADRESSE
INSERT INTO ADRESSE (id_client, numero_rue, rue, ville, province, pays, code_postal)
VALUES
(1, 123, 'Main Street', 'Toronto', 'ON', 'Canada', 'A1A1A1'),
(2, 456, 'Queen Street', 'Ottawa', 'ON', 'Canada', 'B2B2B2');

-- CATEGORIE
INSERT INTO CATEGORIE (nom_categorie)
VALUES ('Africain'), ('Asiatique');

-- PAYS_ORIGINE
INSERT INTO PAYS_ORIGINE (nom_pays)
VALUES ('Congo'), ('Japon');

-- PLAT
INSERT INTO PLAT (id_categorie, id_pays, nom_plat, description, prix, statut)
VALUES
(1, 1, 'Poulet Moambe', 'Plat africain', 15.99, 'Disponible'),
(2, 2, 'Sushi', 'Plat japonais', 12.50, 'Disponible');

-- COMMANDE
INSERT INTO COMMANDE (id_client, id_adresse, date_commande, statut_commande, total_commande)
VALUES
(1, 1, CURRENT_DATE, 'En cours', 28.49);

-- LIGNE_COMMANDE
INSERT INTO LIGNE_COMMANDE
VALUES
(1, 1, 1, 15.99),
(1, 2, 1, 12.50);

-- PAIEMENT
INSERT INTO PAIEMENT (id_commande, date_paiement, montant, mode_paiement, statut_paiement)
VALUES
(1, CURRENT_DATE, 28.49, 'Carte', 'Payé');

-- LIVREUR
INSERT INTO LIVREUR (nom, prenom, post_nom, telephone, email)
VALUES
('Mike', 'Jordan', '', '5555555', 'livreur@email.com');

-- LIVRAISON
INSERT INTO LIVRAISON (id_commande, id_livreur, date_livraison, statut_livraison, frais_livraison)
VALUES
(1, 1, CURRENT_DATE, 'Livré', 5.00);
