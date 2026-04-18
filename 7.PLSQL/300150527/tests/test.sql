-- ==========================================================
-- Tests TP PostgreSQL : Compagnie Aérienne (Version finale)
-- ==========================================================

-- ----------------------------------------------------------
-- 1) Ajouter plusieurs passagers (valides)
-- ----------------------------------------------------------
CALL ajouter_passager('Karim', 'Ali', 'BB999', 'Algerienne');
CALL ajouter_passager('Yacine', 'Amine', 'CC111', 'Algerienne');
CALL ajouter_passager('Nadia', 'Sara', 'DD222', 'Algerienne');

-- ----------------------------------------------------------
-- 2) Test erreur : passeport vide
-- ----------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL ajouter_passager('Test', 'Erreur', '', 'DZ');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK (passeport)';
    END;
END;
$$;

-- ----------------------------------------------------------
-- 3) Réservations valides
-- (IDs logiques après insertion : 2,3,4)
-- ----------------------------------------------------------
CALL reserver_vol(2, 1);
CALL reserver_vol(3, 1);
CALL reserver_vol(4, 1);

-- ----------------------------------------------------------
-- 4) Test erreur : réservation en double
-- ----------------------------------------------------------
DO $$
BEGIN
    BEGIN
        CALL reserver_vol(2, 1);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK (doublon)';
    END;
END;
$$;

-- ----------------------------------------------------------
-- 5) Fonction : nombre de passagers par vol
-- ----------------------------------------------------------
SELECT nombre_passagers_par_vol(1);

-- ----------------------------------------------------------
-- 6) Affichage des données
-- ----------------------------------------------------------
SELECT * FROM Passager;
SELECT * FROM Reservation;

-- ----------------------------------------------------------
-- 7) Vérifier logs (triggers + procedures)
-- ----------------------------------------------------------
SELECT * FROM logs;