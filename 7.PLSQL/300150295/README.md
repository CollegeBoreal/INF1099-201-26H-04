# 🐘 TP PostgreSQL — Procédures Stockées, Fonctions & Triggers

> Travail pratique sur les langages procéduraux (PL/pgSQL) dans PostgreSQL.  
> Mise en pratique des procédures stockées, fonctions, triggers, gestion des exceptions et journalisation.

---

## 📚 Contexte

Ce TP porte sur **PL/pgSQL**, le langage procédural de PostgreSQL, qui permet d'ajouter de la logique métier directement dans la base de données : boucles, conditions, variables, gestion d'erreurs, triggers automatiques.

Il fait suite au cours sur les **langages procéduraux (PL)** et leurs usages dans les SGBD modernes (Oracle PL/SQL, SQL Server T-SQL, MySQL SQL/PSM).

---

## 🗂️ Structure du projet

```
📁 /
├── init/
│   ├── 01-ddl.sql              # Création des tables (etudiants, logs, cours, inscriptions)
│   ├── 02-dml.sql              # Données initiales
│   └── 03-programmation.sql   # Fonctions, procédures et triggers (travail étudiant)
│
├── tests/
│   └── test.sql               # Scénarios de test automatisés
│
└── README.md
```

---

## 🚀 Lancer l'environnement

### Prérequis

- [Docker](https://www.docker.com/) installé et démarré

### Démarrage du conteneur PostgreSQL

**Windows (PowerShell) :**
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

**Linux / macOS :**
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

> 📌 Les fichiers SQL dans `init/` sont exécutés **automatiquement** au démarrage du conteneur.

---

## 🔌 Se connecter à la base

```bash
docker container exec -it tp_postgres psql -U etudiant -d tpdb
```

---

## 🧪 Lancer les tests

**Windows (PowerShell) :**
```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

**Linux / macOS :**
```bash
docker container exec -i tp_postgres psql -U etudiant -d tpdb < tests/test.sql
```

---

## ✅ Objectifs du TP

Le fichier `03-programmation.sql` contient le squelette à compléter :

| Élément | Description |
|---|---|
| `ajouter_etudiant` | Procédure avec validation d'âge, vérification d'email et journalisation |
| `nombre_etudiants_par_age` | Fonction retournant le nombre d'étudiants dans une tranche d'âge |
| `inscrire_etudiant_cours` | Procédure d'inscription avec vérification d'existence et de doublon |
| `valider_etudiant` | Trigger `BEFORE INSERT` pour valider âge et format email |
| `log_action` | Trigger `AFTER INSERT/UPDATE/DELETE` pour journaliser toutes les actions |

---

## 💡 Concepts clés

### Fonction vs Procédure

| | Fonction | Procédure |
|---|---|---|
| Retourne une valeur | ✅ Oui | ❌ Non |
| Utilisable dans `SELECT` | ✅ Oui | ❌ Non |
| Appel | `SELECT ma_fonction()` | `CALL ma_procedure()` |
| Gestion de transactions | ❌ Non | ✅ Oui |

### Trigger

Exécuté **automatiquement** sur un événement (`INSERT`, `UPDATE`, `DELETE`).  
Utilisé ici pour : validation des données et journalisation automatique.

### Gestion des exceptions

```sql
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur : %', SQLERRM;
```

---

## 📋 Scénarios de test inclus

```sql
-- Insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- Insertion invalide (âge < 18) → erreur attendue
CALL ajouter_etudiant('Bob', 15, 'bob@email.com');

-- Compter les étudiants entre 20 et 25 ans
SELECT nombre_etudiants_par_age(20, 25);

-- Vérifier les logs générés
SELECT * FROM logs;
```

---

## ⚠️ Bonnes pratiques respectées

- Validation des données **avant** insertion (âge ≥ 18, format email)
- Gestion des exceptions avec `RAISE NOTICE` et `RAISE EXCEPTION`
- Journalisation systématique dans la table `logs`
- Triggers limités aux validations simples ; logique complexe dans les procédures
- Tests couvrant les cas valides **et** invalides

---

## 🛠️ Technologies

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-latest-2496ED?logo=docker&logoColor=white)
![PL/pgSQL](https://img.shields.io/badge/PL%2FpgSQL-procédural-informational)
