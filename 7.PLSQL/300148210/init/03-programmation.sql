-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================


-- ============================================================
-- 1️⃣  Procédure : ajouter_etudiant
-- ============================================================
-- Objectif : Ajouter un étudiant avec validations et journalisation
--
-- Validations :
--   - age >= 18
--   - email au format valide (regex)
--   - email unique (géré aussi par contrainte UNIQUE, mais on lève une erreur claire)
--
-- Comportement :
--   - RAISE NOTICE en cas de succès
--   - RAISE NOTICE avec le message d'erreur en cas d'échec (l'exception est relancée
--     pour que l'appelant puisse la capter dans test.sql)
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(p_nom TEXT, p_age INT, p_email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- ── Validation de l'âge ───────────────────────────────────────────────────
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Âge invalide (%) pour % : l''étudiant doit avoir au moins 18 ans.',
            p_age, p_nom;
    END IF;

    -- ── Validation du format email (regex simple) ─────────────────────────────
    IF p_email !~* '^[^@\s]+@[^@\s]+\.[^@\s]+$' THEN
        RAISE EXCEPTION 'Email invalide (%) pour %.', p_email, p_nom;
    END IF;

    -- ── Vérification unicité de l'email ──────────────────────────────────────
    IF EXISTS (SELECT 1 FROM etudiants WHERE email = p_email) THEN
        RAISE EXCEPTION 'L''email % est déjà utilisé par un autre étudiant.', p_email;
    END IF;

    -- ── Insertion ─────────────────────────────────────────────────────────────
    INSERT INTO etudiants (nom, age, email)
    VALUES (p_nom, p_age, p_email);

    -- ── Journalisation manuelle (complète le trigger automatique) ─────────────
    INSERT INTO logs (action)
    VALUES ('PROCEDURE ajouter_etudiant → étudiant ajouté : ' || p_nom
            || ' (email: ' || p_email || ', âge: ' || p_age || ')');

    -- ── Confirmation ──────────────────────────────────────────────────────────
    RAISE NOTICE '[OK] Étudiant ajouté avec succès : % (email: %, âge: %)',
        p_nom, p_email, p_age;

EXCEPTION
    WHEN others THEN
        -- Log de l'erreur puis on la remonte à l'appelant
        RAISE NOTICE '[ERREUR] Impossible d''ajouter % : %', p_nom, SQLERRM;
        RAISE;   -- relance l'exception pour que test.sql puisse la catcher
END;
$$;


-- ============================================================
-- 2️⃣  Fonction : nombre_etudiants_par_age
-- ============================================================
-- Retourne le nombre d'étudiants dont l'âge est compris dans [min_age, max_age].
-- Retourne 0 si la tranche est vide ou invalide.
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(p_min_age INT, p_max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    -- ── Validation de la tranche ──────────────────────────────────────────────
    IF p_min_age > p_max_age THEN
        RAISE NOTICE '[AVERTISSEMENT] min_age (%) > max_age (%) → résultat sera 0.',
            p_min_age, p_max_age;
        RETURN 0;
    END IF;

    -- ── Comptage ──────────────────────────────────────────────────────────────
    SELECT COUNT(*)
      INTO v_total
      FROM etudiants
     WHERE age BETWEEN p_min_age AND p_max_age;

    RAISE NOTICE '[INFO] Étudiants entre % et % ans : %', p_min_age, p_max_age, v_total;
    RETURN v_total;
END;
$$;


-- ============================================================
-- 2️⃣ bis  Fonction : nombre_etudiants  (alias sans paramètres)
-- ============================================================
-- Retourne le nombre total d'étudiants (utilisée dans test.sql).
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total FROM etudiants;
    RAISE NOTICE '[INFO] Nombre total d''étudiants : %', v_total;
    RETURN v_total;
END;
$$;


-- ============================================================
-- 3️⃣  Procédure : inscrire_etudiant_cours
-- ============================================================
-- Objectif : Inscrire un étudiant à un cours avec vérifications complètes.
--
-- Vérifications :
--   - L'étudiant existe (par email)
--   - Le cours existe (par nom)
--   - L'inscription n'est pas déjà présente
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(p_email TEXT, p_cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id    INT;
    v_etudiant_nom TEXT;
BEGIN
    -- ── Récupération de l'étudiant ────────────────────────────────────────────
    SELECT id, nom
      INTO v_etudiant_id, v_etudiant_nom
      FROM etudiants
     WHERE email = p_email;

    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Aucun étudiant trouvé avec l''email %.', p_email;
    END IF;

    -- ── Récupération du cours ─────────────────────────────────────────────────
    SELECT id
      INTO v_cours_id
      FROM cours
     WHERE nom = p_cours_nom;

    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours introuvable : %.', p_cours_nom;
    END IF;

    -- ── Vérification de doublon ───────────────────────────────────────────────
    IF EXISTS (
        SELECT 1
          FROM inscriptions
         WHERE etudiant_id = v_etudiant_id
           AND cours_id    = v_cours_id
    ) THEN
        RAISE EXCEPTION '% (%) est déjà inscrit au cours "%".',
            v_etudiant_nom, p_email, p_cours_nom;
    END IF;

    -- ── Insertion ─────────────────────────────────────────────────────────────
    INSERT INTO inscriptions (etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    -- ── Journalisation ────────────────────────────────────────────────────────
    INSERT INTO logs (action)
    VALUES ('PROCEDURE inscrire_etudiant_cours → ' || v_etudiant_nom
            || ' (' || p_email || ') inscrit au cours : ' || p_cours_nom);

    RAISE NOTICE '[OK] Inscription réussie : % → cours "%"', v_etudiant_nom, p_cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[ERREUR] Inscription échouée (% / %) : %',
            p_email, p_cours_nom, SQLERRM;
        RAISE;
END;
$$;


-- ============================================================
-- 4️⃣  Trigger : validation BEFORE INSERT sur etudiants
-- ============================================================
-- Empêche toute insertion directe (hors procédure) avec âge < 18 ou email invalide.
-- Ce trigger protège la table même si quelqu'un insère sans passer par la procédure.
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    -- ── Contrôle de l'âge ─────────────────────────────────────────────────────
    IF NEW.age IS NOT NULL AND NEW.age < 18 THEN
        RAISE EXCEPTION '[TRIGGER valider_etudiant] Âge invalide (%) pour % : minimum 18 ans requis.',
            NEW.age, NEW.nom;
    END IF;

    -- ── Contrôle du format email ──────────────────────────────────────────────
    IF NEW.email IS NOT NULL AND NEW.email !~* '^[^@\s]+@[^@\s]+\.[^@\s]+$' THEN
        RAISE EXCEPTION '[TRIGGER valider_etudiant] Email invalide (%) pour %.',
            NEW.email, NEW.nom;
    END IF;

    -- Si tout est valide, on laisse passer la ligne
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- On supprime le trigger s'il existe déjà (pour les re-exécutions)
DROP TRIGGER IF EXISTS trg_valider_etudiant ON etudiants;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();


-- ============================================================
-- 5️⃣  Trigger : log automatique sur etudiants et inscriptions
-- ============================================================
-- Journalise chaque INSERT, UPDATE et DELETE avec les données OLD/NEW.
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
DECLARE
    v_detail TEXT;
BEGIN
    -- ── Construction du message selon l'opération ─────────────────────────────
    CASE TG_OP

        WHEN 'INSERT' THEN
            -- On affiche les colonnes pertinentes selon la table
            IF TG_TABLE_NAME = 'etudiants' THEN
                v_detail := 'nouveau étudiant → id=' || NEW.id
                         || ', nom=' || NEW.nom
                         || ', age=' || NEW.age
                         || ', email=' || NEW.email;
            ELSIF TG_TABLE_NAME = 'inscriptions' THEN
                v_detail := 'nouvelle inscription → etudiant_id=' || NEW.etudiant_id
                         || ', cours_id=' || NEW.cours_id;
            ELSE
                v_detail := 'id=' || NEW.id;
            END IF;

        WHEN 'UPDATE' THEN
            IF TG_TABLE_NAME = 'etudiants' THEN
                v_detail := 'modification étudiant id=' || NEW.id
                         || ' | avant: nom=' || OLD.nom || ', age=' || OLD.age
                         || ' | après: nom=' || NEW.nom || ', age=' || NEW.age;
            ELSIF TG_TABLE_NAME = 'inscriptions' THEN
                v_detail := 'modification inscription id=' || NEW.id;
            ELSE
                v_detail := 'id=' || NEW.id;
            END IF;

        WHEN 'DELETE' THEN
            IF TG_TABLE_NAME = 'etudiants' THEN
                v_detail := 'suppression étudiant id=' || OLD.id
                         || ', nom=' || OLD.nom
                         || ', email=' || OLD.email;
            ELSIF TG_TABLE_NAME = 'inscriptions' THEN
                v_detail := 'suppression inscription id=' || OLD.id
                         || ', etudiant_id=' || OLD.etudiant_id
                         || ', cours_id=' || OLD.cours_id;
            ELSE
                v_detail := 'id=' || OLD.id;
            END IF;

        ELSE
            v_detail := '(opération inconnue)';
    END CASE;

    -- ── Insertion dans la table logs ──────────────────────────────────────────
    INSERT INTO logs (action)
    VALUES ('[TRIGGER] ' || TG_OP || ' sur ' || TG_TABLE_NAME || ' → ' || v_detail);

    -- Pour DELETE on retourne OLD, pour INSERT/UPDATE on retourne NEW
    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger sur etudiants
DROP TRIGGER IF EXISTS trg_log_etudiant ON etudiants;
CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

-- Trigger sur inscriptions
DROP TRIGGER IF EXISTS trg_log_inscription ON inscriptions;
CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();
