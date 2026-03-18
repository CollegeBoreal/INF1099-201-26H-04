INSERT INTO CLIENT (nom, prenom, email, telephone, date_creation)
VALUES ('Santu', 'Emeraude', 'emeraude@email.com', '123456789', CURRENT_DATE);

INSERT INTO CATEGORIE (nom_categorie)
VALUES ('Africain'), ('Italien');

INSERT INTO PAYS_ORIGINE (nom_pays)
VALUES ('Congo'), ('Italie');

INSERT INTO PLAT (id_categorie, id_pays, nom_plat, prix, statut)
VALUES (1, 1, 'Poulet braisé', 15.99, 'disponible');

INSERT INTO ADRESSE (id_client, numero_rue, rue, ville, province, pays, code_postal)
VALUES (1, '123', 'Main Street', 'Toronto', 'Ontario', 'Canada', 'M1A1A1');

INSERT INTO COMMANDE (id_client, id_adresse, date_commande, statut_commande, total_commande)
VALUES (1, 1, CURRENT_DATE, 'en cours', 15.99);

INSERT INTO LIGNE_COMMANDE (id_commande, id_plat, quantite, prix_unitaire)
VALUES (1, 1, 1, 15.99);

INSERT INTO PAIEMENT (id_commande, date_paiement, montant, mode_paiement, statut_paiement)
VALUES (1, CURRENT_DATE, 15.99, 'carte', 'payé');
