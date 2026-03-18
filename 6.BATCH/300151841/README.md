 # 🧪 Lab 6 — Script Batch PowerShell pour charger PostgreSQL avec Docker

## 👨‍🎓 Étudiant

**Nom :** Massinissa Mameri
**Cours :** INF1099 — Bases de données
**Laboratoire :** Automatisation avec PowerShell et Docker

---

# 🎯 Objectif du laboratoire

L’objectif de ce laboratoire est d’automatiser le chargement d’une base de données PostgreSQL à l’aide d’un script **PowerShell**.

Le script permet d’exécuter plusieurs scripts SQL dans un ordre précis afin de :

* créer la structure de la base de données
* insérer les données
* gérer les permissions
* vérifier les résultats

Les technologies utilisées dans ce laboratoire sont :

* Docker
* PostgreSQL
* PowerShell
* SQL

---

# 📁 Structure du projet

```
6.BATCH/
│
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
├── load-db.ps1
└── images/
```

### Description des fichiers

| Fichier         | Description                                                   |
| --------------- | ------------------------------------------------------------- |
| **DDL.sql**     | Création du schéma et des tables                              |
| **DML.sql**     | Insertion des données                                         |
| **DCL.sql**     | Gestion des utilisateurs et des permissions                   |
| **DQL.sql**     | Requêtes SQL pour vérifier les données                        |
| **load-db.ps1** | Script PowerShell qui automatise l'exécution des fichiers SQL |

---

# 🐳 Création du conteneur PostgreSQL

Le conteneur PostgreSQL est créé avec Docker :

```
docker run -d `
--name postgres-lab `
-e POSTGRES_PASSWORD=postgres `
-e POSTGRES_DB=ecole `
-p 5432:5432 `
postgres
```

Vérifier que le conteneur fonctionne :

```
docker ps
```

---

# ⚙️ Script PowerShell

Le script **load-db.ps1** automatise l’exécution des scripts SQL.

Les fichiers sont exécutés dans cet ordre :

```
DDL → DML → DCL → DQL
```

Commande pour exécuter le script :

```
powershell -ExecutionPolicy Bypass -File .\load-db.ps1
```

Le script :

1. Vérifie que le conteneur Docker est actif
2. Vérifie que les fichiers SQL existent
3. Exécute les scripts SQL dans PostgreSQL
4. Affiche les résultats des requêtes

---

# 📊 Vérification des données

Connexion à PostgreSQL :

```
docker exec -it postgres-lab psql -U postgres -d ecole
```

Exemples de requêtes :

```
SELECT * FROM esport.game;
SELECT * FROM esport.team;
SELECT * FROM esport.player;
```

Ces requêtes permettent de vérifier que les données ont été correctement chargées.

---

# 📸 Captures d’écran

Les captures d’écran du laboratoire se trouvent dans le dossier :

```
images/
```

Elles montrent :

* la création du conteneur Docker
* l’exécution du script PowerShell
* la vérification des données dans PostgreSQL

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/6.BATCH/300151841/images/1_structure_labbatch.png.png)

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/6.BATCH/300151841/images/2_postgres_actif.png.png)

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/6.BATCH/300151841/images/03_postgres_container_running.png.png)

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/6.BATCH/300151841/images/Ex%C3%A9cution%20du%20script.png)

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/6.BATCH/300151841/images/V%C3%A9rification%20dans%20PostgreSQL.png)
---

# ✅ Résultat

Le script PowerShell permet d’automatiser complètement le déploiement de la base de données PostgreSQL.

Les tables sont créées, les données sont insérées et les permissions sont appliquées automatiquement.

Cette méthode permet de gagner du temps et d’éviter les erreurs lors de l’exécution manuelle des scripts SQL.

---

# 🛠 Technologies utilisées

* Docker
* PostgreSQL
* PowerShell
* SQL

