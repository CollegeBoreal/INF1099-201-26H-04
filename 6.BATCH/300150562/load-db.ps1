$docker = "C:\Program Files\Docker\Docker\resources\bin\docker.exe"

$container = "postgres-maillot"
$db = "boutique_maillots"
$user = "postgres"
$log = "execution.log"

Write-Host "🚀 Début du chargement..."

$running = & $docker ps --format "{{.Names}}"
if ($running -notcontains $container) {
    Write-Host "❌ Conteneur non actif"
    exit
}

# Nettoyer log
if (Test-Path $log) {
    Remove-Item $log
}

# Copier fichiers dans le conteneur
& $docker cp DDL.sql ${container}:/DDL.sql
& $docker cp DML.sql ${container}:/DML.sql
& $docker cp DCL.sql ${container}:/DCL.sql
& $docker cp DQL.sql ${container}:/DQL.sql

# Exécution avec arrêt si erreur
function Run-SQL($file) {
    Write-Host "📄 Exécution $file"
    $result = & $docker exec -i $container psql -U $user -d $db -f "/$file" 2>&1

    $result | Tee-Object -FilePath $log -Append

    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ ERREUR dans $file"
        exit
    }
}

Run-SQL "DDL.sql"
Run-SQL "DML.sql"
Run-SQL "DCL.sql"
Run-SQL "DQL.sql"

Write-Host "✅ Terminé avec succès !"