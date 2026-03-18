param(
    [string]$Container = "postgres-lab"
)

# Encodage UTF-8 (corrige les caractères bizarres)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Database  = "ecole"
$User      = "postgres"
$LogFile   = "execution.log"

$Files = "DDL.sql","DML.sql","DCL.sql","DQL.sql"

# Vérifie si le conteneur est actif
$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {
    Write-Output "ERREUR : le conteneur $Container n'est pas actif."
    exit
}

$start = Get-Date

"=== Début ===" | Out-File $LogFile

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        "ERREUR : fichier manquant : $file" | Tee-Object -FilePath $LogFile -Append
        exit
    }

    Write-Output "Execution de $file"

    # ⚡ Execution silencieuse (cache NOTICE et messages inutiles)
    Get-Content $file | docker exec -i $Container `
        psql -U $User -d $Database `
        -v ON_ERROR_STOP=1 `
        --quiet `
        2>$null |
    Tee-Object -FilePath $LogFile -Append
}

$end = Get-Date
$duration = $end - $start

Write-Output "Temps d'exécution : $duration"
"Temps d'exécution : $duration" | Tee-Object -FilePath $LogFile -Append

Write-Output "=== Chargement terminé avec succès ==="
"=== Fin ===" | Tee-Object -FilePath $LogFile -Append
