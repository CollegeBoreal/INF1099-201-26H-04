SET search_path TO exchange;

-- ============================================================
-- 1) PROCEDURE : ajouter_client
-- ============================================================
CREATE OR REPLACE PROCEDURE exchange.ajouter_client(
    p_nom VARCHAR(50),
    p_prenom VARCHAR(50),
    p_telephone VARCHAR(20),
    p_email VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_nom IS NULL OR TRIM(p_nom) = '' THEN
        RAISE EXCEPTION 'Nom obligatoire';
    END IF;

    IF p_prenom IS NULL OR TRIM(p_prenom) = '' THEN
        RAISE EXCEPTION 'Prenom obligatoire';
    END IF;

    IF p_email IS NULL OR p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide : %', p_email;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exchange.client
        WHERE email = p_email
    ) THEN
        RAISE EXCEPTION 'Email deja utilise : %', p_email;
    END IF;

    INSERT INTO exchange.client(nom, prenom, telephone, email)
    VALUES (p_nom, p_prenom, p_telephone, p_email);

    RAISE NOTICE 'Client ajoute avec succes : % %', p_prenom, p_nom;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Erreur ajout client : %', SQLERRM;
        RAISE;
END;
$$;


-- ============================================================
-- 2) FONCTION : nombre_transactions_client
-- ============================================================
CREATE OR REPLACE FUNCTION exchange.nombre_transactions_client(p_id_client INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM exchange.client WHERE id_client = p_id_client
    ) THEN
        RAISE EXCEPTION 'Client introuvable : %', p_id_client;
    END IF;

    SELECT COUNT(*)
    INTO v_total
    FROM exchange.transaction
    WHERE id_client = p_id_client;

    RETURN v_total;
END;
$$;


-- ============================================================
-- 3) PROCEDURE : ajouter_transaction
-- ============================================================
CREATE OR REPLACE PROCEDURE exchange.ajouter_transaction(
    p_id_client INT,
    p_id_devise_source INT,
    p_id_devise_cible INT,
    p_id_taux INT,
    p_montant_initial NUMERIC(12,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_taux NUMERIC(12,6);
    v_montant_converti NUMERIC(12,2);
    v_id_transaction INT;
BEGIN
    IF p_montant_initial <= 0 THEN
        RAISE EXCEPTION 'Montant initial invalide : %', p_montant_initial;
    END IF;

    IF p_id_devise_source = p_id_devise_cible THEN
        RAISE EXCEPTION 'Les devises source et cible doivent etre differentes';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exchange.client WHERE id_client = p_id_client
    ) THEN
        RAISE EXCEPTION 'Client introuvable : %', p_id_client;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exchange.devise WHERE id_devise = p_id_devise_source
    ) THEN
        RAISE EXCEPTION 'Devise source introuvable : %', p_id_devise_source;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exchange.devise WHERE id_devise = p_id_devise_cible
    ) THEN
        RAISE EXCEPTION 'Devise cible introuvable : %', p_id_devise_cible;
    END IF;

    SELECT valeur_taux
    INTO v_taux
    FROM exchange.taux_change
    WHERE id_taux = p_id_taux
      AND id_devise_source = p_id_devise_source
      AND id_devise_cible = p_id_devise_cible;

    IF v_taux IS NULL THEN
        RAISE EXCEPTION 'Taux de change invalide ou incompatible';
    END IF;

    v_montant_converti := ROUND((p_montant_initial * v_taux)::numeric, 2);

    INSERT INTO exchange.transaction(
        date_transaction,
        montant_initial,
        montant_converti,
        statut,
        id_client,
        id_devise_source,
        id_devise_cible,
        id_taux
    )
    VALUES (
        CURRENT_TIMESTAMP,
        p_montant_initial,
        v_montant_converti,
        'EN_ATTENTE',
        p_id_client,
        p_id_devise_source,
        p_id_devise_cible,
        p_id_taux
    )
    RETURNING id_transaction INTO v_id_transaction;

    INSERT INTO exchange.historique_transaction(date_action, action, id_transaction)
    VALUES (CURRENT_TIMESTAMP, 'Transaction creee par procedure', v_id_transaction);

    RAISE NOTICE 'Transaction ajoutee : ID=%', v_id_transaction;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Erreur ajout transaction : %', SQLERRM;
        RAISE;
END;
$$;


-- ============================================================
-- 4) TRIGGER : validation_transaction
-- ============================================================
CREATE OR REPLACE FUNCTION exchange.valider_transaction()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.montant_initial <= 0 THEN
        RAISE EXCEPTION 'Montant initial doit etre > 0';
    END IF;

    IF NEW.montant_converti <= 0 THEN
        RAISE EXCEPTION 'Montant converti doit etre > 0';
    END IF;

    IF NEW.id_devise_source = NEW.id_devise_cible THEN
        RAISE EXCEPTION 'Les devises source et cible doivent etre differentes';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_valider_transaction ON exchange.transaction;

CREATE TRIGGER trg_valider_transaction
BEFORE INSERT OR UPDATE
ON exchange.transaction
FOR EACH ROW
EXECUTE FUNCTION exchange.valider_transaction();


-- ============================================================
-- 5) TRIGGER : log_transaction
-- ============================================================
CREATE OR REPLACE FUNCTION exchange.log_transaction()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO exchange.historique_transaction(date_action, action, id_transaction)
        VALUES (CURRENT_TIMESTAMP, 'INSERT transaction', NEW.id_transaction);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO exchange.historique_transaction(date_action, action, id_transaction)
        VALUES (CURRENT_TIMESTAMP, 'UPDATE transaction', NEW.id_transaction);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO exchange.historique_transaction(date_action, action, id_transaction)
        VALUES (CURRENT_TIMESTAMP, 'DELETE transaction', OLD.id_transaction);
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_log_transaction ON exchange.transaction;

CREATE TRIGGER trg_log_transaction
AFTER INSERT OR UPDATE OR DELETE
ON exchange.transaction
FOR EACH ROW
EXECUTE FUNCTION exchange.log_transaction();