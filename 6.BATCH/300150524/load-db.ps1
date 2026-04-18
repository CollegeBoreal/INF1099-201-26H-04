# ============================================================
# load-db.ps1 — Chargement automatique PostgreSQL CarGoRent
# Usage : .\load-db.ps1 [nom-du-conteneur]
# ============================================================

param([string]$Container = "postgres-cargorent")

$Database = "cargorent_model"
$User     = "postgres"
$LogFile  = "execution.log"
$Files    = @("ddl.sql", "dml.sql", "dcl.sql", "dql.sql")

function Write-Log {
    param([string]$Message)
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $Message"
    Write-Output $line
    Add-Content -Path $LogFile -Value $line
}

$start = Get-Date
Write-Log "Demarrage du chargement..."

# Vérifier que le conteneur est actif
$running = docker ps --format "{{.Names}}" | Select-String $Container
if (-not $running) {
    Write-Log "ERREUR : conteneur '$Container' non actif!"
    exit 1
}

# Exécution des fichiers SQL dans l'ordre
foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        Write-Log "ERREUR : fichier manquant : $file"
        exit 1
    }

    Write-Log "Execution de $file"

    Get-Content $file | docker exec -i $Container psql -U $User -d $Database
}

# Temps d'exécution
$duree = ((Get-Date) - $start).TotalSeconds
Write-Log "Termine en $([math]::Round($duree, 2)) secondes!"