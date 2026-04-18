$projectDir = "$env:USERPROFILE\Downloads\INF1099"

# Lancer MySQL
docker run -d --name INF1099-mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -p 3306:3306 `
  mysql:8.0

# Attendre que MySQL soit prêt
Start-Sleep -Seconds 20

# Créer la base
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"

# Créer utilisateur
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"

# Donner les droits
docker exec INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'%' WITH GRANT OPTION;"

# Appliquer
docker exec INF1099-mysql mysql -u root -prootpass -e "FLUSH PRIVILEGES;"

# Import schéma
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

# Import données
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

# Vérification
docker exec INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"

Write-Host "✅ TP2 terminé avec succès !" -ForegroundColor Green
