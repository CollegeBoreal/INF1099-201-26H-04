-- ============================================================
-- 02-dml.sql - BorealFit - Données initiales
-- ============================================================

INSERT INTO utilisateurs (nom, age, email) VALUES
('Marie Tremblay',  22, 'marie.tremblay@borealfit.ca'),
('Jean Bouchard',   25, 'jean.bouchard@borealfit.ca'),
('Sophie Gagnon',   21, 'sophie.gagnon@borealfit.ca'),
('Mathieu Lavoie',  28, 'mathieu.lavoie@borealfit.ca');

INSERT INTO activites (nom, categorie, credits) VALUES
('Spinning',    'Cardio',          2),
('HIIT',        'Cardio',          3),
('Hatha Yoga',  'Yoga & Bien-etre', 1),
('Bench Press', 'Musculation',     2);
