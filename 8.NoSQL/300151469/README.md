
# 🧪 TP NoSQL — PostgreSQL JSONB + Python

> **Cours** : INF1099 — Bases de données  
> **Étudiant** : Rabia Bouhali — `300151469`  
> **Établissement** : Collège Boréal  
> **Date** : Avril 2026

---

## 📋 Description

Ce travail pratique démontre l'utilisation de **PostgreSQL comme base NoSQL** grâce au type de données **JSONB**. Contrairement aux bases relationnelles classiques, les données sont stockées sous forme de **documents JSON flexibles**, sans schéma fixe par colonne.

Le projet combine :

- 🐘 **PostgreSQL 15** — stockage JSONB avec index GIN
- 🐳 **Docker** — environnement isolé et reproductible
- 🐍 **Python** + `psycopg2` — manipulation des données via script

---

## 🗂️ Structure du projet

```
300151469/
│
├── init.sql            → Création de la table, index GIN et données initiales
├── app.py              → Script Python : INSERT, SELECT, SEARCH, UPDATE, DELETE
├── requirements.txt    → Dépendances Python
├── images/             → Captures d'écran de démonstration
└── README.md           → Documentation du projet
```

---

## 🗄️ Modèle de données

Les données sont stockées dans une seule table `etudiants` avec une colonne `data` de type **JSONB** :

```sql
CREATE TABLE etudiants (
    id   SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);
```

### Exemple de document JSON stocké

```json
{
  "nom": "Alice",
  "age": 25,
  "competences": ["Python", "Docker"]
}
```

### Index GIN

Un **index GIN** (Generalized Inverted Index) est créé sur la colonne `data` pour accélérer les recherches dans les documents JSON :

```sql
CREATE INDEX idx_etudiants_data ON etudiants USING GIN (data);
```

---

## ⚙️ Opérateurs JSONB utilisés

| Opérateur | Syntaxe | Description | Exemple |
|---|---|---|---|
| `->` | `data->'competences'` | Retourne la valeur JSON brute | `["Python", "Docker"]` |
| `->>` | `data->>'nom'` | Retourne la valeur en texte | `Alice` |
| `@>` | `data @> '{"competences": ["Python"]}'` | Vérifie si le document contient une valeur | `true` |
| `jsonb_set` | `jsonb_set(data, '{age}', '26')` | Met à jour un champ sans écraser le document | — |

---

## 🐳 Lancer l'environnement Docker

> **Prérequis** : Docker Desktop installé et en cours d'exécution.

### 🪟 Windows (PowerShell)

```powershell
docker run --name postgres-nosql `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql `
  -d postgres
```

### 🐧 Linux / macOS

```bash
docker run --name postgres-nosql \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=ecole \
  -p 5432:5432 \
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -d postgres
```

> 💡 Le fichier `init.sql` est automatiquement exécuté au premier démarrage du conteneur. La table et les données sont créées sans intervention manuelle.

---

## 🐍 Installation et exécution Python

### 1. Installer les dépendances

```bash
pip install -r requirements.txt
```

### 2. Lancer le script

```bash
python app.py
```

### Sortie attendue

```
🐘 TP NoSQL — PostgreSQL JSONB
   Rabia Bouhali | 300151469 | INF1099

==================================================
  INSERT — Ajout de Diana
==================================================
✅ Étudiant inséré avec succès (id = 4)

==================================================
  SELECT ALL — Tous les étudiants
==================================================
  4 étudiant(s) trouvé(s) :

  [1] Alice   | Âge : 25 | Compétences : Python, Docker
  [2] Bob     | Âge : 22 | Compétences : Java, SQL
  [3] Charlie | Âge : 30 | Compétences : Linux, Bash, Python
  [4] Diana   | Âge : 28 | Compétences : DevOps, Kubernetes

==================================================
  SEARCH — Recherche par nom : 'Alice'
==================================================
✅ Trouvé : {"nom": "Alice", "age": 25, "competences": ["Python", "Docker"]}

==================================================
  SEARCH — Compétence : 'Python'
==================================================
  2 étudiant(s) avec la compétence 'Python' :

  [1] Alice   — Python, Docker
  [3] Charlie — Linux, Bash, Python
...
```

---

## 🔧 Fonctionnalités implémentées

### Partie obligatoire

| Fonctionnalité | Fonction Python | Opérateur SQL |
|---|---|---|
| Insérer un étudiant | `inserer_etudiant()` | `INSERT INTO ... VALUES (%s)` |
| Afficher tous les étudiants | `afficher_tous()` | `SELECT id, data FROM etudiants` |
| Rechercher par nom | `rechercher_par_nom()` | `data->>'nom' = %s` |
| Rechercher par compétence | `rechercher_par_competence()` | `data @> '{"competences": [...]}'` |

### Bonus ⭐

| Fonctionnalité | Fonction Python | Opérateur SQL |
|---|---|---|
| Modifier l'âge d'un étudiant | `mettre_a_jour_age()` | `jsonb_set(data, '{age}', ...)` |
| Supprimer un étudiant | `supprimer_etudiant()` | `DELETE WHERE data->>'nom' = %s` |

---

## 🔌 Paramètres de connexion

| Paramètre | Valeur |
|---|---|
| Hôte | `localhost` |
| Port | `5432` |
| Base de données | `ecole` |
| Utilisateur | `postgres` |
| Mot de passe | `postgres` |

---

## 🛑 Arrêter et nettoyer Docker

```bash
# Arrêter le conteneur
docker stop postgres-nosql

# Supprimer le conteneur
docker rm postgres-nosql
```

---

## 🎓 Compétences démontrées

- Déploiement d'un conteneur PostgreSQL avec Docker
- Conception d'une table NoSQL avec le type JSONB
- Optimisation des requêtes avec un index GIN
- Connexion et manipulation d'une base PostgreSQL en Python
- Utilisation des opérateurs JSONB : `->`, `->>`, `@>`, `jsonb_set`
- Gestion propre des dépendances Python avec `requirements.txt`
- Gestion des erreurs et fermeture propre des connexions

---

## 📚 Références

- [Documentation PostgreSQL 15 — Type JSONB](https://www.postgresql.org/docs/15/datatype-json.html)
- [Documentation PostgreSQL 15 — Fonctions et opérateurs JSON](https://www.postgresql.org/docs/15/functions-json.html)
- [psycopg2 — Documentation officielle](https://www.psycopg.org/docs/)
- [Docker Hub — postgres](https://hub.docker.com/_/postgres)
- Notes de cours — INF1099, Collège Boréal, 2026
