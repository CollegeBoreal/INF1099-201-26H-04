# 🐘 TP PostgreSQL – Gestion des utilisateurs et permissions (DCL)

---

# 🎯 Objectif du TP

L’objectif de ce TP est de comprendre comment gérer les **utilisateurs et les permissions dans PostgreSQL** en utilisant les commandes **DCL (Data Control Language)**.

Nous allons apprendre à :

* 👤 créer des utilisateurs
* 🔐 donner des permissions
* 🧪 tester les permissions
* 🚫 retirer des permissions
* 🗑️ supprimer des utilisateurs

---

# 🛠 Technologies utilisées

* 💻 Windows PowerShell
* 🐳 Docker
* 🐘 PostgreSQL 16
* ⌨️ psql (PostgreSQL CLI)

---

# 1️⃣ Vérification du conteneur PostgreSQL

Tentative d’accès au conteneur :

```powershell
docker container exec --interactive --tty postgres bash
```

Erreur obtenue :

```
Error: can only create exec sessions on running containers
```

Cela signifie que le conteneur **n’est pas démarré**.

---

# 2️⃣ Vérifier l’état des conteneurs

```powershell
docker ps -a
```

Résultat :

```
STATUS: Exited
```

Le conteneur PostgreSQL est arrêté.

---

# 3️⃣ Démarrage du conteneur

```powershell
docker start postgres
```

Puis vérification :

```powershell
docker ps -a
```

Résultat :

```
STATUS: Up
```

Le conteneur fonctionne maintenant.

---

# 4️⃣ Accès au conteneur

```powershell
docker container exec --interactive --tty postgres bash
```

--------

Puis accès à PostgreSQL :

```bash
psql -U postgres
```
----------------------

<img width="1366" height="729" alt="1" src="https://github.com/user-attachments/assets/e7de533d-f963-487c-94f9-a07aa8202bac" />

-------------------

# 5️⃣ Création de la base de données

```sql
CREATE DATABASE cours;
```

Connexion :

```sql
\c cours
```

Résultat :

```
You are now connected to database "cours"
```

------------------

<img width="1366" height="305" alt="2" src="https://github.com/user-attachments/assets/767f3760-db3b-4541-ba58-dba78a088b64" />

--------

# 6️⃣ Création du schéma

```sql
CREATE SCHEMA tp_dcl;
```

---

# 7️⃣ Création de la table

```sql
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);
```

Vérification :

```sql
\dt tp_dcl.*
```

Résultat :

```
tp_dcl | etudiants | table
```

--------

<img width="1366" height="421" alt="3" src="https://github.com/user-attachments/assets/c17c164d-5666-437b-83ce-1981c02509ed" />

-------
---

# 8️⃣ Création des utilisateurs

```sql
CREATE USER etudiant WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';
```

--------------------

<img width="1366" height="180" alt="4" src="https://github.com/user-attachments/assets/5cbf007e-5e02-43e3-b23e-be755c08ddc4" />

-----------------

# 9️⃣ Attribution des permissions

Autoriser l’accès à la base :

```sql
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
```

Autoriser l’accès au schéma :

```sql
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
```

----------------

<img width="1366" height="164" alt="5" src="https://github.com/user-attachments/assets/c1e8677d-c67f-4420-958a-93d635642b46" />

-------------

Permissions pour **etudiant** :

```sql
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
```

Permissions pour **professeur** :

```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;
```

Permission sur la séquence :

```sql
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;
```

----------------------

<img width="1366" height="320" alt="6" src="https://github.com/user-attachments/assets/cfac061f-898e-4fc6-b549-d122af5f4e83" />

-----------------------



# 🔟 Test avec l’utilisateur etudiant

Connexion :

```bash
psql -U etudiant -d cours
```

Lecture :

```sql
SELECT * FROM tp_dcl.etudiants;
```

Résultat :

```
(0 rows)
```

Tentative d’insertion :

```sql
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 85);
```

Résultat :

```
ERROR: permission denied for table etudiants
```

✔️ L’utilisateur **etudiant ne peut que lire les données**.

------------------

<img width="1366" height="391" alt="7" src="https://github.com/user-attachments/assets/a932ffca-1484-49d8-a682-630364b7730d" />

---------------


# 1️⃣1️⃣ Test avec l’utilisateur professeur

Connexion :

```bash
psql -U professeur -d cours
```

Insertion :

```sql
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Khaled', 90);
```

Modification :

```sql
UPDATE tp_dcl.etudiants SET moyenne = 95 WHERE nom = 'Khaled';
```

Vérification :

```sql
SELECT * FROM tp_dcl.etudiants;
```

Résultat :

```
 id | nom    | moyenne
----+--------+--------
 1  | Khaled | 95
```

✔️ L’utilisateur **professeur peut modifier les données**.

-------------

<img width="1366" height="403" alt="8" src="https://github.com/user-attachments/assets/65e29861-5a38-4360-b129-4d9c8de13e17" />

--------------


# 1️⃣2️⃣ Retirer une permission

Connexion avec postgres :

```bash
psql -U postgres -d cours
```

Retirer SELECT :

```sql
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
```

Test :

```sql
SELECT * FROM tp_dcl.etudiants;
```

Résultat :

```
ERROR: permission denied
```
--------------

<img width="1366" height="382" alt="9" src="https://github.com/user-attachments/assets/851ed113-12ea-42b4-addd-12c36a5a45a3" />

----------

# 1️⃣3️⃣ Tentative de suppression des utilisateurs

```sql
DROP USER etudiant;
DROP USER professeur;
```

Erreur :

```
role cannot be dropped because some objects depend on it
```

Les utilisateurs possèdent encore des permissions.

----------

<img width="1366" height="346" alt="10" src="https://github.com/user-attachments/assets/0194c9e5-6c13-462f-ade4-946fbbf81993" />

---------------


# 1️⃣4️⃣ Suppression des permissions

```sql
REVOKE CONNECT ON DATABASE cours FROM etudiant, professeur;

REVOKE USAGE ON SCHEMA tp_dcl FROM etudiant, professeur;

REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;

REVOKE SELECT, INSERT, UPDATE, DELETE 
ON tp_dcl.etudiants FROM professeur;

REVOKE USAGE, SELECT, UPDATE 
ON SEQUENCE tp_dcl.etudiants_id_seq FROM professeur;
```

---

# 1️⃣5️⃣ Suppression finale des utilisateurs

```sql
DROP USER etudiant;
DROP USER professeur;
```

Résultat :

```
DROP ROLE
```

Les utilisateurs sont supprimés.

---------------

<img width="1366" height="729" alt="11" src="https://github.com/user-attachments/assets/4adaa41a-3d81-4b47-9a24-4112996e5798" />

-------------------

# 🧾 Conclusion

Dans ce TP nous avons appris à utiliser **DCL dans PostgreSQL** pour gérer les utilisateurs et sécuriser l’accès aux données.

Les commandes principales utilisées sont :

* 👤 CREATE USER
* 🔐 GRANT
* 🚫 REVOKE
* 🗑️ DROP USER

Ces commandes permettent de **contrôler précisément l’accès à une base de données**.

---
