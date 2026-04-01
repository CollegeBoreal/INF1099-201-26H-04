# -----------------------------------------------
# Script PowerShell pour charger PostgreSQL
# -----------------------------------------------

param (
    [string]$Container = "postgres-lab"
)

$Database = "ecole"
$User     = "postgres"
$LogFile  = "execution.log"

$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)

# Vérifier que le conteneur est actif
$containerRunning = docker ps --format "{{.Names}}" | Select-String -Pattern "^$Container$"

if (-not $containerRunning) {
    Write-Output "ERREUR : le conteneur $Container n'est pas actif."
    exit
}

# Charger chaque fichier SQL
"=== Début : $(Get-Date) ===" | Out-File $LogFile -Encoding UTF8

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        Write-Output "ERREUR : fichier manquant : $file"
        "ERREUR : $file manquant" | Out-File $LogFile -Append
        exit
    }

    Write-Output "Execution de $file..."

    $output = Get-Content $file | docker exec -i $Container psql -U $User -d $Database 2>&1

    $output | ForEach-Object { Write-Output "  >> $_" }
    "[$file] $output" | Out-File $LogFile -Append
}

"=== Fin : $(Get-Date) ===" | Out-File $LogFile -Append
Write-Output "Chargement terminé. Log sauvegardé dans $LogFile"