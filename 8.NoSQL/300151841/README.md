# 🧪 TP NoSQL — PostgreSQL JSONB

![Python](https://img.shields.io/badge/Python-3.13-3776AB?style=for-the-badge&logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Podman](https://img.shields.io/badge/Podman-892CA0?style=for-the-badge&logo=podman&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-11-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Status](https://img.shields.io/badge/Status-✅%20Complété-success?style=for-the-badge)

---

**Cours :** INF1099-201-26H-04  
**Étudiant :** Massi · **Matricule :** 300151841  
**Environnement :** Windows 11 · PowerShell · Podman · PostgreSQL 18 · Python 3.13

---

## 🎯 Objectif

Construire une mini base **NoSQL** en utilisant **PostgreSQL avec le type JSONB**, dans un conteneur **Podman**, et l'interroger via un script **Python**.

---

## 📁 Structure du projet

```
300151841/
├── 📂 images/
│   ├── 1_conteneur.png
│   ├── 2_donnees.png
│   ├── 3_verification.png
│   └── 4_script_python.png
├── 📄 init.sql
├── 🐍 app.py
├── 📦 requirements.txt
└── 📝 README.md
```

---

## 🛠️ Environnement technique

| Composant  | Version       |
|:----------:|:-------------:|
| 🖥️ OS      | Windows 11    |
| 🐳 Conteneur | Podman      |
| 🗄️ Base    | PostgreSQL 18 |
| 🐍 Langage | Python 3.13   |
| 📦 Librairie | pg8000 1.29.8 |

---

## 🚀 Étapes réalisées

### 1️⃣ Lancement du conteneur PostgreSQL

```powershell
podman run --name postgres-nosql `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql `
  -d postgres
```

> ⚠️ Le fichier `init.sql` n'étant pas chargé automatiquement, il a été copié et exécuté manuellement :

```powershell
podman cp init.sql postgres-nosql:/init.sql
podman exec -it postgres-nosql psql -U postgres -d ecole -f /init.sql
```
![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/8.NoSQL/300151841/images/1_conteneur_docker.png)

---

### 2️⃣ Initialisation de la base — `init.sql`

- ✅ Création de la table `tournaments` avec colonne `data JSONB`
- ✅ Ajout d'un index **GIN** pour optimiser les requêtes JSONB
- ✅ Insertion de 3 tournois en format JSON

```sql
CREATE TABLE tournaments (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_tournaments_data ON tournaments USING GIN (data);

INSERT INTO tournaments (data) VALUES
('{"tournament_name": "Winter Clash 2026", "game": "Valorant", ...}'),
('{"tournament_name": "Spring Arena 2026", "game": "League of Legends", ...}'),
('{"tournament_name": "Summer Cup 2026", "game": "Counter-Strike 2", ...}');
```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/8.NoSQL/300151841/images/2_donnees_chargees.png)

---

### 3️⃣ Vérification des données

```powershell
podman exec -it postgres-nosql psql -U postgres -d ecole `
  -c "SELECT data->>'tournament_name' FROM tournaments;"
```
![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/8.NoSQL/300151841/images/3_index_gin.png)

---

### 4️⃣ Script Python — `app.py`

> ⚠️ En raison d'un problème d'encodage UTF-8 lié au chemin Windows (`é` dans `Administrator`), `psycopg2` était inutilisable. La solution adoptée utilise `subprocess` pour appeler `psql` via Podman directement depuis Python.

| Opération | Description |
|:---:|---|
| ➕ INSERT | Ajout d'un tournoi en JSON |
| 📋 SELECT ALL | Affichage de tous les tournois |
| 🔎 SELECT filtré | Recherche par jeu (`->>`) |
| 🔎 SELECT filtré | Recherche par équipe (`@>`) |
| ✏️ UPDATE | Modification d'un champ JSON (`\|\|`) |
| 🗑️ DELETE | Suppression d'un tournoi |


![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/8.NoSQL/300151841/images/Screenshot%202026-04-11%20160235.png)


---

## 🧪 Requêtes JSONB utilisées

```sql
-- 🔍 Recherche par nom de tournoi
SELECT data FROM tournaments
WHERE data->>'tournament_name' = 'Winter Clash 2026';

-- 🎮 Recherche par jeu
SELECT data FROM tournaments
WHERE data->>'game' = 'Valorant';

-- 👥 Recherche par équipe (tableau JSON)
SELECT data FROM tournaments
WHERE data->'teams' @> '["Alpha Wolves"]'::jsonb;

-- ✏️ Mise à jour partielle d'un champ JSON
UPDATE tournaments
SET data = data || '{"location": "Vancouver"}'::jsonb
WHERE data->>'tournament_name' = 'Summer Cup 2026';

-- 🗑️ Suppression d'un tournoi
DELETE FROM tournaments
WHERE data->>'tournament_name' = 'Autumn Masters 2026';
```

---

## 🔑 Opérateurs JSONB utilisés

| Opérateur | Description |
|:---------:|-------------|
| `->`  | Accès à un champ JSON (retourne du JSON) |
| `->>`  | Accès à un champ JSON (retourne du texte) |
| `@>`  | Vérifie si un tableau JSON contient une valeur |
| `\|\|` | Fusionne deux objets JSON (utilisé pour UPDATE) |

---

## ⚠️ Problèmes rencontrés et solutions

| ❌ Problème | ✅ Solution |
|------------|------------|
| `psycopg2` crash — encodage UTF-8 (`é` dans le chemin Windows) | Utilisation de `subprocess` + `psql` |
| `init.sql` non chargé automatiquement au démarrage | Copie manuelle avec `podman cp` puis `psql -f` |
| Authentification PostgreSQL échouée (`scram-sha-256`) | Modification de `pg_hba.conf` + `password_encryption = md5` |
| Docker Desktop absent sur la machine | Remplacement par **Podman** |

---

## 🎓 Compétences acquises

- 🗄️ Utilisation de **JSONB** dans PostgreSQL comme stockage NoSQL
- 🐳 Gestion de conteneurs avec **Podman**
- 🔍 Opérateurs JSONB : `->`, `->>`, `@>`, `||`
- 🐍 Interaction **Python** avec PostgreSQL via `subprocess`
- 🔧 Débogage avancé d'environnement Windows

---

## ✅ Résultat final

| Élément | Statut |
|---------|:------:|
| Conteneur PostgreSQL lancé | ✅ |
| Table `tournaments` créée | ✅ |
| Index GIN présent | ✅ |
| Données JSON insérées | ✅ |
| Script Python fonctionnel | ✅ |
| INSERT / SELECT / UPDATE / DELETE | ✅ |

---

## 🏁 Conclusion

Ce TP m'a permis de comprendre comment exploiter **PostgreSQL comme une base NoSQL** grâce au type JSONB, tout en gérant un environnement conteneurisé avec Podman et en automatisant les opérations via Python. Les difficultés rencontrées (encodage, authentification, Docker absent) ont permis de développer des compétences supplémentaires en **débogage** et en **adaptation de l'environnement**.
