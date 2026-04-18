-- ============================================================
-- DQL - Data Query Language
-- Boutique de réparation de smartphones
-- #300150205
-- Prérequis : DDL.sql et DML.sql doivent avoir été exécutés
-- ============================================================

-- ------------------------------------------------------------
-- Requête 1 : Liste simple de toutes les marques
-- ------------------------------------------------------------
SELECT * FROM boutique.Marque;

-- ------------------------------------------------------------
-- Requête 2 : Liste des réparations avec client et technicien
-- ------------------------------------------------------------
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

-- ------------------------------------------------------------
-- Requête 3 : Détail complet d'une réparation (pièces + MO)
-- ------------------------------------------------------------
SELECT
    r.ID_Reparation,
    c.Nom                   AS Client,
    p.Nom_Piece,
    p.Prix_Unitaire,
    lr.Prix_MO,
    (p.Prix_Unitaire + lr.Prix_MO) AS Total_Ligne
FROM boutique.Ligne_Reparation lr
JOIN boutique.Reparation   r  ON lr.ID_Reparation = r.ID_Reparation
JOIN boutique.Appareil     a  ON r.Num_IMEI        = a.Num_IMEI
JOIN boutique.Client       c  ON a.ID_Client       = c.ID_Client
JOIN boutique.Piece_Rechange p ON lr.ID_Piece      = p.ID_Piece;

-- ------------------------------------------------------------
-- Requête 4 : Réparations filtrées par statut
-- ------------------------------------------------------------
SELECT
    r.ID_Reparation,
    c.Nom AS Client,
    r.Date_Depot,
    r.Statut
FROM boutique.Reparation r
JOIN boutique.Appareil a ON r.Num_IMEI  = a.Num_IMEI
JOIN boutique.Client   c ON a.ID_Client = c.ID_Client
WHERE r.Statut = 'Terminée';

-- ------------------------------------------------------------
-- Requête 5 : Total payé par client
-- ------------------------------------------------------------
SELECT
    c.Nom        AS Client,
    c.Prenom,
    SUM(p.Montant_Total) AS Total_Paye
FROM boutique.Paiement p
JOIN boutique.Reparation r ON p.ID_Reparation = r.ID_Reparation
JOIN boutique.Appareil   a ON r.Num_IMEI       = a.Num_IMEI
JOIN boutique.Client     c ON a.ID_Client      = c.ID_Client
GROUP BY c.ID_Client, c.Nom, c.Prenom
ORDER BY Total_Paye DESC;

-- ------------------------------------------------------------
-- Requête 6 : Appareils avec leur modèle et marque
-- ------------------------------------------------------------
SELECT
    a.Num_IMEI,
    a.Couleur,
    a.Etat_General,
    mo.Nom_Modele,
    ma.Nom_Marque
FROM boutique.Appareil a
JOIN boutique.Modele mo ON a.ID_Modele  = mo.ID_Modele
JOIN boutique.Marque ma ON mo.ID_Marque = ma.ID_Marque;
