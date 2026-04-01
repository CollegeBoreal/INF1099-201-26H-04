# TP INF1099 — MySQL avec Podman

> **INF1099 · Bases de données · Collège Boréal · Hiver 2026**

---

## Table des matières

- [Objectif](#objectif)
- [Environnement utilisé](#environnement-utilisé)
- [Étapes réalisées](#étapes-réalisées)
  - [Étape 1 — Installation et configuration de Podman](#étape-1--installation-et-configuration-de-podman)
  - [Étape 2 — Création du dossier de travail](#étape-2--création-du-dossier-de-travail)
  - [Étape 3 — Préparation de la base Sakila](#étape-3--préparation-de-la-base-sakila)
  - [Étape 4 — Alias Docker → Podman](#étape-4--alias-docker--podman)
  - [Étape 5 — Lancement du conteneur MySQL](#étape-5--lancement-du-conteneur-mysql)
  - [Étape 6 — Création de la base Sakila](#étape-6--création-de-la-base-sakila)
  - [Étape 7 — Création de l'utilisateur](#étape-7--création-de-lutilisateur)
  - [Étape 8 — Importation de Sakila](#étape-8--importation-de-sakila)
  - [Étape 9 — Vérification finale](#étape-9--vérification-finale)
- [Conclusion](#conclusion)
- [Captures d'écran](#captures-décran)

---

## Objectif

Ce TP consiste à configurer un environnement MySQL fonctionnel avec **Podman** sous Windows afin de :

| Statut | Objectif |
|:------:|----------|
| ✅ | Installer et configurer Podman avec WSL2 |
| ✅ | Lancer un conteneur MySQL |
| ✅ | Créer la base de données Sakila |
| ✅ | Créer un utilisateur MySQL |
| ✅ | Importer les données Sakila |
| ✅ | Vérifier les tables |

---

## Environnement utilisé

| Composant | Détail |
|-----------|--------|
| 💻 Système | Windows 10 / 11 |
| ⚙️ Terminal | PowerShell (Admin) |
| 🐳 Podman | 5.x |
| 🐧 WSL2 | Activé |
| 🐬 MySQL | 8.0 |
| 🗄️ Base de données | Sakila |

---

## Étapes réalisées

### Étape 1 — Installation et configuration de Podman

Vérification de l'installation, initialisation et démarrage de la machine virtuelle Podman.

```bash
podman --version
podman machine init
podman machine start
podman machine list
```
![wait](https://github.com/user-attachments/assets/cd4371c6-8d44-4775-b325-fdad50ec9ae5")

---

### Étape 2 — Création du dossier de travail

Création d'un répertoire dédié au projet dans le dossier Téléchargements.

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
```

---

### Étape 3 — Préparation de la base Sakila

Extraction de l'archive téléchargée depuis le site officiel de MySQL.

```powershell
Expand-Archive -Path "$projectDir\sakila-db.zip" -DestinationPath $projectDir -Force
```

**Structure obtenue :**

```
sakila-db/
├── sakila-schema.sql
└── sakila-data.sql
```
![wait](https://github.com/user-attachments/assets/ec226a10-70c5-4bb4-b644-8db30d1ca8f3")

---

### Étape 4 — Alias Docker → Podman

Création d'un alias pour utiliser la commande `docker` comme raccourci vers `podman`.

```powershell
Set-Alias docker podman
```
![wait](https://github.com/user-attachments/assets/8b2f87f5-a3e5-4c46-836c-490f2f961c31")

---

### Étape 5 — Lancement du conteneur MySQL

Démarrage d'un conteneur MySQL 8.0 avec les variables d'environnement nécessaires.

```powershell
docker run -d --name INF1099-mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -p 3306:3306 `
  mysql:8.0
```
![wait](https://github.com/user-attachments/assets/8abc02da-6e08-402a-bc84-fc34c11e2944")


**Vérification du conteneur actif :**

```powershell
docker ps
```

---

### Étape 6 — Création de la base Sakila

Connexion au conteneur et création de la base de données `sakila`.

```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
```

**Vérification :**

```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "SHOW DATABASES;"
```
![wait](https://github.com/user-attachments/assets/69362694-9d9c-44f4-af7f-2b9972fde8e1")

---

### Étape 7 — Création de l'utilisateur

Création d'un compte utilisateur dédié avec les privilèges sur la base `sakila`.

```powershell
# Création de l'utilisateur
docker exec -it INF1099-mysql mysql -u root -prootpass -e \
  "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"

# Attribution des privilèges
docker exec -it INF1099-mysql mysql -u root -prootpass -e \
  "GRANT ALL PRIVILEGES ON sakila.* TO 'etudiants'@'%'; FLUSH PRIVILEGES;"
```
![wait](https://github.com/user-attachments/assets/5a6a7701-61f4-419b-b41c-433cdac513e4")

---

### Étape 8 — Importation de Sakila

Import du schéma puis des données dans la base `sakila`.

```powershell
# Import du schéma (structure des tables)
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

# Import des données
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```
![wait](https://github.com/user-attachments/assets/6327d2be-d043-431c-b8f6-0efc871fd93f")

---

### Étape 9 — Vérification finale

Affichage des tables disponibles dans la base `sakila`.

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 \
  -e "USE sakila; SHOW TABLES;"
```

**Tables présentes :**

| Table | Table |
|-------|-------|
| `actor` | `film_actor` |
| `address` | `film_category` |
| `category` | `film_text` |
| `city` | `inventory` |
| `country` | `language` |
| `customer` | `payment` |
| `film` | `rental` |
| `staff` | `store` |

---

## Conclusion

| Résultat | Statut |
|----------|:------:|
| Conteneur MySQL opérationnel | ✅ |
| Base Sakila créée | ✅ |
| Utilisateur `etudiants` configuré | ✅ |
| Données Sakila importées | ✅ |
| Tables vérifiées et accessibles | ✅ |
| Environnement prêt pour les TPs suivants | ✅ |

L'environnement MySQL est entièrement fonctionnel via Podman sous Windows avec WSL2. La base de données Sakila est importée et accessible avec l'utilisateur `etudiants`.

---

## Captures d'écran

Les captures se trouvent dans le dossier [`/screenshots`](./screenshots/) :

| # | Description |
|---|-------------|
| 01 | Installation de Podman |
| 02 | Machine Podman active (`podman machine list`) |
| 03 | Conteneur MySQL actif (`docker ps`) |
| 04 | Liste des bases de données (`SHOW DATABASES`) |
| 05 | Tables Sakila (`SHOW TABLES`) |
| 06 | Connexion via MySQL Workbench |

---

## Auteur

Projet réalisé dans le cadre du cours **INF1099 — Bases de données**  
Collège Boréal · Hiver 2026
