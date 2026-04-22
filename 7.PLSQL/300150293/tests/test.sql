-- Test 1 : insertion valide
CALL ajouter_etudiant('Alice', 22, 'alice@email.com');
CALL ajouter_etudiant('Bob', 19, 'bob@email.com');

-- Test 2 : age invalide
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Charlie', 15, 'charlie@email.com');
    EXCEPTION WHEN others THEN
        RAISE NOTICE 'Test age invalide OK : %', SQLERRM;
    END;
END;
$$;

-- Test 3 : email invalide
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Dave', 20, 'pas-un-email');
    EXCEPTION WHEN others THEN
        RAISE NOTICE 'Test email invalide OK : %', SQLERRM;
    END;
END;
$$;

-- Test 4 : fonction tranche age
SELECT nombre_etudiants_par_age(18, 25);

-- Test 5 : inscription
CALL inscrire_etudiant_cours('alice@email.com', 'Python');

-- Test 6 : doublon inscription
DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('alice@email.com', 'Python');
    EXCEPTION WHEN others THEN
        RAISE NOTICE 'Test doublon OK : %', SQLERRM;
    END;
END;
$$;

-- Test 7 : voir les logs
SELECT * FROM logs ORDER BY date_action;

-- Test 8 : voir les etudiants
SELECT * FROM etudiants;