# 🛫 Projet SQL — Gestion d'un Aéroport avec PostgreSQL

**Cours :** INF1099 — Modélisation SQL  
**Section :** 26H-04  
**SGBD :** PostgreSQL  
**Schéma :** `aeroport`

---

## 📋 Description du projet

Ce projet implémente une base de données relationnelle complète pour la gestion d'un aéroport.  
Il couvre l'ensemble du cycle SQL : modélisation, création, insertion, consultation, modification, suppression et contrôle des accès.

> **Méthode de travail :**
> 1. Exécution automatique via les scripts SQL (`DDL.sql`, `DML.sql`, `DQL.sql`, `DCL.sql`) pour valider le bon fonctionnement global.
> 2. Reproduction manuelle de chaque étape avec captures d'écran pour démontrer la compréhension réelle du système.

---

## 📁 Structure du projet

![Structure du projet](images/1.PNG)

```
5.ModelisationSQL/
├── DDL.sql        # Création des tables (CREATE TABLE)
├── DML.sql        # Manipulation des données (INSERT / UPDATE / DELETE)
├── DQL.sql        # Requêtes de lecture (SELECT / JOIN / GROUP BY)
├── DCL.sql        # Contrôle des accès (GRANT / REVOKE / ROLES)
├── images/        # Captures d'écran de chaque étape
└── README.md
```

---

## 🗂️ Diagrammes de la base de données

### Diagramme Entité-Relation (ER)

<img width="8192" height="6132" alt="diagramme1" src="https://github.com/user-attachments/assets/a072ce66-eb23-4197-a935-699f4e3d82d1" />


### Diagramme relationnel (modèle logique)

<img width="1384" height="1183" alt="diagramme2" src="https://github.com/user-attachments/assets/86e6839a-fd19-4aff-a282-a4cd756a2eb3" />


---

## 🗄️ Tables du système (15 tables)

| Table               | Description                                            |
|---------------------|--------------------------------------------------------|
| `CompagnieAerienne` | Compagnies aériennes (nom, pays, code IATA)            |
| `Avion`             | Flotte d'avions liée aux compagnies                    |
| `Terminal`          | Terminaux de l'aéroport                                |
| `Gate`              | Portes d'embarquement par terminal                     |
| `Runway`            | Pistes d'atterrissage/décollage                        |
| `Vol`               | Vols (origine, destination, avion, gate, piste)        |
| `Passager`          | Passagers (nom, passeport, nationalité)                |
| `Reservation`       | Réservations de passagers sur des vols                 |
| `Billet`            | Billets émis (siège, classe)                           |
| `Bagage`            | Bagages des passagers                                  |
| `Personnel`         | Employés de l'aéroport                                 |
| `ControleSecurite`  | Contrôles de sécurité (passager + agent)               |
| `Maintenance`       | Interventions de maintenance sur les avions            |
| `Incident`          | Incidents signalés sur des vols                        |
| `ServiceSol`        | Services au sol assignés aux vols                      |

---

## 🔁 Phase 1 — Exécution automatique des scripts

Avant la démonstration manuelle, tous les scripts ont été exécutés automatiquement pour valider leur bon fonctionnement.

### DDL.sql — Création automatique du schéma

<img width="588" height="550" alt="7" src="https://github.com/user-attachments/assets/2c415387-70a9-4578-90d7-1e710dc72771" />


> PostgreSQL effectue un `DROP CASCADE` sur les 15 objets existants avant de recréer le schéma complet.

### DML.sql — Insertion automatique des données

<img width="395" height="417" alt="8" src="https://github.com/user-attachments/assets/09bdaef7-b1de-4575-86ca-ab2a03a109cf" />


### DQL.sql — Requêtes automatiques

<img width="808" height="693" alt="9" src="https://github.com/user-attachments/assets/b343c2e2-578b-488f-9692-5e5868a15f94" />

<img width="711" height="719" alt="9 1" src="https://github.com/user-attachments/assets/ea06cc09-5376-4949-85a1-85e255621b47" />

<img width="676" height="717" alt="9 2" src="https://github.com/user-attachments/assets/add16bb9-0a42-436a-9ea1-a24a7cee0031" />


### DCL.sql — Contrôle des accès automatique

<img width="1134" height="724" alt="10" src="https://github.com/user-attachments/assets/3d6929ce-b8b2-405b-b0b1-88222b7d837b" />

