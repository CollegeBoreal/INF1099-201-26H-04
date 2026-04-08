# 📦 Projet Batch – Automatisation PostgreSQL avec Docker

## 📂 Structure du projet

```bash
📁 batch/
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
└── load-db.ps1
```

---

## 📖 Description du projet

Dans ce projet, nous avons mis en place une base de données PostgreSQL en utilisant Docker.
L’objectif était d’automatiser entièrement la création, le remplissage et l’exploitation de la base de données à l’aide de scripts SQL et d’un script PowerShell.

---

## ⚙️ Étapes réalisées

### 1. Création du conteneur PostgreSQL

Nous avons lancé un conteneur Docker avec PostgreSQL en utilisant la commande suivante :

```bash
docker container run -d `
--name postgres-lab `
-e POSTGRES_PASSWORD=postgres `
-e POSTGRES_DB=ecole `
-p 5432:5432 `
postgres
```

Ce conteneur héberge la base de données **ecole** accessible localement.

---

### 2. Création des scripts SQL

Nous avons séparé le travail en plusieurs fichiers SQL pour mieux organiser le projet :

#### 🔹 DDL.sql

Ce fichier contient toutes les commandes de création de la base de données :

* création des tables
* définition des clés primaires
* mise en place des clés étrangères

#### 🔹 DML.sql

Ce fichier permet d’insérer des données dans les tables :

* ajout d’utilisateurs
* ajout de véhicules
* ajout de transactions, etc.

#### 🔹 DCL.sql

Ce fichier sert à gérer les permissions :

* attribution des droits (GRANT)
* restriction des actions (REVOKE)

#### 🔹 DQL.sql

Ce fichier contient les requêtes de consultation :

* affichage des données
* jointures entre tables
* vérification du bon fonctionnement de la base

---

### 3. Automatisation avec PowerShell

Nous avons créé un script `load-db.ps1` pour automatiser l’exécution de tous les fichiers SQL.

Ce script :

* vérifie si les fichiers existent
* exécute chaque fichier dans PostgreSQL via Docker
* affiche un message pour chaque étape

Extrait du fonctionnement :

* boucle sur chaque fichier SQL
* exécution avec `docker exec` et `psql`
* gestion des erreurs si un fichier est manquant

---

### 4. Exécution du projet

Pour lancer toute la configuration, il suffit d’exécuter :

```powershell
.\load-db.ps1
```

Le script charge automatiquement :

1. la structure de la base (DDL)
2. les données (DML)
3. les permissions (DCL)
4. les requêtes de test (DQL)

---

## 🎯 Résultat obtenu

À la fin :

* la base de données est entièrement créée
* les données sont insérées automatiquement
* les permissions sont appliquées
* les requêtes permettent de tester le système

Tout le processus est automatisé, ce qui évite les erreurs et fait gagner du temps.
<img src="images/Screenshot 2026-03-18 142004.png" width="600">
<img src="images/Screenshot 2026-03-18 141942.png" width="600">

---

## 💡 Conclusion

Ce projet montre comment utiliser Docker et PowerShell pour automatiser la gestion d’une base de données PostgreSQL.
Il permet de structurer le travail, de le rendre reproductible et plus professionnel.
