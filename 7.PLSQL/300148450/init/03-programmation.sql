-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================

-- ============================================================
-- 1) Procédure : ajouter_etudiant
-- Objectif : ajouter un étudiant avec validation et journalisation
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(p_nom TEXT, p_age INT, p_email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : un étudiant doit avoir au moins 18 ans.', p_nom;
    END IF;

    IF p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', p_nom, p_email;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM etudiants
        WHERE email = p_email
    ) THEN
        RAISE EXCEPTION 'Email deja utilise : %', p_email;
    END IF;

    INSERT INTO etudiants(nom, age, email)
    VALUES (p_nom, p_age, p_email);

    INSERT INTO logs(action)
    VALUES ('Ajout manuel d''un etudiant : ' || p_nom || ' (' || p_email || ')');

    RAISE NOTICE 'Etudiant ajoute avec succes : %', p_nom;

EXCEPTION
    WHEN others THEN
        INSERT INTO logs(action)
        VALUES ('Erreur lors de l''ajout de ' || COALESCE(p_nom, 'inconnu') || ' : ' || SQLERRM);

        RAISE NOTICE 'Erreur detectee : %', SQLERRM;
END;
$$;

-- ============================================================
-- 2) Fonction : nombre_etudiants_par_age
-- Objectif : retourne le nombre d'étudiants dans une tranche d'âge
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    IF min_age > max_age THEN
        RAISE EXCEPTION 'Intervalle invalide : min_age (%) > max_age (%)', min_age, max_age;
    END IF;

    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$$;

-- ============================================================
-- 3) Procédure : inscrire_etudiant_cours
-- Objectif : inscrire un étudiant à un cours
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(p_etudiant_email TEXT, p_cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id INT;
BEGIN
    SELECT id
    INTO v_etudiant_id
    FROM etudiants
    WHERE email = p_etudiant_email;

    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouve : %', p_etudiant_email;
    END IF;

    SELECT id
    INTO v_cours_id
    FROM cours
    WHERE nom = p_cours_nom;

    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouve : %', p_cours_nom;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM inscriptions
        WHERE etudiant_id = v_etudiant_id
          AND cours_id = v_cours_id
    ) THEN
        RAISE EXCEPTION 'Inscription deja existante pour % dans le cours %', p_etudiant_email, p_cours_nom;
    END IF;

    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    INSERT INTO logs(action)
    VALUES ('Inscription de ' || p_etudiant_email || ' au cours ' || p_cours_nom);

    RAISE NOTICE 'Inscription reussie : % -> %', p_etudiant_email, p_cours_nom;

EXCEPTION
    WHEN others THEN
        INSERT INTO logs(action)
        VALUES ('Erreur inscription : ' || SQLERRM);

        RAISE NOTICE 'Erreur lors de l''inscription : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4) Trigger de validation avant insertion d'un étudiant
-- Objectif : valider automatiquement l'âge et l'email
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : %', NEW.nom, NEW.age;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', NEW.nom, NEW.email;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_valider_etudiant ON etudiants;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT OR UPDATE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

-- ============================================================
-- 5) Trigger de log automatique
-- Objectif : journaliser les opérations INSERT/UPDATE/DELETE
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs(action)
        VALUES (
            'INSERT sur ' || TG_TABLE_NAME || ' | nouvelle valeur : ' ||
            COALESCE(NEW.nom, NEW.email, NEW.id::TEXT)
        );
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logs(action)
        VALUES (
            'UPDATE sur ' || TG_TABLE_NAME || ' | ancienne valeur : ' ||
            COALESCE(OLD.nom, OLD.email, OLD.id::TEXT) ||
            ' | nouvelle valeur : ' ||
            COALESCE(NEW.nom, NEW.email, NEW.id::TEXT)
        );
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES (
            'DELETE sur ' || TG_TABLE_NAME || ' | ancienne valeur : ' ||
            COALESCE(OLD.nom, OLD.email, OLD.id::TEXT)
        );
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_log_etudiant ON etudiants;
DROP TRIGGER IF EXISTS trg_log_inscription ON inscriptions;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();
