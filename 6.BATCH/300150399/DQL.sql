SELECT * FROM boutique.equipe;

SELECT * FROM boutique.client;

SELECT
c.nom,
c.prenom,
p.nom_produit,
e.nom_equipe
FROM boutique.client c
JOIN boutique.commande co ON co.id_client = c.id_client
JOIN boutique.ligne_commande lc ON lc.id_commande = co.id_commande
JOIN boutique.produit p ON p.id_produit = lc.id_produit
JOIN boutique.equipe e ON e.id_equipe = p.id_equipe;