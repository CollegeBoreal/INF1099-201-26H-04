-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================

-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================
CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Vérifier que l'âge >= 18
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % (Doit être >= 18)', nom;
    END IF;

    -- Vérifier que l'email est valide
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', nom;
    END IF;

    -- Insertion de l'étudiant
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- Ajouter journalisation dans logs
    INSERT INTO logs(action)
    VALUES ('Procédure: Ajout étudiant réussi : ' || nom);

    -- RAISE NOTICE indiquant succès
    RAISE NOTICE 'SUCCÈS: Etudiant ajouté avec succès : %', nom;

EXCEPTION
    WHEN others THEN
        -- RAISE NOTICE indiquant erreur
        RAISE NOTICE 'ERREUR LORS DE L''AJOUT: Impossible d''ajouter % : %', nom, SQLERRM;
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
    -- Optimisation: Validation des paramètres d'entrée
    IF min_age > max_age THEN
         RAISE EXCEPTION 'L''âge minimum ne peut pas être supérieur à l''âge maximum.';
    END IF;

    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$$;

-- ============================================================
-- 3️⃣ Procédure : inscrire_etudiant_cours
-- ============================================================
CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id INT;
BEGIN
    -- récupérer id étudiant et vérifier existence
    SELECT id INTO v_etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouvé avec email : %', etudiant_email;
    END IF;

    -- récupérer id cours et vérifier existence
    SELECT id INTO v_cours_id FROM cours WHERE nom = cours_nom;
    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouvé : %', cours_nom;
    END IF;

    -- Vérifier que l'inscription n'existe pas déjà
    IF EXISTS(SELECT 1 FROM inscriptions WHERE etudiant_id = v_etudiant_id AND cours_id = v_cours_id) THEN
        RAISE EXCEPTION 'Etudiant déjà inscrit à ce cours';
    END IF;

    -- Insertion dans inscriptions
    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Procédure: Inscription étudiant ' || etudiant_email || ' au cours ' || cours_nom);

    RAISE NOTICE 'SUCCÈS: Inscription réussie : % -> %', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'ERREUR INSCRIPTION: Échec de l''inscription : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4️⃣ Trigger validation avant insertion d'un étudiant
-- ============================================================
CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Trigger Rejet: Age invalide (%) pour %', NEW.age, NEW.nom;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Trigger Rejet: Email invalide pour %', NEW.nom;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_valider_etudiant ON etudiants;
CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

-- ============================================================
-- 5️⃣ Trigger log automatique sur etudiants et inscriptions
-- ============================================================
CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
DECLARE
    detail TEXT;
BEGIN
    -- Amélioration des logs (OLD/NEW) demandée
    IF TG_OP = 'INSERT' THEN
        detail := 'Nouvelle entrée ID=' || NEW.id;
    ELSIF TG_OP = 'UPDATE' THEN
        detail := 'Modification ID=' || OLD.id;
    ELSIF TG_OP = 'DELETE' THEN
        detail := 'Suppression ID=' || OLD.id;
    END IF;

    INSERT INTO logs(action)
    VALUES ('Trigger Log: Action ' || TG_OP || ' sur table ' || TG_TABLE_NAME || ' - ' || detail);
    
    RETURN NULL; -- AFTER triggers should return NULL
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_log_etudiant ON etudiants;
CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

DROP TRIGGER IF EXISTS trg_log_inscription ON inscriptions;
CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();
