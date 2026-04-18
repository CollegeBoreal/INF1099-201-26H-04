-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================


-- ============================================================
-- 1️⃣  PROCÉDURE : ajouter_etudiant
-- ============================================================
-- Insère un étudiant après validation de l'âge et de l'email.
-- Journalise l'opération dans la table logs.
--
-- Appel :
--   CALL ajouter_etudiant('Alice', 22, 'alice@email.com');
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation âge minimum
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : % ans (minimum 18 requis)', nom, age;
    END IF;

    -- Validation format email
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', nom, email;
    END IF;

    -- Insertion de l'étudiant
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom || ' (age=' || age || ', email=' || email || ')');

    -- Confirmation
    RAISE NOTICE '✅ Etudiant ajouté : % (age=%, email=%)', nom, age, email;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE '❌ Erreur : l''email % est déjà utilisé.', email;
    WHEN others THEN
        RAISE NOTICE '❌ Erreur lors de l''ajout de % : %', nom, SQLERRM;
END;
$$;


-- ============================================================
-- 2️⃣  FONCTION : nombre_etudiants_par_age
-- ============================================================
-- Retourne le nombre d'étudiants dans une tranche d'âge donnée.
--
-- Appel :
--   SELECT nombre_etudiants_par_age(18, 25);
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    -- Validation des paramètres
    IF min_age > max_age THEN
        RAISE EXCEPTION 'Paramètres invalides : min_age (%) doit être <= max_age (%)', min_age, max_age;
    END IF;

    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RAISE NOTICE '📊 Etudiants entre % et % ans : %', min_age, max_age, total;

    RETURN total;
END;
$$;


-- ============================================================
-- 3️⃣  PROCÉDURE : inscrire_etudiant_cours
-- ============================================================
-- Inscrit un étudiant à un cours.
-- Vérifie que l'étudiant et le cours existent, et que
-- l'inscription n'est pas déjà présente.
--
-- Appel :
--   CALL inscrire_etudiant_cours('alice@email.com', 'Mathématiques');
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id    INT;
BEGIN
    -- Récupération et vérification de l'étudiant
    SELECT id INTO v_etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant introuvable avec l''email : %', etudiant_email;
    END IF;

    -- Récupération et vérification du cours
    SELECT id INTO v_cours_id FROM cours WHERE nom = cours_nom;
    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours introuvable : %', cours_nom;
    END IF;

    -- Vérification doublon inscription
    IF EXISTS (
        SELECT 1 FROM inscriptions
        WHERE etudiant_id = v_etudiant_id AND cours_id = v_cours_id
    ) THEN
        RAISE EXCEPTION 'L''étudiant % est déjà inscrit au cours %', etudiant_email, cours_nom;
    END IF;

    -- Insertion de l'inscription
    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Inscription : ' || etudiant_email || ' → ' || cours_nom);

    RAISE NOTICE '✅ Inscription réussie : % → %', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE '❌ Erreur inscription (% → %) : %', etudiant_email, cours_nom, SQLERRM;
END;
$$;


-- ============================================================
-- 4️⃣  TRIGGER : validation AVANT insertion d'un étudiant
-- ============================================================
-- Déclenché BEFORE INSERT sur etudiants.
-- Bloque l'insertion si l'âge < 18 ou si l'email est invalide.
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Trigger — Age invalide pour % : % ans', NEW.nom, NEW.age;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Trigger — Email invalide pour % : %', NEW.nom, NEW.email;
    END IF;

    RAISE NOTICE '🔍 Validation OK pour %', NEW.nom;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();


-- ============================================================
-- 5️⃣  TRIGGER : log automatique sur etudiants et inscriptions
-- ============================================================
-- Déclenché AFTER INSERT, UPDATE ou DELETE.
-- Enregistre chaque modification dans la table logs avec
-- le détail de l'opération (OLD et NEW).
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
DECLARE
    detail TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        detail := 'INSERT sur ' || TG_TABLE_NAME
               || ' — ' || COALESCE(NEW.nom::TEXT, 'id=' || NEW.id::TEXT);

    ELSIF TG_OP = 'UPDATE' THEN
        detail := 'UPDATE sur ' || TG_TABLE_NAME
               || ' — avant : ' || COALESCE(OLD.nom::TEXT, 'id=' || OLD.id::TEXT)
               || ' → après : ' || COALESCE(NEW.nom::TEXT, 'id=' || NEW.id::TEXT);

    ELSIF TG_OP = 'DELETE' THEN
        detail := 'DELETE sur ' || TG_TABLE_NAME
               || ' — ' || COALESCE(OLD.nom::TEXT, 'id=' || OLD.id::TEXT);
        INSERT INTO logs(action) VALUES (detail);
        RETURN OLD;
    END IF;

    INSERT INTO logs(action) VALUES (detail);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger sur etudiants
CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

-- Trigger sur inscriptions
CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();
