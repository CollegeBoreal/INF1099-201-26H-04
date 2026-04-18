-- DML - Modélisation SQL - DjaberBenyezza - 300146667

\c reparation_smartphones

-- Étape 4 : Insérer des données (INSERT)
INSERT INTO boutique.Marque (Nom_Marque) VALUES ('Apple'), ('Samsung'), ('Google');

INSERT INTO boutique.Modele (Nom_Modele, Annee_Sortie, ID_Marque) VALUES
    ('iPhone 14', 2022, 1),
    ('Galaxy S23', 2023, 2),
    ('Pixel 7', 2022, 3);

INSERT INTO boutique.Client (Nom, Prenom, Telephone, Email) VALUES
    ('Tremblay', 'Marie', '514-111-2222', 'marie.tremblay@email.com'),
    ('Gagnon', 'Luc', '438-333-4444', 'luc.gagnon@email.com');

INSERT INTO boutique.Adresse (Numero_rue, Rue, Ville, Code_Postal, ID_Client) VALUES
    ('12', 'Rue Sainte-Catherine', 'Montreal', 'H3B 1A7', 1),
    ('5', 'Boulevard Laurier', 'Quebec', 'G1V 2M2', 2);

INSERT INTO boutique.Technicien (Nom, Prenom, Specialite) VALUES
    ('Cote', 'Alex', 'Ecran et batterie'),
    ('Roy', 'Sophie', 'Carte mere et logiciel');

INSERT INTO boutique.Appareil (Num_IMEI, Couleur, Etat_General, ID_Modele, ID_Client) VALUES
    ('351756111111111', 'Noir', 'Ecran fissure', 1, 1),
    ('352999222222222', 'Blanc', 'Ne s allume plus', 2, 2);

INSERT INTO boutique.Piece_Rechange (Nom_Piece, Prix_Unitaire) VALUES
    ('Ecran iPhone 14', 149.99),
    ('Batterie Galaxy S23', 59.99);

INSERT INTO boutique.Reparation (Date_Depot, Statut, Num_IMEI, ID_Technicien) VALUES
    ('2024-03-01', 'En cours', '351756111111111', 1),
    ('2024-03-05', 'Terminee', '352999222222222', 2);

INSERT INTO boutique.Ligne_Reparation (Description_Tache, Prix_MO, ID_Reparation, ID_Piece) VALUES
    ('Remplacement ecran complet', 50.00, 1, 1),
    ('Remplacement batterie et nettoyage', 40.00, 2, 2);

INSERT INTO boutique.Paiement (Date_Paiement, Montant_Total, Mode_Paiement, ID_Reparation) VALUES
    ('2024-03-10', 199.99, 'Carte credit', 1),
    ('2024-03-08', 99.99, 'Comptant', 2);

INSERT INTO boutique.Garantie (Date_Fin, Conditions, ID_Reparation) VALUES
    ('2024-09-10', 'Garantie 6 mois pieces et main-oeuvre', 1),
    ('2024-09-08', 'Garantie 6 mois sur la batterie', 2);

-- Étape 5 : Lire les données (SELECT)
SELECT
    r.ID_Reparation,
    c.Nom        AS Client,
    t.Nom        AS Technicien,
    a.Num_IMEI,
    r.Date_Depot,
    r.Statut
FROM boutique.Reparation r
JOIN boutique.Appareil   a ON r.Num_IMEI      = a.Num_IMEI
JOIN boutique.Client     c ON a.ID_Client     = c.ID_Client
JOIN boutique.Technicien t ON r.ID_Technicien = t.ID_Technicien;

-- Étape 6 : Modifier des données (UPDATE)
UPDATE boutique.Reparation
SET Statut = 'Terminee'
WHERE ID_Reparation = 1;

SELECT ID_Reparation, Statut FROM boutique.Reparation;

-- Étape 7 : Supprimer des données (DELETE)
DELETE FROM boutique.Garantie WHERE ID_Garantie = 2;

SELECT * FROM boutique.Garantie;
