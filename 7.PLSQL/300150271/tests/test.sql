-- ==================================================================================
-- test.sql
-- TP PostgreSQL : Scénarios de test — Domaine Immobilier
-- ==================================================================================

-- ============================================================
-- Test 1 : Vente valide
-- ============================================================
CALL enregistrer_vente(1, 1);   -- Alice achète appartement 101

-- ============================================================
-- Test 2 : Vente d'un appartement déjà vendu (erreur attendue)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL enregistrer_vente(2, 1);  -- Bob tente d'acheter appt déjà vendu
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- Test 3 : Client inexistant (erreur attendue)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL enregistrer_vente(999, 2);  -- Client ID 999 n'existe pas
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- Test 4 : Chiffre d'affaires par ville
-- ============================================================
SELECT chiffre_affaires_ville('Montréal') AS CA_Montreal;
SELECT chiffre_affaires_ville('Laval')    AS CA_Laval;
SELECT chiffre_affaires_ville('Québec')   AS CA_Quebec;

-- ============================================================
-- Test 5 : Ajout d'appartement valide
-- ============================================================
CALL ajouter_appartement(401, 65.0, 210000, 2);

-- ============================================================
-- Test 6 : Ajout d'appartement avec surface négative (erreur attendue)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL ajouter_appartement(402, -10.0, 200000, 2);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- Vérifications finales
-- ============================================================
SELECT * FROM vente;
SELECT * FROM appartement;
SELECT * FROM logs ORDER BY date_action;
