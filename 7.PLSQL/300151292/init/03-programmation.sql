-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procedures Stockees et Triggers
-- Auteur : Amine Kahil — 300151292
-- Domaine : BorealFit (reservation de seances sportives)
-- ==================================================================================

-- ============================================================
-- 1. Procedure : ajouter_utilisateur
-- ============================================================
-- Objectif : Ajouter un utilisateur avec validations et journalisation
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_utilisateur(p_nom TEXT, p_age INT, p_email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifier que l age >= 18
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : doit etre >= 18', p_nom;
    END IF;

    -- Verifier que l email est valide
    IF p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', p_nom, p_email;
    END IF;

    -- Insertion de l utilisateur
    INSERT INTO utilisateurs(nom, age, email)
    VALUES (p_nom, p_age, p_email);

    -- Journalisation dans logs
    INSERT INTO logs(action)
    VALUES ('Ajout utilisateur : ' || p_nom);

    -- RAISE NOTICE succes
    RAISE NOTICE 'Utilisateur ajoute avec succes : %', p_nom;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Erreur : email deja utilise pour % : %', p_nom, p_email;
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l ajout de % : %', p_nom, SQLERRM;
END;
$$;

-- ============================================================
-- 2. Fonction : nombre_utilisateurs_par_age
-- ============================================================
-- Objectif : Retourne le nombre d utilisateurs dans une tranche d age
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_utilisateurs_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    -- Validation de la tranche d age
    IF min_age > max_age THEN
        RAISE EXCEPTION 'Tranche d age invalide : min_age (%) > max_age (%)', min_age, max_age;
    END IF;

    SELECT COUNT(*) INTO total
    FROM utilisateurs
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$$;

-- ============================================================
-- 3. Procedure : reserver_activite
-- ============================================================
-- Objectif : Inscrire un utilisateur a une activite
-- ============================================================

CREATE OR REPLACE PROCEDURE reserver_activite(p_email TEXT, p_activite TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_utilisateur_id INT;
    v_activite_id    INT;
BEGIN
    -- Recuperer id utilisateur et verifier existence
    SELECT id INTO v_utilisateur_id FROM utilisateurs WHERE email = p_email;
    IF v_utilisateur_id IS NULL THEN
        RAISE EXCEPTION 'Utilisateur non trouve : %', p_email;
    END IF;

    -- Recuperer id activite et verifier existence
    SELECT id INTO v_activite_id FROM activites WHERE nom = p_activite;
    IF v_activite_id IS NULL THEN
        RAISE EXCEPTION 'Activite non trouvee : %', p_activite;
    END IF;

    -- Verifier que la reservation n existe pas deja
    IF EXISTS(
        SELECT 1 FROM reservations
        WHERE utilisateur_id = v_utilisateur_id
        AND activite_id = v_activite_id
    ) THEN
        RAISE EXCEPTION 'Utilisateur % deja inscrit a l activite %', p_email, p_activite;
    END IF;

    -- Insertion dans reservations
    INSERT INTO reservations(utilisateur_id, activite_id)
    VALUES (v_utilisateur_id, v_activite_id);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Reservation : ' || p_email || ' -> ' || p_activite);

    RAISE NOTICE 'Reservation reussie : % -> %', p_email, p_activite;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur reservation : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4. Trigger : validation avant insertion d un utilisateur
-- ============================================================
-- Objectif : Valider age et email avant insertions directes
-- ============================================================

CREATE OR REPLACE FUNCTION valider_utilisateur()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : doit etre >= 18', NEW.nom;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', NEW.nom, NEW.email;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_utilisateur
BEFORE INSERT ON utilisateurs
FOR EACH ROW
EXECUTE FUNCTION valider_utilisateur();

-- ============================================================
-- 5. Triggers : log automatique sur utilisateurs et reservations
-- ============================================================
-- Objectif : Journaliser toutes les modifications (INSERT, UPDATE, DELETE)
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' : ' || OLD.id);
        RETURN OLD;
    ELSE
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' : ' || NEW.id);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_utilisateur
AFTER INSERT OR UPDATE OR DELETE ON utilisateurs
FOR EACH ROW
EXECUTE FUNCTION log_action();

CREATE TRIGGER trg_log_reservation
AFTER INSERT OR UPDATE OR DELETE ON reservations
FOR EACH ROW
EXECUTE FUNCTION log_action();
