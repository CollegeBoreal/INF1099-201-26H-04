-- ==================================================================================
-- tests/test.sql — Jeu de tests complet
-- ==================================================================================

-- Test insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- Test insertion invalide (âge < 18)
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- Test insertion invalide (email invalide)
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Sara', 20, 'emailsansarobase');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- Test email en double
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Ali2', 25, 'ali@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- Test fonction nombre_etudiants_par_age
SELECT nombre_etudiants_par_age(18, 25);

-- Test tranche invalide
DO $$
BEGIN
    BEGIN
        PERFORM nombre_etudiants_par_age(30, 20);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- Vérifier les logs
SELECT * FROM logs;
