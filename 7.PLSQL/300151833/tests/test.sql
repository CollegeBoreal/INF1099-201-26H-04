-- Test insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');
CALL ajouter_etudiant('Sara', 25, 'sara@email.com');

-- Test insertion invalide (age < 18)
DO \$\$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
\$\$;

-- Test email invalide
DO \$\$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Eve', 20, 'pasunemail');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur email attendue OK : %', SQLERRM;
    END;
END;
\$\$;

-- Test fonction tranche d'age
SELECT nombre_etudiants_par_age(20, 30);

-- Test inscription
CALL inscrire_etudiant_cours('ali@email.com', 'Informatique');

-- Test double inscription
DO \$\$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('ali@email.com', 'Informatique');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Double inscription bloquee OK : %', SQLERRM;
    END;
END;
\$\$;

-- Verifier logs
SELECT * FROM logs ORDER BY date_action DESC;

-- Verifier etudiants
SELECT * FROM etudiants;

-- Verifier inscriptions
SELECT e.nom, c.nom AS cours
FROM inscriptions i
JOIN etudiants e ON e.id = i.etudiant_id
JOIN cours c ON c.id = i.cours_id;
