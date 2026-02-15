# Définition du répertoire de travail

$projectDir = "C:\Users\Laptop\Downloads\INF1099"



# 1. Lancer le conteneur MySQL

docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0



# Attendre que MySQL démarre (important pour l'automatisation)

Start-Sleep -Seconds 20



# 2. Créer la base et l’utilisateur

docker exec -i INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"

docker exec -i INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"

docker exec -i INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'%' WITH GRANT OPTION;"



# 3. Importer le schéma et les données

Get-Content "$projectDir\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Get-Content "$projectDir\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila



# 4. Ajout de mon ID 

docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila -e "INSERT INTO actor (first_name, last_name) VALUES ('ABDERRAFIA YAHIA', '300142242');"



Write-Host "Le TP a été déployé et personnalisé avec succès !" -ForegroundColor Green 