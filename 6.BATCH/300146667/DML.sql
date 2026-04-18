-- ============================================================
-- DML - Data Manipulation Language
-- Boutique de réparation de smartphones
-- #300150205
-- Prérequis : DDL.sql doit avoir été exécuté
-- ============================================================

-- ------------------------------------------------------------
-- INSERT — Insertion des données
-- ------------------------------------------------------------

-- Marques
INSERT INTO boutique.Marque (Nom_Marque) VALUES
    ('Apple'),
    ('Samsung'),
    ('Google');

-- Modèles
INSERT INTO boutique.Modele (Nom_Modele, Annee_Sortie, ID_Marque) VALUES
    ('iPhone 14',  2022, 1),
    ('Galaxy S23', 2023, 2),
    ('Pixel 7',    2022, 3);

-- Clients
INSERT INTO boutique.Client (Nom, Prenom, Telephone, Email) VALUES
    ('Tremblay', 'Marie', '514-111-2222', 'marie.tremblay@email.com'),
    ('Gagnon',   'Luc',   '438-333-4444', 'luc.gagnon@email.com');

-- Adresses
INSERT INTO boutique.Adresse (Numero_rue, Rue, Ville, Code_Postal, ID_Client) VALUES
    ('12', 'Rue Sainte-Catherine', 'Montréal', 'H3B 1A7', 1),
    ('5',  'Boulevard Laurier',    'Québec',   'G1V 2M2', 2);

-- Techniciens
INSERT INTO boutique.Technicien (Nom, Prenom, Specialite) VALUES
    ('Côté', 'Alex',   'Écran et batterie'),
    ('Roy',  'Sophie', 'Carte mère et logiciel');

-- Appareils
INSERT INTO boutique.Appareil (Num_IMEI, Couleur, Etat_General, ID_Modele, ID_Client) VALUES
    ('351756111111111', 'Noir',  'Écran fissuré',     1, 1),
    ('352999222222222', 'Blanc', 'Ne s''allume plus',  2, 2);

-- Pièces de rechange
INSERT INTO boutique.Piece_Rechange (Nom_Piece, Prix_Unitaire) VALUES
    ('Écran iPhone 14',     149.99),
    ('Batterie Galaxy S23',  59.99);

-- Réparations
INSERT INTO boutique.Reparation (Date_Depot, Statut, Num_IMEI, ID_Technicien) VALUES
    ('2024-03-01', 'En cours', '351756111111111', 1),
    ('2024-03-05', 'Terminée', '352999222222222', 2);

-- Lignes de réparation
INSERT INTO boutique.Ligne_Reparation (Description_Tache, Prix_MO, ID_Reparation, ID_Piece) VALUES
    ('Remplacement écran complet',         50.00, 1, 1),
    ('Remplacement batterie et nettoyage', 40.00, 2, 2);

-- Paiements
INSERT INTO boutique.Paiement (Date_Paiement, Montant_Total, Mode_Paiement, ID_Reparation) VALUES
    ('2024-03-10', 199.99, 'Carte crédit', 1),
    ('2024-03-08',  99.99, 'Comptant',     2);

-- Garanties
INSERT INTO boutique.Garantie (Date_Fin, Conditions, ID_Reparation) VALUES
    ('2024-09-10', 'Garantie 6 mois pièces et main-d''oeuvre', 1),
    ('2024-09-08', 'Garantie 6 mois sur la batterie',          2);

-- ------------------------------------------------------------
-- UPDATE — Modification des données
-- ------------------------------------------------------------

-- Mettre à jour le statut de la réparation 1
UPDATE boutique.Reparation
SET Statut = 'Terminée'
WHERE ID_Reparation = 1;

-- Mise à jour du prix d'une pièce
UPDATE boutique.Piece_Rechange
SET Prix_Unitaire = 54.99
WHERE ID_Piece = 2;

-- ------------------------------------------------------------
-- DELETE — Suppression des données
-- ------------------------------------------------------------

-- Supprimer la garantie 2
DELETE FROM boutique.Garantie
WHERE ID_Garantie = 2;