<img width="933" height="714" alt="10 1" src="https://github.com/user-attachments/assets/7c915ddd-679f-46db-b5a1-d0c81acdc532" />

---

## 🔧 Phase 2 — Démonstration manuelle étape par étape

---

## Étape 1 — Création de la base de données

```sql
DROP DATABASE IF EXISTS aeroport;
CREATE DATABASE aeroport;
\c aeroport
CREATE SCHEMA aeroport;
```

<img width="786" height="295" alt="11" src="https://github.com/user-attachments/assets/7410bcaa-d1db-4c4a-baa7-ae83266caa59" />


> ✅ La base `aeroport` est créée, la connexion est établie et le schéma `aeroport` est initialisé.

---

## Étape 2 — Création des tables (DDL)

Toutes les tables sont créées manuellement avec leurs **clés primaires**, **clés étrangères** et **contraintes de référence**. L'ordre de création respecte les dépendances entre tables.

```sql
CREATE TABLE CompagnieAerienne (
    id_compagnie SERIAL PRIMARY KEY,
    nom TEXT,
    pays TEXT,
    code_IATA TEXT
);

CREATE TABLE Avion (
    id_avion SERIAL PRIMARY KEY,
    modele TEXT,
    capacite INT,
    annee_fabrication INT,
    id_compagnie INT REFERENCES CompagnieAerienne(id_compagnie)
);

CREATE TABLE Terminal (
    id_terminal SERIAL PRIMARY KEY,
    nom TEXT,
    capacite INT
);

CREATE TABLE Gate (
    id_gate SERIAL PRIMARY KEY,
    code_gate TEXT,
    id_terminal INT REFERENCES Terminal(id_terminal)
);

-- ... (et les 11 autres tables)
```

<img width="1366" height="729" alt="12" src="https://github.com/user-attachments/assets/c13a4825-59f2-402f-b167-57013023893e" />



### Vérification — liste des 15 tables créées

```sql
\dt aeroport.*
```
<img width="465" height="429" alt="13" src="https://github.com/user-attachments/assets/d9530fd0-fd20-4b67-bd5c-3a28ac10a992" />


> ✅ Les 15 tables sont présentes : `avion`, `bagage`, `billet`, `compagnieaerienne`, `controlesecurite`, `gate`, `incident`, `maintenance`, `passager`, `personnel`, `reservation`, `runway`, `servicesol`, `terminal`, `vol`.

---

## Étape 3 — Insertion des données (INSERT)

```sql
INSERT INTO CompagnieAerienne (nom, pays, code_IATA)
VALUES ('Air France', 'France', 'AF'),
       ('Air Algerie', 'Algerie', 'AH');

INSERT INTO Avion (modele, capacite, annee_fabrication, id_compagnie)
VALUES ('Boeing 737', 180, 2015, 1),
       ('Airbus A320', 160, 2018, 2);

INSERT INTO Vol (numero_vol, date_depart, date_arrivee, origine, destination, id_avion, id_gate, id_runway)
VALUES ('AF123', '2026-05-01', '2026-05-01', 'Paris', 'Alger', 1, 1, 1),
       ('AH456', '2026-05-02', '2026-05-02', 'Alger', 'Lyon', 2, 2, 2);
```

<img width="1366" height="730" alt="15" src="https://github.com/user-attachments/assets/80ddeee5-ca09-4786-9a47-3c99ba0e4370" />


> ✅ Toutes les données sont insérées avec succès dans les 15 tables en respectant l'ordre des dépendances.

---

## Étape 4 — Lecture des données (SELECT)

### Requêtes simples et avec conditions

```sql
-- Requêtes simples
SELECT * FROM aeroport.Passager;
SELECT * FROM aeroport.Vol;
SELECT * FROM aeroport.Avion;

-- Requêtes avec condition
SELECT * FROM aeroport.Vol WHERE origine = 'Paris';
SELECT * FROM aeroport.Reservation WHERE statut = 'Confirmee';
```

### Requêtes avec JOIN

