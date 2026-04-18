-- ============================================================
-- tests/test.sql
-- Fichier de tests — TP PostgreSQL Stored Procedures
-- #300150205
-- ============================================================

-- ------------------------------------------------------------
-- TEST 1 : Insertion valide via procédure
-- ------------------------------------------------------------
CALL ajouter_etudiant('Bob Martin', 23, 'bob.martin@email.com');
-- Attendu : NOTICE "Etudiant ajouté avec succès : Bob Martin (23 ans)"

-- ------------------------------------------------------------
-- TEST 2 : Insertion invalide — age < 18
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Junior Trop Jeune', 15, 'junior@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (age invalide) : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 3 : Insertion invalide — email mal forme
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Sans Email', 20, 'pas-un-email');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (email invalide) : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 4 : Insertion invalide — email deja existant
-- ------------------------------------------------------------
CALL ajouter_etudiant('Doublon Email', 21, 'alice.tremblay@email.com');
-- Attendu : NOTICE "Erreur : l'email ... est deja utilise."

-- ------------------------------------------------------------
-- TEST 5 : Fonction nombre_etudiants_par_age
-- ------------------------------------------------------------
SELECT nombre_etudiants_par_age(18, 25);
-- Attendu : nombre d'etudiants entre 18 et 25 ans

SELECT nombre_etudiants_par_age(30, 40);
-- Attendu : 0

-- ------------------------------------------------------------
-- TEST 6 : Fonction — tranche invalide
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        PERFORM nombre_etudiants_par_age(30, 20);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (tranche invalide) : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 7 : Inscription valide
-- ------------------------------------------------------------
CALL inscrire_etudiant_cours('alice.tremblay@email.com', 'Bases de donnees');
-- Attendu : NOTICE "Inscription reussie"

-- ------------------------------------------------------------
-- TEST 8 : Inscription invalide — doublon
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('alice.tremblay@email.com', 'Bases de donnees');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (doublon inscription) : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 9 : Inscription invalide — etudiant inexistant
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL inscrire_etudiant_cours('fantome@email.com', 'Bases de donnees');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue (etudiant inexistant) : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- TEST 10 : Trigger validation — INSERT direct invalide
-- ------------------------------------------------------------
DO $$
BEGIN
    BEGIN
        INSERT INTO etudiants(nom, age, email)
        VALUES ('Trop Jeune Direct', 16, 'direct@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Trigger declenche : %', SQLERRM;
    END;
END;
$$;

-- ------------------------------------------------------------
-- Verification finale
-- ------------------------------------------------------------
SELECT * FROM etudiants;
SELECT * FROM cours;
SELECT * FROM inscriptions;
SELECT * FROM logs ORDER BY date_action;
