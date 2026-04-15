-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- Étudiant : Ramatoulaye Diallo — 300153476
-- ==================================================================================


-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================
-- Objectif : Ajouter un étudiant avec validations et journalisation
-- Paramètres :
--   nom   TEXT → Nom complet de l'étudiant
--   age   INT  → Âge (doit être >= 18)
--   email TEXT → Adresse courriel valide et unique
-- Retour : aucun (PROCEDURE)
-- Appel   : CALL ajouter_etudiant('Alice', 22, 'alice@email.com');
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validation 1 : l'âge doit être >= 18
    IF age < 18 THEN
        RAISE EXCEPTION 'Âge invalide pour % : % ans — minimum requis : 18 ans', nom, age;
    END IF;

    -- Validation 2 : l'email doit respecter le format standard
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Adresse courriel invalide pour % : "%"', nom, email;
    END IF;

    -- Insertion de l'étudiant dans la table
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- Journalisation de l'action dans la table logs
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom || ' (' || email || ')');

    -- Confirmation de succès
    RAISE NOTICE 'Succès : étudiant "%" ajouté avec l''adresse "%"', nom, email;

EXCEPTION
    WHEN unique_violation THEN
        -- Cas spécifique : email déjà utilisé
        RAISE NOTICE 'Erreur : l''adresse "%" est déjà enregistrée dans la base.', email;
    WHEN others THEN
        -- Tous les autres cas d'erreur
        RAISE NOTICE 'Erreur lors de l''ajout de "%" : %', nom, SQLERRM;
END;
$$;


-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants_par_age
-- ============================================================
-- Objectif : Retourner le nombre d'étudiants dans une tranche d'âge
-- Paramètres :
--   min_age INT → Âge minimum (inclus)
--   max_age INT → Âge maximum (inclus)
-- Retour  : INT → nombre d'étudiants dans la tranche
-- Appel   : SELECT nombre_etudiants_par_age(18, 25);
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    -- Validation : la tranche doit être logique
    IF min_age > max_age THEN
        RAISE EXCEPTION 'Plage d''âge invalide : min (%) ne peut pas être supérieur à max (%)', min_age, max_age;
    END IF;

    -- Compter les étudiants dans la tranche d'âge
    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RAISE NOTICE 'Nombre d''étudiants entre % et % ans : %', min_age, max_age, total;

    RETURN total;
END;
$$;


-- ============================================================
-- 3️⃣ Trigger : validation avant insertion d'un étudiant
-- ============================================================
-- Objectif  : Valider âge et email AVANT toute insertion dans etudiants
-- Événement : BEFORE INSERT ON etudiants
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    -- Validation de l'âge
    IF NEW.age < 18 THEN
        RAISE EXCEPTION
            'Insertion refusée — âge invalide pour "%" : % ans (minimum : 18 ans)',
            NEW.nom, NEW.age;
    END IF;

    -- Validation du format du courriel
    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION
            'Insertion refusée — courriel invalide pour "%" : "%"',
            NEW.nom, NEW.email;
    END IF;

    -- Tout est valide : on laisse passer la ligne
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();


-- ============================================================
-- 4️⃣ Trigger : log automatique sur etudiants
-- ============================================================
-- Objectif  : Journaliser INSERT, UPDATE et DELETE sur etudiants
-- Utilise TG_OP, NEW et OLD pour des logs détaillés
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
DECLARE
    detail TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        detail := 'INSERT sur ' || TG_TABLE_NAME
               || ' — nouveau : ' || NEW.nom;

    ELSIF TG_OP = 'UPDATE' THEN
        detail := 'UPDATE sur ' || TG_TABLE_NAME
               || ' — avant : ' || OLD.nom
               || ' / après : ' || NEW.nom;

    ELSIF TG_OP = 'DELETE' THEN
        detail := 'DELETE sur ' || TG_TABLE_NAME
               || ' — supprimé : ' || OLD.nom;
        INSERT INTO logs(action) VALUES (detail);
        RETURN OLD;
    END IF;

    INSERT INTO logs(action) VALUES (detail);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();
