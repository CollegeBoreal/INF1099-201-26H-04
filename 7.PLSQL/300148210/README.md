# TP PostgreSQL — Procédures Stockées, Fonctions & Triggers

## Structure du projet

```
tp_postgres/
├── init/
│   ├── 01-ddl.sql           → Création des tables
│   ├── 02-dml.sql           → Données initiales
│   └── 03-programmation.sql → Fonctions, procédures, triggers
├── tests/
│   └── test.sql             → Jeu de tests complet
└── README.md
```

---

## Lancer PostgreSQL avec Docker

### 🐧 Linux / macOS
```bash
docker container run -d \
  --name tp_postgres \
  -e POSTGRES_USER=etudiant \
  -e POSTGRES_PASSWORD=etudiant \
  -e POSTGRES_DB=tpdb \
  -p 5432:5432 \
  -v $(pwd)/init:/docker-entrypoint-initdb.d \
  postgres:15
```

### 🪟 PowerShell (Windows)
```powershell
docker container run -d `
  --name tp_postgres `
  -e POSTGRES_USER=etudiant `
  -e POSTGRES_PASSWORD=etudiant `
  -e POSTGRES_DB=tpdb `
  -p 5432:5432 `
  -v "$PWD/init:/docker-entrypoint-initdb.d" `
  postgres:15
```

> Les fichiers SQL dans `init/` sont exécutés automatiquement au démarrage dans l'ordre alphabétique.

---

## Se connecter au conteneur

```bash
docker container exec -it tp_postgres psql -U etudiant -d tpdb
```

---

## Lancer les tests

```bash
docker container exec -i tp_postgres psql -U etudiant -d tpdb < tests/test.sql
```

---

## Ce que fait chaque fichier

### `01-ddl.sql` — Schéma
| Table | Rôle |
|---|---|
| `etudiants` | Données des étudiants |
| `cours` | Catalogue des cours |
| `inscriptions` | Liaison étudiant ↔ cours |
| `logs` | Journal de toutes les actions |

### `03-programmation.sql` — Logique métier

| Objet | Type | Description |
|---|---|---|
| `ajouter_etudiant` | Procédure | Ajout avec validation âge/email + log |
| `nombre_etudiants` | Fonction | Compte total d'étudiants |
| `nombre_etudiants_par_age` | Fonction | Compte dans une tranche d'âge |
| `inscrire_etudiant_cours` | Procédure | Inscription avec contrôle de doublon |
| `valider_etudiant` | Trigger BEFORE INSERT | Bloque âge < 18 ou email invalide |
| `log_action` | Trigger AFTER INSERT/UPDATE/DELETE | Journalise chaque modification avec OLD/NEW |

---

## Points clés implémentés

- **Validation d'âge** : minimum 18 ans (procédure + trigger)
- **Validation email** : regex `^[^@\s]+@[^@\s]+\.[^@\s]+$`
- **Gestion des erreurs** : `RAISE EXCEPTION` + bloc `EXCEPTION WHEN others`
- **Logs détaillés** : OLD/NEW dans les triggers, messages clairs avec `RAISE NOTICE`
- **Protection en double** : le trigger valide même les insertions directes sans procédure
