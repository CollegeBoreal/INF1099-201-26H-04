# 🐘 TP PostgreSQL – Gestion des utilisateurs et permissions (DCL)



## 👨‍🎓 Étudiant

### Nom : Rahmani Chakib  

### Numéro étudiant : 300150399  

---



# 🎯 Objectif du laboratoire



Ce TP a pour objectif de comprendre la gestion des \*\*utilisateurs et des permissions dans PostgreSQL\*\*.



À la fin du TP, l’étudiant sera capable de :



- Créer une base de données PostgreSQL

- Créer un schéma et une table

- Créer des utilisateurs PostgreSQL

- Attribuer des permissions avec \*\*GRANT\*\*

- Retirer des permissions avec \*\*REVOKE\*\*

- Tester les permissions selon différents rôles

- Comprendre la gestion des \*\*séquences SERIAL\*\*

- Utiliser les \*\*rôles PostgreSQL\*\*



---



# 🛠 Environnement utilisé



- Windows 11

- PowerShell

- Podman

- PostgreSQL 16

- Client psql



Connexion au conteneur PostgreSQL :



```bash

podman exec -it postgres psql -U postgres



---



# 1️⃣ Connexion à PostgreSQL



La première étape consiste à se connecter au conteneur PostgreSQL en utilisant \*\*Podman\*\* depuis PowerShell.



Commande utilisée :



```bash

podman exec -it postgres psql -U postgres

```



Cette commande permet :



- d’entrer dans le conteneur PostgreSQL

- de lancer le client \*\*psql\*\*

- de se connecter en tant qu’utilisateur \*\*postgres\*\*



Une fois la commande exécutée, l’invite `postgres=#` apparaît, indiquant que la connexion au serveur PostgreSQL est réussie.



![Connexion PostgreSQL](./images/1.png)



---



# 2️⃣ Création de la base de données



Une fois connecté à PostgreSQL, la prochaine étape consiste à créer une base de données appelée \*\*cours\*\*.



Commande utilisée :



```sql

CREATE DATABASE cours;

```



Cette commande crée une nouvelle base de données dans PostgreSQL qui sera utilisée pour le reste du laboratoire.



Après la création de la base de données, on se connecte à celle-ci avec la commande :



```sql

\\c cours

```



Cette commande change la base de données active dans \*\*psql\*\* et permet d’exécuter les commandes suivantes directement dans la base \*\*cours\*\*.



![Création de la base de données](./images/2.png)



---



# 3️⃣ Création du schéma et de la table



Dans cette étape, nous créons un \*\*schéma PostgreSQL\*\* nommé `tp\_dcl` afin d’organiser les objets de la base de données.



Commande utilisée :



```sql

CREATE SCHEMA tp\_dcl;

```



Ensuite, nous créons une table appelée \*\*etudiants\*\* dans ce schéma.



```sql

CREATE TABLE tp\_dcl.etudiants (

&nbsp;   id SERIAL PRIMARY KEY,

&nbsp;   nom TEXT,

&nbsp;   moyenne NUMERIC

);

```



Explication :



- `id SERIAL` crée automatiquement un identifiant unique

- `PRIMARY KEY` définit la clé primaire de la table

- `nom` stocke le nom de l’étudiant

- `moyenne` stocke la moyenne de l’étudiant



Cette table sera utilisée pour tester les permissions des différents utilisateurs PostgreSQL.



![Création du schéma et de la table](./images/3.png)



---



# 4️⃣ Insertion des premières données



Une fois la table `tp\_dcl.etudiants` créée, nous ajoutons quelques enregistrements afin de pouvoir tester les permissions des utilisateurs.



Commandes utilisées :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Karim', 75);

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Sarah', 88);

```



Ces commandes insèrent deux étudiants dans la table :



- \*\*Karim\*\* avec une moyenne de \*\*75\*\*

- \*\*Sarah\*\* avec une moyenne de \*\*88\*\*



Pour vérifier que les données ont bien été ajoutées, on exécute la requête suivante :



```sql

SELECT \* FROM tp\_dcl.etudiants;

