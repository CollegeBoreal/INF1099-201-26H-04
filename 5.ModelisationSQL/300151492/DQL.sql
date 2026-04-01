-- ============================================================
-- DQL.sql — Data Query Language
-- Toutes les requêtes de consultation (SELECT)
-- TP Modélisation SQL — Gestion des Participations à des Événements
-- ============================================================

\c participation_db;

-- ============================================================
-- 1. Vérifications de base
-- ============================================================

-- Lister toutes les personnes
SELECT * FROM Personne;

-- Lister tous les événements
SELECT * FROM Evenement;

-- Lister toutes les participations
SELECT * FROM Participation;

-- ============================================================
-- 2. Vue récapitulative
-- ============================================================

-- Résumé par événement (via la vue)
SELECT * FROM vue_recap_participation;

-- ============================================================
-- 3. Liste complète des participants par événement
-- ============================================================
SELECT
    e.titre,
    p.nom,
    p.prenom,
    pa.statut_participation
FROM Participation pa
JOIN Personne  p ON pa.id_personne  = p.id_personne
JOIN Evenement e ON pa.id_evenement = e.id_evenement
ORDER BY e.titre, p.nom;

-- ============================================================
-- 4. Note moyenne par événement
-- ============================================================
SELECT
    e.titre,
    ROUND(AVG(pa.note), 2) AS moyenne_note
FROM Participation pa
JOIN Evenement e ON pa.id_evenement = e.id_evenement
GROUP BY e.titre
ORDER BY moyenne_note DESC NULLS LAST;

-- ============================================================
-- 5. Nombre de participants par statut pour chaque événement
-- ============================================================
SELECT
    e.titre,
    pa.statut_participation,
    COUNT(*) AS nb
FROM Participation pa
JOIN Evenement e ON pa.id_evenement = e.id_evenement
GROUP BY e.titre, pa.statut_participation
ORDER BY e.titre;

-- ============================================================
-- 6. Événements avec un taux de présence >= 80% (HAVING)
-- ============================================================
SELECT
    e.titre,
    COUNT(pa.id_participation) AS total_inscrits,
    SUM(CASE WHEN pa.statut_participation = 'présent' THEN 1 ELSE 0 END) AS presents,
    ROUND(
        SUM(CASE WHEN pa.statut_participation = 'présent' THEN 1 ELSE 0 END)::NUMERIC
        / COUNT(pa.id_participation) * 100, 2
    ) AS taux_presence
FROM Evenement e
JOIN Participation pa ON e.id_evenement = pa.id_evenement
GROUP BY e.titre
HAVING ROUND(
    SUM(CASE WHEN pa.statut_participation = 'présent' THEN 1 ELSE 0 END)::NUMERIC
    / COUNT(pa.id_participation) * 100, 2
) >= 80
ORDER BY taux_presence DESC;

-- ============================================================
-- 7. Personne la plus active (la plus d'événements)
-- ============================================================
SELECT
    p.nom,
    p.prenom,
    COUNT(pa.id_evenement) AS nb_evenements
FROM Participation pa
JOIN Personne p ON pa.id_personne = p.id_personne
GROUP BY p.nom, p.prenom
ORDER BY nb_evenements DESC
LIMIT 1;

-- ============================================================
-- 8. Personnes n'ayant jamais participé à un événement (LEFT JOIN)
-- ============================================================
SELECT
    p.nom,
    p.prenom,
    p.email
FROM Personne p
LEFT JOIN Participation pa ON p.id_personne = pa.id_personne
WHERE pa.id_participation IS NULL;

-- ============================================================
-- 9. Événements sans aucun présent
-- ============================================================
SELECT
    e.titre,
    e.date_debut
FROM Evenement e
LEFT JOIN Participation pa
       ON e.id_evenement = pa.id_evenement
      AND pa.statut_participation = 'présent'
WHERE pa.id_participation IS NULL;

-- ============================================================
-- 10. Analyse des performances avec EXPLAIN ANALYZE
-- ============================================================
EXPLAIN ANALYZE
SELECT e.titre, COUNT(pa.id_participation) AS nb_participants
FROM Evenement e
LEFT JOIN Participation pa ON e.id_evenement = pa.id_evenement
GROUP BY e.id_evenement, e.titre;
