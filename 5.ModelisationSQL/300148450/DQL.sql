-- ============================================================
-- DQL.sql — Interrogation des données
-- Projet : Gestion de Bibliothèque
-- Étudiant : Hocine Adjaoud — 300148450
-- ============================================================

\c gestion_bibliotheque

-- ------------------------------------------------------------
-- SELECT simples
-- ------------------------------------------------------------

-- Tous les membres
SELECT * FROM bibliotheque.Membre;

-- Tous les livres
SELECT * FROM bibliotheque.Livre;

-- Exemplaires disponibles
SELECT
    l.Titre,
    l.Auteur,
    x.Statut
FROM bibliotheque.Exemplaire x
JOIN bibliotheque.Livre l ON x.ID_Livre = l.ID_Livre
WHERE x.Statut = 'Disponible';

-- Emprunts non retournés
SELECT *
FROM bibliotheque.Emprunt
WHERE Date_Retour IS NULL;

-- ------------------------------------------------------------
-- SELECT avec JOIN
-- ------------------------------------------------------------

-- Liste complète des emprunts avec membre et livre
SELECT
    e.ID_Emprunt,
    m.Nom               AS Membre,
    m.Prenom,
    l.Titre             AS Livre,
    l.Auteur,
    e.Date_Emprunt,
    e.Date_Retour_Prevue,
    e.Date_Retour
FROM bibliotheque.Emprunt e
JOIN bibliotheque.Membre     m ON e.ID_Membre     = m.ID_Membre
JOIN bibliotheque.Exemplaire x ON e.ID_Exemplaire = x.ID_Exemplaire
JOIN bibliotheque.Livre      l ON x.ID_Livre      = l.ID_Livre
ORDER BY e.Date_Emprunt DESC;

-- Membres avec leur adresse
SELECT
    m.Nom,
    m.Prenom,
    m.Telephone,
    a.Numero_Rue,
    a.Rue,
    a.Ville,
    a.Code_Postal
FROM bibliotheque.Membre  m
JOIN bibliotheque.Adresse a ON m.ID_Membre = a.ID_Membre;

-- Emprunts en retard (date de retour prévue dépassée et pas encore retournés)
SELECT
    m.Nom,
    m.Prenom,
    l.Titre,
    e.Date_Retour_Prevue,
    CURRENT_DATE - e.Date_Retour_Prevue AS Jours_Retard
FROM bibliotheque.Emprunt e
JOIN bibliotheque.Membre     m ON e.ID_Membre     = m.ID_Membre
JOIN bibliotheque.Exemplaire x ON e.ID_Exemplaire = x.ID_Exemplaire
JOIN bibliotheque.Livre      l ON x.ID_Livre      = l.ID_Livre
WHERE e.Date_Retour IS NULL
  AND e.Date_Retour_Prevue < CURRENT_DATE;

-- ------------------------------------------------------------
-- SELECT avec GROUP BY et agrégats
-- ------------------------------------------------------------

-- Nombre d'emprunts par membre
SELECT
    m.Nom,
    m.Prenom,
    COUNT(e.ID_Emprunt) AS Nb_Emprunts
FROM bibliotheque.Membre m
LEFT JOIN bibliotheque.Emprunt e ON m.ID_Membre = e.ID_Membre
GROUP BY m.ID_Membre, m.Nom, m.Prenom
ORDER BY Nb_Emprunts DESC;

-- Nombre d'exemplaires par livre avec disponibilité
SELECT
    l.Titre,
    l.Auteur,
    COUNT(x.ID_Exemplaire)                                  AS Total_Exemplaires,
    COUNT(CASE WHEN x.Statut = 'Disponible' THEN 1 END)    AS Disponibles,
    COUNT(CASE WHEN x.Statut = 'Emprunté'   THEN 1 END)    AS Empruntés
FROM bibliotheque.Livre l
LEFT JOIN bibliotheque.Exemplaire x ON l.ID_Livre = x.ID_Livre
GROUP BY l.ID_Livre, l.Titre, l.Auteur
ORDER BY l.Titre;

-- Nombre de livres par catégorie
SELECT
    Categorie,
    COUNT(*) AS Nb_Livres
FROM bibliotheque.Livre
GROUP BY Categorie
ORDER BY Nb_Livres DESC;

-- Membres ayant emprunté plus d'un livre
SELECT
    m.Nom,
    m.Prenom,
    COUNT(e.ID_Emprunt) AS Nb_Emprunts
FROM bibliotheque.Membre m
JOIN bibliotheque.Emprunt e ON m.ID_Membre = e.ID_Membre
GROUP BY m.ID_Membre, m.Nom, m.Prenom
HAVING COUNT(e.ID_Emprunt) > 1;