```



Cette commande affiche toutes les lignes de la table `etudiants`.



![Insertion des données](images/4.png)



---



# 5️⃣ Création des utilisateurs PostgreSQL



Dans cette étape, nous créons deux utilisateurs PostgreSQL qui auront des permissions différentes sur la base de données.



Commandes utilisées :



```sql

CREATE USER etudiant WITH PASSWORD 'etudiant123';

CREATE USER professeur WITH PASSWORD 'prof123';

```



Explication :



- \*\*etudiant\*\* : utilisateur qui aura seulement des permissions de lecture.

- \*\*professeur\*\* : utilisateur qui aura des permissions complètes pour modifier les données.



Ces utilisateurs seront ensuite utilisés pour tester les différents niveaux d'accès aux données dans la table `tp\_dcl.etudiants`.



![Création des utilisateurs](images/5.png)



---



# 6️⃣ Attribution des permissions (GRANT)



Après avoir créé les utilisateurs, il est nécessaire de leur attribuer les permissions appropriées sur la base de données.



Les permissions sont attribuées à différents niveaux : la base de données, le schéma et la table.



Autoriser les utilisateurs à se connecter à la base de données :



```sql

GRANT CONNECT ON DATABASE cours TO etudiant, professeur;

```



Autoriser l'accès au schéma `tp\_dcl` :



```sql

GRANT USAGE ON SCHEMA tp\_dcl TO etudiant, professeur;

```



Attribuer les permissions sur la table `etudiants`.



L'utilisateur \*\*etudiant\*\* peut seulement lire les données :



```sql

GRANT SELECT ON tp\_dcl.etudiants TO etudiant;

```



L'utilisateur \*\*professeur\*\* peut lire et modifier les données :



```sql

GRANT SELECT, INSERT, UPDATE, DELETE ON tp\_dcl.etudiants TO professeur;

```



Ces permissions permettent de contrôler précisément ce que chaque utilisateur peut faire dans la base de données.



![Attribution des permissions](images/6.png)



---



# 7️⃣ Test de l'utilisateur étudiant



Après avoir attribué les permissions, nous testons le comportement de l'utilisateur \*\*etudiant\*\*.



Connexion à la base de données avec cet utilisateur :



```sql

\\c cours etudiant

```



Une fois connecté, nous testons l'accès à la table `etudiants` avec la requête suivante :



```sql

SELECT \* FROM tp\_dcl.etudiants;

```



Cette requête doit fonctionner car l'utilisateur \*\*etudiant\*\* possède la permission \*\*SELECT\*\* sur la table.



Le résultat affiche les étudiants déjà enregistrés dans la base de données.



![Test SELECT utilisateur étudiant](images/7.png)



---



# 8️⃣ Tentative d'insertion refusée pour l'utilisateur étudiant



Dans cette étape, nous vérifions que l'utilisateur \*\*etudiant\*\* ne possède pas les permissions nécessaires pour modifier les données.



Commande testée :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Alice', 85);

```



Résultat attendu :



```text

ERROR: permission denied for table etudiants

```



Cette erreur confirme que l'utilisateur \*\*etudiant\*\* n'a que la permission \*\*SELECT\*\* et ne peut pas effectuer d'opérations d'insertion dans la table.



Cela démontre que les permissions attribuées précédemment fonctionnent correctement.



![INSERT refusé pour étudiant](images/8.png)



---



# 9️⃣ Connexion avec l'utilisateur professeur



Dans cette étape, nous nous connectons à la base de données avec l'utilisateur \*\*professeur\*\* afin de tester ses permissions.



Commande utilisée :



```sql

\\c cours professeur

```



L'utilisateur \*\*professeur\*\* possède des permissions plus élevées que l'utilisateur \*\*etudiant\*\*, notamment :



- lecture des données (\*\*SELECT\*\*)

- insertion de nouvelles données (\*\*INSERT\*\*)

- modification des données (\*\*UPDATE\*\*)

- suppression des données (\*\*DELETE\*\*)



Cette connexion permet de vérifier que cet utilisateur peut effectuer des opérations de modification dans la table `tp\_dcl.etudiants`.



![Connexion utilisateur professeur](images/9.png)



---


# 🔟 Erreur liée à la séquence SERIAL



Une fois connecté avec l'utilisateur \*\*professeur\*\*, nous tentons d'insérer un nouvel étudiant dans la table.



