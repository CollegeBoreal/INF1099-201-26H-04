-- ============================================================
-- test.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- Centre Sportif — Gestion de Terrains & Réservations
-- #300150293
-- ============================================================

-- ------------------------------------------------------------
-- Test 1 : Insertion client valide
-- ------------------------------------------------------------
CALL ajouter_client('Dupont', 'Karim', 'karim@email.com', '514-222-3333');
-- Résultat attendu : NOTICE: Client ajouté avec succès : Dupont Karim

-- ------------------------------------------------------------
-- Test 2 : Email invalide
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_client('Ndiaye', 'Fatou', 'email-invalide', '438-444-5555');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;
-- Résultat attendu : NOTICE: Erreur attendue OK : Email invalide pour Ndiaye

-- ------------------------------------------------------------
-- Test 3 : Nom vide
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_client('', 'Test', 'test2@email.com', '514-000-0001');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;
-- Résultat attendu : NOTICE: Erreur attendue OK : Le nom ne peut pas être vide

-- ------------------------------------------------------------
-- Test 4 : Email doublon
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_client('Dupont2', 'Karim2', 'karim@email.com', '514-111-1111');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;
-- Résultat attendu : NOTICE: Erreur attendue OK : Email déjà utilisé

-- ------------------------------------------------------------
-- Test 5 : Fonction nombre_reservations_par_terrain valide
-- ------------------------------------------------------------
SELECT nombre_reservations_par_terrain(1);
-- Résultat attendu : 0 (aucune réservation encore)

-- ------------------------------------------------------------
-- Test 6 : Fonction avec terrain inexistant
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        PERFORM nombre_reservations_par_terrain(999);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;
-- Résultat attendu : NOTICE: Erreur attendue OK : Terrain non trouvé : 999

-- ------------------------------------------------------------
-- Test 7 : Réservation valide
-- ------------------------------------------------------------
CALL faire_reservation(
    'karim@email.com',
    'Terrain A1',
    '2024-05-01 18:00:00',
    '2024-05-01 19:00:00'
);
-- Résultat attendu : NOTICE: Réservation réussie : karim@email.com sur Terrain A1 — Montant : 80.00$

-- ------------------------------------------------------------
-- Test 8 : Doublon de réservation sur le même créneau
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL faire_reservation(
            'test@email.com',
            'Terrain A1',
            '2024-05-01 18:00:00',
            '2024-05-01 19:00:00'
        );
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;
-- Résultat attendu : NOTICE: Erreur attendue OK : Le terrain Terrain A1 est déjà réservé

-- ------------------------------------------------------------
-- Test 9 : Client inexistant pour réservation
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL faire_reservation(
            'inconnu@email.com',
            'Terrain A1',
            '2024-05-02 10:00:00',
            '2024-05-02 11:00:00'
        );
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;
-- Résultat attendu : NOTICE: Erreur attendue OK : Client non trouvé

-- ------------------------------------------------------------
-- Test 10 : Trigger INSERT direct invalide
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        INSERT INTO clients (nom, prenom, email, telephone)
        VALUES ('Trigger', 'Test', 'email-invalide-trigger', '000-000-0000');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK (trigger) : %', SQLERRM;
    END;
END;
$$;
-- Résultat attendu : NOTICE: Erreur attendue OK (trigger) : Email invalide pour Trigger

-- ------------------------------------------------------------
-- Vérification finale
-- ------------------------------------------------------------
SELECT * FROM clients;
SELECT * FROM terrains;
SELECT * FROM reservations;
SELECT * FROM logs ORDER BY date_action;
