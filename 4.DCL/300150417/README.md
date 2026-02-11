##ABDELATIF NEMOUS +_+

# 🐘 TP PostgreSQL – Gestion des utilisateurs et permissions (DCL)

## 🎯 Objectifs du TP
Ce TP a pour but de comprendre la gestion des utilisateurs et des permissions dans PostgreSQL.

À la fin du TP, l’étudiant est capable de :

- Créer une base de données et un schéma
- Créer des utilisateurs PostgreSQL
- Attribuer des droits avec `GRANT`
- Retirer des droits avec `REVOKE`
- Tester les permissions selon les rôles (étudiant / professeur)
- Comprendre la gestion des rôles et des permissions sur les séquences (`SERIAL`)
- Supprimer des utilisateurs (`DROP USER`)

---

## 🛠️ Prérequis
- PostgreSQL installé (dans Podman)
- Accès à `psql`
- Conteneur PostgreSQL en cours d’exécution

Connexion au conteneur :

```powershell
docker exec -it postgres psql -U postgres

```

## 1️⃣ Création de la base de test et préparation

### 1.1 Création de la base cours

On commence par créer une base de données appelée cours :

```powershell

CREATE DATABASE cours;

```
Puis on se connecte à la base :
```powershell

\c cours

```
![image](./images/1.PNG)

### 1.2 Création du schéma tp_dcl et de la table etudiants

On crée ensuite un schéma dédié à l’exercice :

```powershell
CREATE SCHEMA tp_dcl;

```
Puis une table pour stocker des étudiants :
```powershell
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);

```
![image](./images/1.2.PNG)


### 1.3 Insertion de données de test

On insère quelques données afin de pouvoir tester les permissions :
```powershell

INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Karim', 75);
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Sarah', 88);

```
Puis on vérifie le contenu :

```powershell
SELECT * FROM tp_dcl.etudiants;

```

![image](./images/1.3.PNG)

## 2️⃣ Création des utilisateurs

Deux utilisateurs sont créés :

etudiant : accès lecture uniquement

professeur : accès lecture + écriture

Commandes utilisées :

```powershell
CREATE USER etudiant WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';
```

![image](./images/2.PNG)

## 3️⃣ Attribution des permissions (GRANT)

### 3.1 Donner l’accès à la base

Pour permettre la connexion à la base cours :

```powershell
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
```

### 3.2 Donner l’accès au schéma

Pour permettre l’accès au schéma tp_dcl :
```powershell
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
```
### 3.3 Donner les droits sur la table
Étudiant : lecture seulement
```powershell
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
```

Professeur : lecture + écriture
```powershell
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;
```

![image](./images/3.PNG)


## 4️⃣ Test des permissions avec l’utilisateur étudiant

### 4.1 Connexion en tant qu’étudiant

L’étudiant se connecte à la base :

```powershell
psql -U etudiant -d cours
```

⚠️ Remarque : dans PostgreSQL, la commande psql -U ... ne doit pas être exécutée dans psql.
Elle doit être exécutée dans PowerShell.

### 4.2 Test SELECT (autorisé)
```powershell
SELECT * FROM tp_dcl.etudiants;
```

### 4.3 Test INSERT (normalement refusé)
```powershell
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Alice', 85);
```

## 5️⃣ Test des permissions avec l’utilisateur professeur

### 5.1 Connexion en tant que professeur
```powershell
psql -U professeur -d cours
```
### 5.2 Test INSERT (autorisé)
```powershell
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Bob', 90);
```
### 5.3 Test UPDATE (autorisé)

```powershell
UPDATE tp_dcl.etudiants SET moyenne=95 WHERE nom='Bob';
```



![image](./images/4.PNG)


## 6️⃣ Retirer un droit avec REVOKE

On retire le droit SELECT à l’étudiant :
```powershell
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
```

Ensuite on teste à nouveau en se connectant en étudiant :
```powershell
SELECT * FROM tp_dcl.etudiants;

```
Résultat attendu : erreur "permission denied".

![image](./images/5.PNG)

## 7️⃣ Tentative de suppression des utilisateurs (DROP USER)

La commande suivante est utilisée :
```powershell
DROP USER etudiant;
DROP USER professeur;

```
Cependant, si l’utilisateur courant n’est pas superuser, PostgreSQL refuse cette action.

![image](./images/6.PNG)


## 8️⃣ Bonus : Création d’un rôle enseignant
### 8.1 Création du rôle

Un rôle enseignant est créé pour regrouper les permissions :
```powershell
CREATE ROLE enseignant;
```

On donne au rôle les droits sur la table :
```powershell
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO enseignant;
```

### 8.2 Création de l’utilisateur prof2
```powershell
CREATE USER prof2 WITH PASSWORD 'prof2';

```
On associe l’utilisateur au rôle :

```powershell
GRANT enseignant TO prof2;
```

## 9️⃣ Problèmes rencontrés et correction (schéma + séquence)
### 9.1 Problème d’accès au schéma

Lors du test d’insertion avec prof2, PostgreSQL a retourné :


permission denied for schema tp_dcl

Solution :

```powershell
GRANT USAGE ON SCHEMA tp_dcl TO enseignant;
```
### 9.2 Problème d’accès à la séquence SERIAL

Ensuite, PostgreSQL a retourné :


permission denied for sequence etudiants_id_seq

Car la colonne id SERIAL utilise une séquence automatique.

Solution :

```powershell
GRANT USAGE, SELECT ON SEQUENCE tp_dcl.etudiants_id_seq TO enseignant;

```
Après cela, l’insertion a fonctionné correctement.


![image](./images/7.PNG)

## ✅ Conclusion

Ce TP démontre l’importance des permissions dans PostgreSQL :

Les droits doivent être accordés sur plusieurs niveaux :

Base de données (CONNECT)

Schéma (USAGE)

Table (SELECT, INSERT, UPDATE, DELETE)

Séquence (USAGE, SELECT) pour les colonnes SERIAL

Les commandes DCL principales utilisées :

CREATE USER

CREATE ROLE

GRANT

REVOKE

DROP USER

Le TP a permis de bien comprendre la gestion sécurisée des accès dans PostgreSQL.
