-- ============================================================
-- DQL.sql — Requêtes de consultation (SELECT)
-- Projet : Gestion de la vente de crampons ⚽👟
-- ============================================================

-- ============================================================
-- 1. Liste complète des clients
-- ============================================================
SELECT
    id_client,
    nom,
    prenom,
    email,
    telephone,
    date_inscription
FROM Client
ORDER BY nom, prenom;

-- ============================================================
-- 2. Catalogue complet : crampons avec marque, catégorie et stock
-- ============================================================
SELECT
    m.nom            AS marque,
    c.modele,
    cat.libelle      AS surface,
    c.pointure,
    c.couleur,
    c.prix,
    s.quantite_disponible,
    CASE
        WHEN s.quantite_disponible = 0            THEN 'RUPTURE'
        WHEN s.quantite_disponible <= s.seuil_alerte THEN 'ALERTE'
        ELSE 'OK'
    END              AS etat_stock
FROM Crampon c
JOIN Marque    m   ON c.id_marque    = m.id_marque
JOIN Categorie cat ON c.id_categorie = cat.id_categorie
JOIN Stock     s   ON c.id_crampon   = s.id_crampon
ORDER BY s.quantite_disponible ASC;

-- ============================================================
-- 3. Toutes les commandes avec le nom du client et son adresse
-- ============================================================
SELECT
    co.id_commande,
    cl.nom,
    cl.prenom,
    co.date_commande,
    co.statut,
    co.montant_total,
    a.ville          AS ville_livraison
FROM Commande co
JOIN Client  cl ON co.id_client  = cl.id_client
LEFT JOIN Adresse a  ON co.id_adresse = a.id_adresse
ORDER BY co.date_commande DESC;

-- ============================================================
-- 4. Détail complet d'une commande (exemple : commande #1)
-- ============================================================
SELECT
    co.id_commande,
    cl.nom              AS client_nom,
    cl.prenom           AS client_prenom,
    m.nom               AS marque,
    c.modele,
    c.pointure,
    lc.quantite,
    lc.prix_unitaire,
    (lc.quantite * lc.prix_unitaire) AS sous_total
FROM Commande co
JOIN Client       cl  ON co.id_client   = cl.id_client
JOIN LigneCommande lc ON co.id_commande = lc.id_commande
JOIN Crampon      c   ON lc.id_crampon  = c.id_crampon
JOIN Marque       m   ON c.id_marque    = m.id_marque
WHERE co.id_commande = 1;

-- ============================================================
-- 5. Montant total par commande
-- ============================================================
SELECT
    co.id_commande,
    cl.nom,
    cl.prenom,
    co.date_commande,
    co.statut,
    SUM(lc.quantite * lc.prix_unitaire) AS montant_total
FROM Commande co
JOIN Client        cl  ON co.id_client   = cl.id_client
JOIN LigneCommande lc  ON co.id_commande = lc.id_commande
GROUP BY co.id_commande, cl.nom, cl.prenom, co.date_commande, co.statut
ORDER BY co.date_commande DESC;

-- ============================================================
-- 6. Suivi complet d'une commande (paiement + livraison)
-- ============================================================
SELECT
    co.id_commande,
    co.statut                   AS statut_commande,
    p.mode_paiement,
    p.statut_paiement,
    p.montant_paye,
    l.transporteur,
    l.numero_suivi,
    l.statut_livraison,
    l.date_livraison_reelle
FROM Commande co
LEFT JOIN Paiement  p ON co.id_commande = p.id_commande
LEFT JOIN Livraison l ON co.id_commande = l.id_commande
ORDER BY co.id_commande;

-- ============================================================
-- 7. Crampons en alerte ou en rupture de stock
-- ============================================================
SELECT
    m.nom            AS marque,
    c.modele,
    c.pointure,
    s.quantite_disponible,
    s.seuil_alerte
FROM Crampon c
JOIN Marque m ON c.id_marque  = m.id_marque
JOIN Stock  s ON c.id_crampon = s.id_crampon
WHERE s.quantite_disponible <= s.seuil_alerte
ORDER BY s.quantite_disponible ASC;

-- ============================================================
-- 8. Nombre de commandes par client
-- ============================================================
SELECT
    cl.id_client,
    cl.nom,
    cl.prenom,
    COUNT(co.id_commande) AS nb_commandes
FROM Client cl
LEFT JOIN Commande co ON cl.id_client = co.id_client
GROUP BY cl.id_client, cl.nom, cl.prenom
ORDER BY nb_commandes DESC;

-- ============================================================
-- 9. Crampons les plus vendus (par quantité)
-- ============================================================
SELECT
    m.nom            AS marque,
    c.modele,
    SUM(lc.quantite)                    AS total_vendus,
    SUM(lc.quantite * lc.prix_unitaire) AS chiffre_affaires
FROM Crampon c
JOIN Marque        m  ON c.id_marque   = m.id_marque
JOIN LigneCommande lc ON c.id_crampon  = lc.id_crampon
JOIN Commande      co ON lc.id_commande = co.id_commande
WHERE co.statut NOT IN ('EN_ATTENTE', 'ANNULEE')
GROUP BY c.id_crampon, m.nom, c.modele
ORDER BY total_vendus DESC;

-- ============================================================
-- 10. Chiffre d'affaires par marque
-- ============================================================
SELECT
    m.nom            AS marque,
    COUNT(DISTINCT lc.id_ligne)         AS lignes_vendues,
    SUM(lc.quantite)                    AS unites_vendues,
    SUM(lc.quantite * lc.prix_unitaire) AS chiffre_affaires
FROM Marque m
JOIN Crampon       c  ON m.id_marque    = c.id_marque
JOIN LigneCommande lc ON c.id_crampon   = lc.id_crampon
JOIN Commande      co ON lc.id_commande = co.id_commande
WHERE co.statut NOT IN ('EN_ATTENTE', 'ANNULEE')
GROUP BY m.id_marque, m.nom
ORDER BY chiffre_affaires DESC;

-- ============================================================
-- 11. Historique des commandes d'un client (exemple : id = 1)
-- ============================================================
SELECT
    co.id_commande,
    co.date_commande,
    co.statut,
    SUM(lc.quantite * lc.prix_unitaire) AS montant_total
FROM Commande co
JOIN LigneCommande lc ON co.id_commande = lc.id_commande
WHERE co.id_client = 1
GROUP BY co.id_commande, co.date_commande, co.statut
ORDER BY co.date_commande;

-- ============================================================
-- 12. Note moyenne et nombre d'avis par crampon
-- ============================================================
SELECT
    m.nom                    AS marque,
    c.modele,
    COUNT(a.id_avis)         AS nb_avis,
    ROUND(AVG(a.note), 1)    AS note_moyenne
FROM Crampon c
JOIN Marque m   ON c.id_marque  = m.id_marque
LEFT JOIN Avis a ON c.id_crampon = a.id_crampon
GROUP BY c.id_crampon, m.nom, c.modele
HAVING COUNT(a.id_avis) > 0
ORDER BY note_moyenne DESC;
