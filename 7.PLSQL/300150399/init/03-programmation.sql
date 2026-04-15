-- ================================
-- 1. PROCÉDURE : ajouter_etudiant
-- ================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(
    p_nom VARCHAR,
    p_age INT,
    p_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation âge
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Age invalide (doit être >= 18)';
    END IF;

    -- Validation email simple
    IF position('@' IN p_email) = 0 THEN
        RAISE EXCEPTION 'Email invalide';
    END IF;

    INSERT INTO etudiants(nom, age, email)
    VALUES (p_nom, p_age, p_email);

    INSERT INTO logs(table_concernee, operation, nouvelle_valeur)
    VALUES ('etudiants', 'INSERT', p_email);

END;
$$;


-- ============================================
-- 2. FONCTION : nombre_etudiants_par_age
-- ============================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(
    min_age INT,
    max_age INT
)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    IF min_age > max_age THEN
        RAISE EXCEPTION 'Intervalle invalide';
    END IF;

    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$$;


-- ============================================
-- 3. PROCÉDURE : inscrire_etudiant_cours
-- ============================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(
    p_email VARCHAR,
    p_nom_cours VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_etudiant INT;
    v_id_cours INT;
BEGIN
    -- Récupérer étudiant
    SELECT id_etudiant INTO v_id_etudiant
    FROM etudiants
    WHERE email = p_email;

    IF v_id_etudiant IS NULL THEN
        RAISE EXCEPTION 'Étudiant introuvable';
    END IF;

    -- Récupérer cours
    SELECT id_cours INTO v_id_cours
    FROM cours
    WHERE nom_cours = p_nom_cours;

    IF v_id_cours IS NULL THEN
        RAISE EXCEPTION 'Cours introuvable';
    END IF;

    INSERT INTO inscriptions(id_etudiant, id_cours)
    VALUES (v_id_etudiant, v_id_cours);

    INSERT INTO logs(table_concernee, operation, nouvelle_valeur)
    VALUES ('inscriptions', 'INSERT', p_email || ' -> ' || p_nom_cours);

END;
$$;


-- ============================================
-- 4. TRIGGER : validation automatique étudiant
-- ============================================

CREATE OR REPLACE FUNCTION trg_valider_etudiant()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide (trigger)';
    END IF;

    IF position('@' IN NEW.email) = 0 THEN
        RAISE EXCEPTION 'Email invalide (trigger)';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION trg_valider_etudiant();


-- ============================================
-- 5. TRIGGER LOG ETUDIANT
-- ============================================

CREATE OR REPLACE FUNCTION trg_log_etudiant()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO logs(table_concernee, operation, ancienne_valeur, nouvelle_valeur)
    VALUES ('etudiants', TG_OP, OLD::TEXT, NEW::TEXT);

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION trg_log_etudiant();


-- ============================================
-- 6. TRIGGER LOG INSCRIPTION
-- ============================================

CREATE OR REPLACE FUNCTION trg_log_inscription()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO logs(table_concernee, operation, nouvelle_valeur)
    VALUES ('inscriptions', TG_OP, NEW::TEXT);

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_log_inscription
AFTER INSERT ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION trg_log_inscription();