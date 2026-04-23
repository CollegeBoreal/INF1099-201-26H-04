# 🎓 Laboratoire : Automatisation de Base de Données Moodle (Infrastructure as Code)

> **Projet académique - ID 300142242** > Ce projet démontre l'automatisation complète du déploiement d'une base de données relationnelle à l'aide d'un script de traitement par lots (Batch) en PowerShell, interfaçant avec un environnement conteneurisé Podman/Docker.

---

## 📑 Table des matières
1. [Description Générale](#-description-générale)
2. [Architecture et Hiérarchie SQL](#-architecture-et-hiérarchie-sql)
3. [Prérequis Système](#-prérequis-système)
4. [Déploiement et Exécution](#-déploiement-et-exécution)
5. [Fonctionnalités Avancées (Défis Bonus)](#-fonctionnalités-avancées-défis-bonus)
6. [Analyse du Script PowerShell](#-analyse-du-script-powershell)
7. [Dépannage (Troubleshooting)](#-dépannage)

---

## 🚀 Description Générale

Ce projet automatise la création, le peuplement et la configuration des droits de sécurité d'une base de données PostgreSQL (nommée `moodle_db`). 

L'intégralité du processus est pilotée par un script PowerShell (`load-db.ps1`) qui orchestre l'injection de fichiers SQL de manière séquentielle dans un conteneur actif. Cette approche garantit un déploiement rapide, sans erreur humaine, et reproductible à l'infini (idempotence).

---

## 📂 Architecture et Hiérarchie SQL

L'ordre d'exécution des scripts est strictement imposé par le laboratoire pour respecter les contraintes d'intégrité référentielle (clés étrangères) de la base de données. 

| Étape | Fichier | Type de commande | Rôle technique détaillé dans ce projet |
| :---: | :--- | :--- | :--- |
| **1** | 🏗️ `DDL.sql` | **Data Definition Language** | S'assure que l'environnement est vierge (`DROP TABLE IF EXISTS CASCADE`) puis crée l'architecture relationnelle : les tables `ETUDIANT`, `COURS`, et la table de liaison `INSCRIPTION`. |
| **2** | ✍️ `DML.sql` | **Data Manipulation Language** | Peuple les tables avec un jeu de données de test (insertion d'étudiants comme Tremblay et Gagnon, de cours, et création d'inscriptions). |
| **3** | 🔐 `DCL.sql` | **Data Control Language** | Implémente la sécurité en créant le rôle `prof_moodle` et en lui accordant les privilèges de connexion (`CONNECT`) et de manipulation (`SELECT, INSERT, UPDATE`) sur le schéma public. |
| **4** | 🔍 `DQL.sql` | **Data Query Language** | Exécute une requête finale de validation (jointure multiple) pour afficher les noms des étudiants associés aux titres de leurs cours respectifs. |

---

## 🛠️ Prérequis Système

Pour garantir le bon fonctionnement de l'automatisation, l'environnement hôte doit disposer de :
* 🐳 **Podman** (ou Docker) installé, configuré et en cours d'exécution.
* 📟 **PowerShell** (pwsh) pour exécuter le script `.ps1`.
* 🗂️ L'arborescence complète dans un même dossier de travail : `load-db.ps1`, `DDL.sql`, `DML.sql`, `DCL.sql`, et `DQL.sql`.

---

## ⚙️ Déploiement et Exécution

### Étape 1 : Instanciation du conteneur PostgreSQL
Avant d'exécuter le script d'automatisation, le moteur de base de données doit être démarré en arrière-plan. Exécutez cette commande dans votre terminal :

```powershell
podman run -d --name postgres-moodle -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=moodle_db -p 5432:5432 postgres
