-- Liste des clients
SELECT * FROM CLIENT;

-- Commandes avec client
SELECT c.nom, c.prenom, co.id_commande, co.total_commande
FROM CLIENT c
JOIN COMMANDE co ON c.id_client = co.id_client;

-- Détails des commandes
SELECT co.id_commande, p.nom_plat, lc.quantite
FROM COMMANDE co
JOIN LIGNE_COMMANDE lc ON co.id_commande = lc.id_commande
JOIN PLAT p ON lc.id_plat = p.id_plat;

-- Commandes payées
SELECT * FROM PAIEMENT
WHERE statut_paiement = 'payé';
