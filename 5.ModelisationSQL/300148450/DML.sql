-- ============================================================
-- DML.sql — Manipulation des données
-- Projet : Gestion de Bibliothèque
-- Étudiant : Hocine Adjaoud — 300148450
-- ============================================================

\c gestion_bibliotheque

-- ------------------------------------------------------------
-- INSERT — Insertion des données
-- ------------------------------------------------------------

-- Membres
INSERT INTO bibliotheque.Membre (Nom, Prenom, Telephone, Email) VALUES
    ('Adjaoud', 'Hocine', '514-000-1111', 'hocine.adjaoud@email.com'),
    ('Leblanc', 'Sophie', '438-222-3333', 'sophie.leblanc@email.com'),
    ('Tremblay', 'Marc',   '514-555-6666', 'marc.tremblay@email.com');

-- Adresses
INSERT INTO bibliotheque.Adresse (Numero_Rue, Rue, Ville, Code_Postal, ID_Membre) VALUES
    ('10', 'Rue de la Paix',   'Montréal', 'H2X 1Y4', 1),
    ('3',  'Avenue du Parc',   'Laval',    'H7N 2K1', 2),
    ('88', 'Boulevard Décarie','Montréal', 'H4L 3L7', 3);

-- Livres
INSERT INTO bibliotheque.Livre (Titre, Auteur, Categorie, Annee_Publication) VALUES
    ('Le Petit Prince',  'Antoine de Saint-Exupéry', 'Roman',           1943),
    ('1984',             'George Orwell',             'Science-fiction', 1949),
    ('L''Étranger',      'Albert Camus',              'Roman',           1942),
    ('Dune',             'Frank Herbert',             'Science-fiction', 1965),
    ('Le Seigneur des anneaux', 'J.R.R. Tolkien',    'Fantasy',         1954);

-- Exemplaires
INSERT INTO bibliotheque.Exemplaire (Statut, ID_Livre) VALUES
    ('Disponible', 1),
    ('Emprunté',   2),
    ('Disponible', 3),
    ('Disponible', 4),
    ('Emprunté',   5),
    ('Disponible', 1);

-- Emprunts
INSERT INTO bibliotheque.Emprunt (Date_Emprunt, Date_Retour_Prevue, Date_Retour, ID_Exemplaire, ID_Membre) VALUES
    ('2024-03-01', '2024-03-15', NULL,         2, 1),
    ('2024-02-10', '2024-02-24', '2024-02-22', 1, 2),
    ('2024-03-05', '2024-03-19', NULL,         5, 3);

-- ------------------------------------------------------------
-- UPDATE — Modification des données
-- ------------------------------------------------------------

-- Marquer un emprunt comme retourné
UPDATE bibliotheque.Emprunt
SET Date_Retour = '2024-03-14'
WHERE ID_Emprunt = 1;

-- Mettre à jour le statut de l'exemplaire correspondant
UPDATE bibliotheque.Exemplaire
SET Statut = 'Disponible'
WHERE ID_Exemplaire = 2;

-- Vérification UPDATE
SELECT ID_Emprunt, Date_Retour FROM bibliotheque.Emprunt;

-- ------------------------------------------------------------
-- DELETE — Suppression des données
-- ------------------------------------------------------------

-- Supprimer un emprunt terminé
DELETE FROM bibliotheque.Emprunt
WHERE ID_Emprunt = 2;

-- Vérification DELETE
SELECT * FROM bibliotheque.Emprunt;
