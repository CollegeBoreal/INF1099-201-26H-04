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

**Linux / macOS**
```bash
docker run --name postgres-nosql \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=ecole \
  -p 5432:5432 \
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -d postgres
```

> 📸 *Capture attendue — conteneur lancé avec succès :*
> ![Docker run](images/01_docker_run.png)

---

### 2. Vérifier que le conteneur tourne

```bash
docker ps
docker logs postgres-nosql
```

> 📸 *Capture attendue — `docker ps` montre le conteneur actif :*
> ![Docker ps](images/02_docker_ps.png)

> 📸 *Capture attendue — logs confirmant le chargement de `init.sql` :*
> ![Docker logs](images/03_docker_logs.png)

---

### 3. Installer les dépendances Python

```bash
pip install -r requirements.txt
```

> 📸 *Capture attendue — installation de `psycopg2-binary` :*
> ![Pip install](images/04_pip_install.png)

---

### 4. Lancer le script

```bash
python app.py
```

> 📸 *Capture attendue — résultat du SELECT ALL :*
> ![Select all](images/05_select_all.png)

> 📸 *Capture attendue — résultat de la recherche filtrée :*
> ![Search nom](images/06_search_nom.png)

> 📸 *Capture attendue — sortie complète du script Python :*
> ![Python output](images/07_python_output.png)

---

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


