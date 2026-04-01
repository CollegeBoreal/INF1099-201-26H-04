-- ADRESSE
INSERT INTO ADRESSE (rue, ville, province, code_postal, pays) VALUES
('123 Rue A', 'Montreal', 'QC', 'H1A1A1', 'Canada'),
('456 Rue B', 'Toronto', 'ON', 'M1B1B1', 'Canada'),
('789 Rue C', 'Laval', 'QC', 'H7A2B2', 'Canada'),
('321 Rue D', 'Quebec', 'QC', 'G1A3C3', 'Canada'),
('654 Rue E', 'Ottawa', 'ON', 'K1A4D4', 'Canada');

-- CLIENT
INSERT INTO CLIENT (nom, prenom, telephone, email, id_adresse) VALUES
('Dupont', 'Jean', '1111111111', 'jean@email.com', 1),
('Martin', 'Sophie', '2222222222', 'sophie@email.com', 2),
('Tremblay', 'Marc', '3333333333', 'marc@email.com', 3),
('Gagnon', 'Julie', '4444444444', 'julie@email.com', 4),
('Roy', 'Alex', '5555555555', 'alex@email.com', 5);

-- LABORATOIRE
INSERT INTO LABORATOIRE (nom_labo, telephone, email, id_adresse) VALUES
('LaboTech', '1111111111', 'l1@lab.com', 1),
('BioTest', '2222222222', 'l2@lab.com', 2),
('FoodSafe', '3333333333', 'l3@lab.com', 3),
('AnalysePro', '4444444444', 'l4@lab.com', 4),
('NutriLab', '5555555555', 'l5@lab.com', 5);

-- ANALYSTE
INSERT INTO ANALYSTE (nom, prenom, specialite, email, id_laboratoire) VALUES
('Smith', 'Alice', 'Microbio', 'a1@lab.com', 1),
('Brown', 'Bob', 'Chimie', 'a2@lab.com', 2),
('Lee', 'Chris', 'Toxicologie', 'a3@lab.com', 3),
('Khan', 'Sara', 'Qualité', 'a4@lab.com', 4),
('Nguyen', 'Tom', 'Nutrition', 'a5@lab.com', 5);

-- PRODUIT
INSERT INTO PRODUIT_ALIMENTAIRE (nom_produit, categorie, marque) VALUES
('Lait', 'Laitier', 'Agropur'),
('Fromage', 'Laitier', 'Saputo'),
('Jus', 'Boisson', 'Tropicana'),
('Pain', 'Boulangerie', 'Premiere'),
('Yaourt', 'Laitier', 'Danone');

-- LOT
INSERT INTO LOT (code_lot, date_fabrication, date_expiration, id_produit) VALUES
('LOT1', '2025-01-01', '2025-06-01', 1),
('LOT2', '2025-01-02', '2025-06-02', 2),
('LOT3', '2025-01-03', '2025-06-03', 3),
('LOT4', '2025-01-04', '2025-06-04', 4),
('LOT5', '2025-01-05', '2025-06-05', 5);

-- ECHANTILLON
INSERT INTO ECHANTILLON (code_echantillon, date_prelevement, quantite, id_lot) VALUES
('ECH1', '2025-02-01', 10, 1),
('ECH2', '2025-02-02', 12, 2),
('ECH3', '2025-02-03', 8, 3),
('ECH4', '2025-02-04', 15, 4),
('ECH5', '2025-02-05', 9, 5);

-- TYPE ANALYSE
INSERT INTO TYPE_ANALYSE (nom_analyse, methode, duree) VALUES
('Bactérie', 'Culture', 48),
('Chimique', 'Spectro', 24),
('Toxine', 'ELISA', 36),
('Qualité', 'Visuel', 12),
('Nutrition', 'Analyse', 20);

-- ANALYSE
INSERT INTO ANALYSE_LAB (date_analyse, statut_analyse, id_client, id_echantillon, id_type_analyse, id_analyste) VALUES
('2025-02-10', 'Terminée', 1, 1, 1, 1),
('2025-02-11', 'En cours', 2, 2, 2, 2),
('2025-02-12', 'Terminée', 3, 3, 3, 3),
('2025-02-13', 'En attente', 4, 4, 4, 4),
('2025-02-14', 'Terminée', 5, 5, 5, 5);

-- RESULTAT
INSERT INTO RESULTAT_ANALYSE (valeur_mesuree, unite, commentaire, id_analyse) VALUES
(5.5, 'CFU', 'OK', 1),
(7.2, 'mg', 'Bon', 2),
(3.1, 'ppm', 'Acceptable', 3),
(9.8, 'CFU', 'Limite', 4),
(2.5, 'mg', 'OK', 5);

-- NORME
INSERT INTO NORME (code_norme, description, seuil_min, seuil_max) VALUES
('N1', 'Norme 1', 0, 10),
('N2', 'Norme 2', 1, 8),
('N3', 'Norme 3', 0, 5),
('N4', 'Norme 4', 2, 12),
('N5', 'Norme 5', 1, 9);

-- CONFORMITE
INSERT INTO CONFORMITE (statut_conformite, observation, id_resultat, id_norme) VALUES
('Conforme', 'OK', 1, 1),
('Conforme', 'OK', 2, 2),
('Non conforme', 'Trop élevé', 3, 3),
('Conforme', 'OK', 4, 4),
('Conforme', 'OK', 5, 5);

-- RAPPORT
INSERT INTO RAPPORT (date_rapport, conclusion, id_analyse) VALUES
('2025-02-15', 'OK', 1),
('2025-02-16', 'OK', 2),
('2025-02-17', 'Non conforme', 3),
('2025-02-18', 'OK', 4),
('2025-02-19', 'OK', 5);

-- FACTURE
INSERT INTO FACTURE (num_facture, date_facture, montant, id_client) VALUES
('F1', '2025-03-01', 100, 1),
('F2', '2025-03-02', 150, 2),
('F3', '2025-03-03', 200, 3),
('F4', '2025-03-04', 120, 4),
('F5', '2025-03-05', 180, 5);

-- PAIEMENT
INSERT INTO PAIEMENT (mode_paiement, date_paiement, statut, id_facture) VALUES
('Carte', '2025-03-06', 'Payé', 1),
('Cash', '2025-03-07', 'Payé', 2),
('Carte', '2025-03-08', 'En attente', 3),
('Virement', '2025-03-09', 'Payé', 4),
('Carte', '2025-03-10', 'Payé', 5);
