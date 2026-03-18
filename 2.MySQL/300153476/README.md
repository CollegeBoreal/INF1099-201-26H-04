# 🐳 TP MySQL avec Podman — INF1099
**Manipulation de données avec MySQL et administration**  
**Étudiant·e :** Ramatoulaye Diallo — `300153476`  
**Cours :** INF1099-201-26H-04 | 2.MySQL  
**Date :** 2026-01-28

---

## ✅ Résultats obtenus

Toutes les étapes du TP ont été complétées avec succès sur Windows avec Podman 5.7.1.

---

## 🛠️ Environnement utilisé

| Outil | Version |
|-------|---------|
| Podman | 5.7.1 |
| MySQL | 8.0 |
| OS | Windows 11 |
| Shell | PowerShell (Admin) |
| Alias | `docker` → `podman` |

---

## 📁 Structure du projet
```
C:\Users\diall\Downloads\INF1099\
└── sakila-db\
    ├── sakila-schema.sql
    └── sakila-data.sql
```

---

## 🚀 Étapes réalisées

### 1️⃣ Vérification de Podman
```powershell
Podman -v
# podman version 5.7.1
```
> ✅ Podman installé et fonctionnel.

---

### 2️⃣ Créer le dossier projet dans Downloads
```powershell
# Créer le dossier INF1099 dans Downloads
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
```
> ✅ Dossier `C:\Users\diall\Downloads\INF1099` créé le 2026-01-28 à 4:09 PM.

---

### 3️⃣ Décompresser Sakila DB
```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" `
               -DestinationPath $projectDir
```
> ✅ Archive extraite dans `$projectDir\sakila-db`.

---

### 4️⃣ Configurer l'alias Docker → Podman
```powershell
# Alias temporaire (session courante)
Set-Alias docker podman

# Alias permanent (ajouter dans $PROFILE)
notepad $PROFILE
# Ligne à ajouter :
Set-Alias docker podman
```
> ✅ `docker` redirige vers `podman` dans toute la session.

---

### 5️⃣ Démarrer la machine Podman
```powershell
podman machine start
# Starting machine "podman-machine-default"
# Machine "podman-machine-default" started successfully
```
> ✅ Machine Podman démarrée. API Docker disponible sur `npipe:////./pipe/docker_engine`.

---

### 6️⃣ Créer et lancer le conteneur MySQL 8.0
```powershell
docker run -d `
  --name INF1099-mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -p 3306:3306 `
  mysql:8.0
```
> ✅ Image `mysql:8.0` téléchargée depuis `docker.io/library/mysql:8.0`.  
> ✅ Conteneur `INF1099-mysql` démarré sur le port `0.0.0.0:3306->3306/tcp`.

Vérification :
```powershell
docker ps
# CONTAINER ID   IMAGE                        STATUS              NAMES
# c35113e9974b   docker.io/library/mysql:8.0  Up About a minute   INF1099-mysql
```

---

### 7️⃣ Créer la base de données Sakila
```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
# Enter password: rootpass
```

Vérification :
```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "SHOW DATABASES;"
```

| Database |
|----------|
| information_schema |
| mysql |
| performance_schema |
| **sakila** |
| sys |

> ✅ Base de données `sakila` créée avec succès.

---

### 8️⃣ Créer l'utilisateur `etudiants`
```powershell
docker exec -it INF1099-mysql `
  mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"

docker exec -it INF1099-mysql `
  mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
```
> ✅ Utilisateur `etudiants` créé avec mot de passe `etudiants_1` et tous les privilèges.

---

### 9️⃣ Importer le schéma et les données Sakila

**Schéma :**
```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
  docker exec -i INF1099-mysql mysql -u root -prootpass sakila
# mysql: [Warning] Using a password on the command line interface can be insecure.
```

**Données :**
```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
  docker exec -i INF1099-mysql mysql -u root -prootpass sakila
# mysql: [Warning] Using a password on the command line interface can be insecure.
```
> ✅ Schéma et données importés. L'avertissement de sécurité sur le mot de passe en ligne de commande est normal et attendu.

---

### 🔟 Vérifier l'importation

**Liste des tables :**
```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 `
  -e "USE sakila; SHOW TABLES;"
```

<details>
<summary>📋 Tables présentes dans sakila (cliquer pour voir)</summary>

| Tables_in_sakila |
|-----------------|
| actor |
| actor_info |
| address |
| category |
| city |
| country |
| customer |
| customer_list |
| film |
| film_actor |
| film_category |
| film_list |
| film_text |
| inventory |
| language |
| nicer_but_slower_film_list |
| payment |
| rental |
| sales_by_film_category |
| sales_by_store |
| staff |
| staff_list |
| store |

</details>

**Vérification du contenu :**
```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass `
  -e "SELECT COUNT(*) FROM sakila.actor;"
```

| COUNT(*) |
|----------|
| **200** |

> ✅ 200 acteurs importés — base Sakila complète et opérationnelle.

---

## 📋 Commandes utiles (référence rapide)

| Commande | Description |
|----------|-------------|
| `docker ps -a` | Lister tous les conteneurs |
| `docker stop INF1099-mysql` | Arrêter le conteneur |
| `docker start INF1099-mysql` | Démarrer le conteneur |
| `docker logs INF1099-mysql` | Voir les logs du serveur |
| `docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1` | Se connecter à MySQL |
| `podman machine start` | Démarrer la VM Linux Podman |
| `podman machine stop` | Arrêter la VM Linux Podman |

---

## 🎯 Résumé des objectifs atteints

| Objectif | Statut |
|----------|--------|
| Installer et configurer Podman avec alias Docker | ✅ |
| Créer et démarrer la machine Podman (VM Linux) | ✅ |
| Lancer un conteneur MySQL 8.0 | ✅ |
| Créer la base de données `sakila` | ✅ |
| Créer l'utilisateur `etudiants` avec privilèges | ✅ |
| Importer le schéma Sakila | ✅ |
| Importer les données Sakila | ✅ |
| Vérifier les tables (23 tables présentes) | ✅ |
| Vérifier les données (200 acteurs) | ✅ |

---

## 📚 Références

- [Sakila DB — MySQL Sample Database](https://dev.mysql.com/doc/sakila/en/)
- [Podman Documentation](https://podman.io/docs)
- MySQL Workbench : `choco install mysql.workbench`
