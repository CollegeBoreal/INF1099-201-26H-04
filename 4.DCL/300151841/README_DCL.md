# 🔐 TP PostgreSQL — Gestion des utilisateurs et permissions (DCL)

> **INF1099 — Bases de données** · Massinissa Mameri · `300151841`

---

## 📋 Table des matières

- [Objectifs](#-objectifs)
- [Étapes du laboratoire](#-étapes-du-laboratoire)
  - [Étape 1 — Connexion à PostgreSQL](#étape-1--connexion-à-postgresql)
  - [Étape 2 — Créer la base de données](#étape-2--créer-la-base-de-données)
  - [Étape 3 — Créer un schéma](#étape-3--créer-un-schéma)
  - [Étape 4 — Créer une table](#étape-4--créer-une-table)
  - [Étape 5 — Créer des utilisateurs](#étape-5--créer-des-utilisateurs)
  - [Étape 6 — Attribuer des permissions (GRANT)](#étape-6--attribuer-des-permissions-grant)
  - [Étape 7 — Tester avec l'utilisateur `etudiant`](#étape-7--tester-avec-lutilisateur-etudiant)
  - [Étape 8 — Tester avec l'utilisateur `professeur`](#étape-8--tester-avec-lutilisateur-professeur)
  - [Étape 9 — Retirer une permission (REVOKE)](#étape-9--retirer-une-permission-revoke)
- [À retenir](#-à-retenir)

---

## 🎯 Objectifs

Ce TP guide l'utilisation du **DCL (Data Control Language)** dans PostgreSQL afin de comprendre la gestion des utilisateurs et de leurs permissions.

| # | Objectif |
|---|----------|
| ✅ | Créer des utilisateurs dans PostgreSQL |
| ✅ | Attribuer des permissions avec `GRANT` |
| ✅ | Tester les accès (lecture / écriture) |
| ✅ | Retirer des permissions avec `REVOKE` |
| ✅ | Comprendre la sécurité d'une base de données |

---

## 🚀 Étapes du laboratoire

---

### Étape 1 — Connexion à PostgreSQL

Connexion au conteneur PostgreSQL avec l'utilisateur administrateur.

```bash
podman exec -it postgres psql -U postgres
```

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 2 — Créer la base de données

Création d'une base de données pour le TP.

```sql
CREATE DATABASE cours;
```

Connexion à la base :

```sql
\c cours
```

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 3 — Créer un schéma

Organisation des objets du TP dans un schéma dédié.

```sql
CREATE SCHEMA tp_dcl;
```

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 4 — Créer une table

Création d'une table pour tester les permissions des utilisateurs.

```sql
CREATE TABLE tp_dcl.etudiants (
    id      SERIAL PRIMARY KEY,
    nom     TEXT,
    moyenne NUMERIC
);
```

Vérification de la table :

```sql
\dt tp_dcl.*
```

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 5 — Créer des utilisateurs

Création de deux utilisateurs avec des rôles distincts :

| Utilisateur | Mot de passe | Accès |
|-------------|-------------|-------|
| `etudiant` | `etudiant123` | Lecture seulement |
| `professeur` | `prof123` | Lecture et écriture |

```sql
CREATE USER etudiant   WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';
```

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 6 — Attribuer des permissions (GRANT)

**Accès à la base de données :**

```sql
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
```

**Accès au schéma :**

```sql
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
```

**Permissions sur la table :**

```sql
-- Étudiant : lecture seule
GRANT SELECT ON tp_dcl.etudiants TO etudiant;

-- Professeur : lecture + écriture complète
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;
```

**Permissions sur la séquence :**

```sql
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;
```

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 7 — Tester avec l'utilisateur `etudiant`

Connexion en tant qu'étudiant :

```bash
podman exec -it postgres psql -U etudiant -d cours
```

**Test de lecture ✅**

```sql
SELECT * FROM tp_dcl.etudiants;
-- Résultat : lecture autorisée
```

**Test d'insertion ❌**

```sql
INSERT INTO tp_dcl.etudiants(nom, moyenne)
VALUES ('Patrick', 85);
```

```
ERROR: permission denied for table etudiants
```

> L'utilisateur `etudiant` ne peut que **lire** les données, pas les modifier.

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 8 — Tester avec l'utilisateur `professeur`

Connexion en tant que professeur :

```bash
podman exec -it postgres psql -U professeur -d cours
```

**Insertion ✅**

```sql
INSERT INTO tp_dcl.etudiants(nom, moyenne)
VALUES ('Khaled', 90);
```

**Modification ✅**

```sql
UPDATE tp_dcl.etudiants
SET moyenne = 95
WHERE nom = 'Khaled';
```

> L'utilisateur `professeur` a un accès **complet** en lecture et écriture.

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

### Étape 9 — Retirer une permission (REVOKE)

Reconnexion en administrateur :

```bash
podman exec -it postgres psql -U postgres -d cours
```

Retrait de la permission de lecture pour `etudiant` :

```sql
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
```

Vérification — reconnexion avec `etudiant` :

```sql
SELECT * FROM tp_dcl.etudiants;
```

```
ERROR: permission denied for table etudiants
```

> La permission a bien été révoquée. L'accès est désormais **bloqué**.

> 🖼️ *Capture d'écran disponible dans le dossier `images/`*

---

## 🧠 À retenir

**DCL** signifie **Data Control Language** — il gère les droits d'accès dans PostgreSQL.

### Commandes principales

| Commande | Description |
|----------|-------------|
| `CREATE USER` | Créer un nouvel utilisateur |
| `GRANT` | Attribuer des permissions |
| `REVOKE` | Retirer des permissions |
| `DROP USER` | Supprimer un utilisateur |

### Niveaux de permissions dans PostgreSQL

```
Base de données  →  accès global à la base
      │
      └── Schéma  →  accès aux objets du schéma
                │
                └── Table  →  opérations sur les données (SELECT, INSERT, UPDATE, DELETE)
```

---

*Cours INF1099 — Bases de données · Massinissa Mameri · `300151841`*
