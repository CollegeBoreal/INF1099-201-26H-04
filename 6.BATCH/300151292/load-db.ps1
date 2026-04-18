# load-db.ps1
# Usage : ./load-db.ps1 [nom-du-conteneur]

param(
    [string]$Container = "postgres-lab"
)

$Database  = "ecole"
$User      = "postgres"
$LogFile   = "execution.log"
$Files     = "DDL.sql","DML.sql","DCL.sql","DQL.sql"

$StartTime = Get-Date
"=== Début : $StartTime ===" | Tee-Object -FilePath $LogFile

# Vérification du conteneur
$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {
    $msg = "ERREUR : le conteneur '$Container' n'est pas actif."
    Write-Output $msg
    $msg | Out-File -FilePath $LogFile -Append
    exit
}

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        $msg = "ERREUR : fichier manquant : $file"
        Write-Output $msg
        $msg | Out-File -FilePath $LogFile -Append
        exit
    }

    Write-Output "Execution de $file"
    "Execution de $file" | Out-File -FilePath $LogFile -Append

    Get-Content $file | docker exec -i $Container psql -U $User -d $Database 2>&1 | Tee-Object -FilePath $LogFile -Append
}

$EndTime  = Get-Date
$Duration = ($EndTime - $StartTime).TotalSeconds

$msg = "=== Terminé : $EndTime | Durée : $Duration secondes ==="
Write-Output $msg
$msg | Out-File -FilePath $LogFile -Append