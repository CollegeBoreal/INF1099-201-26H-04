-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- #300150205
-- Prérequis : 01-ddl.sql et 02-dml.sql doivent avoir été exécutés
-- ==================================================================================


-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================
-- Objectif : Ajouter un étudiant avec validations et journalisation
-- Valide l'âge (>= 18), le format email, et journalise l'opération
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation de l'âge
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : % ans (minimum 18 ans requis)', nom, age;
    END IF;

    -- Validation du format email
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', nom, email;
    END IF;

    -- Insertion de l'étudiant
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- Journalisation du succès
    INSERT INTO logs(action)
    VALUES ('INSERT étudiant : ' || nom || ' (' || email || ')');

    RAISE NOTICE 'Étudiant ajouté avec succès : % (% ans)', nom, age;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Erreur : l''email % est déjà utilisé.', email;
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l''ajout de % : %', nom, SQLERRM;
END;
$$;


-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants_par_age
-- ============================================================
-- Objectif : Retourne le nombre d'étudiants dans une tranche d'âge
-- Valide que min_age <= max_age avant d'exécuter la requête
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    -- Validation de la tranche d'âge
    IF min_age > max_age THEN
        RAISE EXCEPTION 'Tranche d''âge invalide : min (%) > max (%)', min_age, max_age;
    END IF;

    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RAISE NOTICE '% étudiant(s) trouvé(s) entre % et % ans', total, min_age, max_age;

    RETURN total;
END;
$$;


-- ============================================================
-- 3️⃣ Procédure : inscrire_etudiant_cours
-- ============================================================
-- Objectif : Inscrire un étudiant à un cours
-- Vérifie l'existence de l'étudiant, du cours et l'absence de doublon
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id    INT;
BEGIN
    -- Récupérer l'étudiant
    SELECT id INTO v_etudiant_id
    FROM etudiants
    WHERE email = etudiant_email;

    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Étudiant non trouvé avec l''email : %', etudiant_email;
    END IF;

    -- Récupérer le cours
    SELECT id INTO v_cours_id
    FROM cours
    WHERE nom = cours_nom;

    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouvé : %', cours_nom;
    END IF;

    -- Vérifier que l'inscription n'existe pas déjà
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
    VALUES ('INSCRIPTION : ' || etudiant_email || ' → ' || cours_nom);

    RAISE NOTICE 'Inscription réussie : % → %', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur inscription : %', SQLERRM;
END;
$$;


-- ============================================================
-- 4️⃣ Trigger : validation avant insertion d'un étudiant
-- ============================================================
-- Objectif : Valider âge et email automatiquement avant INSERT
-- Déclenché BEFORE INSERT sur la table etudiants
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    -- Validation de l'âge
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Trigger — Age invalide pour % : % ans (minimum 18 ans)', NEW.nom, NEW.age;
    END IF;

    -- Validation du format email
    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Trigger — Email invalide pour % : %', NEW.nom, NEW.email;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();


-- ============================================================
-- 5️⃣ Trigger : log automatique sur etudiants et inscriptions
-- ============================================================
-- Objectif : Journaliser INSERT, UPDATE et DELETE automatiquement
-- Utilise OLD et NEW pour capturer les détails de chaque opération
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' : id=' || OLD.id::text);
        RETURN OLD;
    ELSE
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' : id=' || NEW.id::text);
        RETURN NEW;
    END IF;
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
