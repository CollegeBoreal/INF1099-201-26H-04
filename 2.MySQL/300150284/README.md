# TP MySQL avec Podman sur Windows  

**Nom : Aroua Mohand Tahar**  
**Cours : INF1099 – Manipulation de données**  
**Collège : Collège Boréal**  


---

## 📌 Description du TP

Ce laboratoire consiste à installer et configurer Podman sur Windows, lancer un conteneur MySQL 8.0, créer une base de données, importer la base Sakila et exécuter des requêtes SQL pour vérifier son bon fonctionnement.

Le TP est réalisé entièrement avec PowerShell et un environnement conteneurisé.

---

## 🎯 Objectifs

À la fin de ce laboratoire, j’ai été capable de :

- Installer et configurer Podman sur Windows  
- Configurer un alias Docker pour Podman  
- Initialiser et démarrer une machine virtuelle Linux  
- Lancer un conteneur MySQL 8.0  
- Créer une base de données MySQL  
- Créer un utilisateur et gérer les privilèges  
- Importer le schéma et les données de la base Sakila  
- Tester des requêtes SQL  

---

## 🗂 Structure du projet

INF1099/
│
├── sakila-db/
│   ├── sakila-schema.sql
│   └── sakila-data.sql
│
├── start-sakila-INF1099.ps1
└── README.md

---

## 🚀 Étapes principales réalisées

### 1️⃣ Préparation de l’environnement
- Création du dossier INF1099 dans Downloads
- Décompression des fichiers Sakila

### 2️⃣ Configuration de Podman
- Initialisation de la machine Linux
- Démarrage de la machine
- Vérification avec `podman ps -a`

### 3️⃣ Lancement du conteneur MySQL

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

### 4️⃣ Création de la base de données

```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
```

### 5️⃣ Création de l’utilisateur

```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
```

### 6️⃣ Importation du schéma et des données

```powershell
Get-Content "$env:USERPROFILE\Downloads\INF1099\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
Get-Content "$env:USERPROFILE\Downloads\INF1099\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

### 7️⃣ Vérification des tables

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

### 8️⃣ Test de requêtes SQL

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SELECT COUNT(*) FROM film;"
```

---

## 🔄 Script d’automatisation

Le script `start-sakila-INF1099.ps1` permet d’automatiser :
- Le lancement du conteneur
- La création de la base
- La création de l’utilisateur
- L’importation complète de Sakila

Exécution :

```powershell
.\start-sakila-INF1099.ps1
```

---

## 📚 Conclusion

Ce TP m’a permis de comprendre le fonctionnement des conteneurs avec Podman, l’utilisation de MySQL en environnement virtualisé et l’importation d’une base de données complète.

J’ai renforcé mes compétences en administration de bases de données, en PowerShell et en gestion d’environnements conteneurisés sous Windows.
