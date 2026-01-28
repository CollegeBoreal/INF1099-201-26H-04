# INF1099 – TP : Pratique de manipulation de données avec MySQL et Podman

## 🎯 Objectifs

À la fin de ce TP, l’étudiant sera capable de :

1. Installer **Podman** et configurer un alias **Docker** sur Windows
2. Lancer un conteneur **MySQL**
3. Créer une base de données et un utilisateur
4. Importer la base de données **Sakila** pour pratiquer SQL
5. Manipuler les tables pour des exercices INF1099

---

## 1️⃣ Prérequis

* Windows 10/11 64 bits ou Linux avec Podman
* **Podman installé** + alias Docker (`Set-Alias docker podman`)
* PowerShell ou terminal bash
* Accès Internet pour télécharger les fichiers SQL

---

## 2️⃣ Télécharger la base de données Sakila

1. Télécharger ZIP : [Sakila DB](http://downloads.mysql.com/docs/sakila-db.zip)
2. Décompresser dans le répertoire projet, par exemple :

```powershell
Expand-Archive -Path C:\INF-Tp\sakila-db.zip -DestinationPath C:\INF-Tp\sakila-db
```

---

## 3️⃣ Lancer MySQL dans Podman (alias Docker)

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

Vérifier le conteneur :

```powershell
docker ps
```

---

## 4️⃣ Créer la base de données Sakila

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
```

* Mot de passe root = `rootpass`
* Vérification :

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "SHOW DATABASES;"
```

---

## 5️⃣ Créer l’utilisateur **etudiants**

```powershell
docker exec -it INF1099-mysql `
  mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1' WITH GRANT OPTION;"
```

Vérifier la création de l’utilisateur :

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "SELECT User, Host FROM mysql.user;"
```

---

## 6️⃣ Importer la base Sakila

### Charger le schéma :

```powershell
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila < C:\INF-Tp\sakila-db\sakila-schema.sql
```

### Charger les données :

```powershell
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila < C:\INF-Tp\sakila-db\sakila-data.sql
```

---

## 7️⃣ Vérification

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

* Tables attendues : `actor`, `film`, `customer`, etc.

---

## 8️⃣ Commandes Podman/Docker utiles

| Commande                                                         | Description                |
| ---------------------------------------------------------------- | -------------------------- |
| `docker ps -a`                                                   | Lister tous les conteneurs |
| `docker stop INF1099-mysql`                                      | Arrêter le conteneur       |
| `docker start INF1099-mysql`                                     | Démarrer le conteneur      |
| `docker logs INF1099-mysql`                                      | Voir les logs du serveur   |
| `docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1` | Se connecter à MySQL       |

---

## 9️⃣ Points pédagogiques

* L’utilisation de **Podman avec alias Docker** permet d’utiliser tous les tutoriels Docker existants
* Les conteneurs isolent MySQL → pas d’installation locale
* Base **Sakila** = excellent TP pour apprendre SQL : SELECT, JOIN, INSERT, UPDATE, DELETE

---

