SELECT * FROM exchange.client;

SELECT 
    t.id_transaction,
    c.nom,
    c.prenom,
    ds.code_devise AS devise_source,
    dc.code_devise AS devise_cible,
    t.montant_initial,
    t.montant_converti,
    t.statut
FROM exchange.transaction t
JOIN exchange.client c ON t.id_client = c.id_client
JOIN exchange.devise ds ON t.id_devise_source = ds.id_devise
JOIN exchange.devise dc ON t.id_devise_cible = dc.id_devise
ORDER BY t.id_transaction;

SELECT 
    p.id_paiement,
    mp.nom_mode,
    pp.nom_prestataire,
    p.montant_paye
FROM exchange.paiement p
JOIN exchange.mode_paiement mp ON p.id_mode_paiement = mp.id_mode_paiement
JOIN exchange.prestataire_paiement pp ON p.id_prestataire = pp.id_prestataire
ORDER BY p.id_paiement;