
# 🐬 TP INF1099 — MySQL avec Podman

## 📚 Informations générales

* **Cours** : INF1099 — Bases de données
* **Session** : Hiver 2026
* **Étudiant** : Mazigh Bareche
* **Numéro étudiant** : 300150271

---

## 🎯 Objectifs du TP

Ce travail avait pour but de :

* Installer et configurer Podman sur Windows
* Utiliser un alias Docker avec Podman
* Créer et gérer un conteneur MySQL
* Créer une base de données et un utilisateur
* Importer la base de données **Sakila**
* Vérifier et manipuler les données

---

## 🖥️ Environnement utilisé

* Windows 10/11
* PowerShell (mode administrateur)
* Podman (version 5.x)
* MySQL 8.0 (conteneur)
* WSL2 activé

---

## ⚙️ Étapes réalisées

### 1️⃣ Configuration de l’environnement

* Activation de la virtualisation (BIOS)
* Installation de WSL
* Configuration de Podman

```powershell
podman machine init
podman machine start
```

---

### 2️⃣ Alias Docker

```powershell
Set-Alias docker podman
```

---

### 3️⃣ Lancement du conteneur MySQL

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

---

### 4️⃣ Création de la base de données

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
```

---

### 5️⃣ Création de l’utilisateur

```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"

docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
```

---

### 6️⃣ Importation de la base Sakila

```powershell
Get-Content "sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
Get-Content "sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

---

### 7️⃣ Vérification

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

✔️ Tables importées avec succès :

* actor
* film
* customer
* rental
* payment
* etc

---

## 📸 Captures d’écran

Les captures suivantes sont incluses dans le dossier `images/` :

* Création du projet
* Configuration Podman
* Conteneur MySQL en cours d’exécution
* Création de la base de données
* Création de l’utilisateur
* Importation des données
* Vérification des tables

---

## 📂 Structure du projet

```
2.MySQL/
└── 300150271/
    ├── sakila-db/
    │   ├── sakila-schema.sql
    │   └── sakila-data.sql
    ├── start-sakila-INF1099.ps1
    ├── images/
    └── README.md
```

---

## 🚀 Script d’automatisation

```powershell
$projectDir = "C:\Users\User\Developer\INF1099-201-26H-04\2.MySQL\300150271"

docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"

docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1' WITH GRANT OPTION;"

Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

---

## ✅ Conclusion

Ce TP m’a permis de :

* Comprendre l’utilisation de Podman et des conteneurs
* Manipuler une base de données MySQL
* Importer et exploiter une base réelle (Sakila)
* Automatiser des tâches avec PowerShell

---

## 📌 Références

* https://podman.io
* https://dev.mysql.com/doc/index-other.html
