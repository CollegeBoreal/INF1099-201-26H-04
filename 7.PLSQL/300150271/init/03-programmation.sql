-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- Domaine : Gestion Immobilière (Client, Immeuble, Appartement, Vente)
-- ==================================================================================

-- ============================================================
-- 1️⃣ Procédure : enregistrer_vente
-- ============================================================
-- Objectif : Enregistrer la vente d'un appartement à un client
--            avec validations et journalisation automatique
-- ============================================================

CREATE OR REPLACE PROCEDURE enregistrer_vente(
    p_idclient      INT,
    p_idappartement INT,
    p_datevente     DATE DEFAULT CURRENT_DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_client_nom  TEXT;
    v_appt_num    INT;
    v_deja_vendu  BOOLEAN;
BEGIN
    -- Vérifier que le client existe
    SELECT Nom INTO v_client_nom FROM client WHERE IdClient = p_idclient;
    IF v_client_nom IS NULL THEN
        RAISE EXCEPTION 'Client introuvable : ID %', p_idclient;
    END IF;

    -- Vérifier que l'appartement existe
    SELECT NumAppartement INTO v_appt_num FROM appartement WHERE IdAppartement = p_idappartement;
    IF v_appt_num IS NULL THEN
        RAISE EXCEPTION 'Appartement introuvable : ID %', p_idappartement;
    END IF;

    -- Vérifier que l'appartement n'est pas déjà vendu
    SELECT EXISTS(
        SELECT 1 FROM vente WHERE IdAppartement = p_idappartement
    ) INTO v_deja_vendu;

    IF v_deja_vendu THEN
        RAISE EXCEPTION 'Appartement % déjà vendu', v_appt_num;
    END IF;

    -- Enregistrement de la vente
    INSERT INTO vente (DateVente, IdClient, IdAppartement)
    VALUES (p_datevente, p_idclient, p_idappartement);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Vente enregistrée : ' || v_client_nom || ' -> Appt ' || v_appt_num);

    RAISE NOTICE 'Vente enregistrée : % a acheté l''appartement %', v_client_nom, v_appt_num;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l''enregistrement de la vente : %', SQLERRM;
END;
$$;

-- ============================================================
-- 2️⃣ Fonction : chiffre_affaires_ville
-- ============================================================
-- Objectif : Retourne le chiffre d'affaires total des ventes
--            pour une ville donnée
-- ============================================================

CREATE OR REPLACE FUNCTION chiffre_affaires_ville(p_ville TEXT)
RETURNS FLOAT
LANGUAGE plpgsql
AS $$
DECLARE
    total FLOAT;
BEGIN
    SELECT COALESCE(SUM(a.Prix), 0) INTO total
    FROM vente v
    JOIN appartement a ON v.IdAppartement = a.IdAppartement
    JOIN immeuble i    ON a.IdImmeuble    = i.IdImmeuble
    WHERE LOWER(i.Ville) = LOWER(p_ville);

    RETURN total;
END;
$$;

-- ============================================================
-- 3️⃣ Procédure : ajouter_appartement
-- ============================================================
-- Objectif : Ajouter un appartement dans un immeuble existant
--            avec validation des données
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_appartement(
    p_num       INT,
    p_surface   FLOAT,
    p_prix      FLOAT,
    p_idimmeuble INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_immeuble_adresse TEXT;
BEGIN
    -- Vérifier que l'immeuble existe
    SELECT Adresse INTO v_immeuble_adresse FROM immeuble WHERE IdImmeuble = p_idimmeuble;
    IF v_immeuble_adresse IS NULL THEN
        RAISE EXCEPTION 'Immeuble introuvable : ID %', p_idimmeuble;
    END IF;

    -- Vérifier surface et prix positifs
    IF p_surface <= 0 THEN
        RAISE EXCEPTION 'La surface doit être positive (reçu : %)', p_surface;
    END IF;
    IF p_prix <= 0 THEN
        RAISE EXCEPTION 'Le prix doit être positif (reçu : %)', p_prix;
    END IF;

    -- Insertion
    INSERT INTO appartement (NumAppartement, Surface, Prix, IdImmeuble)
    VALUES (p_num, p_surface, p_prix, p_idimmeuble);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Appartement ajouté : appt ' || p_num || ' dans ' || v_immeuble_adresse);

    RAISE NOTICE 'Appartement % ajouté dans l''immeuble : %', p_num, v_immeuble_adresse;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur ajout appartement : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4️⃣ Trigger : validation avant insertion d'un appartement
-- ============================================================
-- Objectif : Vérifier que Surface et Prix sont bien positifs
--            avant tout INSERT dans la table appartement
-- ============================================================

CREATE OR REPLACE FUNCTION valider_appartement()
RETURNS trigger AS $$
BEGIN
    IF NEW.Surface <= 0 THEN
        RAISE EXCEPTION 'Surface invalide (%) pour l''appartement %', NEW.Surface, NEW.NumAppartement;
    END IF;
    IF NEW.Prix <= 0 THEN
        RAISE EXCEPTION 'Prix invalide (%) pour l''appartement %', NEW.Prix, NEW.NumAppartement;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_appartement
BEFORE INSERT ON appartement
FOR EACH ROW
EXECUTE FUNCTION valider_appartement();

-- ============================================================
-- 5️⃣ Trigger : journalisation automatique sur vente
-- ============================================================
-- Objectif : Enregistrer dans logs toute action INSERT / UPDATE / DELETE
--            sur la table vente
-- ============================================================

CREATE OR REPLACE FUNCTION log_action_vente()
RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES ('DELETE sur vente : IdVente=' || OLD.IdVente);
        RETURN OLD;
    ELSE
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur vente : IdVente=' || NEW.IdVente ||
                ', IdClient=' || NEW.IdClient ||
                ', IdAppartement=' || NEW.IdAppartement);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_vente
AFTER INSERT OR UPDATE OR DELETE ON vente
FOR EACH ROW
EXECUTE FUNCTION log_action_vente();
