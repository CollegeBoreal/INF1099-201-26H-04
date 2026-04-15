param([string]$Container = "postgres")

$Database = "ecole"
$User     = "postgres"
$LogFile  = "execution.log"
$Files    = @("DDL.sql", "DML.sql", "DCL.sql", "DQL.sql")

function Write-Log {
    param([string]$Message)
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $Message"
    Write-Output $line
    Add-Content -Path $LogFile -Value $line
}

$start = Get-Date
Write-Log "Demarrage du chargement..."

$running = docker ps --format "{{.Names}}" | Select-String $Container
if (-not $running) {
    Write-Log "ERREUR : conteneur non actif!"
    exit 1
}

foreach ($file in $Files) {
    if (-not (Test-Path $file)) {
        Write-Log "ERREUR : fichier manquant : $file"
        exit 1
    }
    Write-Log "Execution de $file"
    Get-Content $file | docker exec -i $Container psql -U $User -d $Database
}

$duree = ((Get-Date) - $start).TotalSeconds
Write-Log "Termine en $([math]::Round($duree, 2)) secondes!"
