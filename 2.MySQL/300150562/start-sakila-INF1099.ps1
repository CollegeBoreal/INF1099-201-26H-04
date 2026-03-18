# start-sakila-INF1099.ps1
$projectDir = "$env:USERPROFILE\Downloads\INF1099"

# Lancer MySQL dans Docker
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

Start-Sleep -Seconds 15

# Créer la base Sakila
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE IF NOT EXISTS sakila;"

# Créer l'utilisateur étudiants
docker exec INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'%' IDENTIFIED BY 'etudiants_1' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Importer le schéma et les données
Get-Content "$projectDir\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
Get-Content "$projectDir\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Write-Host "Base Sakila prête à l'emploi !"
