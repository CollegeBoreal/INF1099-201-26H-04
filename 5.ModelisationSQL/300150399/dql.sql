-- Commandes détaillées

SELECT
co.id_commande,
c.nom,
c.prenom,
p.nom_produit,
e.nom_equipe,
lc.quantite,
co.total,
co.date_commande
FROM boutique.commande co
JOIN boutique.client c ON co.id_client=c.id_client
JOIN boutique.ligne_commande lc ON lc.id_commande=co.id_commande
JOIN boutique.produit p ON lc.id_produit=p.id_produit
JOIN boutique.equipe e ON p.id_equipe=e.id_equipe
ORDER BY co.date_commande;

-- Paiements détaillés

SELECT
pa.id_paiement,
pa.date_paiement,
pa.montant_paye,
mp.nom_mode,
pr.nom_prestataire,
pa.statut
FROM boutique.paiement pa
JOIN boutique.mode_paiement mp ON pa.id_mode_paiement=mp.id_mode_paiement
JOIN boutique.prestataire_paiement pr ON pa.id_prestataire=pr.id_prestataire
ORDER BY pa.date_paiement;