-- ==================================================================================
-- 03-programmation.sql
-- ==================================================================================

-- 1) Procedure : ajouter_etudiant
CREATE OR REPLACE PROCEDURE ajouter_etudiant(p_nom TEXT, p_age INT, p_email TEXT)
LANGUAGE plpgsql
AS $proc$
BEGIN
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', p_nom;
    END IF;

    IF p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', p_nom;
    END IF;

    INSERT INTO etudiants(nom, age, email)
    VALUES (p_nom, p_age, p_email);

    INSERT INTO logs(action)
    VALUES ('Ajout etudiant : ' || p_nom);

    RAISE NOTICE 'Etudiant ajoute avec succes : %', p_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l ajout de % : %', p_nom, SQLERRM;
END;
$proc$;

-- 2) Fonction : nombre_etudiants_par_age
CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $func$
DECLARE
    total INT;
BEGIN
    IF min_age > max_age THEN
        RAISE EXCEPTION 'min_age ne peut pas etre superieur a max_age';
    END IF;

    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$func$;

-- 3) Procedure : inscrire_etudiant_cours
CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(p_email TEXT, p_cours TEXT)
LANGUAGE plpgsql
AS $proc2$
DECLARE
    v_etudiant_id INT;
    v_cours_id INT;
BEGIN
    SELECT id INTO v_etudiant_id FROM etudiants WHERE email = p_email;
    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouve : %', p_email;
    END IF;

    SELECT id INTO v_cours_id FROM cours WHERE nom = p_cours;
    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouve : %', p_cours;
    END IF;

    IF EXISTS(SELECT 1 FROM inscriptions WHERE etudiant_id = v_etudiant_id AND cours_id = v_cours_id) THEN
        RAISE EXCEPTION 'Etudiant deja inscrit a ce cours';
    END IF;

    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    INSERT INTO logs(action)
    VALUES ('Inscription : ' || p_email || ' -> ' || p_cours);

    RAISE NOTICE 'Inscription reussie : % -> %', p_email, p_cours;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur inscription : %', SQLERRM;
END;
$proc2$;

-- 4) Trigger : validation avant insertion etudiant
CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $trig1$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', NEW.nom;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', NEW.nom;
    END IF;

    RETURN NEW;
END;
$trig1$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

-- 5) Trigger : log automatique
CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $trig2$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' : id=' || OLD.id::text);
        RETURN OLD;
    ELSE
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' : ' || COALESCE(NEW.nom, 'id=' || NEW.id::text));
        RETURN NEW;
    END IF;
END;
$trig2$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();
