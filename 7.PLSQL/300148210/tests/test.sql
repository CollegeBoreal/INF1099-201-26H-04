-- ==================================================================================
-- tests/test.sql
-- Jeu de tests complet pour les procédures, fonctions et triggers du TP
-- ==================================================================================

\echo '================================================================='
\echo '  TESTS TP PostgreSQL — Procédures, Fonctions, Triggers'
\echo '================================================================='


-- ─────────────────────────────────────────────────────────────────────────────
-- 1. TESTS : ajouter_etudiant
-- ─────────────────────────────────────────────────────────────────────────────

\echo ''
\echo '--- 1.1 Insertion valide ---'
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

\echo ''
\echo '--- 1.2 Insertion valide ---'
CALL ajouter_etudiant('Sara', 19, 'sara@email.com');

\echo ''
\echo '--- 1.3 Erreur attendue : âge < 18 ---'
DO $$
BEGIN
    CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Erreur bien levée pour âge invalide : %', SQLERRM;
END;
$$;

\echo ''
\echo '--- 1.4 Erreur attendue : email invalide ---'
DO $$
BEGIN
    CALL ajouter_etudiant('Carla', 20, 'carla-sans-arobase.com');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Erreur bien levée pour email invalide : %', SQLERRM;
END;
$$;

\echo ''
\echo '--- 1.5 Erreur attendue : email déjà utilisé ---'
DO $$
BEGIN
    CALL ajouter_etudiant('Ali2', 25, 'ali@email.com');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Erreur bien levée pour email dupliqué : %', SQLERRM;
END;
$$;


-- ─────────────────────────────────────────────────────────────────────────────
-- 2. TESTS : nombre_etudiants / nombre_etudiants_par_age
-- ─────────────────────────────────────────────────────────────────────────────

\echo ''
\echo '--- 2.1 Nombre total d''étudiants ---'
SELECT nombre_etudiants();

\echo ''
\echo '--- 2.2 Étudiants entre 18 et 23 ans ---'
SELECT nombre_etudiants_par_age(18, 23);

\echo ''
\echo '--- 2.3 Tranche vide (40-50 ans) ---'
SELECT nombre_etudiants_par_age(40, 50);

\echo ''
\echo '--- 2.4 Tranche invalide (min > max) ---'
SELECT nombre_etudiants_par_age(30, 20);


-- ─────────────────────────────────────────────────────────────────────────────
-- 3. TESTS : inscrire_etudiant_cours
-- ─────────────────────────────────────────────────────────────────────────────

\echo ''
\echo '--- 3.1 Inscription valide ---'
CALL inscrire_etudiant_cours('ali@email.com', 'Bases de données');

\echo ''
\echo '--- 3.2 Inscription valide (autre cours) ---'
CALL inscrire_etudiant_cours('ali@email.com', 'Algorithmique');

\echo ''
\echo '--- 3.3 Erreur attendue : double inscription ---'
DO $$
BEGIN
    CALL inscrire_etudiant_cours('ali@email.com', 'Bases de données');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Double inscription bloquée : %', SQLERRM;
END;
$$;

\echo ''
\echo '--- 3.4 Erreur attendue : étudiant inconnu ---'
DO $$
BEGIN
    CALL inscrire_etudiant_cours('inconnu@email.com', 'Algorithmique');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Étudiant inexistant bloqué : %', SQLERRM;
END;
$$;

\echo ''
\echo '--- 3.5 Erreur attendue : cours inconnu ---'
DO $$
BEGIN
    CALL inscrire_etudiant_cours('ali@email.com', 'Cours qui n''existe pas');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Cours inexistant bloqué : %', SQLERRM;
END;
$$;


-- ─────────────────────────────────────────────────────────────────────────────
-- 4. TESTS : trigger de validation (INSERT direct sans procédure)
-- ─────────────────────────────────────────────────────────────────────────────

\echo ''
\echo '--- 4.1 Erreur attendue : INSERT direct avec âge < 18 ---'
DO $$
BEGIN
    INSERT INTO etudiants (nom, age, email)
    VALUES ('MineurDirect', 16, 'mineur@email.com');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Trigger a bloqué l''insertion : %', SQLERRM;
END;
$$;

\echo ''
\echo '--- 4.2 Erreur attendue : INSERT direct avec email invalide ---'
DO $$
BEGIN
    INSERT INTO etudiants (nom, age, email)
    VALUES ('EmailInvalide', 20, 'pas-un-email');
EXCEPTION
    WHEN others THEN
        RAISE NOTICE '[TEST OK] Trigger a bloqué l''email invalide : %', SQLERRM;
END;
$$;


-- ─────────────────────────────────────────────────────────────────────────────
-- 5. VÉRIFICATION DES LOGS
-- ─────────────────────────────────────────────────────────────────────────────

\echo ''
\echo '--- 5. Contenu de la table logs ---'
SELECT id, action, date_action
  FROM logs
 ORDER BY id;


-- ─────────────────────────────────────────────────────────────────────────────
-- 6. ÉTAT FINAL DES TABLES
-- ─────────────────────────────────────────────────────────────────────────────

\echo ''
\echo '--- 6.1 Table etudiants ---'
SELECT * FROM etudiants ORDER BY id;

\echo ''
\echo '--- 6.2 Table cours ---'
SELECT * FROM cours ORDER BY id;

\echo ''
\echo '--- 6.3 Table inscriptions ---'
SELECT i.id, e.nom AS etudiant, c.nom AS cours, i.date_inscription
  FROM inscriptions i
  JOIN etudiants e ON e.id = i.etudiant_id
  JOIN cours     c ON c.id = i.cours_id
 ORDER BY i.id;

\echo ''
\echo '================================================================='
\echo '  FIN DES TESTS'
\echo '================================================================='
