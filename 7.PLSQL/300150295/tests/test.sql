-- Test insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- Test insertion invalide (age < 18)
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

-- Test fonction
SELECT nombre_etudiants();

-- Verifier les logs
SELECT * FROM logs;
