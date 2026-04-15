-- ============================================================
--  Procédure : ajouter_etudiant
-- ============================================================
CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation âge
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', nom;
    END IF;

    -- Validation email
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', nom;
    END IF;

    -- Insertion
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- Log
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom);

    -- Succès
    RAISE NOTICE 'Etudiant ajouté : %', nom;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Email déjà existant : %', email;
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l’ajout : %', SQLERRM;
END;
$$;


-- ============================================================
-- Fonction : nombre_etudiants
-- ============================================================
CREATE OR REPLACE FUNCTION nombre_etudiants()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM etudiants;
    RETURN total;
END;
$$;


-- ============================================================
-- 3️⃣ Trigger : validation âge
-- ============================================================
CREATE OR REPLACE FUNCTION verifier_age()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', NEW.nom;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_verifier_age
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION verifier_age();


-- ============================================================
-- 4️⃣ Trigger : log
-- ============================================================
CREATE OR REPLACE FUNCTION log_etudiant()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || NEW.nom);

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_etudiant();
