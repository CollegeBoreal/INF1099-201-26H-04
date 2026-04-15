<<<<<<< HEAD
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
SELECT nombre_etudiants_par_age(18,30);

-- Test inscription
CALL inscrire_etudiant_cours('ali@email.com', 'Math');

-- Vérifier logs
SELECT * FROM logs;
=======
-- ============================================================
-- tests/test.sql
-- TP PostgreSQL — Fichier de validation
-- Étudiante : Aroua Mohand Tahar
-- Matricule : 300150284
-- ============================================================

-- ------------------------------------------------------------
-- TEST 1 : ajout valide via procédure
-- ------------------------------------------------------------
CALL ajouter_etudiant('Aroua Mohand', 22, 'aroua.mohand@email.com');
-- Attendu : notice de succès

-- ------------------------------------------------------------
-- TEST 2 : refus si l’âge est inférieur à 18
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Etudiant Mineur', 16, 'mineur@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test OK - âge invalide détecté : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 3 : refus si le courriel est invalide
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Email Incorrect', 20, 'email-invalide');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test OK - email invalide détecté : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 4 : refus si le courriel existe déjà
-- ------------------------------------------------------------
CALL ajouter_etudiant('Copie Courriel', 23, 'sara.belkacem@email.com');
-- Attendu : notice indiquant que le courriel est déjà utilisé

-- ------------------------------------------------------------
-- TEST 5 : fonction de comptage par tranche d’âge
-- ------------------------------------------------------------
SELECT nombre_etudiants_par_age(18, 25);
SELECT nombre_etudiants_par_age(26, 30);

-- ------------------------------------------------------------
-- TEST 6 : intervalle d’âge invalide
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        PERFORM nombre_etudiants_par_age(30, 20);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test OK - intervalle invalide : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 7 : inscription valide à un cours
-- ------------------------------------------------------------
CALL inscrire_etudiant_cours('sara.belkacem@email.com', 'Bases de donnees');

-- ------------------------------------------------------------
-- TEST 8 : tentative d’inscription en double
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('sara.belkacem@email.com', 'Bases de donnees');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test OK - doublon inscription : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 9 : étudiant inexistant
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('absent@email.com', 'Bases de donnees');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Test OK - étudiant introuvable : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 10 : insertion directe invalide pour tester le trigger
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        INSERT INTO etudiants(nom, age, email)
        VALUES ('Insertion Directe', 17, 'directe@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Trigger activé correctement : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- Vérifications finales
-- ------------------------------------------------------------
SELECT * FROM etudiants ORDER BY id;
SELECT * FROM cours ORDER BY id;
SELECT * FROM inscriptions ORDER BY id;
SELECT * FROM logs ORDER BY date_action, id;
>>>>>>> f650d2d5a543182bc73855a0024af6ff9f85c796
