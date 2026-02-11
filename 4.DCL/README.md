# 4.DCL

---

# 🔹 DCL = **Data Control Language**

C’est une **partie du SQL** qui sert à **contrôler les droits et la sécurité des données** dans une base.

En SQL, on a plusieurs “langages” selon le type d’action :

| Catégorie                              | But                           | Exemples                                    |
| -------------------------------------- | ----------------------------- | ------------------------------------------- |
| **DDL** (Data Definition Language)     | Définir/modifier la structure | `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE` |
| **DML** (Data Manipulation Language)   | Manipuler les données         | `INSERT`, `UPDATE`, `DELETE`                |
| **DQL** (Data Query Language)          | Interroger / lire les données | `SELECT`                                    |
| **DCL** (Data Control Language)        | Contrôler les droits          | `GRANT`, `REVOKE`, `CREATE USER`            |
| **TCL** (Transaction Control Language) | Gérer les transactions        | `COMMIT`, `ROLLBACK`                        |

---

## 🔑 Les commandes DCL principales

1. **CREATE USER** → créer un utilisateur
2. **DROP USER** → supprimer un utilisateur
3. **GRANT** → donner des droits (lecture, écriture…)
4. **REVOKE** → retirer des droits

Exemple simple :

```sql
CREATE USER etudiant WITH PASSWORD 'abc123';
GRANT SELECT ON table1 TO etudiant;
REVOKE SELECT ON table1 FROM etudiant;
DROP USER etudiant;
```

👉 En résumé : **DCL = qui peut faire quoi sur la base de données**. Penser `ACL` - Access Control 

---

### 🔹 ACL (Access Control List)

* **Niveau : système / réseau / fichiers**
* **But : contrôler l’accès à une ressource (fichier, répertoire, service)**
* **Concept :** pour chaque ressource, on a une “liste de contrôle” indiquant qui peut y accéder et avec quels droits.
* **Exemple classique Linux :**

```bash
ls -l fichier.txt
-rw-r----- 1 alice staff 123 Feb 11 12:00 fichier.txt
```

* Ici, la **ACL** dit que :

  * `alice` peut lire et écrire
  * le groupe `staff` peut lire
  * les autres n’ont aucun droit

* Linux moderne ou Windows NT utilisent souvent **ACL explicites** pour gérer des permissions fines (lecture, écriture, exécution).

---

### 🔹 Comparaison DCL vs ACL

| Aspect             | DCL                                                      | ACL                                                               |
| ------------------ | -------------------------------------------------------- | ----------------------------------------------------------------- |
| Niveau             | Base de données                                          | Système / fichiers / réseau                                       |
| Objectif           | Contrôler qui peut manipuler des données (tables, vues…) | Contrôler qui peut accéder à une ressource (fichier, répertoire…) |
| Commandes / outils | `GRANT`, `REVOKE`, `CREATE USER`                         | `chmod`, `chown`, `setfacl`, ACL Windows                          |
| Granularité        | Tables, schémas, colonnes                                | Fichiers, répertoires, services, ports…                           |
| Exemple            | `GRANT SELECT ON table1 TO etudiant;`                    | `setfacl -m u:ubuntu:r fichier.txt`                               |

💡 **Résumé simple :**

* **DCL = contrôle des droits **dans la base de données**
* **ACL = contrôle des droits **dans le système** ou sur des ressources externes

---

# 📝 TP PostgreSQL : Gestion des utilisateurs et permissions (DCL)

## **Objectif**

* Créer des utilisateurs
* Gérer leurs droits (lecture/écriture)
* Tester les permissions
* Comprendre l’importance des droits sur la base, le schéma et les tables

---

## **Prérequis**

* PostgreSQL installé
```lua
docker container exec --interactive --tty postgres bash
```
* Accès à `psql` ou PgAdmin
* Une base de test : `cours`

---

## **1️⃣ Préparation**

Se connecter en tant que superutilisateur :

```bash
psql -U postgres
```

Créer la base de test :

```sql
CREATE DATABASE cours;
\c cours
```

Créer un schéma :

```sql
CREATE SCHEMA tp_dcl;
```

Créer une table pour l’exercice :

```sql
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);
```

### 🎯 Rappel fondamental

PostgreSQL fonctionne ainsi :

```
Cluster
 ├── Base 1 (postgres)
 ├── Base 2 (cours)
 │     └── Schéma tp_dcl
 │           └── Table etudiants
 └── Base 3 (appdb)
```

Un schéma appartient à une base.
Une table appartient à un schéma.
Les droits sont liés à la base courante.

---

## **2️⃣ Créer des utilisateurs**

```sql
-- Étudiant simple (lecture)
CREATE USER etudiant WITH PASSWORD 'etudiant123';

-- Professeur (lecture/écriture)
CREATE USER professeur WITH PASSWORD 'prof123';
```

---

## **3️⃣ Donner des droits (GRANT)**

### 🔹 Connexion à la base

```sql
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
```

### 🔹 Accès au schéma

```sql
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
```

### 🔹 Droits sur la table

```sql
-- Étudiant : lecture seule
GRANT SELECT ON tp_dcl.etudiants TO etudiant;

-- Professeur : lecture + écriture
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;

-- Donner les droits sur la séquence
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;
```

Se déconnecter:

```psql
--quit
\q 
```

---

## **4️⃣ Vérifier les droits**

Se connecter en tant qu’étudiant :

```bash
psql -U etudiant -d cours
```

Tester :

```sql
SELECT * FROM tp_dcl.etudiants;  -- OK
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 85); -- ERREUR
```

Se connecter en tant que professeur :

```sql
psql -U professeur -d cours
```

Tester :

```sql
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Khaled', 90); -- OK
UPDATE tp_dcl.etudiants SET moyenne=95 WHERE nom='Khaled';       -- OK
```

---

## **5️⃣ Retirer des droits (REVOKE)**

```sql
-- Retirer le droit lecture à l’étudiant
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
```

Vérifier la modification :

```sql
\c - etudiant
SELECT * FROM tp_dcl.etudiants;  -- ERREUR maintenant
```

---

## **6️⃣ Supprimer un utilisateur (DROP USER)**

```sql
DROP USER etudiant;
DROP USER professeur;
```

⚠️ PostgreSQL ne permet pas de supprimer un utilisateur si celui-ci possède encore des objets (tables, schémas). Ici, tout reste dans le schéma `tp_dcl`.

---

## **7️⃣ Bonus pédagogique**

* Créer un rôle `enseignant` pour regrouper plusieurs profs :

```sql
CREATE ROLE enseignant;
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO enseignant;

-- Ajouter un utilisateur à ce rôle
CREATE USER prof2 WITH PASSWORD 'prof2';
GRANT enseignant TO prof2;
```

* Vérifier que `prof2` hérite bien des droits :

```sql
\c - prof2
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 88);
```

---

# 🧠 À retenir

1. DCL = **Data Control Language**

   * `GRANT` / `REVOKE` = gérer permissions
   * `CREATE USER` / `DROP USER` = gérer utilisateurs

2. PostgreSQL sépare les niveaux :

   * **Database** → connexion
   * **Schema** → accès aux objets
   * **Table** → droits CRUD

3. Les rôles permettent de **regrouper les permissions** et simplifient la gestion.

