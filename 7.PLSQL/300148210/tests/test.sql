CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

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

SELECT nombre_etudiants_par_age(18, 25);

CALL inscrire_etudiant_cours('ali@email.com', 'Informatique');

DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('ali@email.com', 'Informatique');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

SELECT * FROM logs ORDER BY date_action DESC;