```sql
-- Vol avec avion, gate et piste
SELECT v.numero_vol, v.origine, v.destination,
       a.modele AS avion, g.code_gate, r.code_runway
FROM Vol v
JOIN Avion a   ON v.id_avion  = a.id_avion
JOIN Gate g    ON v.id_gate   = g.id_gate
JOIN Runway r  ON v.id_runway = r.id_runway;

-- Passagers avec leurs vols (Passager → Reservation → Vol)
SELECT p.nom, p.prenom, v.numero_vol, v.destination
FROM Passager p
JOIN Reservation res ON p.id_passager = res.id_passager
JOIN Vol v           ON res.id_vol    = v.id_vol;
```
<img width="1366" height="729" alt="16" src="https://github.com/user-attachments/assets/0425a95c-964d-47cb-adc8-f01a79a5c6be" />


> ✅ Les relations entre tables sont vérifiées : `Passager → Reservation → Vol → Avion → CompagnieAerienne`.

---

## Étape 5 — Modification des données (UPDATE)

### UPDATE simple — modifier la nationalité d'un passager

```sql
-- Avant modification
SELECT * FROM Passager;

-- Modification
UPDATE Passager
SET nationalite = 'Canadienne'
WHERE nom = 'Dupont';

-- Vérification
SELECT * FROM Passager;
```

### UPDATE avec condition — annuler une réservation

```sql
UPDATE Reservation
SET statut = 'Annulee'
WHERE id_reservation = 2;
```

<img width="844" height="589" alt="17" src="https://github.com/user-attachments/assets/5d8beae8-5394-4359-ab6f-6a6e66a10365" />


### UPDATE avec jointure — valider les réservations vers Lyon

```sql
UPDATE Reservation r
SET statut = 'Validee'
FROM Vol v
WHERE r.id_vol = v.id_vol
  AND v.destination = 'Lyon';

-- Vérification
SELECT id_reservation, statut FROM Reservation;
```

<img width="491" height="296" alt="17 1" src="https://github.com/user-attachments/assets/a5a0ac98-27cc-4cc9-8622-95e9142e6ebe" />


> ✅ Chaque UPDATE est immédiatement vérifié avec un `SELECT` pour confirmer la modification.

---

## Étape 6 — Suppression des données (DELETE)

### DELETE avec condition — supprimer les bagages légers

```sql
-- Avant suppression : 2 bagages
SELECT * FROM aeroport.Bagage;

-- Suppression des bagages de moins de 18 kg
DELETE FROM Bagage WHERE poids < 18;

-- Après suppression : 1 bagage
SELECT * FROM aeroport.Bagage;
```

<img width="545" height="285" alt="18" src="https://github.com/user-attachments/assets/76530fcb-7d93-4951-ae72-5628d3dcc652" />


> ✅ Avant : 2 bagages (Valise 20.5kg + Sac 15kg). Après : 1 bagage (Valise 20.5kg uniquement).

---

## Étape 7 — Contrôle des accès (DCL)

Deux rôles sont créés pour sécuriser l'accès à la base de données :

| Rôle         | Permissions                                                          |
|--------------|----------------------------------------------------------------------|
| `user_read`  | `SELECT` uniquement sur toutes les tables                            |
| `user_admin` | `SELECT`, `INSERT`, `UPDATE`, `DELETE` + accès aux séquences SERIAL  |

---

### Problème 1 — rôles non supprimables (dépendances sur tables)

Lors du premier `DROP ROLE`, PostgreSQL refuse car les rôles possèdent encore des droits sur les tables du schéma :

<img width="1155" height="599" alt="19 1" src="https://github.com/user-attachments/assets/4d23fb5f-8de9-40c7-be84-1a91b48a4ddd" />


> ⚠️ **Problème :** Les rôles ont encore des privilèges actifs sur les tables.  
> **Solution :** Exécuter `REVOKE` sur toutes les tables avant `DROP ROLE`.

---

### Création des rôles et attribution des droits

```sql
CREATE ROLE user_read  LOGIN PASSWORD 'read123';
CREATE ROLE user_admin LOGIN PASSWORD 'admin123';

-- Accès au schéma
GRANT USAGE ON SCHEMA aeroport TO user_read;
GRANT USAGE ON SCHEMA aeroport TO user_admin;

-- Lecture seule pour user_read
GRANT SELECT ON ALL TABLES IN SCHEMA aeroport TO user_read;

-- Accès complet pour user_admin
GRANT SELECT, INSERT, UPDATE, DELETE
    ON ALL TABLES IN SCHEMA aeroport TO user_admin;

-- Accès aux séquences SERIAL (nécessaire pour INSERT avec id auto-incrémenté)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA aeroport TO user_admin;

-- Droits automatiques pour les futures nouvelles tables
ALTER DEFAULT PRIVILEGES IN SCHEMA aeroport
    GRANT SELECT ON TABLES TO user_read;

ALTER DEFAULT PRIVILEGES IN SCHEMA aeroport
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO user_admin;
```

