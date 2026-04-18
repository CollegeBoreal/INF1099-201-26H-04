# ⚙️ TP PL/SQL : Procédures, Fonctions et Triggers

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker/Podman](https://img.shields.io/badge/Podman-Conteneur-892CA0?style=for-the-badge&logo=podman&logoColor=white)

> **Projet : Implémentation de logique métier côté serveur avec PL/pgSQL.**

---

## 🎯 Objectifs Réalisés
- ✅ **Procédures Stockées** : Création de procédures pour l'ajout d'étudiants et l'inscription aux cours avec gestion des exceptions (`RAISE NOTICE` / `RAISE EXCEPTION`).
- ✅ **Fonctions** : Implémentation d'une fonction retournant le nombre d'étudiants par tranche d'âge.
- ✅ **Triggers (Déclencheurs)** : 
  - `BEFORE INSERT` : Validation automatique de l'âge et du format de l'email avant l'insertion en base.
  - `AFTER INSERT/UPDATE/DELETE` : Système de journalisation (logging) automatique traçant les opérations (`TG_OP`) sur les tables.

---

## 🗂️ Structure du Répertoire

```text
📂 init/
 ┣ 📄 01-ddl.sql             ← Structure des tables (étudiants, cours, inscriptions, logs)
 ┣ 📄 02-dml.sql             ← Données initiales
 ┗ 📄 03-programmation.sql   ← Script principal (PL/pgSQL)
📂 tests/
 ┗ 📄 test.sql               ← Script de validation automatisé
📂 images/
 ┗ 🖼️ test_results_plsql.png ← Preuve d'exécution réussie
📄 README.md
