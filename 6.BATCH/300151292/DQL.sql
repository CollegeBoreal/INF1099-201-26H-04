-- ============================================================
-- DQL.sql - BorealFit - Requêtes SELECT (PostgreSQL)
-- ============================================================

-- 1. Tous les utilisateurs
SELECT * FROM utilisateurs;

-- 2. Réservations avec nom de l'utilisateur et activité
SELECT
    u.prenom || ' ' || u.nom AS utilisateur,
    a.nom_activite,
    r.date_reservation,
    r.statut
FROM reservations r
JOIN utilisateurs u ON r.utilisateur_id = u.id
JOIN activites    a ON r.activite_id    = a.id
ORDER BY r.date_reservation;

-- 3. Activités par catégorie
SELECT
    c.nom_categorie,
    a.nom_activite
FROM activites a
JOIN categories c ON a.categorie_id = c.id
ORDER BY c.nom_categorie;

-- 4. Nombre de réservations par utilisateur
SELECT
    u.prenom || ' ' || u.nom AS utilisateur,
    COUNT(r.id) AS nb_reservations
FROM utilisateurs u
LEFT JOIN reservations r ON u.id = r.utilisateur_id
GROUP BY u.id, u.nom, u.prenom
ORDER BY nb_reservations DESC;
