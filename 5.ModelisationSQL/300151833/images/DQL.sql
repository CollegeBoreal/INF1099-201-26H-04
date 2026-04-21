-- ============================================================
-- DQL - Requêtes
-- ============================================================

-- 1. Toutes les catégories
SELECT * FROM bibliotheque.Categorie;

-- 2. Emprunts avec membres et employés
SELECT
    e.ID_Emprunt,
    m.Nom AS Membre,
    emp.Nom AS Employe,
    e.Date_Emprunt,
    e.Statut
FROM bibliotheque.Emprunt e
JOIN bibliotheque.Membre m ON e.ID_Membre = m.ID_Membre
JOIN bibliotheque.Employe emp ON e.ID_Employe = emp.ID_Employe;

-- 3. Détail emprunt
SELECT
    e.ID_Emprunt,
    m.Nom,
    l.Titre,
    a.Nom AS Auteur
FROM bibliotheque.Ligne_Emprunt le
JOIN bibliotheque.Emprunt e ON le.ID_Emprunt = e.ID_Emprunt
JOIN bibliotheque.Membre m ON e.ID_Membre = m.ID_Membre
JOIN bibliotheque.Livre l ON le.ID_Livre = l.ID_Livre
JOIN bibliotheque.Auteur a ON l.ID_Auteur = a.ID_Auteur;

-- 4. Emprunts terminés
SELECT *
FROM bibliotheque.Emprunt
WHERE Statut = 'Terminé';

-- 5. Total amendes par membre
SELECT
    m.Nom,
    SUM(p.Montant) AS Total
FROM bibliotheque.Paiement p
JOIN bibliotheque.Emprunt e ON p.ID_Emprunt = e.ID_Emprunt
JOIN bibliotheque.Membre m ON e.ID_Membre = m.ID_Membre
GROUP BY m.Nom;

-- 6. Livres + auteur + catégorie
SELECT
    l.Titre,
    a.Nom AS Auteur,
    c.Nom_Categorie
FROM bibliotheque.Livre l
JOIN bibliotheque.Auteur a ON l.ID_Auteur = a.ID_Auteur
JOIN bibliotheque.Categorie c ON l.ID_Categorie = c.ID_Categorie;
