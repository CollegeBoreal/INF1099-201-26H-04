-- ============================================================
-- DML - Data Manipulation Language
-- Bibliothèque Universitaire
-- Prérequis : DDL.sql doit avoir été exécuté
-- ============================================================

-- ------------------------------------------------------------
-- INSERT — Insertion des données
-- ------------------------------------------------------------

-- Auteurs
INSERT INTO bibliotheque.Auteur (Nom, Prenom, Nationalite) VALUES
    ('Hugo',    'Victor', 'Française'),
    ('Rowling', 'J.K.',   'Britannique'),
    ('Camus',   'Albert', 'Française');

-- Catégories
INSERT INTO bibliotheque.Categorie (Nom_Categorie) VALUES
    ('Roman'),
    ('Science-Fiction'),
    ('Philosophie');

-- Livres
INSERT INTO bibliotheque.Livre (Titre, Annee_Publication, ISBN, ID_Auteur, ID_Categorie) VALUES
    ('Les Misérables',                       1862, '978-2-07-040850-4', 1, 1),
    ('Harry Potter à l''école des sorciers', 1997, '978-2-07-054100-9', 2, 1),
    ('L''Étranger',                          1942, '978-2-07-036024-5', 3, 3);

-- Membres
INSERT INTO bibliotheque.Membre (Nom, Prenom, Telephone, Email) VALUES
    ('Tremblay', 'Marie', '514-111-2222', 'marie.tremblay@email.com'),
    ('Gagnon',   'Luc',   '438-333-4444', 'luc.gagnon@email.com');

-- Adresses
INSERT INTO bibliotheque.Adresse (Numero_Rue, Rue, Ville, Code_Postal, ID_Membre) VALUES
    ('12', 'Rue Sainte-Catherine', 'Montréal', 'H3B 1A7', 1),
    ('5',  'Boulevard Laurier',    'Québec',   'G1V 2M2', 2);

-- Employés
INSERT INTO bibliotheque.Employe (Nom, Prenom, Poste) VALUES
    ('Côté', 'Jean',   'Bibliothécaire'),
    ('Roy',  'Sophie', 'Assistant');

-- Emprunts
INSERT INTO bibliotheque.Emprunt (Date_Emprunt, Date_Retour_Prevue, Statut, ID_Membre, ID_Employe) VALUES
    ('2024-03-01', '2024-03-15', 'En cours', 1, 1),
    ('2024-03-05', '2024-03-20', 'Terminé',  2, 2);

-- Lignes d'emprunt
INSERT INTO bibliotheque.Ligne_Emprunt (Date_Retour_Effective, ID_Emprunt, ID_Livre) VALUES
    (NULL,         1, 1),
    ('2024-03-18', 2, 2);

-- Paiements (amendes)
INSERT INTO bibliotheque.Paiement (Date_Paiement, Montant, Mode_Paiement, ID_Emprunt) VALUES
    ('2024-03-21', 5.00, 'Carte crédit', 1),
    ('2024-03-19', 2.50, 'Comptant',     2);

-- ------------------------------------------------------------
-- UPDATE — Modification des données
-- ------------------------------------------------------------

-- Mettre à jour le statut de l'emprunt 1
UPDATE bibliotheque.Emprunt
SET Statut = 'Terminé'
WHERE ID_Emprunt = 1;

-- Mise à jour du montant d'un paiement
UPDATE bibliotheque.Paiement
SET Montant = 3.50
WHERE ID_Paiement = 2;

-- ------------------------------------------------------------
-- DELETE — Suppression des données
-- ------------------------------------------------------------

-- Supprimer le paiement 2
DELETE FROM bibliotheque.Paiement
WHERE ID_Paiement = 2;
