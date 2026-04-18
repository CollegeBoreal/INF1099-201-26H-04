-- =========================================================
-- test.sql
-- Tests des procédures, fonctions et triggers
-- =========================================================

-- 1. Test d'insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- 2. Test d'insertion invalide (âge)
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test age invalide : OK';
    END;
END;
$$;

-- 3. Test d'insertion invalide (email)
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Karim', 21, 'karim-email-invalide');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test email invalide : OK';
    END;
END;
$$;

-- 4. Test de la fonction
SELECT nombre_etudiants_par_age(18, 25) AS total_18_25;

-- 5. Test d'inscription à un cours
CALL inscrire_etudiant_cours('ali@email.com', 'Base de donnees');

-- 6. Vérification des étudiants
SELECT * FROM etudiants ORDER BY id;

-- 7. Vérification des inscriptions
SELECT * FROM inscriptions ORDER BY id;

-- 8. Vérification des logs
SELECT * FROM logs ORDER BY id;
