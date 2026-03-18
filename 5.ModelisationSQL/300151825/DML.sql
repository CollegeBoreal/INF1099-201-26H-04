-- ============================================================
-- DML.sql — Manipulation des données (INSERT, UPDATE, DELETE)
-- Projet : Gestion de la vente de crampons ⚽👟
-- ============================================================

-- ============================================================
-- INSERT — Insertion des données initiales
-- ============================================================

-- Clients
INSERT INTO Client (nom, prenom, email) VALUES
    ('Tremblay',  'Luc',     'luc.tremblay@email.com'),
    ('Gagnon',    'Sophie',  'sophie.gagnon@email.com'),
    ('Roy',       'Marc',    'marc.roy@email.com'),
    ('Bouchard',  'Julie',   'julie.bouchard@email.com'),
    ('Côté',      'Alexis',  'alexis.cote@email.com');

-- Crampons
INSERT INTO Crampon (marque, modele, pointure, couleur, prix) VALUES
    ('Nike',    'Mercurial Vapor 15',   42.0, 'Noir/Or',     249.99),
    ('Adidas',  'Predator Accuracy',   43.0, 'Blanc/Rouge',  219.99),
    ('Nike',    'Phantom GX Elite',    41.0, 'Bleu/Blanc',   229.99),
    ('Puma',    'King Platinum',        44.0, 'Noir/Argent',  189.99),
    ('Adidas',  'Copa Mundial',         42.5, 'Noir/Blanc',   159.99),
    ('Under Armour', 'Magnetico Pro',  40.0, 'Rouge/Noir',   174.99);

-- Stock initial pour chaque crampon
INSERT INTO Stock (id_crampon, quantite_disponible) VALUES
    (1, 20),
    (2, 15),
    (3, 12),
    (4, 25),
    (5, 30),
    (6, 8);

-- Commandes
INSERT INTO Commande (date_commande, statut, id_client) VALUES
    ('2024-01-10', 'LIVREE',    1),
    ('2024-02-14', 'LIVREE',    2),
    ('2024-03-05', 'EXPEDIEE',  3),
    ('2024-03-20', 'CONFIRMEE', 1),
    ('2024-04-01', 'EN_ATTENTE',4);

-- Lignes de commande
INSERT INTO Ligne_Commande (id_commande, id_crampon, quantite) VALUES
    (1, 1, 1),   -- Luc commande 1 paire de Mercurial Vapor 15
    (1, 3, 2),   -- Luc commande aussi 2 paires de Phantom GX
    (2, 2, 1),   -- Sophie commande 1 Predator
    (3, 4, 1),   -- Marc commande 1 King Platinum
    (3, 5, 1),   -- Marc commande aussi 1 Copa Mundial
    (4, 1, 1),   -- Luc recommande 1 Mercurial Vapor
    (5, 6, 3);   -- Julie commande 3 paires Magnetico Pro

-- ============================================================
-- UPDATE — Mise à jour de données existantes
-- ============================================================

-- Mise à jour du statut d'une commande (commande 3 passe à LIVREE)
UPDATE Commande
SET statut = 'LIVREE'
WHERE id_commande = 3;

-- Mise à jour du prix d'un crampon (promotion sur le Copa Mundial)
UPDATE Crampon
SET prix = 139.99
WHERE id_crampon = 5;

-- Mise à jour du stock après une vente manuelle
UPDATE Stock
SET quantite_disponible = quantite_disponible - 1
WHERE id_crampon = 2;

-- Correction d'un email client
UPDATE Client
SET email = 'alexis.cote2024@email.com'
WHERE id_client = 5;

-- ============================================================
-- DELETE — Suppression de données
-- ============================================================

-- Suppression d'une commande annulée (les lignes seront supprimées en CASCADE)
-- On insère d'abord une commande de test à supprimer
INSERT INTO Commande (date_commande, statut, id_client)
VALUES ('2024-04-10', 'ANNULEE', 5);

DELETE FROM Commande
WHERE statut = 'ANNULEE';
