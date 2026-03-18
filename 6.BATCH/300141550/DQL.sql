-- Tous les clients
SELECT * FROM CLIENT;

-- Commandes avec client
SELECT c.nom, co.id_commande, co.total_commande
FROM CLIENT c
JOIN COMMANDE co ON c.id_client = co.id_client;

-- Détails commande
SELECT co.id_commande, p.nom_plat, lc.quantite
FROM LIGNE_COMMANDE lc
JOIN PLAT p ON lc.id_plat = p.id_plat
JOIN COMMANDE co ON lc.id_commande = co.id_commande;

-- Livraison
SELECT l.id_livraison, li.nom, l.statut_livraison
FROM LIVRAISON l
JOIN LIVREUR li ON l.id_livreur = li.id_livreur;
