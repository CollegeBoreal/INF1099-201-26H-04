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

## 🚀 Étapes réalisées

### 1️⃣ Vérification de Podman
```powershell
Podman -v
# podman version 5.7.1
```

![Podman version 5.7.1](screenshots/podman_version.png)

---

### 2️⃣ Créer le dossier projet dans Downloads
```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
```

![Création du dossier INF1099](screenshots/fichier_sakila.png)

---

### 3️⃣ Décompresser Sakila DB
```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" `
               -DestinationPath $projectDir
```

![Décompression de sakila-db.zip](screenshots/decompression_sakila.png)

---

### 4️⃣ Configurer l'alias Docker → Podman
```powershell
# Alias temporaire
Set-Alias docker podman

# Alias permanent — ajouter dans $PROFILE
notepad $PROFILE
Set-Alias docker podman
```

![Configuration alias docker → podman](screenshots/file_docker.png)

---

### 5️⃣ Démarrer la machine Podman
```powershell
podman machine start
# Starting machine "podman-machine-default"
# Machine "podman-machine-default" started successfully
```

![Démarrage de la machine Podman](screenshots/podman_start.png)

> ✅ API Docker disponible sur `npipe:////./pipe/docker_engine`

---

### 6️⃣ Créer et lancer le conteneur MySQL 8.0
```powershell
docker run -d `
  --name INF1099-mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -p 3306:3306 `
  mysql:8.0
```

![Création du conteneur MySQL 8.0](screenshots/creation_du_conteneur_mysql.png)

Vérification — conteneur actif :
```powershell
docker ps
```

![Liste des conteneurs actifs](screenshots/liste_container.png)

> ✅ `INF1099-mysql` tourne sur le port `0.0.0.0:3306->3306/tcp`

---

### 7️⃣ Créer la base de données Sakila + vérification
```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
docker exec -it INF1099-mysql mysql -u root -p -e "SHOW DATABASES;"
```

![Création de la base sakila et SHOW DATABASES](screenshots/cree_liste_database.png)

> ✅ Base `sakila` visible dans la liste aux côtés de `information_schema`, `mysql`, `performance_schema`, `sys`

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
```

![Import du schéma Sakila](screenshots/copier_le_contente_de_sakila.png)

**Données :**
```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
  docker exec -i INF1099-mysql mysql -u root -prootpass sakila
```

![Import des données Sakila](screenshots/copy_contenu_des.png)

> ✅ L'avertissement `Using a password on the command line interface can be insecure` est normal et attendu.

---

### 🔟 Vérification finale

**Liste des 23 tables :**
```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 `
  -e "USE sakila; SHOW TABLES;"
```

![Liste complète des tables Sakila](screenshots/fin_msql.png)

**Comptage des acteurs :**
```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass `
  -e "SELECT COUNT(*) FROM sakila.actor;"
```

![COUNT(*) FROM sakila.actor = 200](screenshots/resultat_copy.png)

> ✅ **200 acteurs** importés — base Sakila complète et opérationnelle.

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
| Vérifier les 23 tables présentes | ✅ |
| Vérifier les données (200 acteurs) | ✅ |

---

## 📚 Références

- [Sakila DB — MySQL Sample Database](https://dev.mysql.com/doc/sakila/en/)
- [Podman Documentation](https://podman.io/docs)
- MySQL Workbench : `choco install mysql.workbench`