Commande utilisée :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Bob', 90);

```



Cependant, PostgreSQL retourne l'erreur suivante :



```text

ERROR: permission denied for sequence etudiants\_id\_seq

```



Cette erreur apparaît parce que la colonne `id SERIAL` utilise automatiquement une \*\*séquence PostgreSQL\*\* pour générer les identifiants.



Même si l'utilisateur \*\*professeur\*\* possède les permissions sur la table, il doit également avoir les permissions sur la \*\*séquence associée\*\*.



![Erreur de séquence SERIAL](images/10.png)



---



# 1️⃣1️⃣ Correction de l'erreur de séquence



Pour résoudre l'erreur précédente, il est nécessaire de donner à l'utilisateur \*\*professeur\*\* les permissions sur la séquence associée à la colonne `SERIAL`.



Commande utilisée :



```sql

GRANT USAGE, SELECT ON SEQUENCE tp\_dcl.etudiants\_id\_seq TO professeur;

```



Explication :



- \*\*USAGE\*\* permet d'utiliser la séquence pour générer une nouvelle valeur

- \*\*SELECT\*\* permet de lire la valeur actuelle de la séquence



Après avoir attribué ces permissions, l'utilisateur \*\*professeur\*\* peut utiliser correctement la séquence générée automatiquement par PostgreSQL lors des insertions.



![Permission sur la séquence](images/11.png)



---



# 1️⃣2️⃣ Insertion réussie avec l'utilisateur professeur



Après avoir corrigé les permissions de la séquence, nous testons à nouveau l'insertion d'un nouvel étudiant.



Commande utilisée :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Bob', 90);

```



Cette fois-ci, la commande fonctionne correctement et PostgreSQL confirme l'insertion avec le message :



```text

INSERT 0 1

```



Cela signifie qu'un nouvel enregistrement a été ajouté dans la table.



Cette étape confirme que l'utilisateur \*\*professeur\*\* possède désormais toutes les permissions nécessaires pour insérer des données dans la table.



![Insertion réussie](images/12.png)



---



# 1️⃣3️⃣ Mise à jour des données



Après avoir inséré l'étudiant \*\*Bob\*\*, nous testons la modification des données avec l'utilisateur \*\*professeur\*\*.



Commande utilisée :



```sql

UPDATE tp\_dcl.etudiants

SET moyenne = 95

WHERE nom = 'Bob';

```



Cette commande modifie la moyenne de l'étudiant \*\*Bob\*\*.



PostgreSQL confirme la modification avec le message :



```text

UPDATE 1

```



Cela signifie qu'une ligne a été mise à jour dans la table.



Cette étape démontre que l'utilisateur \*\*professeur\*\* possède bien les permissions nécessaires pour modifier les données.



![Mise à jour des données](images/13.png)



---



# 1️⃣4️⃣ Vérification des données après modification



Après l’insertion et la modification des données, il est important de vérifier que les changements ont bien été appliqués dans la table.



Commande utilisée :



```sql

SELECT \* FROM tp\_dcl.etudiants;

```



Cette requête affiche tous les enregistrements présents dans la table `etudiants`.



Le résultat montre :



- Karim avec une moyenne de 75

- Sarah avec une moyenne de 88

- Bob avec une moyenne mise à jour à 95



Cette étape confirme que les opérations \*\*INSERT\*\* et \*\*UPDATE\*\* effectuées par l'utilisateur \*\*professeur\*\* ont bien été appliquées.



![Vérification des données](images/14.png)



---



# 1️⃣5️⃣ Suppression d'une permission avec REVOKE



Dans cette étape, nous retirons la permission \*\*SELECT\*\* à l'utilisateur \*\*etudiant\*\*.



Commande utilisée :



```sql

REVOKE SELECT ON tp\_dcl.etudiants FROM etudiant;

```



La commande \*\*REVOKE\*\* permet de retirer une permission précédemment attribuée avec \*\*GRANT\*\*.



Après l'exécution de cette commande, l'utilisateur \*\*etudiant\*\* ne peut plus consulter les données de la table `tp\_dcl.etudiants`.



