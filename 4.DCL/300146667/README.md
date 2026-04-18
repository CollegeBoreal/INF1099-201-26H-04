# TP PostgreSQL - DCL (Data Control Language)
# DjaberBenyezza
# 300146667

---

# 🚀 Étapes du laboratoire

## Étape 0 : Connexion au container Docker

```bash
docker container exec --interactive --tty postgres bash
```

Puis se connecter à PostgreSQL en tant que superutilisateur :

```bash
psql -U postgres
```

---

## Étape 1 : Créer la base de données et le schéma

```sql
CREATE DATABASE cours;
\c cours
CREATE SCHEMA tp_dcl;
```

Résultat :
```
CREATE DATABASE
You are now connected to database "cours" as user "postgres".
CREATE SCHEMA
```

---

## Étape 2 : Créer la table

```sql
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);
```

Résultat :
```
CREATE TABLE
```

---

## Étape 3 : Créer les utilisateurs

```sql
-- Étudiant simple (lecture)
CREATE USER etudiant WITH PASSWORD 'etudiant123';

-- Professeur (lecture/écriture)
CREATE USER professeur WITH PASSWORD 'prof123';
```

Résultat :
```
CREATE ROLE
CREATE ROLE
```

---

## Étape 4 : Donner les droits (GRANT)

```sql
-- Connexion à la base
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;

-- Accès au schéma
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;

-- Étudiant : lecture seule
GRANT SELECT ON tp_dcl.etudiants TO etudiant;

-- Professeur : lecture + écriture complète
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;

-- Droits sur la séquence (nécessaire pour les INSERT avec SERIAL)
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;
```

Résultat :
```
GRANT
GRANT
GRANT
GRANT
GRANT
```

---

## Étape 5 : Tester les droits de l'étudiant

```bash
\q
psql -U etudiant -d cours
```

```sql
SELECT * FROM tp_dcl.etudiants;  -- ✅ Doit fonctionner
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 85);  -- ❌ Doit échouer
```

Résultat :
```
 id | nom | moyenne
----+-----+---------
(0 rows)

ERROR:  permission denied for table etudiants
```

✅ SELECT fonctionne, INSERT refusé comme attendu.

---

## Étape 6 : Tester les droits du professeur

```bash
\q
psql -U professeur -d cours
```

```sql
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Khaled', 90);  -- ✅ OK
UPDATE tp_dcl.etudiants SET moyenne=95 WHERE nom='Khaled';          -- ✅ OK
SELECT * FROM tp_dcl.etudiants;                                     -- ✅ OK
```

Résultat :
```
INSERT 0 1
UPDATE 1
 id |  nom   | moyenne
----+--------+---------
  1 | Khaled |      95
(1 row)
```

✅ INSERT, UPDATE et SELECT fonctionnent pour le professeur.

---

## Étape 7 : Retirer des droits (REVOKE)

```bash
\q
psql -U postgres -d cours
```

```sql
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
```

Vérifier que le droit a bien été retiré :

```sql
\c - etudiant
SELECT * FROM tp_dcl.etudiants;  -- ❌ Doit maintenant échouer
```

Résultat :
```
REVOKE
ERROR:  permission denied for table etudiants
```

✅ Le droit SELECT a bien été retiré à l'étudiant.

---

## Étape 8 : Supprimer les utilisateurs (DROP USER)

```sql
\c - postgres
DROP USER etudiant;
DROP USER professeur;
```

Résultat :
```
ERROR:  role "etudiant" cannot be dropped because some objects depend on it
DETAIL:  privileges for database cours
         privileges for schema tp_dcl

ERROR:  role "professeur" cannot be dropped because some objects depend on it
DETAIL:  privileges for database cours
         privileges for schema tp_dcl
         privileges for sequence tp_dcl.etudiants_id_seq
         privileges for table tp_dcl.etudiants
```

⚠️ PostgreSQL ne permet pas de supprimer un utilisateur si celui-ci possède encore des privilèges — comportement attendu.

---

## 🔑 Hiérarchie des droits PostgreSQL

```
Cluster PostgreSQL
 ├── Base : cours
 │     └── Schéma : tp_dcl
 │           ├── Table : etudiants
 │           └── Séquence : etudiants_id_seq
 └── Utilisateurs : etudiant, professeur
```

> Pour qu'un utilisateur puisse accéder à une table, il faut **3 niveaux de droits** :
> 1. `GRANT CONNECT` sur la **base**
> 2. `GRANT USAGE` sur le **schéma**
> 3. `GRANT SELECT/INSERT/...` sur la **table**