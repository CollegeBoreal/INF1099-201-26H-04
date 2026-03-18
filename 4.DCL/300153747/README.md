🗄️ TP PostgreSQL – Gestion des utilisateurs et permissions (DCL)



🎯 Objectifs
Ce TP porte sur la gestion des utilisateurs et des permissions dans PostgreSQL via les commandes DCL (Data Control Language).
À la fin du TP, l'étudiant est capable de :

✅ Créer une base de données et un schéma
✅ Créer des utilisateurs PostgreSQL
✅ Attribuer des droits avec GRANT
✅ Retirer des droits avec REVOKE
✅ Tester les permissions selon les rôles (etudiant / professeur)
✅ Gérer les permissions sur les séquences (SERIAL)
✅ Supprimer des utilisateurs avec DROP USER


🛠️ Prérequis

PostgreSQL installé (via Docker / Podman)
Accès à psql
Conteneur PostgreSQL en cours d'exécution

Connexion au conteneur :
bashdocker exec -it postgres psql -U postgres

1️⃣ Création de la base de données et préparation
1.1 Création de la base cours
sqlCREATE DATABASE cours;
\c cours
1.2 Création du schéma tp_dcl et de la table etudiants
sqlCREATE SCHEMA tp_dcl;

CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);
1.3 Insertion de données de test
sqlINSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Karim', 75);
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Sarah', 88);

SELECT * FROM tp_dcl.etudiants;

<img src="images/Screenshot 2026-02-25 144131.png" width="600">


2️⃣ Création des utilisateurs
Deux utilisateurs sont créés avec des rôles distincts :
UtilisateurRôleMot de passeetudiantLecture seule (SELECT)etudiant123professeurLecture + écritureprof123
sqlCREATE USER etudiant WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';

📸 Capture — Création des utilisateurs et attribution des permissions :

<img src="images/Screenshot 2026-02-25 143612.png" width="600">

3️⃣ Attribution des permissions (GRANT)
3.1 Accès à la base
sqlGRANT CONNECT ON DATABASE cours TO etudiant, professeur;
3.2 Accès au schéma
sqlGRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
3.3 Droits sur la table
sql-- Étudiant : lecture seule
GRANT SELECT ON tp_dcl.etudiants TO etudiant;

-- Professeur : lecture + écriture
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;
3.4 Droits sur la séquence SERIAL
sqlGRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;

📸 Capture — Initialisation complète (autre terminal) :
<img src="images/Screenshot 2026-02-25 144155.png" width="600">

4️⃣ Test des permissions
4.1 Connexion en tant qu'étudiant
bashpsql -U etudiant -d cours

⚠️ Cette commande doit être exécutée dans le terminal (PowerShell), pas dans psql.

sql-- ✅ Autorisé
SELECT * FROM tp_dcl.etudiants;

-- ❌ Refusé
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Alice', 85);
4.2 Connexion en tant que professeur
bashpsql -U professeur -d cours
sql-- ✅ Autorisé
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Bob', 90);

-- ✅ Autorisé
UPDATE tp_dcl.etudiants SET moyenne = 95 WHERE nom = 'Bob';

📸 Capture — Tests SELECT (étudiant OK), INSERT (étudiant refusé), INSERT/UPDATE (professeur OK) :



5️⃣ Retrait d'un droit avec REVOKE
On retire le droit SELECT à l'utilisateur etudiant :
sqlREVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
Test après révocation :
sql-- ❌ Résultat attendu : ERROR: permission denied for table etudiants
SELECT * FROM tp_dcl.etudiants;

6️⃣ Suppression des utilisateurs (DROP USER)
sqlDROP USER etudiant;
DROP USER professeur;

⚠️ Si l'utilisateur courant n'est pas superuser, PostgreSQL refuse cette opération avec l'erreur suivante :
ERROR: permission denied to drop role
DETAIL: Only roles with the CREATEROLE attribute and the ADMIN option on the target roles may drop roles.


📸 Capture — Erreur DROP USER + REVOKE :

<img src="images/Screenshot 2026-02-25 144209.png" width="600">

7️⃣ Bonus — Création d'un rôle enseignant
7.1 Création du rôle et attribution des droits
sqlCREATE ROLE enseignant;

GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO enseignant;
GRANT USAGE ON SCHEMA tp_dcl TO enseignant;
GRANT USAGE, SELECT ON SEQUENCE tp_dcl.etudiants_id_seq TO enseignant;
7.2 Création de l'utilisateur prof2
sqlCREATE USER prof2 WITH PASSWORD 'prof2';
GRANT enseignant TO prof2;

⚠️ Problèmes rencontrés et solutions
ProblèmeCauseSolutionpermission denied for schema tp_dclLe rôle n'avait pas accès au schémaGRANT USAGE ON SCHEMA tp_dcl TO enseignant;permission denied for sequence etudiants_id_seqLa colonne SERIAL utilise une séquence interneGRANT USAGE, SELECT ON SEQUENCE tp_dcl.etudiants_id_seq TO enseignant;ERROR: permission denied to drop roleL'utilisateur n'est pas superuserExécuter DROP USER en tant que postgres

✅ Conclusion
Ce TP illustre la gestion granulaire des permissions dans PostgreSQL. Les droits doivent être accordés à plusieurs niveaux :
Base de données  →  CONNECT
Schéma           →  USAGE
Table            →  SELECT, INSERT, UPDATE, DELETE
Séquence         →  USAGE, SELECT  (obligatoire pour SERIAL)
Commandes DCL utilisées :
sqlCREATE USER   -- Créer un utilisateur
CREATE ROLE   -- Créer un rôle réutilisable
GRANT         -- Attribuer des droits
REVOKE        -- Retirer des droits
DROP USER     -- Supprimer un utilisateur (requiert superuser)

