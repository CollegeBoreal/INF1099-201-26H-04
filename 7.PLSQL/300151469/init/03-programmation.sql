-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================

-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================
-- Objectif : Ajouter un étudiant avec validations et journalisation
-- Paramètres :
--   nom   TEXT  → nom complet de l'étudiant
--   age   INT   → âge (doit être >= 18)
--   email TEXT  → adresse email unique et valide
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation : l'âge doit être >= 18
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : l''âge minimum est 18 ans (age fourni : %)', nom, age;
    END IF;

    -- Validation : format de l'email (doit contenir @ et un domaine)
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : format attendu exemple@domaine.com (email fourni : %)', nom, email;
    END IF;

    -- Insertion de l'étudiant dans la table
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- Journalisation de l'action dans la table logs
    INSERT INTO logs(action)
    VALUES ('AJOUT étudiant : ' || nom || ' (email : ' || email || ')');

    -- Message de confirmation
    RAISE NOTICE 'Étudiant ajouté avec succès : % (age : %, email : %)', nom, age, email;

EXCEPTION
    WHEN unique_violation THEN
        -- L'email existe déjà dans la table
        RAISE NOTICE 'Erreur : l''email % est déjà utilisé par un autre étudiant.', email;
    WHEN others THEN
        -- Toute autre erreur inattendue
        RAISE NOTICE 'Erreur lors de l''ajout de % : %', nom, SQLERRM;
END;
$$;


-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants_par_age
-- ============================================================
-- Objectif : Retourne le nombre d'étudiants dans une tranche d'âge
-- Paramètres :
--   min_age INT → âge minimum (inclus)
--   max_age INT → âge maximum (inclus)
-- Retour : INT → nombre d'étudiants dans la tranche
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    -- Validation : min_age ne peut pas être supérieur à max_age
    IF min_age > max_age THEN
        RAISE EXCEPTION 'Plage d''âge invalide : min_age (%) ne peut pas être supérieur à max_age (%)', min_age, max_age;
    END IF;

    -- Compter les étudiants dont l'âge est dans la tranche
    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RAISE NOTICE 'Nombre d''étudiants entre % et % ans : %', min_age, max_age, total;

    RETURN total;
END;
$$;


-- ============================================================
-- 3️⃣ Procédure : inscrire_etudiant_cours
-- ============================================================
-- Objectif : Inscrire un étudiant à un cours avec vérifications
-- Paramètres :
--   etudiant_email TEXT → email de l'étudiant à inscrire
--   cours_nom      TEXT → nom du cours cible
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
    v_cours_id    INT;
BEGIN
    -- Récupérer l'id de l'étudiant via son email
    SELECT id INTO v_etudiant_id
    FROM etudiants
    WHERE email = etudiant_email;

    -- Vérifier que l'étudiant existe
    IF v_etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Étudiant non trouvé avec l''email : %', etudiant_email;
    END IF;

    -- Récupérer l'id du cours via son nom
    SELECT id INTO v_cours_id
    FROM cours
    WHERE nom = cours_nom;

    -- Vérifier que le cours existe
    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouvé : %', cours_nom;
    END IF;

    -- Vérifier que l'étudiant n'est pas déjà inscrit à ce cours
    IF EXISTS (
        SELECT 1 FROM inscriptions
        WHERE etudiant_id = v_etudiant_id
          AND cours_id    = v_cours_id
    ) THEN
        RAISE EXCEPTION 'L''étudiant % est déjà inscrit au cours %', etudiant_email, cours_nom;
    END IF;

    -- Créer l'inscription
    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    -- Journaliser l'inscription
    INSERT INTO logs(action)
    VALUES ('INSCRIPTION : ' || etudiant_email || ' → cours "' || cours_nom || '"');

    -- Confirmation
    RAISE NOTICE 'Inscription réussie : % → cours "%"', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l''inscription de % au cours % : %', etudiant_email, cours_nom, SQLERRM;
END;
$$;


-- ============================================================
-- 4️⃣ Trigger : validation avant insertion d'un étudiant
-- ============================================================
-- Objectif : Valider les données (âge, email) AVANT chaque INSERT
--            sur la table etudiants
-- Déclenché : BEFORE INSERT ON etudiants
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    -- Validation de l'âge minimum
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Trigger - Age invalide pour % : % ans (minimum 18 ans requis)', NEW.nom, NEW.age;
    END IF;

    -- Validation du format de l'email
    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Trigger - Email invalide pour % : % (format attendu : exemple@domaine.com)', NEW.nom, NEW.email;
    END IF;

    -- Tout est valide, on autorise l'insertion
    RAISE NOTICE 'Trigger validation OK pour : %', NEW.nom;
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
-- Objectif : Journaliser automatiquement toutes les opérations
--            INSERT, UPDATE, DELETE sur les tables surveillées
-- Déclenché : AFTER INSERT OR UPDATE OR DELETE
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
DECLARE
    detail  TEXT;
    sujet   TEXT;
    sujet_old TEXT;
BEGIN
    -- Identifier la ligne concernée selon la table
    -- etudiants  → utiliser le nom
    -- inscriptions → utiliser etudiant_id et cours_id
    IF TG_TABLE_NAME = 'etudiants' THEN
        IF TG_OP = 'DELETE' THEN
            sujet := 'nom=' || OLD.nom;
        ELSE
            sujet := 'nom=' || NEW.nom;
            sujet_old := 'nom=' || OLD.nom;
        END IF;
    ELSIF TG_TABLE_NAME = 'inscriptions' THEN
        IF TG_OP = 'DELETE' THEN
            sujet := 'etudiant_id=' || OLD.etudiant_id || ', cours_id=' || OLD.cours_id;
        ELSE
            sujet := 'etudiant_id=' || NEW.etudiant_id || ', cours_id=' || NEW.cours_id;
            sujet_old := 'etudiant_id=' || OLD.etudiant_id || ', cours_id=' || OLD.cours_id;
        END IF;
    ELSE
        sujet := 'id=' || COALESCE(NEW.id::text, OLD.id::text);
    END IF;

    -- Construire le message de log selon l'opération
    IF TG_OP = 'INSERT' THEN
        detail := 'INSERT sur ' || TG_TABLE_NAME || ' : ' || sujet;

    ELSIF TG_OP = 'UPDATE' THEN
        detail := 'UPDATE sur ' || TG_TABLE_NAME
               || ' : avant="' || sujet_old
               || '" → après="' || sujet || '"';

    ELSIF TG_OP = 'DELETE' THEN
        detail := 'DELETE sur ' || TG_TABLE_NAME || ' : ' || sujet;
        INSERT INTO logs(action) VALUES (detail);
        RETURN OLD;
    END IF;

    INSERT INTO logs(action) VALUES (detail);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger sur la table etudiants
CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

-- Trigger sur la table inscriptions
CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();
