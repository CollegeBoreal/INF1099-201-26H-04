<<<<<<< HEAD
<<<<<<< HEAD
-- ==================================================================================
-- tests/test.sql
-- TP PostgreSQL : Tests des procédures, fonctions et triggers
-- ==================================================================================

-- ============================================================
-- 1. Test : ajouter_etudiant (valide)
-- ============================================================
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');
CALL ajouter_etudiant('Marie', 25, 'marie@email.com');

-- ============================================================
-- 2. Test : ajouter_etudiant (age invalide < 18)
-- ============================================================
=======
-- Test insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- Test insertion invalide
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
    EXCEPTION
        WHEN others THEN
<<<<<<< HEAD
            RAISE NOTICE 'Erreur attendue (age invalide) : OK';
=======
            RAISE NOTICE 'Erreur attendue OK';
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    END;
END;
$$;

<<<<<<< HEAD
-- ============================================================
-- 3. Test : ajouter_etudiant (email invalide)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Charlie', 20, 'emailinvalide');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (email invalide) : OK';
    END;
END;
$$;

-- ============================================================
-- 4. Test : ajouter_etudiant (email en double)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Ali2', 23, 'ali@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (email dupliqué) : OK';
    END;
END;
$$;

-- ============================================================
-- 5. Test : fonction nombre_etudiants_par_age
-- ============================================================
SELECT nombre_etudiants_par_age(18, 30) AS nb_etudiants_18_30;

-- ============================================================
-- 6. Test : inscrire_etudiant_cours (valide)
-- ============================================================
CALL inscrire_etudiant_cours('ali@email.com', 'Informatique');
CALL inscrire_etudiant_cours('marie@email.com', 'Mathématiques');

-- ============================================================
-- 7. Test : inscrire_etudiant_cours (double inscription)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('ali@email.com', 'Informatique');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (déjà inscrit) : OK';
    END;
END;
$$;

-- ============================================================
-- 8. Vérifier les étudiants
-- ============================================================
SELECT * FROM etudiants;

-- ============================================================
-- 9. Vérifier les inscriptions
-- ============================================================
SELECT e.nom, c.nom AS cours
FROM inscriptions i
JOIN etudiants e ON e.id = i.etudiant_id
JOIN cours c ON c.id = i.cours_id;

-- ============================================================
-- 10. Vérifier les logs
-- ============================================================
SELECT * FROM logs ORDER BY date_action;
=======
-- Test fonction
SELECT nombre_etudiants();

-- Vérifier logs
SELECT * FROM logs;
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
=======
-- Test insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- Test insertion invalide
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK';
    END;
END;
$$;

-- Test fonction
SELECT nombre_etudiants();

-- Vérifier logs
SELECT * FROM logs;
>>>>>>> f650d2d5a543182bc73855a0024af6ff9f85c796
