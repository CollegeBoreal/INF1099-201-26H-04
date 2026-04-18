-- DQL - Modélisation SQL - DjaberBenyezza - 300146667

\c reparation_smartphones

-- Requête 1 : Liste des réparations avec client et technicien
SELECT
    r.ID_Reparation,
    c.Nom AS Client,
    t.Nom AS Technicien,
    a.Num_IMEI,
    r.Date_Depot,
    r.Statut
FROM boutique.Reparation r
JOIN boutique.Appareil a ON r.Num_IMEI = a.Num_IMEI
JOIN boutique.Client c ON a.ID_Client = c.ID_Client
JOIN boutique.Technicien t ON r.ID_Technicien = t.ID_Technicien;

-- Requête 2 : Total des paiements par mode
SELECT Mode_Paiement, SUM(Montant_Total) AS Total
FROM boutique.Paiement
GROUP BY Mode_Paiement;

-- Requête 3 : Appareils avec leur modèle et marque
SELECT a.Num_IMEI, a.Couleur, m.Nom_Modele, ma.Nom_Marque
FROM boutique.Appareil a
JOIN boutique.Modele m ON a.ID_Modele = m.ID_Modele
JOIN boutique.Marque ma ON m.ID_Marque = ma.ID_Marque;
