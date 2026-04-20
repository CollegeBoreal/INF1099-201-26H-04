CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', nom;
    END IF;

    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', nom;
    END IF;

    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    INSERT INTO logs(action)
    VALUES ('Ajout etudiant : ' || nom);

    RAISE NOTICE 'Etudiant ajoute : %', nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l ajout de % : %', nom, SQLERRM;
END;
$$;

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;
    RETURN total;
END;
$$;

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id INT;
BEGIN
    SELECT id INTO v_etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouve : %', etudiant_email;
    END IF;

    SELECT id INTO v_cours_id FROM cours WHERE nom = cours_nom;
    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouve : %', cours_nom;
    END IF;

    IF EXISTS(SELECT 1 FROM inscriptions WHERE etudiant_id = v_etudiant_id AND cours_id = v_cours_id) THEN
        RAISE EXCEPTION 'Etudiant deja inscrit a ce cours';
    END IF;

    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    INSERT INTO logs(action)
    VALUES ('Inscription etudiant ' || etudiant_email || ' au cours ' || cours_nom);

    RAISE NOTICE 'Inscription reussie : % -> %', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur inscription : %', SQLERRM;
END;
$$;

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', NEW.nom;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', NEW.nom;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ': ' || COALESCE(NEW.nom::text, OLD.nom::text));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();