-- =========================
-- 1. Tester la fonction
-- =========================
SELECT cargorent.nombre_reservations_periode('2026-04-20', '2026-04-30');

-- =========================
-- 2. Tester la procédure ajouter_client
-- =========================
CALL cargorent.ajouter_client('Yassine', 'Test', '5142222222', 'yassine@cargorent.com', 'P777777');

-- Cas doublon
CALL cargorent.ajouter_client('Yassine', 'Test', '5142222222', 'yassine@cargorent.com', 'P777777');

-- =========================
-- 3. Tester la procédure reserver_voiture
-- =========================
CALL cargorent.reserver_voiture(1, 1, '2026-05-01', '2026-05-03');

-- Cas voiture déjà réservée
CALL cargorent.reserver_voiture(2, 1, '2026-05-05', '2026-05-07');

-- =========================
-- 4. Tester le trigger de validation des dates
-- =========================
INSERT INTO cargorent.reservations(date_debut, date_fin, statut, id_client, id_voiture)
VALUES ('2026-06-10', '2026-06-01', 'erreur', 1, 2);

-- =========================
-- 5. Vérifications finales
-- =========================
SELECT * FROM cargorent.clients;
SELECT * FROM cargorent.voitures;
SELECT * FROM cargorent.reservations;
SELECT * FROM cargorent.logs ORDER BY date_action;