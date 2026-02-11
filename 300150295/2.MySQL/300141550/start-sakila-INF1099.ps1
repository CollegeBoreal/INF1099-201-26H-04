$projectDir = "$env:USERPROFILE\Downloads\INF1099"

# ============================
# 1. Lancer MySQL avec Podman
# ============================
podman run -d --name INF1099-mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -p 3306:3306 `
  mysql:8.0

# Attendre que MySQL soit prêt
Start-Sleep -Seconds 12

# ============================
# 2. Création base + utilisateur
# ============================

# Créer la base sakila
podman exec INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"

# Créer l'utilisateur
podman exec INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"

# Donner les droits
podman exec INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'%' WITH GRANT OPTION;"

# Appliquer
podman exec INF1099-mysql mysql -u root -prootpass -e "FLUSH PRIVILEGES;"

# ============================
# 3. Import du schéma et données
# ============================

Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
  podman exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Get-Content "$projectDir\sakila-db\sakila-data.sql" |
  podman exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

