-- Lister toutes les commandes d'un client
SELECT c.Nom, c.Prénom, co.ID_Commande, co.Date_commande, co.Total_commande
FROM CLIENT c
JOIN COMMANDE co ON c.ID_Client = co.ID_Client
WHERE c.ID_Client = 1;

-- Détails d'une commande avec lignes, maillots et paiement
SELECT co.ID_Commande, lc.ID_Ligne, m.Nom_maillot, lc.Quantité, lc.Total_ligne, p.Montant, p.Mode_paiement
FROM COMMANDE co
JOIN LIGNE_COMMANDE lc ON co.ID_Commande = lc.ID_Commande
JOIN MAILLOT m ON lc.ID_Maillot = m.ID_Maillot
LEFT JOIN PAIEMENT p ON co.ID_Commande = p.ID_Commande
WHERE co.ID_Commande = 1;

-- Lister les livraisons d'un livreur
SELECT l.ID_Livraison, co.ID_Commande, l.Date_livraison, l.Statut_livraison
FROM LIVRAISON l
JOIN COMMANDE co ON l.ID_Commande = co.ID_Commande
WHERE l.ID_Livreur = 1;