<img width="679" height="515" alt="19 2" src="https://github.com/user-attachments/assets/e019825f-3b38-4303-aa56-f2f21df83c8b" />


---

### Test de validation des permissions

```sql
-- Test user_read : SELECT autorisé, INSERT refusé
SET ROLE user_read;
SELECT * FROM aeroport.Passager;            -- ✅ 2 lignes retournées
INSERT INTO aeroport.Passager ...;          -- ❌ ERREUR : droit refusé
RESET ROLE;

-- Test user_admin : INSERT autorisé
SET ROLE user_admin;
INSERT INTO aeroport.Passager ...;          -- ✅ INSERT 0 1
RESET ROLE;
```

<img width="1076" height="698" alt="19 3" src="https://github.com/user-attachments/assets/27c6aee9-6e5c-4907-83a8-ebaccf95cda2" />


---

### Révocation des droits et suppression des rôles

### Problème 2 — séquences encore dépendantes

Lors de la tentative de `DROP ROLE user_admin`, une deuxième erreur apparaît car `user_admin` possède encore des droits sur les séquences SERIAL :

```sql
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA aeroport FROM user_admin;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA aeroport FROM user_read;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA aeroport FROM user_admin;
REVOKE USAGE ON SCHEMA aeroport FROM user_read;
REVOKE USAGE ON SCHEMA aeroport FROM user_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA aeroport REVOKE ALL ON TABLES FROM user_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA aeroport REVOKE ALL ON TABLES FROM user_admin;

DROP ROLE user_read;   -- ✅ DROP ROLE

-- user_admin encore en erreur : droits sur les séquences
DROP ROLE user_admin;  -- ❌ ERREUR : droits sur séquences
```

> ⚠️ **Problème :** `user_admin` possède encore des droits sur les 15 séquences SERIAL du schéma.  
> **Solution :** Ajouter `REVOKE ALL PRIVILEGES ON ALL SEQUENCES`.

```sql
-- Révocation finale sur les séquences
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA aeroport FROM user_admin;

DROP ROLE user_admin;  -- ✅ DROP ROLE
```

<img width="1071" height="658" alt="19 4" src="https://github.com/user-attachments/assets/7cbea0c2-74fd-4719-828f-dca6c64e44ee" />


> ✅ Les deux rôles sont supprimés avec succès après résolution complète de toutes les dépendances.

---

## 🧠 Erreurs rencontrées et solutions

| # | Erreur | Cause | Solution appliquée |
|---|--------|-------|--------------------|
| 1 | `séquence d'octets invalide UTF8 : 0x82` | Caractères accentués mal encodés dans le fichier SQL | Remplacer par ASCII, sauvegarder en UTF-8 sans BOM |
| 2 | `le rôle ne peut pas être supprimé — objets dépendants (tables)` | Privilèges encore actifs sur les 15 tables | Exécuter `REVOKE ALL` sur toutes les tables avant `DROP ROLE` |
| 3 | `droit refusé pour la séquence passager_id_passager_seq` | `user_admin` sans accès aux séquences SERIAL | Ajouter `GRANT USAGE, SELECT ON ALL SEQUENCES` |
| 4 | `le rôle ne peut pas être supprimé — objets dépendants (séquences)` | Droits encore actifs sur les 15 séquences SERIAL | Exécuter `REVOKE ALL PRIVILEGES ON ALL SEQUENCES` avant `DROP ROLE` |

---

## ✅ Récapitulatif final

| Script      | Statut | Contenu                                                    |
|-------------|--------|------------------------------------------------------------|
| `DDL.sql`   | ✅     | Création du schéma et des 15 tables avec clés étrangères   |
| `DML.sql`   | ✅     | INSERT, UPDATE, DELETE sur toutes les tables               |
| `DQL.sql`   | ✅     | SELECT simples, JOIN, GROUP BY, agrégations                |
| `DCL.sql`   | ✅     | CREATE ROLE, GRANT, tests de permissions, REVOKE, DROP ROLE|
