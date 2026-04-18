-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procedures Stockees et Triggers
-- ==================================================================================

-- 1. Procedure : ajouter_etudiant
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

    INSERT INTO etudiants(nom, age, email) VALUES (nom, age, email);
    INSERT INTO logs(action) VALUES ('Ajout etudiant : ' || nom);
    RAISE NOTICE 'Etudiant ajoute avec succes : %', nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l ajout de % : %', nom, SQLERRM;
END;
$$;

-- 2. Fonction : nombre_etudiants
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

-- 3. Trigger : validation avant insertion
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

-- 4. Trigger : log automatique
CREATE OR REPLACE FUNCTION log_auto()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' : ' || COALESCE(NEW.nom, OLD.nom));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_auto();
