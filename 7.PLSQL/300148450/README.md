# 🐘 TP PostgreSQL — Fonctions, Procédures Stockées et Triggers

## 👤 Informations de l’étudiant
- **Nom :** Adjaoud Hocine
- **Numéro étudiant :** 300148450

---

## 📌 Description du laboratoire

Ce laboratoire a pour objectif de découvrir les langages procéduraux dans PostgreSQL à travers l’utilisation de **fonctions**, de **procédures stockées** et de **triggers** en **PL/pgSQL**.

Le projet permet de comprendre comment intégrer une logique métier directement dans la base de données afin d’automatiser certaines validations, journaliser des opérations et améliorer la cohérence des données.

---

## 🎯 Objectifs pédagogiques

À la fin de ce laboratoire, l’étudiant sera capable de :

- distinguer une **fonction** d’une **procédure stockée**
- créer et exécuter du code en **PL/pgSQL**
- utiliser des **triggers** pour automatiser des actions
- gérer les erreurs avec `RAISE NOTICE` et `RAISE EXCEPTION`
- tester le comportement de la base dans différents scénarios

---

## 🧠 Concepts abordés

### Fonction
Une fonction retourne une valeur et peut être utilisée dans une requête SQL.

Exemple :
```sql
SELECT nombre_etudiants_par_age(18, 25);
```

### Procédure stockée
Une procédure exécute une série d’actions, sans retourner directement une valeur dans un `SELECT`.

Exemple :
```sql
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');
```

### Trigger
Un trigger exécute automatiquement une fonction lorsqu’un événement survient sur une table (`INSERT`, `UPDATE`, `DELETE`).

---

## 📁 Structure du projet

```text
300148450/
│
├── init/
│   ├── 01-ddl.sql
│   ├── 02-dml.sql
│   └── 03-programmation.sql
│
├── tests/
│   └── test.sql
│
└── README.md
```

---

## ⚙️ Environnement technique

- **SGBD :** PostgreSQL 15
- **Langage procédural :** PL/pgSQL
- **Conteneurisation :** Docker
- **Utilisateur :** etudiant
- **Mot de passe :** etudiant
- **Base de données :** tpdb

---

## 🚀 Lancement du conteneur PostgreSQL

### PowerShell

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

### Linux / macOS

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

## 📂 Description des fichiers

### `01-ddl.sql`
Ce fichier contient la création des tables :
- `etudiants`
- `cours`
- `inscriptions`
- `logs`

### `02-dml.sql`
Ce fichier contient les données initiales insérées dans les tables :
- étudiants de départ
- cours disponibles

### `03-programmation.sql`
Ce fichier contient toute la logique procédurale du laboratoire :
- procédure `ajouter_etudiant`
- fonction `nombre_etudiants_par_age`
- procédure `inscrire_etudiant_cours`
- trigger de validation
- trigger de journalisation

### `tests/test.sql`
Ce fichier permet d’exécuter les tests afin de vérifier que :
- les insertions valides fonctionnent
- les validations bloquent les données invalides
- les fonctions retournent les bonnes valeurs
- les logs sont bien générés

---

## 🔄 Connexion à PostgreSQL

```bash
docker container exec -it tp_postgres psql -U etudiant -d tpdb
```

---

## ▶️ Exécution des tests

### Windows PowerShell

```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

### Linux / macOS

```bash
docker container exec -i tp_postgres psql -U etudiant -d tpdb < tests/test.sql
```

---

## ✅ Résultats attendus

Les résultats attendus du laboratoire sont les suivants :

- ajout réussi d’un étudiant valide
- refus d’un étudiant dont l’âge est inférieur à 18 ans
- refus d’un étudiant avec un email invalide
- affichage du nombre d’étudiants dans une tranche d’âge
- inscription d’un étudiant à un cours
- génération automatique de logs dans la table `logs`

---

## 🧪 Exemples de tests réalisés

### Ajouter un étudiant valide

```sql
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');
```

### Tester un âge invalide

```sql
CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
```

### Vérifier le nombre d’étudiants

```sql
SELECT nombre_etudiants_par_age(18, 25);
```

### Inscrire un étudiant à un cours

```sql
CALL inscrire_etudiant_cours('ali@email.com', 'Base de donnees');
```

---

## 🛡️ Validation et journalisation

Ce TP met en évidence deux mécanismes importants :

### Validation
Le trigger `trg_valider_etudiant` vérifie automatiquement :
- que l’âge est valide
- que l’adresse email respecte un format acceptable

### Journalisation
Les triggers de log enregistrent automatiquement les opérations effectuées sur :
- la table `etudiants`
- la table `inscriptions`

Cela permet de conserver une trace des actions réalisées dans la base.

---

## 📚 Bonnes pratiques appliquées

- validation des données avant insertion
- gestion des erreurs avec messages explicites
- séparation claire entre structure, données, logique et tests
- utilisation d’un environnement Docker reproductible
- scripts organisés pour faciliter la maintenance

---

## 🧾 Conclusion

Ce laboratoire permet de comprendre le rôle essentiel des langages procéduraux dans un système de gestion de base de données moderne.

L’utilisation de **PL/pgSQL** permet de centraliser certaines règles métier directement dans la base, d’automatiser des comportements à l’aide des triggers et de sécuriser les traitements grâce à la gestion des exceptions.

Ce TP constitue une excellente introduction aux mécanismes avancés de PostgreSQL dans un contexte proche des besoins professionnels.

---

## 📎 Remarque

Ce travail a été réalisé dans un cadre pédagogique afin de mettre en pratique les fonctions, procédures stockées et triggers dans PostgreSQL avec Docker.
