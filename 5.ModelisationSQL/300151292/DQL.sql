-- ============================================================
-- DQL.sql - BorealFit - Requêtes de consultation
-- ============================================================

USE borealfit;

-- 1. Liste de tous les utilisateurs
SELECT id, nom, prenom, email, telephone
FROM UTILISATEUR
ORDER BY nom, prenom;

-- 2. Toutes les séances disponibles avec l'activité et le coach
SELECT 
    s.id AS seance_id,
    a.nom_activite,
    c.nom AS coach,
    s.date_seance,
    s.heure_debut,
    s.heure_fin,
    s.salle,
    s.capacite_max
FROM SEANCE s
JOIN ACTIVITE a ON s.activite_id = a.id
JOIN COACH c ON s.coach_id = c.id
ORDER BY s.date_seance, s.heure_debut;

-- 3. Toutes les réservations confirmées avec les informations utilisateur
SELECT 
    r.id AS reservation_id,
    CONCAT(u.prenom, ' ', u.nom) AS utilisateur,
    r.date_reservation,
    r.statut_reservation
FROM RESERVATION r
JOIN UTILISATEUR u ON r.utilisateur_id = u.id
WHERE r.statut_reservation = 'confirmée'
ORDER BY r.date_reservation;

-- 4. Détail complet d'une réservation : séances réservées
SELECT 
    r.id AS reservation_id,
    CONCAT(u.prenom, ' ', u.nom) AS utilisateur,
    a.nom_activite,
    s.date_seance,
    s.heure_debut,
    s.salle
FROM RESERVATION r
JOIN UTILISATEUR u ON r.utilisateur_id = u.id
JOIN LIGNE_RESERVATION lr ON r.id = lr.reservation_id
JOIN SEANCE s ON lr.seance_id = s.id
JOIN ACTIVITE a ON s.activite_id = a.id
ORDER BY r.id, s.date_seance;

-- 5. Activités classées par catégorie
SELECT 
    cat.nom_categorie,
    act.nom_activite
FROM ACTIVITE act
JOIN CATEGORIE cat ON act.categorie_id = cat.id
ORDER BY cat.nom_categorie, act.nom_activite;

-- 6. Paiements complétés avec montant et utilisateur
SELECT 
    p.id AS paiement_id,
    CONCAT(u.prenom, ' ', u.nom) AS utilisateur,
    p.montant,
    p.mode_paiement,
    p.statut_paiement
FROM PAIEMENT p
JOIN RESERVATION r ON p.reservation_id = r.id
JOIN UTILISATEUR u ON r.utilisateur_id = u.id
WHERE p.statut_paiement = 'complété'
ORDER BY p.montant DESC;

-- 7. Nombre de réservations par utilisateur
SELECT 
    CONCAT(u.prenom, ' ', u.nom) AS utilisateur,
    COUNT(r.id) AS nombre_reservations
FROM UTILISATEUR u
LEFT JOIN RESERVATION r ON u.id = r.utilisateur_id
GROUP BY u.id, u.nom, u.prenom
ORDER BY nombre_reservations DESC;

-- 8. Revenu total par mode de paiement
SELECT 
    mode_paiement,
    SUM(montant) AS revenu_total,
    COUNT(*) AS nb_transactions
FROM PAIEMENT
WHERE statut_paiement = 'complété'
GROUP BY mode_paiement
ORDER BY revenu_total DESC;

-- 9. Séances avec leur taux de remplissage
SELECT 
    a.nom_activite,
    s.date_seance,
    s.salle,
    s.capacite_max,
    COUNT(lr.reservation_id) AS nb_inscrits,
    ROUND((COUNT(lr.reservation_id) / s.capacite_max) * 100, 1) AS taux_remplissage_pct
FROM SEANCE s
JOIN ACTIVITE a ON s.activite_id = a.id
LEFT JOIN LIGNE_RESERVATION lr ON s.id = lr.seance_id
GROUP BY s.id, a.nom_activite, s.date_seance, s.salle, s.capacite_max
ORDER BY taux_remplissage_pct DESC;

-- 10. Adresse complète de chaque utilisateur
SELECT 
    CONCAT(u.prenom, ' ', u.nom) AS utilisateur,
    ad.rue,
    ad.ville,
    ad.province,
    ad.code_postal
FROM UTILISATEUR u
JOIN ADRESSE ad ON u.id = ad.utilisateur_id
ORDER BY u.nom;
