# 🧪 Laboratoire BATCH – Automatisation PostgreSQL avec PowerShell et Podman

## 👤 Auteur

Emeraude Santu

---

## 📌 Description

Ce laboratoire consiste à automatiser le chargement d’une base de données PostgreSQL à l’aide d’un script PowerShell.

L’environnement utilise **Podman** (alternative à Docker) pour exécuter PostgreSQL dans un conteneur, et un script batch permet d’exécuter automatiquement plusieurs fichiers SQL.

---

## 🎯 Objectifs

À la fin de ce laboratoire, l’étudiant est capable de :

* Comprendre les différents types de scripts SQL
* Utiliser Podman pour exécuter PostgreSQL
* Écrire un script PowerShell d’automatisation
* Exécuter plusieurs scripts SQL dans un ordre précis
* Automatiser le déploiement d’une base de données

---

## 🧠 Types de scripts SQL

| Type | Description              | Exemple      |
| ---- | ------------------------ | ------------ |
| DDL  | Création de la structure | CREATE TABLE |
| DML  | Manipulation des données | INSERT       |
| DQL  | Lecture des données      | SELECT       |
| DCL  | Gestion des droits       | GRANT        |

---

## 📁 Structure du projet

```
📦 lab-batch/
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
└── load-db.ps1
```

---

## 🔄 Ordre d’exécution

L’ordre d’exécution est essentiel :

1. DDL → création des tables
2. DML → insertion des données
3. DCL → gestion des droits
4. DQL → vérification

---

## 🐳 Environnement : Podman

Ce laboratoire utilise **Podman** au lieu de Docker.

👉 Un alias est intégré dans le script PowerShell pour permettre l’utilisation des commandes Docker avec Podman.

### Initialisation de Podman

```bash
podman machine init
podman machine start
```

---

## 🚀 Lancement du conteneur PostgreSQL

```bash
docker container run -d \
--name postgres-lab \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=ecole \
-p 5432:5432 \
postgres
```

---

## ⚙️ Script PowerShell

Fichier : `load-db.ps1`

### Fonctionnalités :

* Création automatique d’un alias Docker → Podman
* Vérification que le conteneur est actif
* Vérification de l’existence des fichiers SQL
* Exécution automatique des scripts SQL
* Génération d’un fichier log (`execution.log`)
* Mesure du temps d’exécution

---

## ▶️ Exécution du script

```bash
pwsh ./load-db.ps1
```

Ou avec paramètre :

```bash
pwsh ./load-db.ps1 postgres-lab
```

---

## 🔎 Vérification

Connexion au conteneur :

```bash
docker exec -it postgres-lab psql -U postgres -d ecole
```

Exemple de requête :

```sql
SELECT * FROM CLIENT;
```

---

## 📄 Fichier de log

Un fichier `execution.log` est généré automatiquement et contient :

* Les étapes exécutées
* Les résultats SQL
* Les erreurs éventuelles
* Le temps total d’exécution

---

## 🧠 Explication technique

Le script PowerShell utilise :

* `Get-Content` → lire les fichiers SQL
* `docker exec` → exécuter dans le conteneur
* `psql` → client PostgreSQL
* `Tee-Object` → afficher et enregistrer les logs

---

## ⚠️ Problèmes courants

### ❌ Podman non démarré

Solution :

```bash
podman machine start
```

---

### ❌ Conteneur non actif

```bash
docker ps
```

---

### ❌ Fichier SQL manquant

Vérifier la présence des fichiers dans le dossier.

---

## 🎯 Résultats attendus

Après exécution :

* Tables créées
* Données insérées
* Requêtes exécutées
* Fichier log généré

---

## ✅ Avantages de l’automatisation

* Gain de temps
* Réduction des erreurs humaines
* Reproductibilité
* Déploiement rapide

---

## 🧠 Conclusion

Ce laboratoire démontre l’importance de l’automatisation dans la gestion des bases de données.

L’utilisation combinée de **PowerShell** et **Podman** permet de :

* simplifier le déploiement
* améliorer la productivité
* garantir la cohérence des opérations

---