Cette étape permet de démontrer comment gérer et modifier les permissions des utilisateurs dans PostgreSQL.



![Commande REVOKE](images/15.png)



---



# 1️⃣6️⃣ Test de l'utilisateur étudiant après REVOKE



Après avoir retiré la permission \*\*SELECT\*\* à l'utilisateur \*\*etudiant\*\*, nous testons à nouveau son accès à la table.



Connexion avec l'utilisateur :



```sql

\\c cours etudiant

```



Puis tentative de lecture :



```sql

SELECT \* FROM tp\_dcl.etudiants;

```



Résultat obtenu :



```text

ERROR: permission denied for table etudiants

```



Cette erreur confirme que l'utilisateur \*\*etudiant\*\* n'a plus le droit d'accéder aux données de la table.



Cela démontre que la commande \*\*REVOKE\*\* fonctionne correctement et permet de contrôler l'accès aux ressources de la base de données.



![Accès refusé après REVOKE](images/16.png)



---



# 1️⃣7️⃣ Tentative de suppression des utilisateurs



Dans cette étape, nous tentons de supprimer les utilisateurs précédemment créés.



Commande utilisée :



```sql

DROP USER etudiant;

DROP USER professeur;

```



PostgreSQL retourne l'erreur suivante :



```text

ERROR: role "etudiant" cannot be dropped because some objects depend on it

ERROR: role "professeur" cannot be dropped because some objects depend on it

```



Cette erreur indique que ces utilisateurs possèdent encore des permissions ou des dépendances dans la base de données.



Avant de pouvoir supprimer un utilisateur, il est nécessaire de retirer toutes les permissions ou dépendances associées.



Cette étape montre l'importance de bien gérer les rôles et les permissions dans PostgreSQL.



![Tentative DROP USER](images/17.png)



---



# 1️⃣8️⃣ Création d'un rôle enseignant



Afin de simplifier la gestion des permissions, PostgreSQL permet d'utiliser des \*\*rôles\*\*.



Un rôle peut regrouper plusieurs permissions et être attribué à plusieurs utilisateurs.



Création du rôle :



```sql

CREATE ROLE enseignant;

```



Attribution des permissions au rôle :



```sql

GRANT SELECT, INSERT, UPDATE, DELETE

ON tp\_dcl.etudiants

TO enseignant;

```



Ce rôle possède les mêmes permissions que l'utilisateur \*\*professeur\*\* sur la table `etudiants`.



L'utilisation des rôles permet de gérer plus facilement les permissions lorsqu'il y a plusieurs utilisateurs.



![Création du rôle enseignant](images/18.png)



---



# 1️⃣8️⃣ Création d'un rôle enseignant



Afin de simplifier la gestion des permissions, PostgreSQL permet d'utiliser des \*\*rôles\*\*.



Un rôle peut regrouper plusieurs permissions et être attribué à plusieurs utilisateurs.



Création du rôle :



```sql

CREATE ROLE enseignant;

```



Attribution des permissions au rôle :



```sql

GRANT SELECT, INSERT, UPDATE, DELETE

ON tp\_dcl.etudiants

TO enseignant;

```



Ce rôle possède les mêmes permissions que l'utilisateur \*\*professeur\*\* sur la table `etudiants`.



L'utilisation des rôles permet de gérer plus facilement les permissions lorsqu'il y a plusieurs utilisateurs.



![Création du rôle enseignant](images/18.png)



---



# 1️⃣9️⃣ Création de l'utilisateur prof2 et attribution du rôle



Dans cette étape, nous créons un nouvel utilisateur nommé \*\*prof2\*\*.



Commande utilisée :



```sql

CREATE USER prof2 WITH PASSWORD 'prof2';

```



Ensuite, nous attribuons le rôle \*\*enseignant\*\* à cet utilisateur.



```sql

GRANT enseignant TO prof2;

```



Grâce à cette attribution, l'utilisateur \*\*prof2\*\* hérite automatiquement des permissions définies dans le rôle \*\*enseignant\*\*.



Cela permet de gérer plus facilement les droits d'accès lorsque plusieurs utilisateurs doivent avoir les mêmes permissions.



