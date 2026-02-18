1️⃣ Préparation
Se connecter en tant que superutilisateur :

psql -U postgres
Créer la base de test :

CREATE DATABASE cours;
\c cours
Créer un schéma :

CREATE SCHEMA tp_dcl;
Créer un tableau pour l'exercice :

CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);
🎯 Rappel fondamental
PostgreSQL fonctionne ainsi :

Cluster
 ├── Base 1 (postgres)
 ├── Base 2 (cours)
 │     └── Schéma tp_dcl
 │           └── Table etudiants
 └── Base 3 (appdb)
Un schéma appartient à une base. Une table appartient à un schéma. Les droits sont liés à la base courante.

2️⃣ Créer des utilisateurs
-- Étudiant simple (lecture)
CREATE USER etudiant WITH PASSWORD 'etudiant123';

-- Professeur (lecture/écriture)
CREATE USER professeur WITH PASSWORD 'prof123';
3️⃣ Donner des droits (GRANT)
🔹 Connexion à la base
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
🔹 Accès au schéma
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
🔹 Droits sur la table
-- Étudiant : lecture seule
GRANT SELECT ON tp_dcl.etudiants TO etudiant;

-- Professeur : lecture + écriture
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;

-- Donner les droits sur la séquence
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;
Se déconnecter:

--quit
\q 
4️⃣ vérifier les droits
Se connecter en tant qu'étudiant :

psql -U etudiant -d cours
Testeur :

SELECT * FROM tp_dcl.etudiants;  -- OK
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 85); -- ERREUR
Se connecter en tant que professeur :

psql -U professeur -d cours
Testeur :

INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Khaled', 90); -- OK
UPDATE tp_dcl.etudiants SET moyenne=95 WHERE nom='Khaled';       -- OK
5️⃣ Retirer des droits (REVOKE)
-- Retirer le droit lecture à l’étudiant
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
vérifier la modification :

\c - etudiant
SELECT * FROM tp_dcl.etudiants;  -- ERREUR maintenant
6️⃣ Supprimer un utilisateur (DROP USER)
DROP USER etudiant;
DROP USER professeur;
