param(
    [string]$Container = "postgres-lab"
)

$Database = "ecole"
$User     = "postgres"

$Files = "DDL.sql","DML.sql","DCL.sql","DQL.sql"

$LogFile = "execution.log"

$StartTime = Get-Date

"--- Début de l'exécution ---" | Out-File $LogFile

$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {
    "ERREUR : le conteneur $Container n'est pas actif." | Tee-Object -FilePath $LogFile
    exit
}

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        "ERREUR : fichier manquant : $file" | Tee-Object -FilePath $LogFile -Append
        exit
    }

    "Execution de $file" | Tee-Object -FilePath $LogFile -Append

    Get-Content $file |
    docker exec -i $Container psql -U $User -d $Database |
    Tee-Object -FilePath $LogFile -Append
}

$EndTime = Get-Date
$Duration = $EndTime - $StartTime

"Temps d'exécution : $Duration" | Tee-Object -FilePath $LogFile -Append
"--- Fin de l'exécution ---" | Tee-Object -FilePath $LogFile -Append