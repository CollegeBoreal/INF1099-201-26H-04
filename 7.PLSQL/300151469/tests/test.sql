-- ==================================================================================
-- tests/test.sql
-- TP PostgreSQL : Jeu de tests complets
-- ==================================================================================

-- ============================================================
-- TEST 1 : Insertion valide d'un étudiant via la procédure
-- ============================================================
-- Résultat attendu : NOTICE 'Étudiant ajouté avec succès : Ali'
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- ============================================================
-- TEST 2 : Insertion invalide — âge inférieur à 18
-- ============================================================
-- Résultat attendu : NOTICE 'Erreur lors de l'ajout de Bob : Age invalide...'
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'TEST 2 OK — Erreur attendue capturée : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- TEST 3 : Insertion invalide — email mal formé
-- ============================================================
-- Résultat attendu : erreur email invalide
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Clara', 20, 'emailsansarobas.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'TEST 3 OK — Erreur attendue capturée : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- TEST 4 : Insertion invalide — email en double
-- ============================================================
-- Résultat attendu : NOTICE email déjà utilisé
CALL ajouter_etudiant('Ali2', 23, 'ali@email.com');

-- ============================================================
-- TEST 5 : Fonction nombre_etudiants_par_age — résultat attendu >= 1
-- ============================================================
SELECT nombre_etudiants_par_age(18, 30) AS etudiants_18_30;

-- ============================================================
-- TEST 6 : Fonction nombre_etudiants_par_age — plage invalide
-- ============================================================
-- Résultat attendu : exception min > max
DO $$
BEGIN
    BEGIN
        PERFORM nombre_etudiants_par_age(30, 18);
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'TEST 6 OK — Erreur attendue capturée : %', SQLERRM;
    END;
END;
$$;

-- ============================================================
-- TEST 7 : Inscription valide d'un étudiant à un cours
-- ============================================================
-- Résultat attendu : NOTICE 'Inscription réussie : ali@email.com → cours "Réseaux"'
CALL inscrire_etudiant_cours('ali@email.com', 'Réseaux');

-- ============================================================
-- TEST 8 : Inscription en double — même étudiant, même cours
-- ============================================================
-- Résultat attendu : NOTICE 'Étudiant déjà inscrit...'
CALL inscrire_etudiant_cours('ali@email.com', 'Réseaux');

-- ============================================================
-- TEST 9 : Inscription avec étudiant inexistant
-- ============================================================
-- Résultat attendu : NOTICE 'Étudiant non trouvé'
CALL inscrire_etudiant_cours('inconnu@email.com', 'Réseaux');

-- ============================================================
-- TEST 10 : Inscription avec cours inexistant
-- ============================================================
-- Résultat attendu : NOTICE 'Cours non trouvé'
CALL inscrire_etudiant_cours('ali@email.com', 'Cours inexistant');

-- ============================================================
-- TEST 11 : Vérification des logs après tous les tests
-- ============================================================
-- Résultat attendu : plusieurs entrées dans les logs
SELECT id, action, date_action
FROM logs
ORDER BY id;

-- ============================================================
-- TEST 12 : Vérification de la liste des étudiants inscrits
-- ============================================================
SELECT e.nom, e.age, e.email, c.nom AS cours
FROM etudiants e
JOIN inscriptions i ON i.etudiant_id = e.id
JOIN cours c        ON c.id = i.cours_id
ORDER BY e.nom, c.nom;
