-- CLIENT
INSERT INTO CLIENT (Nom, Prénom, PostNom, Téléphone, Email, Mot_de_passe)
VALUES ('Ekofo', 'Corneil', 'Wema', '437-518-8443', 'corneilekofo003@gmail.com', 'motdepasse123');

-- ADRESSE
INSERT INTO ADRESSE (ID_Client, Numéro_rue, Rue, Ville, Province, Pays, Code_postal, Type_adresse)
VALUES (1, 123, 'Rue Principale', 'Toronto', 'Ontario', 'Canada', 'M4B1B3', 'Résidence');

-- CATEGORIE_MAILLOT
INSERT INTO CATEGORIE_MAILLOT (Nom_catégorie, Description)
VALUES ('Maillot Football', 'Maillot officiel pour football');

-- MAILLOT
INSERT INTO MAILLOT (ID_Categorie, ID_Pays_origine, Nom_maillot, Description, Prix, Statut, Taille, Couleur, Marque, Saison)
VALUES (1, 1, 'Maillot FC Toronto', 'Maillot officiel FC Toronto 2026', 129.99, 'Disponible', 'M', 'Rouge', 'Adidas', '2026');

-- COMMANDE
INSERT INTO COMMANDE (ID_Client, ID_Adresse_livraison, Date_commande, Statut_commande, Total_commande)
VALUES (1, 1, CURRENT_DATE, 'En cours', 129.99);

-- LIGNE_COMMANDE
INSERT INTO LIGNE_COMMANDE (ID_Commande, ID_Maillot, Quantité, Prix_unitaire, Total_ligne)
VALUES (1, 1, 1, 129.99, 129.99);

-- PAIEMENT
INSERT INTO PAIEMENT (ID_Commande, Date_paiement, Montant, Mode_paiement, Statut_paiement, Référence_paiement)
VALUES (1, CURRENT_DATE, 129.99, 'Carte de crédit', 'Validé', 'PAY12345');

-- LIVREUR
INSERT INTO LIVREUR (Nom, Prénom, PostNom, Téléphone, Email, Statut_livreur)
VALUES ('Dupont', 'Jean', '', '416-555-1234', 'dupont@example.com', 'Disponible');

-- LIVRAISON
INSERT INTO LIVRAISON (ID_Commande, ID_Livreur, Date_livraison, Statut_livraison, Frais_livraison, Date_expédition, Numéro_suivi)
VALUES (1, 1, CURRENT_DATE + INTERVAL '2 days', 'En préparation', 15.00, CURRENT_DATE, 'TRK123456');