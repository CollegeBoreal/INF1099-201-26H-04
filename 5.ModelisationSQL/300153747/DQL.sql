SELECT * FROM VEHICULE;
SELECT T.ID_Transit, V.Marque, V.Modele, U.Nom, U.Prenom
FROM TRANSIT T
JOIN VEHICULE V ON T.ID_Vehicule = V.ID_Vehicule
JOIN ACHETEUR A ON T.ID_Acheteur = A.ID_Acheteur
JOIN UTILISATEUR U ON A.ID_Utilisateur = U.ID_Utilisateur;
SELECT *
FROM PAIEMENT
WHERE Statut_paiement = 'Payé'
SELECT P.Nom_port, PA.Nom_pays
FROM PORT P
JOIN PAYS PA ON P.ID_Pays = PA.ID_Pays;
