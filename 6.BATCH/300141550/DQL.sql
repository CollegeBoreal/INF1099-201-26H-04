-- Vérification des données
SELECT '=== ÉTUDIANTS ===' AS info;
SELECT * FROM etudiants;

SELECT '=== COURS ===' AS info;
SELECT * FROM cours;

SELECT '=== INSCRIPTIONS AVEC DÉTAILS ===' AS info;
SELECT 
    e.nom AS etudiant_nom,
    e.prenom AS etudiant_prenom,
    c.code AS cours_code,
    c.titre AS cours_titre,
    i.date_inscription
FROM inscriptions i
JOIN etudiants e ON i.etudiant_id = e.id
JOIN cours c ON i.cours_id = c.id;

SELECT '=== STATISTIQUES ===' AS info;
SELECT 
    c.titre,
    COUNT(i.id) AS nombre_inscrits
FROM cours c
LEFT JOIN inscriptions i ON c.id = i.cours_id
GROUP BY c.id, c.titre;
