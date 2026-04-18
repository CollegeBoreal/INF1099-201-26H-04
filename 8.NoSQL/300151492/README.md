# TP NoSQL — PostgreSQL JSONB

> Travaux pratiques — Stockage et manipulation de données JSON dans PostgreSQL via Docker et Python.

---

## Structure du projet

```
/
├── README.md
├── images/
├── init.sql
├── app.py
└── requirements.txt
```

---

## Prerequis

- Docker installé et en cours d'exécution
- Python 3.8 ou supérieur
- pip

---

## Mise en place

### 1. Lancer PostgreSQL avec Docker

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

Le fichier `init.sql` est automatiquement exécuté au démarrage du conteneur. Il crée la table `etudiants`, l'index GIN, et insère les données initiales.

### 2. Vérifier le démarrage

```bash
# Vérifier que le conteneur est actif
docker ps

# Se connecter à la base de données
docker exec -it postgres-nosql psql -U postgres -d ecole

# Dans psql — vérifier la table et les données
\dt
SELECT * FROM etudiants;
\q
```

### 3. Installer les dépendances Python

```bash
pip install -r requirements.txt
```

### 4. Exécuter le script

```bash
python app.py
```

---

## Requetes SQL de référence

### Afficher tous les étudiants

```sql
SELECT id, data FROM etudiants ORDER BY id;
```

### Rechercher par nom

```sql
SELECT data FROM etudiants
WHERE data->>'nom' = 'Alice';
```

### Rechercher par compétence

```sql
SELECT data FROM etudiants
WHERE data->'competences' @> '["Python"]';
```

### Vérifier l'index GIN

```sql
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'etudiants';
```

---

## Opérateurs JSON

| Operateur | Type retourné | Exemple                              |
|-----------|---------------|--------------------------------------|
| `->`      | JSONB         | `data->'nom'` retourne `"Alice"`     |
| `->>`     | TEXT          | `data->>'nom'` retourne `Alice`      |
| `@>`      | booléen       | `data->'competences' @> '["Python"]'`|

La distinction entre `->` et `->>` est essentielle : `->` conserve le type JSON, `->>` convertit en texte brut. Pour les comparaisons de chaînes, toujours utiliser `->>`.

---

## Requetes bonus

### Modifier un champ JSON

```sql
UPDATE etudiants
SET data = data || '{"age": 26}'::jsonb
WHERE data->>'nom' = 'Alice';
```

### Ajouter une valeur dans un tableau imbriqué

```sql
UPDATE etudiants
SET data = jsonb_set(
    data,
    '{competences}',
    (data->'competences') || '["Docker"]'::jsonb
)
WHERE data->>'nom' = 'Bob';
```

### Supprimer un enregistrement

```sql
DELETE FROM etudiants
WHERE data->>'nom' = 'Diana';
```

---

## Compétences visées

- Déploiement d'un conteneur PostgreSQL avec Docker
- Modélisation NoSQL avec le type JSONB
- Indexation GIN pour les requêtes JSON
- Connexion et requêtes Python avec `psycopg2`
- Gestion des dépendances avec `requirements.txt`
- Opérateurs JSON natifs de PostgreSQL

---

## Arrêt et nettoyage

```bash
# Stopper le conteneur
docker stop postgres-nosql

# Supprimer le conteneur
docker rm postgres-nosql
```
