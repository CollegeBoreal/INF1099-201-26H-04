# 🐘 TP PostgreSQL — Procédures Stockées, Fonctions & Triggers

## 📁 Structure du projet

```
tp_postgres/
│
├── init/
│   ├── 01-ddl.sql              ← Création des tables
│   ├── 02-dml.sql              ← Données initiales
│   └── 03-programmation.sql   ← ✏️ À compléter par l'étudiant
│
├── tests/
│   └── test.sql                ← Tests automatisés
│
└── README.md                   ← Ce fichier
```

---

## 🚀 Lancer le projet

### Prérequis

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installé et démarré

### 1. Créer les dossiers (PowerShell)

```powershell
mkdir tp_postgres\init
mkdir tp_postgres\tests
cd tp_postgres
```

### 2. Placer les fichiers SQL dans `init/`

Copier les fichiers suivants dans le dossier `init/` :

- `01-ddl.sql`
- `02-dml.sql`
- `03-programmation.sql`

### 3. Lancer PostgreSQL

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

> 💡 Les fichiers dans `init/` sont exécutés **automatiquement** au démarrage, dans l'ordre alphabétique.

### 4. Vérifier que le conteneur tourne

```powershell
docker ps
```
<img width="909" height="177" alt="image" src="https://github.com/user-attachments/assets/071ae9a1-3803-4677-86a6-80c6b8a2c0ea" />

---

## 🔌 Se connecter à PostgreSQL

```powershell
docker exec -it tp_postgres psql -U etudiant -d tpdb
```

Une fois connecté, tu peux exécuter des requêtes SQL directement dans le terminal.

---
<img width="918" height="476" alt="image" src="https://github.com/user-attachments/assets/c133ab41-3fe5-4c93-b641-62bd823d4aa6" />


## 🧪 Lancer les tests

```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

Les résultats des procédures, fonctions et triggers s'affichent directement dans le terminal.

---
<img width="915" height="424" alt="image" src="https://github.com/user-attachments/assets/727341b6-1dbe-4bfe-b4fe-1ae533e9e4ca" />

## ✏️ Travail demandé

Compléter le fichier `init/03-programmation.sql` avec les éléments suivants :

| Élément | Description |
|---|---|
| `ajouter_etudiant` | Procédure : insertion avec validation âge/email + logs |
| `nombre_etudiants_par_age` | Fonction : retourne le nombre d'étudiants dans une tranche d'âge |
| `inscrire_etudiant_cours` | Procédure : inscription d'un étudiant à un cours |
| `valider_etudiant` | Trigger BEFORE INSERT : validation âge et email |
| `log_action` | Trigger AFTER INSERT/UPDATE/DELETE : journalisation automatique |

<img width="794" height="113" alt="image" src="https://github.com/user-attachments/assets/a447cc71-5f33-4fbb-9e31-6c951195a60e" />

---

## 🔁 Relancer après modification

Si tu modifies un fichier SQL, il faut **recréer le conteneur** pour que les changements soient pris en compte :

```powershell
docker rm -f tp_postgres
```

Puis relancer la commande `docker run` (étape 3).
<img width="913" height="421" alt="image" src="https://github.com/user-attachments/assets/a52901af-75f3-4afe-bf51-61c6be35bde1" />
<img width="899" height="437" alt="image" src="https://github.com/user-attachments/assets/24f52f34-bff7-40a3-95be-38c404b6ed5d" />

---

## 🛠️ Commandes utiles

| Commande | Description |
|---|---|
| `docker ps` | Voir les conteneurs actifs |
| `docker logs tp_postgres` | Voir les logs du conteneur |
| `docker rm -f tp_postgres` | Supprimer le conteneur |
| `\dt` (dans psql) | Lister les tables |
| `\df` (dans psql) | Lister les fonctions |
| `\q` (dans psql) | Quitter psql |

---

## 📚 Rappel syntaxe PL/pgSQL

```sql
-- Fonction
CREATE OR REPLACE FUNCTION ma_fonction(param INT)
RETURNS INT LANGUAGE plpgsql AS $$
BEGIN
    RETURN param * 2;
END;
$$;

-- Procédure
CREATE OR REPLACE PROCEDURE ma_procedure(param TEXT)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO logs(action) VALUES (param);
    RAISE NOTICE 'OK : %', param;
END;
$$;

-- Trigger
CREATE OR REPLACE FUNCTION ma_fonction_trigger()
RETURNS trigger AS $$
BEGIN
    -- NEW = nouvelle ligne, OLD = ancienne ligne
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER mon_trigger
BEFORE INSERT ON ma_table
FOR EACH ROW EXECUTE FUNCTION ma_fonction_trigger();
```
