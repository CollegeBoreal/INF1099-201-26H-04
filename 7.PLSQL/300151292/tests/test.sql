-- ============================================================
-- test.sql - BorealFit - Tests complets
-- Auteur : Amine Kahil — 300151292
-- ============================================================

-- Test 1 : Insertion valide
CALL ajouter_utilisateur('Alice Dupont', 22, 'alice.dupont@borealfit.ca');

-- Test 2 : Age invalide (< 18)
DO $$
BEGIN
    BEGIN
        CALL ajouter_utilisateur('Bob Mineur', 15, 'bob@borealfit.ca');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test 2 OK - Erreur attendue : %', SQLERRM;
    END;
END;
$$;

-- Test 3 : Email mal forme
DO $$
BEGIN
    BEGIN
        CALL ajouter_utilisateur('Claire Email', 20, 'email-invalide');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test 3 OK - Erreur attendue : %', SQLERRM;
    END;
END;
$$;

-- Test 4 : Email doublon
DO $$
BEGIN
    BEGIN
        CALL ajouter_utilisateur('Marie Doublon', 25, 'marie.tremblay@borealfit.ca');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test 4 OK - Erreur attendue : %', SQLERRM;
    END;
END;
$$;

-- Test 5 : Fonction tranche d age valide
SELECT nombre_utilisateurs_par_age(18, 25);

-- Test 6 : Tranche d age invalide (min > max)
DO $$
BEGIN
    BEGIN
        PERFORM nombre_utilisateurs_par_age(30, 20);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test 6 OK - Erreur attendue : %', SQLERRM;
    END;
END;
$$;

-- Test 7 : Reservation valide
CALL reserver_activite('alice.dupont@borealfit.ca', 'Spinning');

-- Test 8 : Reservation doublon
DO $$
BEGIN
    BEGIN
        CALL reserver_activite('alice.dupont@borealfit.ca', 'Spinning');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test 8 OK - Erreur attendue : %', SQLERRM;
    END;
END;
$$;

-- Test 9 : Utilisateur inexistant
DO $$
BEGIN
    BEGIN
        CALL reserver_activite('inconnu@borealfit.ca', 'HIIT');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test 9 OK - Erreur attendue : %', SQLERRM;
    END;
END;
$$;

-- Test 10 : Trigger INSERT direct invalide
DO $$
BEGIN
    BEGIN
        INSERT INTO utilisateurs(nom, age, email)
        VALUES ('Trop Jeune', 16, 'jeune@borealfit.ca');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test 10 OK - Trigger declenche : %', SQLERRM;
    END;
END;
$$;

-- Verification finale
SELECT * FROM utilisateurs;
SELECT * FROM reservations;
SELECT * FROM logs ORDER BY date_action;
