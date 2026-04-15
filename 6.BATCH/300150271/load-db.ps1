param([string]$Container = "postgres-immo")

$Database = "ecole"
$User     = "postgres"
$LogFile  = "execution.log"

$Files = @("DDL.sql","DML.sql","DCL.sql","DQL.sql")

$start = Get-Date

"Début du chargement..." | Out-File $LogFile

# Vérifier si conteneur actif
$running = docker ps --format "{{.Names}}" | Select-String $Container
if (-not $running) {
    "ERREUR : conteneur non actif" | Tee-Object -FilePath $LogFile -Append
    exit
}

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        "ERREUR : fichier manquant $file" | Tee-Object -FilePath $LogFile -Append
        exit
    }

    "Execution de $file" | Tee-Object -FilePath $LogFile -Append

    Get-Content $file | docker exec -i $Container psql -U $User -d $Database |
    Tee-Object -FilePath $LogFile -Append
}

$end = Get-Date
$duree = ($end - $start).TotalSeconds

"Terminé en $duree secondes" | Tee-Object -FilePath $LogFile -Append