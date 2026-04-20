-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- Centre Sportif — Gestion de Terrains & Réservations
-- #300150293
-- ==================================================================================

-- ============================================================
-- 1 Procédure : ajouter_client
-- ============================================================
CREATE OR REPLACE PROCEDURE ajouter_client(
    p_nom       TEXT,
    p_prenom    TEXT,
    p_email     TEXT,
    p_telephone TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_nom IS NULL OR p_nom = '' THEN
        RAISE EXCEPTION 'Le nom ne peut pas etre vide';
    END IF;

    IF p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', p_nom;
    END IF;

    IF EXISTS (SELECT 1 FROM clients WHERE email = p_email) THEN
        RAISE EXCEPTION 'Email deja utilise : %', p_email;
    END IF;

    INSERT INTO clients (nom, prenom, email, telephone)
    VALUES (p_nom, p_prenom, p_email, p_telephone);

    INSERT INTO logs (action)
    VALUES ('Ajout client : ' || p_nom || ' ' || p_prenom || ' (' || p_email || ')');

    RAISE NOTICE 'Client ajoute avec succes : % %', p_nom, p_prenom;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Erreur : Email deja existant pour % : %', p_nom, SQLERRM;
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l ajout de % : %', p_nom, SQLERRM;
END;
$$;

-- ============================================================
-- 2 Fonction : nombre_reservations_par_terrain
-- ============================================================
CREATE OR REPLACE FUNCTION nombre_reservations_par_terrain(p_terrain_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM terrains WHERE id = p_terrain_id) THEN
        RAISE EXCEPTION 'Terrain non trouve : %', p_terrain_id;
    END IF;

    SELECT COUNT(*) INTO total
    FROM reservations
    WHERE terrain_id = p_terrain_id;

    RETURN total;
END;
$$;

-- ============================================================
-- 3 Procédure : faire_reservation
-- ============================================================
CREATE OR REPLACE PROCEDURE faire_reservation(
    p_client_email TEXT,
    p_terrain_nom  TEXT,
    p_date_debut   TIMESTAMP,
    p_date_fin     TIMESTAMP
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_client_id  INT;
    v_terrain_id INT;
    v_tarif      NUMERIC(10,2);
    v_montant    NUMERIC(10,2);
    v_duree      NUMERIC;
BEGIN
    SELECT id INTO v_client_id FROM clients WHERE email = p_client_email;
    IF v_client_id IS NULL THEN
        RAISE EXCEPTION 'Client non trouve : %', p_client_email;
    END IF;

    SELECT id, tarif_horaire INTO v_terrain_id, v_tarif
    FROM terrains WHERE nom_terrain = p_terrain_nom;
    IF v_terrain_id IS NULL THEN
        RAISE EXCEPTION 'Terrain non trouve : %', p_terrain_nom;
    END IF;

    IF p_date_debut >= p_date_fin THEN
        RAISE EXCEPTION 'La date de debut doit etre avant la date de fin';
    END IF;

    IF EXISTS (
        SELECT 1 FROM reservations
        WHERE terrain_id = v_terrain_id
        AND statut = 'Confirmee'
        AND (p_date_debut, p_date_fin) OVERLAPS (date_debut, date_fin)
    ) THEN
        RAISE EXCEPTION 'Le terrain % est deja reserve sur ce creneau', p_terrain_nom;
    END IF;

    v_duree   := EXTRACT(EPOCH FROM (p_date_fin - p_date_debut)) / 3600;
    v_montant := v_duree * v_tarif;

    INSERT INTO reservations (client_id, terrain_id, date_debut, date_fin, montant_total)
    VALUES (v_client_id, v_terrain_id, p_date_debut, p_date_fin, v_montant);

    INSERT INTO logs (action)
    VALUES ('Reservation : ' || p_client_email || ' sur ' || p_terrain_nom ||
            ' Montant : ' || v_montant || '$');

    RAISE NOTICE 'Reservation reussie : % sur % Montant : %$', p_client_email, p_terrain_nom, v_montant;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur reservation : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4 Trigger : validation avant insertion d'un client
-- ============================================================
CREATE OR REPLACE FUNCTION valider_client()
RETURNS trigger AS $$
BEGIN
    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', NEW.nom;
    END IF;

    IF NEW.nom IS NULL OR NEW.nom = '' THEN
        RAISE EXCEPTION 'Le nom ne peut pas etre vide';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_valider_client ON clients;
CREATE TRIGGER trg_valider_client
BEFORE INSERT ON clients
FOR EACH ROW
EXECUTE FUNCTION valider_client();

-- ============================================================
-- 5 Trigger : log automatique sur clients et reservations
-- ============================================================
CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO logs (action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' id: ' || OLD.id::text);
        RETURN OLD;
    ELSE
        INSERT INTO logs (action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' id: ' || NEW.id::text);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_log_client ON clients;
CREATE TRIGGER trg_log_client
AFTER INSERT OR UPDATE OR DELETE ON clients
FOR EACH ROW
EXECUTE FUNCTION log_action();

DROP TRIGGER IF EXISTS trg_log_reservation ON reservations;
CREATE TRIGGER trg_log_reservation
AFTER INSERT OR UPDATE OR DELETE ON reservations
FOR EACH ROW
EXECUTE FUNCTION log_action();
