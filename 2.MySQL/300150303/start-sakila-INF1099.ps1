# ==============================================================
# Script : start-sakila-INF1099.ps1
# Description : Automatisation du TP INF1099 - Sakila DB
# ==============================================================

$projectDir = "$env:USERPROFILE\Downloads\INF1099"

# --------------------------------------------------------------
# 1. Lancer MySQL (si le conteneur n'existe pas déjà)
# --------------------------------------------------------------
$exists = docker ps -a --format "{{.Names}}" | Select-String "INF1099-mysql"

if ($exists) {
    Write-Host "✅ Le conteneur INF1099-mysql existe déjà, on le démarre..." -ForegroundColor Yellow
    docker start INF1099-mysql
} else {
    Write-Host "🚀 Création du conteneur INF1099-mysql..." -ForegroundColor Cyan
    docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
}

# --------------------------------------------------------------
# 2. Attendre que MySQL soit prêt
# --------------------------------------------------------------
Write-Host "⏳ Attente du démarrage de MySQL..." -ForegroundColor Cyan
Start-Sleep -Seconds 10

# --------------------------------------------------------------
# 3. Créer la base de données sakila
# --------------------------------------------------------------
Write-Host "📦 Création de la base sakila..." -ForegroundColor Cyan
docker exec -i INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE IF NOT EXISTS sakila;"

# --------------------------------------------------------------
# 4. Créer l'utilisateur etudiants (syntaxe MySQL 8.0)
# --------------------------------------------------------------
Write-Host "👤 Création de l'utilisateur etudiants..." -ForegroundColor Cyan
docker exec -i INF1099-mysql mysql -u root -prootpass -e "CREATE USER IF NOT EXISTS 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
docker exec -i INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# --------------------------------------------------------------
# 5. Importer le schéma Sakila
# --------------------------------------------------------------
Write-Host "📂 Import du schéma Sakila..." -ForegroundColor Cyan
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
    docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

# --------------------------------------------------------------
# 6. Importer les données Sakila
# --------------------------------------------------------------
Write-Host "📂 Import des données Sakila..." -ForegroundColor Cyan
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
    docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

# --------------------------------------------------------------
# 7. Vérification finale
# --------------------------------------------------------------
Write-Host "`n✅ Vérification des tables importées :" -ForegroundColor Green
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 sakila -e "SHOW TABLES;"

Write-Host "`n🎉 TP INF1099 prêt ! MySQL Sakila opérationnel." -ForegroundColor Green
