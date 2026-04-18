\# TP DCL — Gestion des utilisateurs et permissions PostgreSQL

\*\*Salim Amir\*\* | \*\*#300150293\*\* | INF1099 · Collège Boréal · 2026



Ce TP couvre la gestion des droits d'accès dans PostgreSQL avec les commandes DCL : GRANT, REVOKE, CREATE USER, DROP USER.



\---



\## 🎯 Objectifs

1\. Créer des utilisateurs avec des rôles différents

2\. Gérer leurs droits (lecture/écriture)

3\. Tester les permissions

4\. Retirer des droits avec REVOKE

5\. Supprimer les utilisateurs



\---



\## 📖 Théorie — DCL vs ACL



| Catégorie | But | Exemples |

|---|---|---|

| DDL | Définir/modifier la structure | CREATE TABLE, ALTER TABLE |

| DML | Manipuler les données | INSERT, UPDATE, DELETE |

| DQL | Interroger les données | SELECT |

| DCL | Contrôler les droits | GRANT, REVOKE, CREATE USER |

| TCL | Gérer les transactions | COMMIT, ROLLBACK |



\*\*DCL\*\* = contrôle des droits dans la base de données  

\*\*ACL\*\* = contrôle des droits dans le système ou sur des ressources externes



\---



\## 1️⃣ Préparation — Créer la base et la table



Se connecter au conteneur :

```cmd

podman container exec --interactive --tty postgres bash

psql -U postgres

```



Créer la base, le schéma et la table :

```sql

CREATE DATABASE cours;

\\c cours

CREATE SCHEMA tp\_dcl;

CREATE TABLE tp\_dcl.reservation (

&#x20;   id      SERIAL PRIMARY KEY,

&#x20;   client  TEXT,

&#x20;   terrain TEXT,

&#x20;   montant NUMERIC

);

```



![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/4.DCL/300150293/images/capture1.png)



\---



\## 2️⃣ Créer les utilisateurs



| Utilisateur | Rôle | Permissions |

|---|---|---|

| client\_sport | Lecture seule | SELECT |

| employe\_sport | Lecture + Écriture | SELECT, INSERT, UPDATE |

| gestionnaire | Accès complet | SELECT, INSERT, UPDATE, DELETE |



```sql

\-- Client : lecture seule

CREATE USER client\_sport WITH PASSWORD 'client123';



\-- Employé : lecture + écriture

CREATE USER employe\_sport WITH PASSWORD 'employe123';



\-- Gestionnaire : accès complet

CREATE USER gestionnaire WITH PASSWORD 'gest123';

```



![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/4.DCL/300150293/images/capture2.png)



\---



\## 3️⃣ Donner des droits — GRANT



```sql

\-- Connexion à la base

GRANT CONNECT ON DATABASE cours TO client\_sport, employe\_sport, gestionnaire;



\-- Accès au schéma

GRANT USAGE ON SCHEMA tp\_dcl TO client\_sport, employe\_sport, gestionnaire;



\-- Client : lecture seule

GRANT SELECT ON tp\_dcl.reservation TO client\_sport;



\-- Employé : lecture + écriture

GRANT SELECT, INSERT, UPDATE ON tp\_dcl.reservation TO employe\_sport;



\-- Gestionnaire : accès complet

GRANT SELECT, INSERT, UPDATE, DELETE ON tp\_dcl.reservation TO gestionnaire;



\-- Droits sur la séquence

GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp\_dcl.reservation\_id\_seq TO employe\_sport, gestionnaire;

```



![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/4.DCL/300150293/images/capture3.png)



\---



\## 4️⃣ Tester les permissions



\### Test client\_sport (lecture seule)

```sql

\\c cours client\_sport



\-- ✅ Doit fonctionner

SELECT \* FROM tp\_dcl.reservation;



\-- ❌ Doit échouer

INSERT INTO tp\_dcl.reservation(client, terrain, montant)

VALUES ('Hack', 'Terrain X', 0);

```



![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/4.DCL/300150293/images/capture4.png)



\### Test employe\_sport (lecture + écriture)

```sql

\\c cours employe\_sport



\-- ✅ Doit fonctionner

INSERT INTO tp\_dcl.reservation(client, terrain, montant)

VALUES ('Alex', 'Tennis', 50);



\-- ✅ Doit fonctionner

UPDATE tp\_dcl.reservation SET montant = 100 WHERE client = 'Alex';



\-- ❌ Doit échouer

DELETE FROM tp\_dcl.reservation WHERE client = 'Alex';

```



![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/4.DCL/300150293/images/capture5.png)



\---



\## 5️⃣ Retirer des droits — REVOKE



```sql

\\c cours postgres



\-- Retirer le droit de lecture au client

REVOKE SELECT ON tp\_dcl.reservation FROM client\_sport;



\-- Vérifier — doit échouer maintenant

\\c - client\_sport

SELECT \* FROM tp\_dcl.reservation;  -- ❌ ERREUR maintenant






\## 6️⃣ Supprimer les utilisateurs — DROP USER



```sql

\\c cours postgres



\-- Révoquer tous les droits restants

REVOKE ALL ON tp\_dcl.reservation FROM employe\_sport, gestionnaire;

REVOKE ALL ON SEQUENCE tp\_dcl.reservation\_id\_seq FROM employe\_sport, gestionnaire;

REVOKE USAGE ON SCHEMA tp\_dcl FROM client\_sport, employe\_sport, gestionnaire;

REVOKE CONNECT ON DATABASE cours FROM client\_sport, employe\_sport, gestionnaire;



\-- Supprimer les utilisateurs

DROP USER client\_sport;

DROP USER employe\_sport;

DROP USER gestionnaire;

```



\---



\## 🧠 À retenir



\- \*\*GRANT\*\* → donner des permissions

\- \*\*REVOKE\*\* → retirer des permissions  

\- \*\*CREATE USER\*\* → créer un utilisateur

\- \*\*DROP USER\*\* → supprimer un utilisateur (droits révoqués d'abord !)

\- PostgreSQL sépare les droits en 3 niveaux : \*\*Base → Schéma → Table\*\*

