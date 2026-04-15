# 🐘 TP PostgreSQL — Procédures Stockées, Fonctions et Triggers

> **Cours** : INF1099 — Bases de données  
> **Étudiant** : Rabia Bouhali — `300151469`  
> **Établissement** : Collège Boréal  
> **Date** : Avril 2026

---

## 📋 Description

Ce travail pratique porte sur la programmation procédurale en PostgreSQL à l'aide du langage **PL/pgSQL**. Il couvre la création de :

- **Procédures stockées** — pour encapsuler la logique métier côté base de données
- **Fonctions** — pour effectuer des calculs et retourner des résultats
- **Triggers** — pour automatiser des actions sur les événements `INSERT`, `UPDATE` et `DELETE`
- **Gestion des exceptions** — pour assurer la robustesse et la traçabilité des erreurs

L'environnement d'exécution est basé sur **Docker** avec l'image officielle `postgres:15`.

---

## 🗂️ Structure du projet

```
300151469/
│
├── init/
│   ├── 01-ddl.sql              → Définition des tables (DDL)
│   ├── 02-dml.sql              → Insertion des données initiales (DML)
│   └── 03-programmation.sql   → Procédures, fonctions et triggers (PL/pgSQL)
│
├── tests/
│   └── test.sql                → Jeu de tests complets (cas valides et invalides)
│
└── README.md                   → Documentation du projet
```

---

## 🗄️ Modèle de données

Le projet repose sur quatre tables interconnectées :

| Table | Description |
|---|---|
| `etudiants` | Informations des étudiants (nom, âge, email) |
| `cours` | Catalogue des cours disponibles |
| `inscriptions` | Relation entre étudiants et cours |
| `logs` | Journal automatique de toutes les actions |

**Diagramme de relations :**
```
etudiants ──< inscriptions >── cours
     │
     └──────────────────────── logs (via triggers)
```

---

## ⚙️ Composants PL/pgSQL implémentés

### Procédures stockées

| Procédure | Paramètres | Description |
|---|---|---|
| `ajouter_etudiant` | `nom TEXT, age INT, email TEXT` | Ajoute un étudiant avec validation de l'âge (≥ 18), validation du format email, journalisation et gestion d'erreurs |
| `inscrire_etudiant_cours` | `etudiant_email TEXT, cours_nom TEXT` | Inscrit un étudiant à un cours après vérification de l'existence des deux entités et de l'absence de doublon |

### Fonctions

| Fonction | Paramètres | Retour | Description |
|---|---|---|---|
| `nombre_etudiants_par_age` | `min_age INT, max_age INT` | `INT` | Retourne le nombre d'étudiants dans une tranche d'âge donnée |

### Triggers

| Trigger | Table | Événement | Fonction associée | Rôle |
|---|---|---|---|---|
| `trg_valider_etudiant` | `etudiants` | `BEFORE INSERT` | `valider_etudiant()` | Valide l'âge et le format de l'email avant toute insertion |
| `trg_log_etudiant` | `etudiants` | `AFTER INSERT / UPDATE / DELETE` | `log_action()` | Journalise toutes les modifications sur la table |
| `trg_log_inscription` | `inscriptions` | `AFTER INSERT / UPDATE / DELETE` | `log_action()` | Journalise toutes les modifications sur les inscriptions |

---

## 🐳 Lancer l'environnement Docker

> **Prérequis** : Docker Desktop installé et en cours d'exécution.

### 🪟 Windows (PowerShell)

```powershell
docker run -d `
  --name tp_postgres `
  -e POSTGRES_USER=etudiant `
  -e POSTGRES_PASSWORD=etudiant `
  -e POSTGRES_DB=tpdb `
  -p 5432:5432 `
  -v ${PWD}/init:/docker-entrypoint-initdb.d `
  postgres:15
```

### 🐧 Linux / macOS

```bash
docker run -d \
  --name tp_postgres \
  -e POSTGRES_USER=etudiant \
  -e POSTGRES_PASSWORD=etudiant \
  -e POSTGRES_DB=tpdb \
  -p 5432:5432 \
  -v ${PWD}/init:/docker-entrypoint-initdb.d \
  postgres:15
```

> 💡 Les fichiers dans `init/` sont exécutés **automatiquement au démarrage** dans l'ordre alphabétique (`01`, `02`, `03`). Il n'est pas nécessaire de les importer manuellement.

---

## 🔌 Se connecter à la base de données

```bash
docker container exec -it tp_postgres psql -U etudiant -d tpdb
```

| Paramètre | Valeur |
|---|---|
| Hôte | `localhost` |
| Port | `5432` |
| Base de données | `tpdb` |
| Utilisateur | `etudiant` |
| Mot de passe | `etudiant` |

---

## 🧪 Exécuter les tests

Le fichier `tests/test.sql` contient **12 tests** couvrant tous les cas :

| # | Test | Résultat attendu |
|---|---|---|
| 1 | Insertion valide d'un étudiant | Succès + NOTICE |
| 2 | Insertion avec âge < 18 | Erreur capturée |
| 3 | Insertion avec email invalide | Erreur capturée |
| 4 | Insertion avec email en double | Erreur `unique_violation` |
| 5 | Fonction `nombre_etudiants_par_age` | Retourne un entier |
| 6 | Fonction avec plage invalide (min > max) | Exception levée |
| 7 | Inscription valide | Succès + NOTICE |
| 8 | Inscription en double | Erreur capturée |
| 9 | Inscription — étudiant inexistant | Erreur capturée |
| 10 | Inscription — cours inexistant | Erreur capturée |
| 11 | Vérification des logs | Affiche toutes les entrées |
| 12 | Liste des inscriptions | JOIN sur 3 tables |

### 🪟 Windows (PowerShell)

```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

### 🐧 Linux / macOS

```bash
docker container exec -i tp_postgres psql -U etudiant -d tpdb < tests/test.sql
```

---

## 🛑 Arrêter et nettoyer l'environnement

```bash
# Arrêter le conteneur
docker stop tp_postgres

# Supprimer le conteneur
docker rm tp_postgres

# Relancer proprement (repart de zéro)
docker run -d --name tp_postgres ...
```

---

## ✅ Bonnes pratiques appliquées

- **Validation des données** à deux niveaux : dans les procédures ET via les triggers
- **Gestion des exceptions** avec distinction entre `unique_violation` et `others`
- **Journalisation complète** via triggers sur INSERT, UPDATE et DELETE
- **Messages RAISE NOTICE** détaillés pour faciliter le débogage
- **Variables préfixées** (`v_etudiant_id`) pour éviter les conflits avec les colonnes
- **Documentation** de chaque procédure, fonction et trigger

---

## 📚 Références

- [Documentation officielle PostgreSQL 15 — PL/pgSQL](https://www.postgresql.org/docs/15/plpgsql.html)
- [Docker Hub — postgres:15](https://hub.docker.com/_/postgres)
- Notes de cours — INF1099, Collège Boréal, 2026
