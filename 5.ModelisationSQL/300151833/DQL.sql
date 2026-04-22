-- ============================================================
-- DQL - Data Query Language
-- Bibliothèque Universitaire
-- Prérequis : DDL.sql et DML.sql doivent avoir été exécutés
-- ============================================================

-- ------------------------------------------------------------
-- Requête 1 : Liste simple de toutes les catégories
-- ------------------------------------------------------------
SELECT * FROM bibliotheque.Categorie;

-- ------------------------------------------------------------
-- Requête 2 : Liste des emprunts avec membre et employé
-- ------------------------------------------------------------
SELECT
    e.ID_Emprunt,
    m.Nom              AS Client,
    emp.Nom            AS Employe,
    e.Date_Emprunt,
    e.Date_Retour_Prevue,
    e.Statut
FROM bibliotheque.Emprunt e
JOIN bibliotheque.Membre  m   ON e.ID_Membre  = m.ID_Membre
JOIN bibliotheque.Employe emp ON e.ID_Employe = emp.ID_Employe;

-- ------------------------------------------------------------
-- Requête 3 : Détail complet d'un emprunt (livres + auteurs)
-- ------------------------------------------------------------
SELECT
    e.ID_Emprunt,
    m.Nom                    AS Membre,
    l.Titre,
    a.Nom                    AS Auteur,
    le.Date_Retour_Effective
FROM bibliotheque.Ligne_Emprunt le
JOIN bibliotheque.Emprunt e ON le.ID_Emprunt = e.ID_Emprunt
JOIN bibliotheque.Membre  m ON e.ID_Membre   = m.ID_Membre
JOIN bibliotheque.Livre   l ON le.ID_Livre   = l.ID_Livre
JOIN bibliotheque.Auteur  a ON l.ID_Auteur   = a.ID_Auteur;

-- ------------------------------------------------------------
-- Requête 4 : Emprunts filtrés par statut
-- ------------------------------------------------------------
SELECT
    e.ID_Emprunt,
    m.Nom AS Membre,
    e.Date_Emprunt,
    e.Statut
FROM bibliotheque.Emprunt e
JOIN bibliotheque.Membre m ON e.ID_Membre = m.ID_Membre
WHERE e.Statut = 'Terminé';

-- ------------------------------------------------------------
-- Requête 5 : Total des amendes payées par membre
-- ------------------------------------------------------------
SELECT
    m.Nom          AS Membre,
    m.Prenom,
    SUM(p.Montant) AS Total_Amendes
FROM bibliotheque.Paiement p
JOIN bibliotheque.Emprunt e ON p.ID_Emprunt = e.ID_Emprunt
JOIN bibliotheque.Membre  m ON e.ID_Membre  = m.ID_Membre
GROUP BY m.ID_Membre, m.Nom, m.Prenom
ORDER BY Total_Amendes DESC;

-- ------------------------------------------------------------
-- Requête 6 : Livres avec leur auteur et catégorie
-- ------------------------------------------------------------
SELECT
    l.Titre,
    l.Annee_Publication,
    a.Nom           AS Auteur,
    c.Nom_Categorie AS Categorie
FROM bibliotheque.Livre l
JOIN bibliotheque.Auteur    a ON l.ID_Auteur    = a.ID_Auteur
JOIN bibliotheque.Categorie c ON l.ID_Categorie = c.ID_Categorie;
