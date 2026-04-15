# =========================================
# load-db.ps1
# Script PowerShell pour charger les scripts SQL
# =========================================

param(
    [string]$Container = "postgres-lab"
)

$Database = "ecole"
$User = "postgres"

$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)

$LogFile = "execution.log"
$StartTime = Get-Date

"" | Out-File -FilePath $LogFile -Encoding utf8
"===== Début d'exécution : $StartTime =====" | Tee-Object -FilePath $LogFile -Append

$containerRunning = docker ps --format "{{.Names}}" | Select-String "^$Container$"

if (-not $containerRunning) {
    $msg = "ERREUR : le conteneur $Container n'est pas actif."
    Write-Output $msg
    $msg | Tee-Object -FilePath $LogFile -Append
    exit 1
}

foreach ($file in $Files) {
    if (-not (Test-Path $file)) {
        $msg = "ERREUR : fichier manquant : $file"
        Write-Output $msg
        $msg | Tee-Object -FilePath $LogFile -Append
        exit 1
    }

    $msg = "Exécution de $file"
    Write-Output $msg
    $msg | Tee-Object -FilePath $LogFile -Append

    Get-Content $file | docker exec -i $Container psql -U $User -d $Database 2>&1 |
        Tee-Object -FilePath $LogFile -Append
}

$EndTime = Get-Date
$Duration = $EndTime - $StartTime

"===== Fin d'exécution : $EndTime =====" | Tee-Object -FilePath $LogFile -Append
"Temps total : $($Duration.TotalSeconds) secondes" | Tee-Object -FilePath $LogFile -Append

Write-Output "Base de données chargée avec succès."
Write-Output "Log généré : $LogFile"
Write-Output "Temps d'exécution : $($Duration.TotalSeconds) secondes"
