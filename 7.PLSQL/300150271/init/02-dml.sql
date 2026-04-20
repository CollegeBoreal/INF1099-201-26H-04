-- ==================================================================================
-- 02-dml.sql
-- TP PostgreSQL : Données initiales — Domaine Immobilier
-- ==================================================================================

INSERT INTO client (Nom, Telephone) VALUES
    ('Alice Tremblay', '514-000-0001'),
    ('Bob Lavoie',     '438-000-0002'),
    ('Claire Ouellet', '450-000-0003'),
    ('David Morin',    '581-000-0004');

INSERT INTO immeuble (Adresse, Ville) VALUES
    ('123 Rue Principale', 'Montréal'),
    ('456 Boulevard du Lac', 'Laval'),
    ('789 Avenue des Pins', 'Québec');

INSERT INTO appartement (NumAppartement, Surface, Prix, IdImmeuble) VALUES
    (101, 55.0,  180000, 1),
    (102, 72.5,  230000, 1),
    (201, 90.0,  310000, 2),
    (301, 45.0,  150000, 3);
