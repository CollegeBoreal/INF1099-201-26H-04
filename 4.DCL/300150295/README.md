📚 TP – DCL (Data Control Language) – PostgreSQL avec Docker
Nom : Lounas Allouti Cours : INF1099 Session : Hiver 2026 Base de données : PostgreSQL (Docker)
🎯 Objectif du TP
Ce TP consiste à :
* Créer des rôles (utilisateurs)
* Accorder des privilèges (GRANT)
* Retirer des privilèges (REVOKE)
* Tester les permissions
* Supprimer les rôles (DROP USER)
* Vérifier la gestion des droits dans PostgreSQL
🐳 1️⃣ Lancement de PostgreSQL avec Docker
Commande utilisée :

docker run --name postgres_tp -e POSTGRES_PASSWORD=admin -p 5432:5432 -d postgres
Vérification :

docker ps
📸 Capture d’écran – Conteneur Docker actif
(Insérer capture ici)
🗄️ 2️⃣ Connexion à PostgreSQL

docker exec -it postgres_tp psql -U postgres
📸 Capture – Connexion réussie
(Insérer capture ici)
🏗️ 3️⃣ Création de la base et du schéma

CREATE DATABASE cours;
\c cours

CREATE SCHEMA tp_dcl;
📸 Capture – Base et schéma créés
(Insérer capture ici)
👥 4️⃣ Création des utilisateurs

CREATE USER etudiant WITH PASSWORD '1234';
CREATE USER professeur WITH PASSWORD '1234';
📸 Capture – Création des rôles
(Insérer capture ici)
📊 5️⃣ Création de la table

CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    moyenne DECIMAL(4,2)
);
📸 Capture – Table créée
(Insérer capture ici)
🔐 6️⃣ Attribution des privilèges (GRANT)

GRANT USAGE ON SCHEMA tp_dcl TO etudiant;
GRANT SELECT ON tp_dcl.etudiants TO etudiant;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA tp_dcl TO professeur;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA tp_dcl TO professeur;
📸 Capture – GRANT effectué
(Insérer capture ici)
❌ 7️⃣ Retrait des privilèges (REVOKE)

REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
📸 Capture – REVOKE effectué
(Insérer capture ici)
🧪 8️⃣ Test des permissions
Connexion avec l’utilisateur etudiant :

psql -U etudiant -d cours
Test :

SELECT * FROM tp_dcl.etudiants;
Résultat attendu :

ERROR: permission denied
📸 Capture – Permission denied
(Insérer capture ici)
🗑️ 9️⃣ Suppression des utilisateurs
Avant suppression :

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA tp_dcl FROM professeur;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA tp_dcl FROM professeur;
REVOKE ALL PRIVILEGES ON SCHEMA tp_dcl FROM professeur;

REVOKE ALL PRIVILEGES ON SCHEMA tp_dcl FROM etudiant;
REVOKE ALL PRIVILEGES ON DATABASE cours FROM etudiant;
Puis :

DROP USER etudiant;
DROP USER professeur;
📸 Capture – Suppression réussie
(Insérer capture ici)
✅ Conclusion
Ce TP m’a permis de :
* Comprendre la gestion des rôles dans PostgreSQL
* Manipuler les commandes GRANT et REVOKE
* Vérifier les permissions utilisateur
* Gérer les dépendances avant suppression d’un rôle
* Utiliser PostgreSQL dans Docker

