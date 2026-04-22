-- ================================================================
-- 1 PROCEDURE : ajouter_etudiant
-- ================================================================
CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : % ans (minimum 18)', nom, age;
    END IF;

    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', nom, email;
    END IF;

    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    INSERT INTO logs(action)
    VALUES ('INSERT etudiant : ' || nom || ' | email : ' || email);

    RAISE NOTICE 'Etudiant ajoute : % (age: %, email: %)', nom, age, email;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Erreur : email % deja utilise.', email;
    WHEN others THEN
        RAISE NOTICE 'Erreur ajout de % : %', nom, SQLERRM;
END;
$$;

-- ================================================================
-- 2 FONCTION : nombre_etudiants_par_age
-- ================================================================
CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    IF min_age > max_age THEN
        RAISE EXCEPTION 'min_age ne peut pas etre superieur a max_age';
    END IF;

    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RAISE NOTICE 'Etudiants entre % et % ans : %', min_age, max_age, total;
    RETURN total;
END;
$$;

-- ================================================================
-- 3 PROCEDURE : inscrire_etudiant_cours
-- ================================================================
CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id    INT;
BEGIN
    SELECT id INTO v_etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant introuvable : %', etudiant_email;
    END IF;

    SELECT id INTO v_cours_id FROM cours WHERE nom = cours_nom;
    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours introuvable : %', cours_nom;
    END IF;

    IF EXISTS (
        SELECT 1 FROM inscriptions
        WHERE etudiant_id = v_etudiant_id AND cours_id = v_cours_id
    ) THEN
        RAISE EXCEPTION 'Etudiant % deja inscrit au cours %', etudiant_email, cours_nom;
    END IF;

    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    INSERT INTO logs(action)
    VALUES ('INSCRIPTION : ' || etudiant_email || ' -> ' || cours_nom);

    RAISE NOTICE 'Inscription reussie : % -> %', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur inscription : %', SQLERRM;
END;
$$;

-- ================================================================
-- 4 TRIGGER : Validation AVANT insertion etudiant
-- ================================================================
CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Trigger : age invalide pour % (% ans)', NEW.nom, NEW.age;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Trigger : email invalide pour % (%)', NEW.nom, NEW.email;
    END IF;

    RAISE NOTICE 'Validation OK pour %', NEW.nom;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

-- ================================================================
-- 5 TRIGGER : Log automatique INSERT / UPDATE / DELETE
-- ================================================================
CREATE OR REPLACE FUNCTION log_action()
RETURNS TRIGGER AS $$
DECLARE
    detail TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        detail := 'INSERT sur ' || TG_TABLE_NAME || ' | ' || COALESCE(NEW.nom::TEXT, NEW.id::TEXT);
    ELSIF TG_OP = 'UPDATE' THEN
        detail := 'UPDATE sur ' || TG_TABLE_NAME
               || ' | avant: ' || COALESCE(OLD.nom::TEXT, OLD.id::TEXT)
               || ' apres: ' || COALESCE(NEW.nom::TEXT, NEW.id::TEXT);
    ELSIF TG_OP = 'DELETE' THEN
        detail := 'DELETE sur ' || TG_TABLE_NAME || ' | ' || COALESCE(OLD.nom::TEXT, OLD.id::TEXT);
        INSERT INTO logs(action) VALUES (detail);
        RETURN OLD;
    END IF;

    INSERT INTO logs(action) VALUES (detail);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW EXECUTE FUNCTION log_action();

CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW EXECUTE FUNCTION log_action();