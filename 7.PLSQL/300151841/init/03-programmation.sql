CREATE OR REPLACE PROCEDURE ajouter_etudiant(p_nom TEXT, p_age INT, p_email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', p_nom;
    END IF;

    IF p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', p_nom;
    END IF;

    IF EXISTS (SELECT 1 FROM etudiants WHERE email = p_email) THEN
        RAISE EXCEPTION 'Email deja existant : %', p_email;
    END IF;

    INSERT INTO etudiants(nom, age, email)
    VALUES (p_nom, p_age, p_email);

    INSERT INTO logs(action)
    VALUES ('Ajout etudiant : ' || p_nom || ' (' || p_email || ')');

    RAISE NOTICE 'Etudiant ajoute avec succes : %', p_nom;
END;
$$;

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

    RETURN total;
END;
$$;

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(p_etudiant_email TEXT, p_cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id INT;
BEGIN
    SELECT id INTO v_etudiant_id
    FROM etudiants
    WHERE email = p_etudiant_email;

    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouve : %', p_etudiant_email;
    END IF;

    SELECT id INTO v_cours_id
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
        RAISE EXCEPTION 'Inscription deja existante';
    END IF;

    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    INSERT INTO logs(action)
    VALUES ('Inscription : ' || p_etudiant_email || ' -> ' || p_cours_nom);

    RAISE NOTICE 'Inscription reussie';
END;
$$;

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger
AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide';
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

CREATE OR REPLACE FUNCTION log_etudiant_action()
RETURNS trigger
AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES (TG_OP || ' etudiants');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_etudiant_action();