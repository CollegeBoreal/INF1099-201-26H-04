# TP PostgreSQL — Gestion des utilisateurs et permissions (DCL)

> **INF1099 · Bases de données · Collège Boréal · Hiver 2026**

---

## Table des matières

- [Objectifs](#objectifs)
- [Étapes du laboratoire](#étapes-du-laboratoire)
  - [Étape 1 — Connexion à PostgreSQL](#étape-1--connexion-à-postgresql)
  - [Étape 2 — Créer la base de données](#étape-2--créer-la-base-de-données)
  - [Étape 3 — Créer un schéma](#étape-3--créer-un-schéma)
  - [Étape 4 — Créer une table](#étape-4--créer-une-table)
  - [Étape 5 — Créer des utilisateurs](#étape-5--créer-des-utilisateurs)
  - [Étape 6 — Attribuer des permissions (GRANT)](#étape-6--attribuer-des-permissions-grant)
  - [Étape 7 — Test utilisateur `etudiant`](#étape-7--test-utilisateur-etudiant)
  - [Étape 8 — Test utilisateur `professeur`](#étape-8--test-utilisateur-professeur)
  - [Étape 9 — Retirer une permission (REVOKE)](#étape-9--retirer-une-permission-revoke)
- [À retenir](#à-retenir)
- [Captures d'écran](#captures-décran)

---

## Objectifs

Ce TP vise à comprendre le **DCL (Data Control Language)** dans PostgreSQL afin de gérer les utilisateurs et leurs permissions.

| Statut | Objectif |
|:------:|----------|
| ✅ | Créer des utilisateurs PostgreSQL |
| ✅ | Attribuer des permissions avec `GRANT` |
| ✅ | Tester les accès (lecture / écriture) |
| ✅ | Retirer des permissions avec `REVOKE` |
| ✅ | Comprendre la sécurité d'une base de données |

---

## Étapes du laboratoire

### Étape 1 — Connexion à PostgreSQL

Connexion en tant qu'administrateur `postgres` via le conteneur Podman.

```bash
podman exec -it postgres psql -U postgres
```
![wait](https://github.com/user-attachments/assets/0504bb4e-474f-434c-ba28-58ddc17d46db)

---

### Étape 2 — Créer la base de données

```sql
CREATE DATABASE airline;
\c airline
```
![wait](https://github.com/user-attachments/assets/273b66c6-94e8-46c4-bd6d-2345aceb8661)

---

### Étape 3 — Créer un schéma

```sql
CREATE SCHEMA tp_dcl;
```
![wait](https://github.com/user-attachments/assets/cc282b78-effb-417a-b8ac-34f9bdbf7358)

---

### Étape 4 — Créer une table

Création d'une table `passager` dans le schéma `tp_dcl`.

```sql
CREATE TABLE tp_dcl.passager (
    id_passager SERIAL PRIMARY KEY,
    nom         TEXT,
    prenom      TEXT,
    email       TEXT
);
```

**Vérification :**

```sql
\dt tp_dcl.*
```
![wait](https://github.com/user-attachments/assets/ef68775a-d568-47e8-a2fe-e0e9a6961357)

---

### Étape 5 — Créer des utilisateurs

```sql
CREATE USER etudiant   WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';
```
![wait](https://github.com/user-attachments/assets/3a29241d-6f18-4a51-9a58-637e1724c1bc)

---

### Étape 6 — Attribuer des permissions (GRANT)

**Accès à la base de données :**

```sql
GRANT CONNECT ON DATABASE airline TO etudiant, professeur;
```

**Accès au schéma :**

```sql
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
```

**Permissions sur la table :**

```sql
-- Étudiant : lecture seule
GRANT SELECT ON tp_dcl.passager TO etudiant;

-- Professeur : accès complet
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.passager TO professeur;
```

**Permissions sur la séquence (pour les INSERT du professeur) :**

```sql
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.passager_id_passager_seq TO professeur;
```
![wait](https://github.com/user-attachments/assets/80c5ae4b-61a0-44d8-9b51-87a6b373445e)

---

### Étape 7 — Test utilisateur `etudiant`

**Connexion :**

```bash
podman exec -it postgres psql -U etudiant -d airline
```

**Lecture — ✅ Autorisé :**

```sql
SELECT * FROM tp_dcl.passager;
```

**Insertion — ❌ Refusé :**

```sql
INSERT INTO tp_dcl.passager(nom, prenom, email)
VALUES ('Diallo', 'Moussa', 'moussa@email.com');
```

```
ERROR: permission denied for table passager
```

> L'utilisateur `etudiant` a uniquement le droit `SELECT` — l'insertion est bien bloquée.

---

### Étape 8 — Test utilisateur `professeur`

**Connexion :**

```bash
podman exec -it postgres psql -U professeur -d airline
```

**Insertion — ✅ Autorisé :**

```sql
INSERT INTO tp_dcl.passager(nom, prenom, email)
VALUES ('Kahil', 'Amine', 'amine@email.com');
```

```
INSERT 0 1
```

**Modification — ✅ Autorisé :**

```sql
UPDATE tp_dcl.passager
SET email = 'amine.kahil@email.com'
WHERE nom = 'Kahil';
```

```
UPDATE 1
```

---

### Étape 9 — Retirer une permission (REVOKE)

**Reconnexion en tant qu'administrateur :**

```bash
podman exec -it postgres psql -U postgres -d airline
```

**Révocation du droit `SELECT` pour `etudiant` :**

```sql
REVOKE SELECT ON tp_dcl.passager FROM etudiant;
```

**Test de vérification (en tant qu'`etudiant`) :**

```sql
SELECT * FROM tp_dcl.passager;
```

```
ERROR: permission denied for table passager
```

> La permission a bien été retirée — l'accès en lecture est maintenant bloqué.

---
![wait](https://github.com/user-attachments/assets/39cb6a0a-a28a-4042-ae6b-f4d72ff50a67)


## À retenir

Le **DCL (Data Control Language)** permet de gérer les droits d'accès dans une base de données relationnelle.

### Commandes principales

| Commande | Description |
|----------|-------------|
| `CREATE USER` | Créer un utilisateur |
| `GRANT` | Donner des permissions |
| `REVOKE` | Retirer des permissions |
| `DROP USER` | Supprimer un utilisateur |

### Hiérarchie des permissions dans PostgreSQL

```
Base de données  →  CONNECT
       ↓
    Schéma       →  USAGE
       ↓
    Table        →  SELECT · INSERT · UPDATE · DELETE
       ↓
   Séquence      →  USAGE · SELECT · UPDATE
```

### Résumé des permissions par utilisateur

| Permission | `etudiant` | `professeur` |
|------------|:----------:|:------------:|
| `CONNECT` | ✅ | ✅ |
| `USAGE` schéma | ✅ | ✅ |
| `SELECT` | ✅ → ❌ (révoqué) | ✅ |
| `INSERT` | ❌ | ✅ |
| `UPDATE` | ❌ | ✅ |
| `DELETE` | ❌ | ✅ |

---

## Captures d'écran

Les captures se trouvent dans le dossier [`/screenshots`](./screenshots/) :

| # | Description |
|---|-------------|
| 01 | Conteneur PostgreSQL actif |
| 02 | Connexion en tant que `postgres` |
| 03 | Création de la base `airline` |
| 04 | Création du schéma `tp_dcl` |
| 05 | Création et vérification de la table `passager` |
| 06 | Création des utilisateurs `etudiant` et `professeur` |
| 07 | Attribution des permissions `GRANT` |
| 08 | Test `etudiant` — `SELECT` autorisé, `INSERT` refusé |
| 09 | Test `professeur` — `INSERT` et `UPDATE` autorisés |
| 10 | Test `REVOKE` — `SELECT` refusé pour `etudiant` |

---

## Auteur

Projet réalisé dans le cadre du cours **INF1099 — Bases de données**  
Collège Boréal · Hiver 2026
