
CREATE OR REPLACE PROCEDURE ajouter_etudiant(
    p_nom TEXT,
    p_age INT,
    p_email TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- 🔎 Validation âge
    IF p_age < 18 THEN
        RAISE EXCEPTION '❌ Âge invalide (%). Étudiant doit avoir 18 ans minimum.', p_age;
    END IF;

    -- 🔎 Validation email
    IF p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION '❌ Email invalide : %', p_email;
    END IF;

    -- 📥 Insertion étudiant
    INSERT INTO etudiants(nom, age, email)
    VALUES (p_nom, p_age, p_email);

    -- 📝 Log automatique
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || p_nom);

    -- ✅ Message succès
    RAISE NOTICE '✔ Étudiant ajouté avec succès : %', p_nom;

EXCEPTION
    WHEN others THEN
        -- ❌ Gestion erreur globale
        RAISE NOTICE '⚠ Erreur lors de l''ajout de % : %', p_nom, SQLERRM;
END;
$$;



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



CREATE OR REPLACE FUNCTION verifier_age()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN

    IF NEW.age < 18 THEN
        RAISE EXCEPTION '❌ Trigger : âge invalide (%).', NEW.age;
    END IF;

    RETURN NEW;

END;
$$;

CREATE TRIGGER trg_verifier_age
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION verifier_age();



CREATE OR REPLACE FUNCTION log_etudiant()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN

    -- 🔁 Détection type d'opération
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs(action)
        VALUES ('INSERT étudiant : ' || NEW.nom);

        RAISE NOTICE '📌 INSERT détecté sur %', NEW.nom;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logs(action)
        VALUES ('UPDATE étudiant : ' || NEW.nom);

        RAISE NOTICE '📌 UPDATE détecté sur %', NEW.nom;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES ('DELETE étudiant : ' || OLD.nom);

        RAISE NOTICE '📌 DELETE détecté sur %', OLD.nom;
    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_etudiant();

