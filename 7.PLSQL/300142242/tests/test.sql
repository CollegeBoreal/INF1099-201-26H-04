-- ============================================================
-- test.sql - Exécution des tests pour PL/SQL
-- ============================================================

\echo '--- TEST 1: Insertion valide (Procédure) ---'
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

\echo '--- TEST 2: Insertion invalide - Age trop bas (Procédure gérée par EXCEPTION) ---'
CALL ajouter_etudiant('Bob', 15, 'bob@email.com');

\echo '--- TEST 3: Utilisation de la fonction ---'
SELECT nombre_etudiants_par_age(18, 25) AS etudiants_18_25;

\echo '--- TEST 4: Inscription à un cours (Procédure) ---'
CALL inscrire_etudiant_cours('ali@email.com', 'Bases de donnees');

\echo '--- TEST 5: Trigger bloquant une insertion directe ---'
-- Ce test échouera intentionnellement à cause du trigger BEFORE INSERT
INSERT INTO etudiants (nom, age, email) VALUES ('TriggerTestFail', 12, 'fail@email.com');

\echo '--- VÉRIFICATION FINALE: Contenu de la table Logs ---'
SELECT * FROM logs ORDER BY date_action;
