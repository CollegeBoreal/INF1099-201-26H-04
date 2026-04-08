-- ============================================================
-- DML.sql — Manipulation des données (INSERT, UPDATE, DELETE)
-- Projet : Gestion de la vente de crampons ⚽👟
-- ============================================================

-- ============================================================
-- INSERT — Insertion des données initiales
-- ============================================================

-- Marques
INSERT INTO Marque (nom, pays_origine, site_web) VALUES
    ('Nike',        'USA',       'www.nike.com'),
    ('Adidas',      'Allemagne', 'www.adidas.com'),
    ('Puma',        'Allemagne', 'www.puma.com'),
    ('New Balance', 'USA',       'www.newbalance.com'),
    ('Mizuno',      'Japon',     'www.mizuno.com');

-- Catégories
INSERT INTO Categorie (code, libelle, description) VALUES
    ('FG', 'Gazon naturel ferme',    'Terrain sec, gazon court — crampons fixes coniques'),
    ('AG', 'Gazon artificiel',       'Pelouse synthétique — crampons courts et nombreux'),
    ('SG', 'Gazon naturel souple',   'Terrain détrempé — crampons vissés interchangeables'),
    ('IN', 'Salle intérieure',       'Parquet ou surface dure — semelle plate et lisse'),
    ('TF', 'Terrain dur multisport', 'Béton ou asphalte — crampons caoutchouc');

-- Clients
INSERT INTO Client (nom, prenom, email, telephone) VALUES
    ('Dupont',  'Lucas',   'lucas.dupont@email.com',   '0612345678'),
    ('Martin',  'Emma',    'emma.martin@email.com',    '0698765432'),
    ('Bernard', 'Théo',    'theo.bernard@email.com',   '0654321098'),
    ('Leroy',   'Camille', 'camille.leroy@email.com',  '0623456789'),
    ('Moreau',  'Antoine', 'antoine.moreau@email.com', '0687654321');

-- Adresses
INSERT INTO Adresse (type_adresse, rue, ville, code_postal, pays, id_client) VALUES
    ('domicile',    '12 rue des Lilas',          'Paris',     '75011', 'France', 1),
    ('livraison',   '3 avenue de la Gare',        'Paris',     '75010', 'France', 1),
    ('domicile',    '5 avenue Foch',              'Lyon',      '69006', 'France', 2),
    ('domicile',    '8 bd de la République',      'Marseille', '13001', 'France', 3),
    ('domicile',    '22 rue Gambetta',            'Bordeaux',  '33000', 'France', 4),
    ('domicile',    '3 rue Victor Hugo',          'Nantes',    '44000', 'France', 5);

-- Crampons
INSERT INTO Crampon (modele, pointure, couleur, prix, id_marque, id_categorie) VALUES
    ('Mercurial Vapor 16',  42.0, 'Noir/Or',     249.99, 1, 1),
    ('Predator Accuracy',   41.0, 'Blanc/Bleu',  199.99, 2, 1),
    ('Future 7 Pro',        43.5, 'Jaune/Noir',  179.99, 3, 2),
    ('Phantom GX Elite',    40.5, 'Gris/Rose',   229.99, 1, 1),
    ('Copa Pure 2',         44.0, 'Blanc/Noir',  159.99, 2, 3),
    ('Furon V7 Pro',        42.5, 'Rouge/Blanc', 189.99, 4, 1),
    ('Tiempo Legend 10',    41.5, 'Marron/Or',   219.99, 1, 1),
    ('Morelia Neo IV',      42.0, 'Blanc/Noir',  239.99, 5, 1),
    ('ULTRA Play IT',       39.0, 'Bleu/Blanc',   89.99, 3, 4),
    ('X Speedportal',       43.0, 'Noir/Blanc',  174.99, 2, 2);

-- Stocks initiaux
INSERT INTO Stock (id_crampon, quantite_disponible, seuil_alerte) VALUES
    (1, 15, 5), (2,  8, 3), (3, 20, 5), (4,  4, 3), (5, 12, 4),
    (6,  6, 3), (7,  3, 5), (8,  9, 4), (9, 25, 8), (10, 11, 5);

