# ---------------------------------------
# Script PowerShell avancé PostgreSQL
# ---------------------------------------

param (
    [string]$Container = "postgres-lab"
)

$Database  = "ecole"
$User      = "postgres"
$LogFile   = "300141567-db.txt"

$Files = "DDL.sql","DML.sql","DCL.sql","DQL.sql"

# Créer dossier log si inexistant
if (-not (Test-Path "log")) {
    New-Item -ItemType Directory -Path "log"
}

# Démarrer timer
$startTime = Get-Date

"===== Début execution $(Get-Date) =====" | Out-File $LogFile

# Vérifier container
$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {
    Write-Output "ERREUR : conteneur non actif"
    exit
}

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        Write-Output "ERREUR : fichier manquant $file"
        exit
    }

    Write-Output "Execution de $file"

    "Execution de $file" | Out-File $LogFile -Append

    Get-Content $file | docker exec -i $Container psql -U $User -d $Database 2>&1 |
    Tee-Object -FilePath $LogFile -Append
}

# Fin timer
$endTime = Get-Date
$duration = $endTime - $startTime

"Temps d'execution : $duration" | Out-File $LogFile -Append

Write-Output "Base chargée avec succès"
Write-Output "Temps d'execution : $duration"