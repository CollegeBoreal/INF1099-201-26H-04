<<<<<<< HEAD
<<<<<<< HEAD
-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================

=======

-- Tables supplémentaires nécessaires
CREATE TABLE IF NOT EXISTS cours (
    id SERIAL PRIMARY KEY,
    nom TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS inscriptions (
    id SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id),
    cours_id    INT REFERENCES cours(id),
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23

-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================
<<<<<<< HEAD
=======
-- Objectif : Ajouter un étudiant avec validations et journalisation
-- ============================================================
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
<<<<<<< HEAD
    -- Vérifier que l'âge est >= 18
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : % ans (minimum 18 ans requis)', nom, age;
=======
    -- Vérifier que l'âge >= 18
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', nom;
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    END IF;

    -- Vérifier que l'email est valide
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
<<<<<<< HEAD
        RAISE EXCEPTION 'Email invalide pour % : %', nom, email;
=======
        RAISE EXCEPTION 'Email invalide pour %', nom;
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    END IF;

    -- Insertion de l'étudiant
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

<<<<<<< HEAD
    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom || ' (age: ' || age || ', email: ' || email || ')');

    -- Confirmation
    RAISE NOTICE 'Étudiant ajouté avec succès : % (%, %)', nom, age, email;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Erreur : l''email % est déjà utilisé par un autre étudiant.', email;
    WHEN others THEN
=======
    -- Journalisation dans logs
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom);

    -- RAISE NOTICE indiquant succès
    RAISE NOTICE 'Etudiant ajouté avec succès : %', nom;

EXCEPTION
    WHEN others THEN
        -- RAISE NOTICE indiquant erreur
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
        RAISE NOTICE 'Erreur lors de l''ajout de % : %', nom, SQLERRM;
END;
$$;

<<<<<<< HEAD

-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants_par_age
=======
-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants
-- ============================================================
-- Objectif : Retourne le nombre total d'étudiants
-- Appelée dans test.sql : SELECT nombre_etudiants();
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM etudiants;

    RETURN total;
END;
$$;

-- ============================================================
-- 3️⃣ Fonction : nombre_etudiants_par_age
-- ============================================================
-- Objectif : Retourne le nombre d'étudiants dans une tranche d'âge
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
<<<<<<< HEAD
    -- Validation des paramètres
    IF min_age < 0 OR max_age < 0 THEN
        RAISE EXCEPTION 'Les âges doivent être positifs (min: %, max: %)', min_age, max_age;
    END IF;

    IF min_age > max_age THEN
        RAISE EXCEPTION 'L''âge minimum (%) ne peut pas être supérieur à l''âge maximum (%)', min_age, max_age;
    END IF;

=======
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

<<<<<<< HEAD
    RAISE NOTICE 'Nombre d''étudiants entre % et % ans : %', min_age, max_age, total;

=======
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    RETURN total;
END;
$$;

<<<<<<< HEAD

-- ============================================================
-- 3️⃣ Procédure : inscrire_etudiant_cours
=======
-- ============================================================
-- 4️⃣ Procédure : inscrire_etudiant_cours
-- ============================================================
-- Objectif : Inscrire un étudiant à un cours avec validations
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_etudiant_id INT;
<<<<<<< HEAD
    v_cours_id INT;
=======
    v_cours_id    INT;
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
BEGIN
    -- Récupérer id étudiant et vérifier existence
    SELECT id INTO v_etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF v_etudiant_id IS NULL THEN
<<<<<<< HEAD
        RAISE EXCEPTION 'Étudiant non trouvé avec l''email : %', etudiant_email;
=======
        RAISE EXCEPTION 'Etudiant non trouvé : %', etudiant_email;
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    END IF;

    -- Récupérer id cours et vérifier existence
    SELECT id INTO v_cours_id FROM cours WHERE nom = cours_nom;
    IF v_cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouvé : %', cours_nom;
    END IF;

    -- Vérifier que l'inscription n'existe pas déjà
    IF EXISTS(
        SELECT 1 FROM inscriptions
<<<<<<< HEAD
        WHERE etudiant_id = v_etudiant_id AND cours_id = v_cours_id
    ) THEN
        RAISE EXCEPTION 'L''étudiant % est déjà inscrit au cours %', etudiant_email, cours_nom;
=======
        WHERE etudiant_id = v_etudiant_id
          AND cours_id    = v_cours_id
    ) THEN
        RAISE EXCEPTION 'Etudiant déjà inscrit à ce cours';
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    END IF;

    -- Insertion dans inscriptions
    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (v_etudiant_id, v_cours_id);

    -- Journalisation
    INSERT INTO logs(action)
<<<<<<< HEAD
    VALUES ('Inscription : ' || etudiant_email || ' -> cours : ' || cours_nom);

    RAISE NOTICE 'Inscription réussie : % inscrit au cours %', etudiant_email, cours_nom;
=======
    VALUES ('Inscription étudiant ' || etudiant_email || ' au cours ' || cours_nom);

    RAISE NOTICE 'Inscription réussie : % -> %', etudiant_email, cours_nom;
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur inscription : %', SQLERRM;
END;
$$;

