SET search_path TO exchange;

-- ============================================================
-- TEST 1 : verifier les donnees initiales
-- ============================================================
SELECT * FROM exchange.client;
SELECT * FROM exchange.transaction;
SELECT * FROM exchange.historique_transaction;

-- ============================================================
-- TEST 2 : procedure ajouter_client (valide)
-- ============================================================
CALL exchange.ajouter_client(
    'Nemous',
    'Abdelatif',
    '6471230000',
    'abdelatif.nemous@gmail.com'
);

SELECT *
FROM exchange.client
WHERE email = 'abdelatif.nemous@gmail.com';

-- ============================================================
-- TEST 3 : procedure ajouter_client (email deja utilise)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL exchange.ajouter_client(
            'Test',
            'Duplicate',
            '1111111111',
            'chakib@gmail.com'
        );
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- TEST 4 : fonction nombre_transactions_client
-- ============================================================
SELECT exchange.nombre_transactions_client(1) AS total_transactions_client_1;

-- ============================================================
-- TEST 5 : procedure ajouter_transaction (valide)
-- ============================================================
CALL exchange.ajouter_transaction(
    1,      -- id_client
    1,      -- CAD
    2,      -- USD
    1,      -- taux compatible CAD -> USD
    250.00
);

SELECT *
FROM exchange.transaction
ORDER BY id_transaction DESC;

-- ============================================================
-- TEST 6 : verifier le log automatique
-- ============================================================
SELECT *
FROM exchange.historique_transaction
ORDER BY id_historique DESC;

-- ============================================================
-- TEST 7 : transaction invalide (montant negatif)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL exchange.ajouter_transaction(
            1,
            1,
            2,
            1,
            -50.00
        );
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- TEST 8 : transaction invalide (client inexistant)
-- ============================================================
DO $$
BEGIN
    BEGIN
        CALL exchange.ajouter_transaction(
            999,
            1,
            2,
            1,
            100.00
        );
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Erreur attendue OK : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- TEST 9 : UPDATE pour tester le trigger de log
-- ============================================================
UPDATE exchange.transaction
SET statut = 'PAYEE'
WHERE id_transaction = (SELECT MAX(id_transaction) FROM exchange.transaction);

SELECT *
FROM exchange.historique_transaction
ORDER BY id_historique DESC;