# 📚 TP Modélisation SQL
## Système de Gestion d'une Bibliothèque Universitaire

<div align="center">

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)
![SQL](https://img.shields.io/badge/SQL-DDL%20|%20DML%20|%20DQL%20|%20DCL-orange)
![Status](https://img.shields.io/badge/Status-Complété-brightgreen)

</div>

---

## 📚 Table des matières

* [🎯 Aperçu du projet](#-aperçu-du-projet)
* [📁 Structure du projet](#-structure-du-projet)
* [🔄 Normalisation](#-normalisation)
* [📊 Diagramme ER](#-diagramme-er)
* [🚀 Démarrage rapide](#-démarrage-rapide)
* [🏗️ DDL — Définition des structures](#️-ddl--définition-des-structures)
* [📝 DML — Manipulation des données](#-dml--manipulation-des-données)
* [🔍 DQL — Requêtes de données](#-dql--requêtes-de-données)
* [🔐 DCL — Contrôle des accès](#-dcl--contrôle-des-accès)

---

## 🎯 Aperçu du projet

Le domaine choisi est la gestion d'une **bibliothèque universitaire**. Ce sujet permet de modéliser le cycle complet depuis l'inscription d'un membre jusqu'au retour des livres empruntés et au paiement d'amendes, en passant par l'affectation d'un employé responsable.

| Catégorie | Détails |
|-----------|---------|
| 🗄️ SGBD | PostgreSQL 16 |
| 🐳 Environnement | Docker |
| 📐 Schéma | `bibliotheque` |
| 🗂️ Tables | 9 tables normalisées |
| 👤 Utilisateurs | `employe_user`, `gestionnaire_user` |

---

## 📁 Structure du projet

```
TP_SQL/
├── 📄 README.md
├── 📄 DDL.sql          ← Création des tables
├── 📄 DML.sql          ← Insertion, modification, suppression
├── 📄 DQL.sql          ← Requêtes de consultation
├── 📄 DCL.sql          ← Gestion des droits
└── 📁 images/
    ├── diagramme_er.png
    ├── 1.png
    ├── 2.png
    └── ...
```

> ⚠️ **Ordre d'exécution obligatoire :** `DDL.sql` → `DML.sql` → `DQL.sql` → `DCL.sql`

---

## 🔄 Normalisation

### 1️⃣ 1FN — Première Forme Normale

Dans cette phase, toutes les données sont regroupées dans une structure plate ("Flat Table"). Chaque attribut est **atomique**. Il n'y a pas encore d'ID techniques.

**Attributs :**

> Membre, Adresse_Membre, Livre, Catégorie, Auteur, Emprunt, Ligne_Emprunt, Paiement, Employé

---

### 2️⃣ 2FN — Deuxième Forme Normale

Définition des relations et des cardinalités. On sépare les entités pour éviter les redondances partielles.

| Entité A | Cardinalité | Relation | Cardinalité | Entité B |
|----------|:-----------:|----------|:-----------:|----------|
| Membre | (0,N) | EFFECTUE | (1,1) | Emprunt |
| Membre | (1,N) | HABITE | (1,1) | Adresse |
| Emprunt | (1,N) | CONTIENT | (1,1) | Ligne_Emprunt |
| Livre | (0,N) | APPARTIENT_À | (1,1) | Catégorie |
| Auteur | (1,N) | ÉCRIT | (1,1) | Livre |
| Ligne_Emprunt | (0,N) | INCLUT | (1,1) | Livre |
| Emprunt | (1,1) | GÉNÈRE | (0,1) | Paiement |
| Employé | (1,N) | GÈRE | (1,1) | Emprunt |

---

### 3️⃣ 3FN — Troisième Forme Normale

Structure finale. Les dépendances transitives sont éliminées. Introduction des **Clés Primaires (ID)** et des **Clés Étrangères (#)**.

| Table | Attributs |
|-------|-----------|
| Membre | ID_Membre 🔑, Nom, Prénom, Téléphone, Email |
| Adresse | ID_Adresse 🔑, Numéro_Rue, Rue, Ville, Code_Postal, #ID_Membre |
| Auteur | ID_Auteur 🔑, Nom, Prénom, Nationalité |
| Catégorie | ID_Categorie 🔑, Nom_Categorie |
| Livre | ID_Livre 🔑, Titre, Année_Publication, ISBN, #ID_Auteur, #ID_Categorie |
| Employé | ID_Employe 🔑, Nom, Prénom, Poste |
| Emprunt | ID_Emprunt 🔑, Date_Emprunt, Date_Retour_Prevue, Statut, #ID_Membre, #ID_Employe |
| Ligne_Emprunt | ID_Ligne 🔑, Date_Retour_Effective, #ID_Emprunt, #ID_Livre |
| Paiement | ID_Paiement 🔑, Date_Paiement, Montant, Mode_Paiement, #ID_Emprunt |

> 💡 **Légende :** 🔑 Clé Primaire &nbsp;|&nbsp; `#` Clé Étrangère

---

## 📊 Diagramme ER

Le diagramme ci-dessous représente la structure conceptuelle du système :

<img width="563" height="655" alt="image" src="https://github.com/user-attachments/assets/7953d89c-9dbb-426a-9462-6139e97256a7" />


> *(Assurez-vous que l'image se trouve dans le dossier `images/`)*

---

## 🚀 Démarrage rapide

```bash
# 1. Entrer dans le container Docker
docker container exec --interactive --tty postgres bash

# 2. Se connecter en superutilisateur
psql -U postgres
```

```sql
-- 3. Créer la base de données
CREATE DATABASE gestion_bibliotheque;
\c gestion_bibliotheque
```

```bash
# 4. Exécuter les fichiers dans l'ordre
\i DDL.sql
\i DML.sql
\i DQL.sql
\i DCL.sql
```

---

## 🏗️ DDL — Définition des structures

### Étape 1 : Connexion et création de la base

```bash
docker container exec --interactive --tty postgres bash
psql -U postgres
```

```sql
CREATE DATABASE gestion_bibliotheque;
\c gestion_bibliotheque
CREATE SCHEMA IF NOT EXISTS bibliotheque;
```

---

### Étape 2 : Création des tables

```sql
-- ============================================================
-- DDL - Data Definition Language
-- Bibliothèque Universitaire
-- ============================================================

CREATE SCHEMA IF NOT EXISTS bibliotheque;

-- ------------------------------------------------------------
-- Table : Membre
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Membre (
    ID_Membre   SERIAL PRIMARY KEY,
    Nom         TEXT NOT NULL,
    Prenom      TEXT NOT NULL,
    Telephone   TEXT,
    Email       TEXT
);

-- ------------------------------------------------------------
-- Table : Adresse
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Adresse (
    ID_Adresse  SERIAL PRIMARY KEY,
    Numero_Rue  TEXT,
    Rue         TEXT NOT NULL,
    Ville       TEXT NOT NULL,
    Code_Postal TEXT NOT NULL,
    ID_Membre   INT  NOT NULL REFERENCES bibliotheque.Membre(ID_Membre)
);

-- ------------------------------------------------------------
-- Table : Auteur
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Auteur (
    ID_Auteur   SERIAL PRIMARY KEY,
    Nom         TEXT NOT NULL,
    Prenom      TEXT NOT NULL,
    Nationalite TEXT
);

-- ------------------------------------------------------------
-- Table : Categorie
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Categorie (
    ID_Categorie   SERIAL PRIMARY KEY,
    Nom_Categorie  TEXT NOT NULL
);

-- ------------------------------------------------------------
-- Table : Livre
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Livre (
    ID_Livre          SERIAL PRIMARY KEY,
    Titre             TEXT NOT NULL,
    Annee_Publication INT,
    ISBN              TEXT,
    ID_Auteur         INT  NOT NULL REFERENCES bibliotheque.Auteur(ID_Auteur),
    ID_Categorie      INT  NOT NULL REFERENCES bibliotheque.Categorie(ID_Categorie)
);

-- ------------------------------------------------------------
-- Table : Employe
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Employe (
    ID_Employe  SERIAL PRIMARY KEY,
    Nom         TEXT NOT NULL,
    Prenom      TEXT NOT NULL,
    Poste       TEXT
);

-- ------------------------------------------------------------
-- Table : Emprunt
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Emprunt (
    ID_Emprunt         SERIAL PRIMARY KEY,
    Date_Emprunt       DATE NOT NULL,
    Date_Retour_Prevue DATE NOT NULL,
    Statut             TEXT NOT NULL,
    ID_Membre          INT  NOT NULL REFERENCES bibliotheque.Membre(ID_Membre),
    ID_Employe         INT  NOT NULL REFERENCES bibliotheque.Employe(ID_Employe)
);

-- ------------------------------------------------------------
-- Table : Ligne_Emprunt
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Ligne_Emprunt (
    ID_Ligne              SERIAL PRIMARY KEY,
    Date_Retour_Effective DATE,
    ID_Emprunt            INT NOT NULL REFERENCES bibliotheque.Emprunt(ID_Emprunt),
    ID_Livre              INT NOT NULL REFERENCES bibliotheque.Livre(ID_Livre)
);

-- ------------------------------------------------------------
-- Table : Paiement
-- ------------------------------------------------------------
CREATE TABLE bibliotheque.Paiement (
    ID_Paiement   SERIAL PRIMARY KEY,
    Date_Paiement DATE          NOT NULL,
    Montant       NUMERIC(10,2) NOT NULL,
    Mode_Paiement TEXT          NOT NULL,
    ID_Emprunt    INT           NOT NULL REFERENCES bibliotheque.Emprunt(ID_Emprunt)
);
```

---

### Étape 3 : Vérifier les tables créées

```sql
\dt bibliotheque.*
```

**Output attendu :**

```
         List of relations
   Schema       |     Name      | Type  |  Owner
----------------+---------------+-------+----------
 bibliotheque   | adresse       | table | postgres
 bibliotheque   | auteur        | table | postgres
 bibliotheque   | categorie     | table | postgres
 bibliotheque   | employe       | table | postgres
 bibliotheque   | emprunt       | table | postgres
 bibliotheque   | ligne_emprunt | table | postgres
 bibliotheque   | livre         | table | postgres
 bibliotheque   | membre        | table | postgres
 bibliotheque   | paiement      | table | postgres
(9 rows)
```

---

## 📝 DML — Manipulation des données

### Étape 4 : Insérer les données (INSERT)

```sql
-- ============================================================
-- DML - Data Manipulation Language
-- Bibliothèque Universitaire
-- Prérequis : DDL.sql doit avoir été exécuté
-- ============================================================

-- Auteurs
INSERT INTO bibliotheque.Auteur (Nom, Prenom, Nationalite) VALUES
    ('Hugo',    'Victor', 'Française'),
    ('Rowling', 'J.K.',   'Britannique'),
    ('Camus',   'Albert', 'Française');

-- Catégories
INSERT INTO bibliotheque.Categorie (Nom_Categorie) VALUES
    ('Roman'),
    ('Science-Fiction'),
    ('Philosophie');

-- Livres
INSERT INTO bibliotheque.Livre (Titre, Annee_Publication, ISBN, ID_Auteur, ID_Categorie) VALUES
    ('Les Misérables',                       1862, '978-2-07-040850-4', 1, 1),
    ('Harry Potter à l''école des sorciers', 1997, '978-2-07-054100-9', 2, 1),
    ('L''Étranger',                          1942, '978-2-07-036024-5', 3, 3);

-- Membres
INSERT INTO bibliotheque.Membre (Nom, Prenom, Telephone, Email) VALUES
    ('Tremblay', 'Marie', '514-111-2222', 'marie.tremblay@email.com'),
    ('Gagnon',   'Luc',   '438-333-4444', 'luc.gagnon@email.com');

-- Adresses
INSERT INTO bibliotheque.Adresse (Numero_Rue, Rue, Ville, Code_Postal, ID_Membre) VALUES
    ('12', 'Rue Sainte-Catherine', 'Montréal', 'H3B 1A7', 1),
    ('5',  'Boulevard Laurier',    'Québec',   'G1V 2M2', 2);

-- Employés
INSERT INTO bibliotheque.Employe (Nom, Prenom, Poste) VALUES
    ('Côté', 'Jean',   'Bibliothécaire'),
    ('Roy',  'Sophie', 'Assistant');

-- Emprunts
INSERT INTO bibliotheque.Emprunt (Date_Emprunt, Date_Retour_Prevue, Statut, ID_Membre, ID_Employe) VALUES
    ('2024-03-01', '2024-03-15', 'En cours', 1, 1),
    ('2024-03-05', '2024-03-20', 'Terminé',  2, 2);

-- Lignes d'emprunt
INSERT INTO bibliotheque.Ligne_Emprunt (Date_Retour_Effective, ID_Emprunt, ID_Livre) VALUES
    (NULL,         1, 1),
    ('2024-03-18', 2, 2);

-- Paiements (amendes)
INSERT INTO bibliotheque.Paiement (Date_Paiement, Montant, Mode_Paiement, ID_Emprunt) VALUES
    ('2024-03-21', 5.00, 'Carte crédit', 1),
    ('2024-03-19', 2.50, 'Comptant',     2);
```

---

### Étape 5 : Modifier des données (UPDATE)

```sql
-- Mettre à jour le statut de l'emprunt 1
UPDATE bibliotheque.Emprunt
SET Statut = 'Terminé'
WHERE ID_Emprunt = 1;

-- Mise à jour du montant d'un paiement
UPDATE bibliotheque.Paiement
SET Montant = 3.50
WHERE ID_Paiement = 2;
```

**Vérifier :**

```sql
SELECT ID_Emprunt, Statut FROM bibliotheque.Emprunt;
```

**Output attendu :**

```
 id_emprunt |  statut
------------+---------
          2 | Terminé
          1 | Terminé
(2 rows)
```

---

### Étape 6 : Supprimer des données (DELETE)

```sql
-- Supprimer le paiement 2
DELETE FROM bibliotheque.Paiement
WHERE ID_Paiement = 2;

-- Vérifier
SELECT * FROM bibliotheque.Paiement;
```

**Output attendu :**

```
DELETE 1
```

---

## 🔍 DQL — Requêtes de données

### Étape 7 : Requêtes de consultation (SELECT)

```sql
-- ============================================================
-- DQL - Data Query Language
-- Bibliothèque Universitaire
-- Prérequis : DDL.sql et DML.sql doivent avoir été exécutés
-- ============================================================

-- ------------------------------------------------------------
-- Requête 1 : Liste simple de toutes les catégories
-- ------------------------------------------------------------
SELECT * FROM bibliotheque.Categorie;

-- ------------------------------------------------------------
-- Requête 2 : Liste des emprunts avec membre et employé
-- ------------------------------------------------------------
SELECT
    e.ID_Emprunt,
    m.Nom              AS Membre,
    emp.Nom            AS Employe,
    e.Date_Emprunt,
    e.Date_Retour_Prevue,
    e.Statut
FROM bibliotheque.Emprunt e
JOIN bibliotheque.Membre  m   ON e.ID_Membre  = m.ID_Membre
JOIN bibliotheque.Employe emp ON e.ID_Employe = emp.ID_Employe;
```

**Output attendu :**

```
 id_emprunt | membre   | employe | date_emprunt | date_retour_prevue |  statut
------------+----------+---------+--------------+--------------------+---------
          1 | Tremblay | Côté    | 2024-03-01   | 2024-03-15         | Terminé
          2 | Gagnon   | Roy     | 2024-03-05   | 2024-03-20         | Terminé
(2 rows)
```

```sql
-- ------------------------------------------------------------
-- Requête 3 : Détail complet d'un emprunt (livres + auteurs)
-- ------------------------------------------------------------
SELECT
    e.ID_Emprunt,
    m.Nom                    AS Membre,
    l.Titre,
    a.Nom                    AS Auteur,
    le.Date_Retour_Effective
FROM bibliotheque.Ligne_Emprunt le
JOIN bibliotheque.Emprunt e ON le.ID_Emprunt = e.ID_Emprunt
JOIN bibliotheque.Membre  m ON e.ID_Membre   = m.ID_Membre
JOIN bibliotheque.Livre   l ON le.ID_Livre   = l.ID_Livre
JOIN bibliotheque.Auteur  a ON l.ID_Auteur   = a.ID_Auteur;

-- ------------------------------------------------------------
-- Requête 4 : Emprunts filtrés par statut
-- ------------------------------------------------------------
SELECT
    e.ID_Emprunt,
    m.Nom AS Membre,
    e.Date_Emprunt,
    e.Statut
FROM bibliotheque.Emprunt e
JOIN bibliotheque.Membre m ON e.ID_Membre = m.ID_Membre
WHERE e.Statut = 'Terminé';

-- ------------------------------------------------------------
-- Requête 5 : Total des amendes payées par membre
-- ------------------------------------------------------------
SELECT
    m.Nom          AS Membre,
    m.Prenom,
    SUM(p.Montant) AS Total_Amendes
FROM bibliotheque.Paiement p
JOIN bibliotheque.Emprunt e ON p.ID_Emprunt = e.ID_Emprunt
JOIN bibliotheque.Membre  m ON e.ID_Membre  = m.ID_Membre
GROUP BY m.ID_Membre, m.Nom, m.Prenom
ORDER BY Total_Amendes DESC;

-- ------------------------------------------------------------
-- Requête 6 : Livres avec leur auteur et catégorie
-- ------------------------------------------------------------
SELECT
    l.Titre,
    l.Annee_Publication,
    a.Nom           AS Auteur,
    c.Nom_Categorie AS Categorie
FROM bibliotheque.Livre l
JOIN bibliotheque.Auteur    a ON l.ID_Auteur    = a.ID_Auteur
JOIN bibliotheque.Categorie c ON l.ID_Categorie = c.ID_Categorie;
```

---

## 🔐 DCL — Contrôle des accès

### Matrice des permissions

| Permission | employe_user | gestionnaire_user |
|------------|:------------:|:-----------------:|
| SELECT | ✅ | ✅ |
| INSERT | ❌ | ✅ |
| UPDATE | ❌ | ✅ |
| DELETE | ❌ | ✅ |
| SEQUENCES | ❌ | ✅ |

---

### Étape 8 : Créer les utilisateurs

```sql
-- Employé : lecture seule
CREATE USER employe_user WITH PASSWORD 'emp123';

-- Gestionnaire : accès complet
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';
```

---

### Étape 9 : Donner les droits (GRANT)

```sql
-- Connexion à la base
GRANT CONNECT ON DATABASE gestion_bibliotheque TO employe_user, gestionnaire_user;

-- Accès au schéma
GRANT USAGE ON SCHEMA bibliotheque TO employe_user, gestionnaire_user;

-- Employé : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA bibliotheque TO employe_user;

-- Gestionnaire : lecture + écriture complète
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bibliotheque TO gestionnaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA bibliotheque TO gestionnaire_user;
```

---

### Étape 10 : Tester les droits de l'employé

```sql
\q
psql -U employe_user -d gestion_bibliotheque
```

```sql
SELECT * FROM bibliotheque.Emprunt;                                     -- ✅ OK
INSERT INTO bibliotheque.Auteur (Nom, Prenom) VALUES ('Test', 'User'); -- ❌ Doit échouer
```

**Output attendu :**

```
ERROR:  permission denied for table auteur
```

---

### Étape 11 : Tester les droits du gestionnaire

```sql
\q
psql -U gestionnaire_user -d gestion_bibliotheque
```

```sql
INSERT INTO bibliotheque.Categorie (Nom_Categorie) VALUES ('Biographie');          -- ✅ OK
UPDATE bibliotheque.Livre SET Annee_Publication = 1863 WHERE ID_Livre = 1;         -- ✅ OK
SELECT * FROM bibliotheque.Categorie;                                               -- ✅ OK
```

---

### Étape 12 : Retirer les droits (REVOKE)

```sql
\q
psql -U postgres -d gestion_bibliotheque
```

```sql
REVOKE SELECT ON ALL TABLES IN SCHEMA bibliotheque FROM employe_user;
```

**Vérifier :**

```sql
\c - employe_user
SELECT * FROM bibliotheque.Emprunt; -- ❌ Doit échouer
```

**Output attendu :**

```
ERROR:  permission denied for table emprunt
```

---

### Étape 13 : Supprimer les utilisateurs (DROP USER)

```sql
\c - postgres
```

```sql
DROP USER employe_user;
DROP USER gestionnaire_user;
```

> ⚠️ PostgreSQL ne permet pas de supprimer un utilisateur si celui-ci possède encore des privilèges. Il faut d'abord révoquer tous ses droits.

**Output attendu :**

```
ERROR:  role "employe_user" cannot be dropped because some objects depend on it
DETAIL:  privileges for database gestion_bibliotheque
         privileges for schema bibliotheque
```

---

*Projet réalisé dans le cadre du cours de Modélisation SQL.*
