SELECT * FROM vehicule;

SELECT t.id_transit, v.marque, v.modele, u.nom, u.prenom
FROM transit t
JOIN vehicule v ON t.id_vehicule = v.id_vehicule
JOIN acheteur a ON t.id_acheteur = a.id_acheteur
JOIN utilisateur u ON a.id_utilisateur = u.id_utilisateur;

SELECT *
FROM paiement
WHERE statut_paiement = 'Payé'; 

SELECT p.nom_port, pa.nom_pays
FROM port p
JOIN pays pa ON p.id_pays = pa.id_pays;
