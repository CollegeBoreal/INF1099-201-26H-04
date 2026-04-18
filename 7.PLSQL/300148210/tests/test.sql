-- ==================================================================================
-- tests/test.sql — Tests complets du TP
-- ==================================================================================
-- Lancer avec :
--   Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
-- ==================================================================================


-- ============================================================
-- TEST 1 — Insertion valide
-- ✅ Attendu : étudiant ajouté, NOTICE de succès
-- ============================================================
\echo '--- TEST 1 : Insertion valide ---'
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');


-- ============================================================
-- TEST 2 — Insertion avec âge invalide (< 18)
-- ✅ Attendu : NOTICE d''erreur, pas d''insertion
-- ============================================================
\echo '--- TEST 2 : Age invalide ---'
CALL ajouter_etudiant('Bob', 15, 'bob@email.com');


-- ============================================================
-- TEST 3 — Insertion avec email invalide
-- ✅ Attendu : NOTICE d''erreur, pas d''insertion
-- ============================================================
\echo '--- TEST 3 : Email invalide ---'
CALL ajouter_etudiant('Charlie', 20, 'pas-un-email');


-- ============================================================
-- TEST 4 — Insertion avec email déjà existant
-- ✅ Attendu : NOTICE erreur unique_violation
-- ============================================================
\echo '--- TEST 4 : Email en doublon ---'
CALL ajouter_etudiant('Dupont', 21, 'ali@email.com');


-- ============================================================
-- TEST 5 — Fonction nombre_etudiants_par_age
-- ✅ Attendu : retourne le nombre d''étudiants entre 18 et 30 ans
-- ============================================================
\echo '--- TEST 5 : Fonction nombre_etudiants_par_age ---'
SELECT nombre_etudiants_par_age(18, 30);


-- ============================================================
-- TEST 6 — Inscription valide à un cours
-- ✅ Attendu : inscription réussie
-- ============================================================
\echo '--- TEST 6 : Inscription valide ---'
CALL inscrire_etudiant_cours('ali@email.com', 'Mathématiques');


-- ============================================================
-- TEST 7 — Inscription doublon
-- ✅ Attendu : NOTICE erreur doublon
-- ============================================================
\echo '--- TEST 7 : Inscription doublon ---'
CALL inscrire_etudiant_cours('ali@email.com', 'Mathématiques');


-- ============================================================
-- TEST 8 — Inscription avec étudiant inexistant
-- ✅ Attendu : NOTICE erreur étudiant introuvable
-- ============================================================
\echo '--- TEST 8 : Etudiant inexistant ---'
CALL inscrire_etudiant_cours('fantome@email.com', 'Mathématiques');


-- ============================================================
-- RÉSULTATS FINAUX
-- ============================================================
\echo '--- ETUDIANTS ---'
SELECT * FROM etudiants;

\echo '--- INSCRIPTIONS ---'
SELECT e.nom, c.nom AS cours
FROM inscriptions i
JOIN etudiants e ON e.id = i.etudiant_id
JOIN cours c     ON c.id = i.cours_id;

\echo '--- LOGS ---'
SELECT * FROM logs ORDER BY date_action;
