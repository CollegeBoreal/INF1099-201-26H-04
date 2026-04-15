-- 1. Afficher tous les membres
SELECT * FROM membre;

-- 2. Afficher tous les coachs
SELECT * FROM coach;

-- 3. Afficher tous les types d’abonnement
SELECT * FROM type_abonnement;

-- 4. Afficher les abonnements avec les membres
SELECT 
    a.id_abonnement,
    m.nom,
    m.prenom,
    t.nom_type,
    a.date_debut,
    a.date_fin,
    a.statut
FROM abonnement a
JOIN membre m ON a.id_membre = m.id_membre
JOIN type_abonnement t ON a.id_type_abonnement = t.id_type_abonnement;

-- 5. Afficher les cours avec le nom du coach et la salle
SELECT
    c.id_cours,
    c.nom_cours,
    c.horaire,
    c.capacite_max,
    co.nom AS nom_coach,
    co.prenom AS prenom_coach,
    s.nom_salle
FROM cours c
JOIN coach co ON c.id_coach = co.id_coach
JOIN salle s ON c.id_salle = s.id_salle;

-- 6. Afficher les membres inscrits aux cours
SELECT
    m.nom,
    m.prenom,
    c.nom_cours,
    i.statut
FROM inscription i
JOIN membre m ON i.id_membre = m.id_membre
JOIN cours c ON i.id_cours = c.id_cours;

-- 7. Afficher les cours suivis par chaque membre
SELECT
    m.nom,
    m.prenom,
    c.nom_cours
FROM membre m
JOIN inscription i ON m.id_membre = i.id_membre
JOIN cours c ON i.id_cours = c.id_cours
ORDER BY m.nom, m.prenom;

-- 8. Afficher le nombre de membres par cours
SELECT
    c.nom_cours,
    COUNT(i.id_inscription) AS nombre_inscriptions
FROM cours c
LEFT JOIN inscription i ON c.id_cours = i.id_cours
GROUP BY c.id_cours, c.nom_cours
ORDER BY nombre_inscriptions DESC;

-- 9. Calculer le total payé par chaque membre
SELECT
    m.nom,
    m.prenom,
    SUM(p.montant) AS total_paye
FROM paiement p
JOIN membre m ON p.id_membre = m.id_membre
GROUP BY m.id_membre, m.nom, m.prenom
ORDER BY total_paye DESC;

-- 10. Afficher les abonnements actifs
SELECT
    m.nom,
    m.prenom,
    t.nom_type,
    a.date_debut,
    a.date_fin
FROM abonnement a
JOIN membre m ON a.id_membre = m.id_membre
JOIN type_abonnement t ON a.id_type_abonnement = t.id_type_abonnement
WHERE a.statut = 'actif';

-- 11. Afficher les cours donnés par chaque coach
SELECT
    co.nom,
    co.prenom,
    c.nom_cours
FROM coach co
JOIN cours c ON co.id_coach = c.id_coach
ORDER BY co.nom;

-- 12. Afficher les paiements avec le nom du membre
SELECT
    p.id_paiement,
    m.nom,
    m.prenom,
    p.montant,
    p.date_paiement,
    p.mode_paiement,
    p.statut
FROM paiement p
JOIN membre m ON p.id_membre = m.id_membre;
