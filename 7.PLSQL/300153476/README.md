# TP PostgreSQL — Procédures Stockées, Fonctions et Triggers

## 📁 Structure du projet

```
300153476/
├── init/
│   ├── 01-ddl.sql            → Création des tables (fourni par le prof)
│   ├── 02-dml.sql            → Données initiales (fourni par le prof)
│   └── 03-programmation.sql  → Fonctions, procédures et triggers (complété)
├── tests/
│   └── test.sql              → Jeu de tests
└── README.md
```

---

## 🐳 Lancer PostgreSQL avec Docker / Podman

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

### 🐧 Linux / WSL

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

---

## 🔌 Se connecter à la base

```bash
docker exec -it tp_postgres psql -U etudiant -d tpdb
```

---

## ✅ Lancer les tests

### 🪟 Windows (PowerShell)

```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

### 🐧 Linux / WSL

```bash
docker exec -i tp_postgres psql -U etudiant -d tpdb < tests/test.sql
```

---

## 📋 Contenu de `03-programmation.sql`

| Élément | Type | Description |
|---|---|---|
| `ajouter_etudiant` | PROCEDURE | Ajoute un étudiant avec validation âge/email et journalisation |
| `nombre_etudiants_par_age` | FUNCTION | Retourne le nombre d'étudiants dans une tranche d'âge |
| `valider_etudiant` | TRIGGER BEFORE INSERT | Bloque toute insertion invalide dans `etudiants` |
| `log_action` | TRIGGER AFTER INSERT/UPDATE/DELETE | Journalise toutes les modifications dans `logs` |
