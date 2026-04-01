-- ============================================================
--  DML.sql — Manipulation des données (Data Manipulation Language)
--  Projet  : Gestion d'un Salon de Coiffure
--  SGBD    : PostgreSQL
--  Auteur  : Jesmina
-- ============================================================

-- ------------------------------------------------------------
--  Insertion dans CLIENT
-- ------------------------------------------------------------
INSERT INTO CLIENT (Nom, Prenom, Telephone, Email) VALUES
    ('Tremblay', 'Marie',    '514-555-0101', 'marie.tremblay@email.com'),
    ('Gagnon',   'Sophie',   '514-555-0202', 'sophie.gagnon@email.com'),
    ('Lavoie',   'Julie',    '514-555-0303', 'julie.lavoie@email.com'),
    ('Bouchard', 'Camille',  '514-555-0404', 'camille.bouchard@email.com'),
    ('Roy',      'Isabelle', '514-555-0505', 'isabelle.roy@email.com');

-- ------------------------------------------------------------
--  Insertion dans COIFFEUSE
-- ------------------------------------------------------------
INSERT INTO COIFFEUSE (Nom, Specialite) VALUES
    ('Beaumont', 'Coloration'),
    ('Leclerc',  'Coupe et brushing'),
    ('Moreau',   'Soins capillaires');

-- ------------------------------------------------------------
--  Insertion dans SERVICE
-- ------------------------------------------------------------
INSERT INTO SERVICE (Nom_service, Prix) VALUES
    ('Coupe femme',      45.00),
    ('Coupe homme',      30.00),
    ('Coloration',       90.00),
    ('Meches',          120.00),
    ('Brushing',         35.00),
    ('Soin profond',     55.00);

-- ------------------------------------------------------------
--  Insertion dans MODELE
-- ------------------------------------------------------------
INSERT INTO MODELE (Nom_modele, Description) VALUES
    ('Bob carre',   'Coupe droite geometrique au niveau du menton'),
    ('Balayage',    'Technique de coloration naturelle et progressive'),
    ('Pixie cut',   'Coupe courte effilee tres tendance'),
    ('Degrade',     'Transition douce entre deux longueurs'),
    ('Boucles',     'Mise en forme de boucles naturelles ou permanentees');

-- ------------------------------------------------------------
--  Insertion dans RENDEZ_VOUS
-- ------------------------------------------------------------
INSERT INTO RENDEZ_VOUS (Date_rdv, Heure_rdv, id_client, id_coiffeuse, id_service, id_modele) VALUES
    ('2025-11-10', '09:00', 1, 1, 1, 1),
    ('2025-11-10', '11:00', 2, 2, 3, 2),
    ('2025-11-12', '14:00', 3, 1, 4, 2),
    ('2025-11-13', '10:30', 4, 3, 6, 5),
    ('2025-11-14', '15:00', 5, 2, 2, 4),
    ('2025-11-17', '09:30', 1, 2, 5, 1),
    ('2025-11-18', '13:00', 2, 1, 3, 3);

-- ------------------------------------------------------------
--  Insertion dans PAYEMENT
-- ------------------------------------------------------------
INSERT INTO PAYEMENT (Date_payement, Montant, Mode_payement, id_rdv) VALUES
    ('2025-11-10',  45.00, 'Carte',    1),
    ('2025-11-10',  90.00, 'Comptant', 2),
    ('2025-11-12', 120.00, 'Carte',    3),
    ('2025-11-13',  55.00, 'Virement', 4),
    ('2025-11-14',  30.00, 'Comptant', 5),
    ('2025-11-17',  35.00, 'Carte',    6),
    ('2025-11-18',  90.00, 'Carte',    7);

-- ------------------------------------------------------------
--  Mise à jour (UPDATE)
-- ------------------------------------------------------------
-- Corriger le prix du service Meches
UPDATE SERVICE
SET Prix = 130.00
WHERE Nom_service = 'Meches';

-- Modifier le mode de paiement d'un paiement
UPDATE PAYEMENT
SET Mode_payement = 'Carte'
WHERE id_payement = 2;

-- ------------------------------------------------------------
--  Suppression (DELETE)
-- ------------------------------------------------------------
-- Exemple : supprimer un rendez-vous annule (desactiver au besoin)
-- DELETE FROM PAYEMENT     WHERE id_rdv = 7;
-- DELETE FROM RENDEZ_VOUS  WHERE id_rdv = 7;
