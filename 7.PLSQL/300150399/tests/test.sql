-- =========================
-- TEST 1 : insertion valide
-- =========================
CALL ajouter_etudiant('Test User', 23, 'test@email.com');

-- =========================
-- TEST 2 : age invalide
-- =========================
CALL ajouter_etudiant('Erreur Age', 15, 'age@email.com');

-- =========================
-- TEST 3 : email invalide
-- =========================
CALL ajouter_etudiant('Erreur Email', 20, 'emailinvalide');

-- =========================
-- TEST 4 : email doublon
-- =========================
CALL ajouter_etudiant('Dup', 22, 'test@email.com');

-- =========================
-- TEST 5 : fonction valide
-- =========================
SELECT nombre_etudiants_par_age(18, 30);

-- =========================
-- TEST 6 : intervalle invalide
-- =========================
SELECT nombre_etudiants_par_age(30, 18);

-- =========================
-- TEST 7 : inscription valide
-- =========================
CALL inscrire_etudiant_cours('test@email.com', 'Bases de données');

-- =========================
-- TEST 8 : doublon inscription
-- =========================
CALL inscrire_etudiant_cours('test@email.com', 'Bases de données');

-- =========================
-- TEST 9 : étudiant inexistant
-- =========================
CALL inscrire_etudiant_cours('fake@email.com', 'Bases de données');

-- =========================
-- VERIFICATION
-- =========================
SELECT * FROM etudiants;
SELECT * FROM inscriptions;
SELECT * FROM logs ORDER BY date_action;
