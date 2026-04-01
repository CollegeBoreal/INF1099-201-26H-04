-- ============================
-- PROCEDURE ajouter_etudiant
-- ============================

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
    VALUES ('Ajout étudiant : ' || nom);

    RAISE NOTICE 'Etudiant ajouté : %', nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur : %', SQLERRM;
END;
$$;

-- ============================
-- FONCTION nombre_etudiants_par_age
-- ============================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
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

-- ============================
-- PROCEDURE inscrire_etudiant_cours
-- ============================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    etudiant_id INT;
    cours_id INT;
BEGIN
    SELECT id INTO etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouvé';
    END IF;

    SELECT id INTO cours_id FROM cours WHERE nom = cours_nom;
    IF cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouvé';
    END IF;

    IF EXISTS(
        SELECT 1 FROM inscriptions i
        WHERE i.etudiant_id = etudiant_id
        AND i.cours_id = cours_id
    ) THEN
        RAISE EXCEPTION 'Déjà inscrit';
    END IF;

    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (etudiant_id, cours_id);

    INSERT INTO logs(action)
    VALUES ('Inscription ' || etudiant_email || ' -> ' || cours_nom);

    RAISE NOTICE 'Inscription réussie';

END;
$$;

-- ============================
-- TRIGGER VALIDATION
-- ============================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

-- ============================
-- TRIGGER LOG
-- ============================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log
AFTER INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();