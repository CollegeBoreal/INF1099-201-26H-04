-- ==================================================================================
-- 03-programmation.sql (VERSION ADAPTÉE AU DDL ACTUEL)
-- ==================================================================================

-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation âge
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide (<18) pour %', nom;
    END IF;

    -- Validation email format
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', nom;
    END IF;

    -- Validation unicité email
    IF EXISTS (SELECT 1 FROM etudiants WHERE email = ajouter_etudiant.email) THEN
        RAISE EXCEPTION 'Email déjà utilisé : %', email;
    END IF;

    -- Insertion
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- Log
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom);

    -- Succès
    RAISE NOTICE '✔ Étudiant ajouté avec succès : %', nom;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE '❌ Email déjà existant : %', email;

    WHEN others THEN
        RAISE NOTICE '❌ Erreur ajout étudiant % : %', nom, SQLERRM;
END;
$$;

-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants_par_age
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    -- Validation paramètres
    IF min_age < 0 OR max_age < 0 THEN
        RAISE EXCEPTION 'Les âges doivent être positifs';
    END IF;

    IF min_age > max_age THEN
        RAISE EXCEPTION 'min_age doit être <= max_age';
    END IF;

    -- Calcul
    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RAISE NOTICE 'Nombre d''étudiants entre % et % ans : %', min_age, max_age, total;

    RETURN total;
END;
$$;

-- ============================================================
-- 3️⃣ Trigger validation étudiant
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide (<18) pour %', NEW.nom;
    END IF;

    IF NEW.email IS NULL OR NEW.email = '' THEN
        RAISE EXCEPTION 'Email vide pour %', NEW.nom;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Format email invalide pour %', NEW.nom;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_valider_etudiant
BEFORE INSERT OR UPDATE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

-- ============================================================
-- 4️⃣ Trigger log détaillé
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs(action)
        VALUES ('INSERT sur ' || TG_TABLE_NAME || ' : ' || NEW.nom);

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logs(action)
        VALUES ('UPDATE sur ' || TG_TABLE_NAME || ' : ' || OLD.nom || ' -> ' || NEW.nom);

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES ('DELETE sur ' || TG_TABLE_NAME || ' : ' || OLD.nom);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger pour etudiants uniquement
CREATE OR REPLACE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();
