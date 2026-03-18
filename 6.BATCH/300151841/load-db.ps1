# ---------------------------------------
# Script PowerShell pour charger PostgreSQL
# ---------------------------------------

param(
    [string]$CONTAINER = "postgres-lab",
    [string]$DATABASE  = "ecole",
    [string]$USER      = "postgres"
)

$FILES = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)

Write-Output "Chargement de la base de donnees..."

$containerRunning = docker ps --format "{{.Names}}" | Select-String "^$CONTAINER$"

if (-not $containerRunning) {
    Write-Output "ERREUR : le conteneur $CONTAINER n'est pas actif."
    exit
}

foreach ($FILE in $FILES) {
    if (-not (Test-Path $FILE)) {
        Write-Output "ERREUR : fichier manquant : $FILE"
        exit
    }
    Write-Output "Execution de $FILE"
    Get-Content $FILE | docker exec -i $CONTAINER psql -U $USER -d $DATABASE
}

Write-Output "Chargement termine."
