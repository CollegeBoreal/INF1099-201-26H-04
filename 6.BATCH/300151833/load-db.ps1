Remove-Item Alias:docker -ErrorAction SilentlyContinue

$Container = "postgres-lab"
$Database  = "ecole"
$User      = "postgres"

$Files = "DDL.sql","DML.sql","DCL.sql","DQL.sql"

$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {
    Write-Output "ERREUR : le conteneur $Container n'est pas actif."
    exit
}

foreach ($file in $Files) {
    if (-not (Test-Path $file)) {
        Write-Output "ERREUR : fichier manquant : $file"
        exit
    }
    Write-Output "Execution de $file"
    Get-Content $file | docker exec -i $Container psql -U $User -d $Database
}

Write-Output "Base de données chargée avec succès."
