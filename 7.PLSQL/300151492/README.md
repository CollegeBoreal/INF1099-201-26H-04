# TP PostgreSQL — Stored Procedures

Fonctions, Procédures Stockées et Triggers en PL/pgSQL

---

## Objectifs

| # | Objectif |
|---|----------|
| 1 | Comprendre la différence entre fonction et procédure stockée |
| 2 | Créer et appeler des fonctions et procédures en PL/pgSQL |
| 3 | Utiliser les triggers pour automatiser la logique métier |
| 4 | Gérer les exceptions et le logging dans PostgreSQL |

---

## Structure du projet

```
300150205/
│
├── init/
│   ├── 01-ddl.sql              <- Création des tables
│   ├── 02-dml.sql              <- Données initiales
│   └── 03-programmation.sql   <- Fonctions, procédures, triggers
│
├── tests/
│   └── test.sql                <- Fichier de tests complets
│
└── README.md
```

---

## Schéma des tables

```
┌─────────────────────┐          ┌──────────────────┐
│      etudiants      │          │      cours       │
├─────────────────────┤          ├──────────────────┤
│ id           PK     │          │ id          PK   │
│ nom          TEXT   │          │ nom    TEXT UNIQUE│
│ age          INT    │          └────────┬─────────┘
│ email        TEXT   │                   │
│ date_creation       │                   │
└──────────┬──────────┘                   │
           │                              │
           │       ┌──────────────────────┤
           │       │    inscriptions      │
           └──────>│ id           PK      │<──────────┘
                   │ etudiant_id  FK      │
                   │ cours_id     FK      │
                   └──────────────────────┘

┌──────────────────────┐
│         logs         │  <- rempli automatiquement par les triggers
├──────────────────────┤
│ id           PK      │
│ action       TEXT    │
│ date_action          │
└──────────────────────┘
```

---

## Schéma du flux complet

```
                         APPLICATION
                              │
              ┌───────────────┼────────────────┐
              │               │                │
              ▼               ▼                ▼
  CALL ajouter_etudiant()  CALL inscrire_   SELECT nombre_
                           etudiant_cours() etudiants_par_age()
              │               │                │
              ▼               │                ▼
  ┌───────────────────────┐   │      ┌──────────────────┐
  │   TRIGGER BEFORE      │   │      │    etudiants     │
  │   trg_valider_etudiant│   │      │    (COUNT)       │
  │                       │   │      └──────────────────┘
  │  age >= 18 ?          │   │
  │  email valide ?       │   │
  └──────────┬────────────┘   │
             │ OK             │
             ▼                ▼
      ┌─────────────┐   ┌─────────────┐
      │  etudiants  │   │inscriptions │
      │   (table)   │   │   (table)   │
      └──────┬──────┘   └──────┬──────┘
             │                 │
             └────────┬────────┘
                      │
                      ▼
        ┌─────────────────────────┐
        │    TRIGGER AFTER        │
        │  trg_log_etudiant       │
        │  trg_log_inscription    │
        └─────────────┬───────────┘
                      │
                      ▼
               ┌─────────────┐
               │    logs     │  <- enregistrement automatique
               │   (table)   │     de chaque opération
               └─────────────┘
```

---

## Définitions clés

| Élément | Description | Exemple d'appel |
|---------|-------------|-----------------|
| `FUNCTION` | Retourne une valeur, utilisable dans un `SELECT` | `SELECT nombre_etudiants_par_age(18, 25);` |
| `PROCEDURE` | Ne retourne pas de valeur, gère les transactions | `CALL ajouter_etudiant('Alice', 22, 'alice@email.com');` |
| `TRIGGER` | Exécuté automatiquement sur `INSERT`, `UPDATE`, `DELETE` | Automatique |

---

## Démarrer PostgreSQL avec Docker

**Étape 1 — Lancer le conteneur**

```powershell
docker run -d --name tp_postgres -e POSTGRES_USER=etudiant -e POSTGRES_PASSWORD=etudiant -e POSTGRES_DB=tpdb -p 5432:5432 -v ${PWD}/init:/docker-entrypoint-initdb.d postgres:15
```

> Le flag `-v` monte le dossier `init/` dans le conteneur. PostgreSQL exécute automatiquement tous les fichiers `.sql` au démarrage dans l'ordre alphabétique.

**Étape 2 — Vérifier que le conteneur tourne**

```bash
docker ps
```

Résultat attendu :

```
CONTAINER ID   IMAGE         STATUS        PORTS                    NAMES
a1b2c3d4e5f6   postgres:15   Up 2 seconds  0.0.0.0:5432->5432/tcp   tp_postgres
```

---

## Contenu de 03-programmation.sql

### 1 — Procédure `ajouter_etudiant`

```sql
CALL ajouter_etudiant('Alice', 22, 'alice@email.com');
```

Validations :
- Age supérieur ou égal à 18 ans
- Format email valide
- Email unique dans la base
- Journalisation automatique dans `logs`

---

### 2 — Fonction `nombre_etudiants_par_age`

```sql
SELECT nombre_etudiants_par_age(18, 25);
```

- Retourne le nombre d'étudiants dans une tranche d'âge donnée

---

### 3 — Procédure `inscrire_etudiant_cours`

```sql
CALL inscrire_etudiant_cours('alice@email.com', 'Informatique');
```

Validations :
- L'étudiant existe dans la base
- Le cours existe dans la base
- L'inscription n'est pas déjà enregistrée
- Journalisation dans `logs`

---

### 4 — Trigger `trg_valider_etudiant`

- Déclenché `BEFORE INSERT` sur `etudiants`
- Valide l'âge et le format email automatiquement
- Bloque l'insertion si les données sont invalides

---

### 5 — Triggers `trg_log_etudiant` et `trg_log_inscription`

- Déclenchés `AFTER INSERT`, `UPDATE`, `DELETE`
- Journalisent chaque opération dans `logs`
- Permettent un historique complet des modifications

---

## Exécuter les tests

**Option A — Manuellement (dans le conteneur)**

```bash
docker exec -it tp_postgres psql -U etudiant -d tpdb
```

**Option B — Automatiquement (PowerShell)**

```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

---

## Tests couverts

| # | Test | Résultat attendu |
|---|------|-----------------|
| 1 | Insertion valide d'un étudiant | Étudiant ajouté, log créé |
| 2 | Age invalide (< 18) | Exception capturée |
| 3 | Email mal formé | Exception capturée |
| 4 | Email en doublon | Erreur unique_violation |
| 5 | Fonction tranche d'âge valide | Nombre retourné |
| 6 | Inscription valide | Inscription créée |
| 7 | Inscription en doublon | Exception capturée |
| 8 | Étudiant inexistant | Exception capturée |
| 9 | Cours inexistant | Exception capturée |
| 10 | INSERT direct invalide via trigger | Trigger bloque l'insertion |

---

## Vérification finale

Se connecter au conteneur :

```bash
docker exec -it tp_postgres psql -U etudiant -d tpdb
```

Puis vérifier les données :

```sql
SELECT * FROM etudiants;
SELECT * FROM cours;
SELECT * FROM inscriptions;
SELECT * FROM logs ORDER BY date_action;
```
