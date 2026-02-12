$projectDir = "$env:USERPROFILE\Downloads\INF1099"
$containerName = "INF1099-mysql"

Write-Host "--- Setup Sakila DB (INF1099) ---"

# Cleanup existing container
if (docker ps -a --format "{{.Names}}" | Select-String -Pattern "^$containerName$") {
    Write-Host "> Nettoyage du conteneur existant..."
    docker rm -f $containerName | Out-Null
}

# Run MySQL 8.0
Write-Host "> Initialisation du conteneur..."
docker run -d --name $containerName -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0 | Out-Null

# Health check loop
Write-Host "> Attente de MySQL (cela peut prendre 15-20s)..."
$ready = $false
for ($i = 0; $i -lt 12; $i++) {
    Start-Sleep -Seconds 5
    docker exec $containerName mysql -u root -prootpass -e "SELECT 1;" 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $ready = $true
        break
    }
}

if (-not $ready) {
    Write-Host "!! Erreur: MySQL n'a pas démarré à temps." -ForegroundColor Red
    exit 1
}

# DB & User Setup
Write-Host "> Configuration des accès..."
docker exec -i $containerName mysql -u root -prootpass <<EOF
CREATE DATABASE IF NOT EXISTS sakila;
CREATE USER IF NOT EXISTS 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';
GRANT ALL PRIVILEGES ON sakila.* TO 'etudiants'@'%';
FLUSH PRIVILEGES;
EOF

Write-Host "--- Setup terminé avec succès ---"