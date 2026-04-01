-- 1. Liste des clients
SELECT * FROM CLIENT;

-- 2. Analyses avec client + analyste
SELECT 
    a.id_analyse,
    c.nom AS client,
    an.nom AS analyste,
    a.statut_analyse
FROM ANALYSE_LAB a
JOIN CLIENT c ON a.id_client = c.id_client
JOIN ANALYSTE an ON a.id_analyste = an.id_analyste;

-- 3. Résultats avec normes et conformité
SELECT 
    r.id_resultat,
    r.valeur_mesuree,
    n.code_norme,
    c.statut_conformite
FROM RESULTAT_ANALYSE r
JOIN CONFORMITE c ON r.id_resultat = c.id_resultat
JOIN NORME n ON c.id_norme = n.id_norme;

-- 4. Produits et leurs lots
SELECT 
    p.nom_produit,
    l.code_lot
FROM PRODUIT_ALIMENTAIRE p
JOIN LOT l ON p.id_produit = l.id_produit;

-- 5. Factures avec paiements
SELECT 
    f.num_facture,
    f.montant,
    p.mode_paiement,
    p.statut
FROM FACTURE f
JOIN PAIEMENT p ON f.id_facture = p.id_facture;

-- 6. Nombre d’analyses par client
SELECT 
    c.nom,
    COUNT(a.id_analyse) AS nb_analyses
FROM CLIENT c
LEFT JOIN ANALYSE_LAB a ON c.id_client = a.id_client
GROUP BY c.nom;

-- 7. Analyses non conformes
SELECT 
    a.id_analyse,
    c.statut_conformite
FROM ANALYSE_LAB a
JOIN RESULTAT_ANALYSE r ON a.id_analyse = r.id_analyse
JOIN CONFORMITE c ON r.id_resultat = c.id_resultat
WHERE c.statut_conformite = 'Non conforme';

-- 8. Analyses avec détails complets
SELECT 
    cl.nom AS client,
    pr.nom_produit,
    t.nom_analyse,
    r.valeur_mesuree
FROM ANALYSE_LAB a
JOIN CLIENT cl ON a.id_client = cl.id_client
JOIN ECHANTILLON e ON a.id_echantillon = e.id_echantillon
JOIN LOT l ON e.id_lot = l.id_lot
JOIN PRODUIT_ALIMENTAIRE pr ON l.id_produit = pr.id_produit
JOIN TYPE_ANALYSE t ON a.id_type_analyse = t.id_type_analyse
JOIN RESULTAT_ANALYSE r ON a.id_analyse = r.id_analyse;

-- 9. Total facturé par client
SELECT 
    c.nom,
    SUM(f.montant) AS total
FROM CLIENT c
JOIN FACTURE f ON c.id_client = f.id_client
GROUP BY c.nom;

-- 10. Analyses par laboratoire
SELECT 
    l.nom_labo,
    COUNT(a.id_analyse) AS total_analyses
FROM LABORATOIRE l
JOIN ANALYSTE an ON l.id_laboratoire = an.id_laboratoire
JOIN ANALYSE_LAB a ON an.id_analyste = a.id_analyste
GROUP BY l.nom_labo;