![Création de l'utilisateur prof2](images/19.png)



---



# 2️⃣0️⃣ Problème d'accès au schéma



Après avoir créé l'utilisateur \*\*prof2\*\* et lui avoir attribué le rôle \*\*enseignant\*\*, nous testons l'insertion de données dans la table.



Commande utilisée :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 88);

```



Cependant, PostgreSQL retourne l'erreur suivante :



```text

ERROR: permission denied for schema tp\_dcl

```



Cette erreur signifie que l'utilisateur \*\*prof2\*\* possède les permissions sur la table via le rôle \*\*enseignant\*\*, mais n'a pas encore accès au \*\*schéma\*\* dans lequel se trouve la table.



Pour corriger ce problème, il est nécessaire d'accorder l'accès au schéma.



Commande utilisée :



```sql

GRANT USAGE ON SCHEMA tp\_dcl TO enseignant;

```



Cette commande permet aux utilisateurs possédant le rôle \*\*enseignant\*\* d'utiliser les objets présents dans le schéma `tp\_dcl`.



![Erreur accès schéma](images/20.png)



---



# 2️⃣1️⃣ Problème d'accès à la séquence



Après avoir corrigé l'accès au schéma, nous testons à nouveau l'insertion avec l'utilisateur \*\*prof2\*\*.



Commande utilisée :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 88);

```



PostgreSQL retourne alors une nouvelle erreur :



```text

ERROR: permission denied for sequence etudiants\_id\_seq

```



Cette erreur apparaît car la colonne `id` de la table utilise le type \*\*SERIAL\*\*, qui repose sur une \*\*séquence PostgreSQL\*\* pour générer automatiquement les identifiants.



Même si l'utilisateur possède des permissions sur la table, il doit également avoir les permissions nécessaires sur la séquence associée.



Pour corriger ce problème, il faut accorder les permissions sur la séquence.



```sql

GRANT USAGE, SELECT ON SEQUENCE tp\_dcl.etudiants\_id\_seq TO enseignant;

```



Cette commande permet aux utilisateurs possédant le rôle \*\*enseignant\*\* d'utiliser la séquence lors des insertions.



![Erreur séquence](images/21.png)



---



# 2️⃣2️⃣ Insertion réussie avec l'utilisateur prof2



Après avoir corrigé les permissions du schéma et de la séquence, nous testons une nouvelle fois l'insertion de données avec l'utilisateur \*\*prof2\*\*.



Commande utilisée :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 88);

```



Cette fois-ci, PostgreSQL confirme l'insertion avec le message :



```text

INSERT 0 1

```



Cela signifie qu'un nouvel enregistrement a été ajouté dans la table `etudiants`.



Cette étape confirme que les permissions attribuées au rôle \*\*enseignant\*\* sont maintenant complètes et permettent aux utilisateurs associés d'effectuer correctement les opérations sur la table.



![Insertion réussie avec prof2](images/22.png)



---



# 2️⃣3️⃣ Vérification finale



Après avoir corrigé les permissions du schéma et de la séquence, l'utilisateur \*\*prof2\*\* peut désormais insérer des données dans la table sans erreur.



Commande utilisée :



```sql

INSERT INTO tp\_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 88);

```



Résultat obtenu :



```text

INSERT 0 1

```



Cela confirme que toutes les permissions nécessaires ont été correctement configurées.



![Insertion finale réussie](images/23.png)



---



# ✅ Conclusion



Ce laboratoire a permis de comprendre la gestion des \*\*utilisateurs et des permissions dans PostgreSQL\*\*.



Les concepts principaux étudiés sont :



- la création d'utilisateurs avec \*\*CREATE USER\*\*

- la gestion des permissions avec \*\*GRANT\*\* et \*\*REVOKE\*\*

- l'utilisation des \*\*rôles PostgreSQL\*\*

- la gestion des accès aux \*\*schémas\*\*

- la gestion des permissions sur les \*\*séquences (SERIAL)\*\*



Nous avons également observé que les permissions doivent être configurées à plusieurs niveaux :



- \*\*base de données\*\*

- \*\*schéma\*\*

- \*\*table\*\*

- \*\*séquence\*\*



Ce TP démontre l'importance d'une bonne gestion des permissions afin de sécuriser l'accès aux données dans une base PostgreSQL.

