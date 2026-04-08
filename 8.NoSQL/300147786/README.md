# 🗄️ Mini base NoSQL avec PostgreSQL JSONB

Mise en pratique de PostgreSQL comme base NoSQL via le type **JSONB**, conteneurisé avec Docker et piloté par Python.

---

## 📁 Structure du projet

```
🆔/
├── README.md
├── images/
│   ├── 01_docker_run.png
│   ├── 02_docker_ps.png
│   ├── 03_docker_logs.png
│   ├── 04_pip_install.png
│   ├── 05_select_all.png
│   ├── 06_search_nom.png
│   └── 07_python_output.png
├── init.sql
├── app.py
└── requirements.txt
```

---

## ⚙️ Stack technique

| Outil | Rôle |
|---|---|
| PostgreSQL (JSONB) | Stockage documents JSON |
| Docker | Conteneurisation de la base |
| Python + psycopg2 | Interaction avec la base |

---

## 🚀 Lancement

### 1. Démarrer PostgreSQL avec Docker

**Windows (PowerShell)**
```powershell
docker run --name postgres-nosql `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql `
  -d postgres
```
---

### 2. Vérifier que le conteneur tourne

```bash
docker ps
docker logs postgres-nosql
```

### 3. Installer les dépendances Python

```bash
pip install -r requirements.txt
```

### 4. Lancer le script

```bash
python app.py
```
---


### 🟢 Partie 1 — Docker
- Lancer le conteneur PostgreSQL
- Vérifier que la base `ecole` est accessible
- Confirmer le chargement automatique de `init.sql`

### 🟡 Partie 2 — SQL NoSQL
- Table `etudiants` créée avec index GIN
- Requêtes : afficher tous les étudiants, rechercher par nom, filtrer par compétence

### 🔵 Partie 3 — Python
- Connexion à PostgreSQL via `psycopg2`
- INSERT d'un document JSON
- SELECT ALL et recherche filtrée


