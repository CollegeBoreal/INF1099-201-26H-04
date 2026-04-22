-- ========================================
-- 1. FONCTION : nombre de réservations
-- ========================================
CREATE OR REPLACE FUNCTION cargorent.nombre_reservations_periode(
    date_debut_param DATE,
    date_fin_param DATE
)
RETURNS INT AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM cargorent.reservations
    WHERE date_debut >= date_debut_param
      AND date_fin <= date_fin_param;

    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- 2. PROCEDURE : ajouter un client
-- ========================================
CREATE OR REPLACE PROCEDURE cargorent.ajouter_client(
    p_nom TEXT,
    p_prenom TEXT,
    p_tel TEXT,
    p_email TEXT,
    p_permis TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO cargorent.clients(nom, prenom, telephone, email, numero_permis)
    VALUES (p_nom, p_prenom, p_tel, p_email, p_permis);

    INSERT INTO cargorent.logs(action)
    VALUES ('Client ajouté : ' || p_nom);

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Client déjà existant!';
END;
$$;

-- ========================================
-- 3. PROCEDURE : réserver voiture
-- ========================================
CREATE OR REPLACE PROCEDURE cargorent.reserver_voiture(
    p_client INT,
    p_voiture INT,
    p_debut DATE,
    p_fin DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    dispo BOOLEAN;
BEGIN
    SELECT disponible INTO dispo
    FROM cargorent.voitures
    WHERE id_voiture = p_voiture;

    IF dispo = FALSE THEN
        RAISE EXCEPTION 'Voiture non disponible!';
    END IF;

    INSERT INTO cargorent.reservations(date_debut, date_fin, statut, id_client, id_voiture)
    VALUES (p_debut, p_fin, 'confirmée', p_client, p_voiture);

    UPDATE cargorent.voitures
    SET disponible = FALSE
    WHERE id_voiture = p_voiture;

    INSERT INTO cargorent.logs(action)
    VALUES ('Reservation créée pour client ' || p_client);

END;
$$;

-- ========================================
-- 4. TRIGGER : validation date
-- ========================================
CREATE OR REPLACE FUNCTION cargorent.verif_dates()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.date_fin < NEW.date_debut THEN
        RAISE EXCEPTION 'Date fin invalide!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verif_dates
BEFORE INSERT ON cargorent.reservations
FOR EACH ROW
EXECUTE FUNCTION cargorent.verif_dates();

-- ========================================
-- 5. TRIGGER : log automatique
-- ========================================
CREATE OR REPLACE FUNCTION cargorent.log_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO cargorent.logs(action)
    VALUES ('Insertion dans reservations ID=' || NEW.id_reservation);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_reservation
AFTER INSERT ON cargorent.reservations
FOR EACH ROW
EXECUTE FUNCTION cargorent.log_insert();