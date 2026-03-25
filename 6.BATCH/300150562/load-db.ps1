$docker = "C:\Program Files\Docker\Docker\resources\bin\docker.exe"

$container = "postgres-maillot"
$db = "boutique_maillots"
$user = "postgres"

# fichier log en TXT
$log = "execution.txt"

Start-Transcript -Path $log -Append

Write-Host "[START] Debut du chargement..."

$running = & $docker ps --format "{{.Names}}"
if ($running -notcontains $container) {
    Write-Host "[ERROR] Conteneur non actif"
    Stop-Transcript
    exit
}

Write-Host "[INFO] Copie des fichiers..."
& $docker cp DDL.sql ${container}:/DDL.sql
& $docker cp DML.sql ${container}:/DML.sql
& $docker cp DCL.sql ${container}:/DCL.sql
& $docker cp DQL.sql ${container}:/DQL.sql

function Run-SQL($file) {
    Write-Host "[INFO] Execution $file"

    $result = & $docker exec -i $container psql -U $user -d $db -f "/$file" 2>&1

    $result | ForEach-Object {
        Write-Host $_
    }

    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Probleme dans $file"
        Stop-Transcript
        exit
    }
}

Run-SQL "DDL.sql"
Run-SQL "DML.sql"
Run-SQL "DCL.sql"
Run-SQL "DQL.sql"

Write-Host "[OK] Termine avec succes !"

Stop-Transcript