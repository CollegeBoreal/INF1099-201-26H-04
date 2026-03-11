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
    email
FROM Client
ORDER BY nom, prenom;

-- ============================================================
-- 2. Liste de tous les crampons disponibles avec leur stock
-- ============================================================
SELECT
    c.id_crampon,
    c.marque,
    c.modele,
    c.pointure,
    c.couleur,
    c.prix,
    s.quantite_disponible
FROM Crampon c
JOIN Stock s ON c.id_crampon = s.id_crampon
ORDER BY c.marque, c.modele;

-- ============================================================
-- 3. Toutes les commandes avec le nom du client
-- ============================================================
SELECT
    co.id_commande,
    cl.nom,
    cl.prenom,
    co.date_commande,
    co.statut
FROM Commande co
JOIN Client cl ON co.id_client = cl.id_client
ORDER BY co.date_commande DESC;

-- ============================================================
-- 4. Détail complet d'une commande (ex: commande #1)
-- ============================================================
SELECT
    co.id_commande,
    cl.nom           AS client_nom,
    cl.prenom        AS client_prenom,
    cr.marque,
    cr.modele,
    cr.pointure,
    lc.quantite,
    cr.prix          AS prix_unitaire,
    (lc.quantite * cr.prix) AS sous_total
FROM Commande co
JOIN Client cl           ON co.id_client   = cl.id_client
JOIN Ligne_Commande lc   ON co.id_commande = lc.id_commande
JOIN Crampon cr          ON lc.id_crampon  = cr.id_crampon
WHERE co.id_commande = 1;

-- ============================================================
-- 5. Total de chaque commande (montant total)
-- ============================================================
SELECT
    co.id_commande,
    cl.nom,
    cl.prenom,
    co.date_commande,
    co.statut,
    SUM(lc.quantite * cr.prix) AS montant_total
FROM Commande co
JOIN Client cl           ON co.id_client   = cl.id_client
JOIN Ligne_Commande lc   ON co.id_commande = lc.id_commande
JOIN Crampon cr          ON lc.id_crampon  = cr.id_crampon
GROUP BY co.id_commande, cl.nom, cl.prenom, co.date_commande, co.statut
ORDER BY co.date_commande DESC;

-- ============================================================
-- 6. Crampons en rupture de stock ou stock faible (< 10 unités)
-- ============================================================
SELECT
    c.marque,
    c.modele,
    c.pointure,
    s.quantite_disponible
FROM Crampon c
JOIN Stock s ON c.id_crampon = s.id_crampon
WHERE s.quantite_disponible < 10
ORDER BY s.quantite_disponible ASC;

-- ============================================================
-- 7. Nombre de commandes par client
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
-- 8. Crampons les plus commandés (classement)
-- ============================================================
SELECT
    cr.marque,
    cr.modele,
    SUM(lc.quantite) AS total_vendu
FROM Crampon cr
JOIN Ligne_Commande lc ON cr.id_crampon = lc.id_crampon
GROUP BY cr.id_crampon, cr.marque, cr.modele
ORDER BY total_vendu DESC;

-- ============================================================
-- 9. Commandes d'un client spécifique (ex: Luc Tremblay, id=1)
-- ============================================================
SELECT
    co.id_commande,
    co.date_commande,
    co.statut,
    SUM(lc.quantite * cr.prix) AS montant_total
FROM Commande co
JOIN Ligne_Commande lc ON co.id_commande = lc.id_commande
JOIN Crampon cr        ON lc.id_crampon  = cr.id_crampon
WHERE co.id_client = 1
GROUP BY co.id_commande, co.date_commande, co.statut
ORDER BY co.date_commande;

-- ============================================================
-- 10. Chiffre d'affaires total par marque de crampon
-- ============================================================
SELECT
    cr.marque,
    SUM(lc.quantite * cr.prix) AS chiffre_affaires
FROM Crampon cr
JOIN Ligne_Commande lc ON cr.id_crampon = lc.id_crampon
GROUP BY cr.marque
ORDER BY chiffre_affaires DESC;