-- Commandes
INSERT INTO Commande (date_commande, statut, id_client, id_adresse) VALUES
    ('2024-11-01', 'LIVREE',     1, 2),
    ('2024-11-15', 'EXPEDIEE',   2, 3),
    ('2024-12-01', 'CONFIRMEE',  1, 2),
    ('2024-12-10', 'EN_ATTENTE', 3, 4),
    ('2025-01-05', 'LIVREE',     4, 5);

-- Lignes de commande
INSERT INTO LigneCommande (quantite, prix_unitaire, id_commande, id_crampon) VALUES
    (1, 249.99, 1, 1),   -- Lucas : 1 Mercurial Vapor 16
    (2, 179.99, 1, 3),   -- Lucas : 2 Future 7 Pro
    (1, 199.99, 2, 2),   -- Emma  : 1 Predator Accuracy
    (1, 229.99, 3, 4),   -- Lucas : 1 Phantom GX Elite
    (1, 159.99, 3, 5),   -- Lucas : 1 Copa Pure 2
    (2, 189.99, 4, 6),   -- Théo  : 2 Furon V7 Pro
    (1, 219.99, 5, 7);   -- Camille : 1 Tiempo Legend 10

-- Paiements
INSERT INTO Paiement (mode_paiement, statut_paiement, montant_paye, date_paiement, reference, id_commande) VALUES
    ('carte',    'VALIDE',     609.97, '2024-11-01 14:32:00', 'TXN-20241101-001', 1),
    ('paypal',   'VALIDE',     199.99, '2024-11-15 09:15:00', 'PP-20241115-002',  2),
    ('virement', 'EN_ATTENTE', 389.98, NULL,                   NULL,               3),
    ('carte',    'VALIDE',     219.99, '2025-01-05 11:00:00', 'TXN-20250105-005', 5);

-- Livraisons
INSERT INTO Livraison (transporteur, numero_suivi, date_expedition, date_livraison_prevue, date_livraison_reelle, statut_livraison, id_commande) VALUES
    ('Colissimo',  'COL123456789FR', '2024-11-02', '2024-11-05', '2024-11-04', 'LIVRE',      1),
    ('DHL',        'DHL987654321',   '2024-11-16', '2024-11-19', NULL,         'EN_TRANSIT', 2),
    ('Chronopost', 'CHR112233445',   '2025-01-06', '2025-01-08', '2025-01-08', 'LIVRE',      5);

-- Avis
INSERT INTO Avis (note, titre, commentaire, verifie, id_client, id_crampon) VALUES
    (5, 'Excellent !',               'Légèreté et grip parfaits, je recommande.',         TRUE, 1, 1),
    (4, 'Très bon rapport qualité',  'Confortable sur terrain synthétique.',               TRUE, 1, 3),
    (5, 'Précision au top',          'Les nervures améliorent vraiment le toucher balle.', TRUE, 2, 2),
    (3, 'Correct mais fragile',      'Bonne adhérence mais coutures qui lâchent vite.',   TRUE, 4, 7);

-- ============================================================
-- UPDATE — Mise à jour de données existantes
-- ============================================================

-- Passage d'une commande au statut LIVREE
UPDATE Commande
SET statut = 'LIVREE'
WHERE id_commande = 3;

-- Promotion sur un crampon
UPDATE Crampon
SET prix = 139.99
WHERE id_crampon = 5;

-- Mise à jour du stock après une vente manuelle
UPDATE Stock
SET quantite_disponible = quantite_disponible - 1,
    date_maj            = CURRENT_TIMESTAMP
WHERE id_crampon = 2
  AND quantite_disponible > 0;

-- Correction d'un email client
UPDATE Client
SET email = 'antoine.moreau2025@email.com'
WHERE id_client = 5;

-- Validation d'un paiement en attente
UPDATE Paiement
SET statut_paiement = 'VALIDE',
    date_paiement   = CURRENT_TIMESTAMP
WHERE id_commande = 3;

-- ============================================================
-- DELETE — Suppression de données
-- ============================================================

-- Insertion d'une commande de test à supprimer
INSERT INTO Commande (date_commande, statut, id_client)
VALUES ('2025-02-01', 'ANNULEE', 5);

-- Suppression de la commande annulée (LigneCommande supprimée en CASCADE)
DELETE FROM Commande
WHERE statut = 'ANNULEE';

-- Suppression d'un avis non vérifié
DELETE FROM Avis
WHERE verifie = FALSE;