<<<<<<< HEAD

-- ============================================================
-- 4️⃣ Trigger : validation avant insertion d'un étudiant
=======
-- ============================================================
-- 5️⃣ Trigger : validation avant insertion d'un étudiant
-- ============================================================
-- Objectif : Valider âge et email avant toute insertion
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
<<<<<<< HEAD
    -- Validation de l'âge
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Trigger - Age invalide pour % : % ans (minimum 18 ans)', NEW.nom, NEW.age;
    END IF;

    -- Validation du format email
    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Trigger - Email invalide pour % : %', NEW.nom, NEW.email;
    END IF;

    RAISE NOTICE 'Trigger validation OK pour : %', NEW.nom;

=======
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : % (minimum 18 ans)', NEW.nom, NEW.age;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', NEW.nom, NEW.email;
    END IF;

>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

<<<<<<< HEAD

-- ============================================================
-- 5️⃣ Trigger : log automatique sur etudiants et inscriptions
=======
-- ============================================================
-- 6️⃣ Trigger : log automatique sur etudiants et inscriptions
-- ============================================================
-- Objectif : Journaliser INSERT, UPDATE, DELETE automatiquement
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
<<<<<<< HEAD
DECLARE
    details TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        details := 'Nouveau : ' || NEW.nom;
    ELSIF TG_OP = 'UPDATE' THEN
        details := 'Modifié : ' || OLD.nom || ' -> ' || NEW.nom;
    ELSIF TG_OP = 'DELETE' THEN
        details := 'Supprimé : ' || OLD.nom;
        INSERT INTO logs(action)
        VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' | ' || details);
        RETURN OLD;
    END IF;

    INSERT INTO logs(action)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' | ' || details);

=======
BEGIN
    INSERT INTO logs(action)
    VALUES (
        TG_OP || ' sur ' || TG_TABLE_NAME || ' : ' ||
        COALESCE(NEW.nom::text, OLD.nom::text)
    );
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
    RETURN NEW;
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
=======
-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================

-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================
-- Objectif : Ajouter un étudiant avec validations et journalisation
-- Étudiant doit compléter : la partie RAISE NOTICE, exceptions, validations
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- TODO : Vérifier que l'âge >= 18
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', nom;
    END IF;

    -- TODO : Vérifier que l'email est valide et unique
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', nom;
    END IF;

    -- Insertion de l'étudiant
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- TODO : Ajouter journalisation dans logs
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom);

    -- TODO : RAISE NOTICE indiquant succès
    RAISE NOTICE 'Etudiant ajouté : %', nom;

EXCEPTION
    WHEN others THEN
        -- TODO : RAISE NOTICE indiquant erreur
        RAISE NOTICE 'Erreur lors de l’ajout de % : %', nom, SQLERRM;
END;
$$;

-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants_par_age
-- ============================================================
-- Objectif : Retourne le nombre d'étudiants dans une tranche d'âge
-- Étudiant doit compléter : éventuellement optimisations ou validations supplémentaires
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$$;


-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants
-- ============================================================
-- Objectif : Retourne le nombre total d'étudiants
-- Appelée dans test.sql : SELECT nombre_etudiants();
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM etudiants;

    RETURN total;
END;
$$;

-- ============================================================
-- 3️⃣ Procédure : inscrire_etudiant_cours
-- ============================================================
-- Objectif : Inscrire un étudiant à un cours
-- Étudiant doit compléter : vérification existence étudiant/cours, gestion erreurs
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    etudiant_id INT;
    cours_id INT;
BEGIN
    -- TODO : récupérer id étudiant et vérifier existence
    SELECT id INTO etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouvé : %', etudiant_email;
    END IF;

    -- TODO : récupérer id cours et vérifier existence
    SELECT id INTO cours_id FROM cours WHERE nom = cours_nom;
    IF cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouvé : %', cours_nom;
    END IF;

    -- TODO : Vérifier que l'inscription n'existe pas déjà
    IF EXISTS(SELECT 1 FROM inscriptions WHERE etudiant_id = etudiant_id AND cours_id = cours_id) THEN
        RAISE EXCEPTION 'Etudiant déjà inscrit à ce cours';
    END IF;

    -- Insertion dans inscriptions
    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (etudiant_id, cours_id);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Inscription étudiant ' || etudiant_email || ' au cours ' || cours_nom);

    RAISE NOTICE 'Inscription réussie : % -> %', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur inscription : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4️⃣ Trigger validation avant insertion d'un étudiant
-- ============================================================
-- Objectif : Valider âge et email avant insertions automatiques
-- Étudiant doit compléter : éventuellement messages d'erreur plus détaillés
-- ============================================================

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

-- ============================================================
-- 5️⃣ Trigger log automatique sur etudiants et inscriptions
-- ============================================================
-- Objectif : journaliser toutes les modifications (INSERT, UPDATE, DELETE)
-- Étudiant doit compléter : gestion des OLD/NEW pour logs plus détaillés
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ': ' || COALESCE(NEW.nom::text, OLD.nom::text));
    RETURN NEW;
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




>>>>>>> f650d2d5a543182bc73855a0024af6ff9f85c796
