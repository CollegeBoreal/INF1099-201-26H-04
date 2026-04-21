## 📝 DML — Manipulation des données

### Étape 4 : Insérer les données (INSERT)

```sql
-- ============================================================
-- DML - Data Manipulation Language
-- Bibliothèque Universitaire
-- Prérequis : DDL.sql do## 🏗️ DDL — Définition des structures

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
