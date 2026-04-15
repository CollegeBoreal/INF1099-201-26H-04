-- test.sql - DjaberBenyezza - 300146667

-- Test 1 : Insertion valide
CALL ajouter_etudiant('Djaber', 22, 'djaber@email.com');

-- Test 2 : Age invalide
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob15@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : age invalide';
    END;
END;
$$;

-- Test 3 : Email invalide
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Claire', 20, 'emailinvalide');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : email invalide';
    END;
END;
$$;

-- Test 4 : Fonction tranche age
SELECT nombre_etudiants_par_age(18, 25);

-- Test 5 : Inscription valide
CALL inscrire_etudiant_cours('alice@email.com', 'Bases de donnees');

-- Test 6 : Inscription doublon
DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('alice@email.com', 'Bases de donnees');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : doublon inscription';
    END;
END;
$$;

-- Test 7 : Verification finale
SELECT * FROM etudiants;
SELECT * FROM inscriptions;
SELECT * FROM logs ORDER BY date_action;
