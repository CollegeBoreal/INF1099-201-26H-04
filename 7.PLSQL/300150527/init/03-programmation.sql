-- ==========================================================
-- TP PostgreSQL : Procedures, Functions, Triggers
-- Projet : Compagnie Aérienne
-- ==========================================================

-- ----------------------------------------------------------
-- Procedure : ajouter_passager
-- ----------------------------------------------------------
CREATE OR REPLACE PROCEDURE ajouter_passager(
    p_nom TEXT,
    p_prenom TEXT,
    p_passeport TEXT,
    p_nationalite TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_passeport IS NULL OR p_passeport = '' THEN
        RAISE EXCEPTION 'Passeport obligatoire pour %', p_nom;
    END IF;

    INSERT INTO Passager(nom, prenom, passeport, nationalite)
    VALUES (p_nom, p_prenom, p_passeport, p_nationalite);

    INSERT INTO logs(action)
    VALUES ('Ajout passager : ' || p_nom);

    RAISE NOTICE 'Passager ajouté avec succès : %', p_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur ajout passager : %', SQLERRM;
END;
$$;

-- ----------------------------------------------------------
-- Fonction : nombre_passagers_par_vol
-- ----------------------------------------------------------
CREATE OR REPLACE FUNCTION nombre_passagers_par_vol(p_id_vol INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM Reservation
    WHERE id_vol = p_id_vol;

    RETURN total;
END;
$$;

-- ----------------------------------------------------------
-- Procedure : reserver_vol
-- ----------------------------------------------------------
CREATE OR REPLACE PROCEDURE reserver_vol(
    p_id_passager INT,
    p_id_vol INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Passager WHERE id_passager = p_id_passager) THEN
        RAISE EXCEPTION 'Passager inexistant';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Vol WHERE id_vol = p_id_vol) THEN
        RAISE EXCEPTION 'Vol inexistant';
    END IF;

    IF EXISTS (
        SELECT 1 FROM Reservation 
        WHERE id_passager = p_id_passager AND id_vol = p_id_vol
    ) THEN
        RAISE EXCEPTION 'Réservation déjà existante';
    END IF;

    INSERT INTO Reservation(date_reservation, statut, id_passager, id_vol)
    VALUES (NOW(), 'Confirmee', p_id_passager, p_id_vol);

    INSERT INTO logs(action)
    VALUES ('Reservation passager ' || p_id_passager || ' pour vol ' || p_id_vol);

    RAISE NOTICE 'Réservation effectuée avec succès';

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur réservation : %', SQLERRM;
END;
$$;

-- ----------------------------------------------------------
-- Trigger : validation passeport
-- ----------------------------------------------------------
CREATE OR REPLACE FUNCTION valider_passager()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.passeport IS NULL OR NEW.passeport = '' THEN
        RAISE EXCEPTION 'Passeport invalide';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_valider_passager
BEFORE INSERT ON Passager
FOR EACH ROW
EXECUTE FUNCTION valider_passager();

-- ----------------------------------------------------------
-- Trigger : log détaillé sur Reservation
-- ----------------------------------------------------------
CREATE OR REPLACE FUNCTION log_action_reservation()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs(action)
        VALUES (
            'INSERT Reservation : passager ' || NEW.id_passager ||
            ', vol ' || NEW.id_vol ||
            ', statut ' || NEW.statut
        );
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logs(action)
        VALUES (
            'UPDATE Reservation : passager ' || NEW.id_passager ||
            ', vol ' || NEW.id_vol ||
            ', statut ' || NEW.statut
        );
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES (
            'DELETE Reservation : passager ' || OLD.id_passager ||
            ', vol ' || OLD.id_vol ||
            ', statut ' || OLD.statut
        );
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_log_reservation ON Reservation;

CREATE TRIGGER trg_log_reservation
AFTER INSERT OR UPDATE OR DELETE ON Reservation
FOR EACH ROW
EXECUTE FUNCTION log_action_reservation();
