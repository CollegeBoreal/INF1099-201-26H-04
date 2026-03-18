TP PostgreSQL – Gestion des utilisateurs et permissions (DCL)
 
Massinissa Mameri

300151841

Ce TP nous guide à travers l’utilisation du DCL (Data Control Language) dans PostgreSQL afin de comprendre comment gérer les utilisateurs et leurs permissions sur une base de données.
________________________________________
🎯 Objectifs
Créer des utilisateurs dans PostgreSQL
Attribuer des permissions aux utilisateurs
Tester les permissions (lecture / écriture)
Retirer des permissions avec REVOKE
Comprendre la sécurité dans une base de données
________________________________________
🚀 Étapes du laboratoire
Étape 1 : Se connecter à PostgreSQL
Connexion au conteneur PostgreSQL avec l’utilisateur administrateur.
podman exec -it postgres psql -U postgres

![wait](https://github.com/user-attachments/assets/af6fb5c1-e0f1-4acb-8936-6d9a8a8e023c)

________________________________________
Étape 2 : Créer la base de données
Création d’une base de données pour le TP.
CREATE DATABASE cours;
Connexion à la base :
\c cours

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/e99312a7-88a2-40c4-8c7f-48db38f6e79f)

________________________________________
Étape 3 : Créer un schéma
Création d’un schéma pour organiser les objets du TP.
CREATE SCHEMA tp_dcl;

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/6a0a42bf-03bc-48b4-9a4c-6089a0135581)

________________________________________
Étape 4 : Créer une table
Création d’une table pour tester les permissions des utilisateurs.
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);
Vérification de la table :
\dt tp_dcl.*

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/91f5f4c8-17a4-4bf0-9b12-36dea9aead51)

________________________________________
Étape 5 : Créer des utilisateurs
Création de deux utilisateurs PostgreSQL :
•	un étudiant (lecture seulement)
•	un professeur (lecture et écriture)
CREATE USER etudiant WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/8ca28561-125f-407e-a628-ff6be4c84660)

________________________________________
Étape 6 : Donner des permissions (GRANT)
Autoriser les utilisateurs à se connecter à la base :
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
Autoriser l’accès au schéma :
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
Donner les droits sur la table :
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;
Donner les droits sur la séquence :
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/07431853-8637-4e12-ad0c-697534b7c2f4)

________________________________________
Étape 7 : Tester les permissions avec l’utilisateur étudiant
Connexion avec l’utilisateur étudiant :
podman exec -it postgres psql -U etudiant -d cours
Test de lecture :
SELECT * FROM tp_dcl.etudiants;
Résultat : la lecture est autorisée.
Test d’insertion :
INSERT INTO tp_dcl.etudiants(nom, moyenne)
VALUES ('Patrick', 85);
Résultat attendu :
ERROR: permission denied for table etudiants

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/7ad0a869-8e50-4467-a431-44121b9d7bdf)

________________________________________
Étape 8 : Tester les permissions avec l’utilisateur professeur
Connexion :
podman exec -it postgres psql -U professeur -d cours
Insertion d’un étudiant :
INSERT INTO tp_dcl.etudiants(nom, moyenne)
VALUES ('Khaled', 90);
Modification :
UPDATE tp_dcl.etudiants
SET moyenne = 95
WHERE nom='Khaled';
Résultat : les opérations sont autorisées.

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/3c0ed324-da7f-48dc-adad-a32daa720472)

________________________________________
Étape 9 : Retirer une permission (REVOKE)
Connexion avec l’utilisateur administrateur :
podman exec -it postgres psql -U postgres -d cours
Retirer la permission de lecture :
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
Tester à nouveau avec l’utilisateur étudiant :
SELECT * FROM tp_dcl.etudiants;
Résultat attendu :
ERROR: permission denied

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/961c71a0-483b-4675-86cc-c6dc967a255d)

________________________________________
🧠 À retenir
DCL signifie Data Control Language.
Les commandes principales sont :
CREATE USER → créer un utilisateur
GRANT → donner des permissions
REVOKE → retirer des permissions
DROP USER → supprimer un utilisateur
Dans PostgreSQL, les permissions peuvent être appliquées à différents niveaux :
Base de données → accès à la base
Schéma → accès aux objets
Tables → opérations sur les données


