#!/usr/bin/env pwsh
# -----------------------------------------------
# load-db.ps1
# Auteure : Rabia BOUHALI | Matricule : 300151469
# Script PowerShell pour charger PostgreSQL (TCF Canada)
# Usage  : ./load-db.ps1
# Bonus  : ./load-db.ps1 postgres-lab
# -----------------------------------------------

param (
    [string]$Container = "postgres-lab"
)

# NOTE : La base "ecole" est créée automatiquement par Docker
# (-e POSTGRES_DB=ecole), donc pas besoin de la créer ici.
$Database = "ecole"
$User     = "postgres"
$LogFile  = "execution.log"

$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)

# --- Démarrage du chronomètre (défi bonus) ---
$Chrono = [System.Diagnostics.Stopwatch]::StartNew()

# --- Initialiser le fichier log ---
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"========================================"  | Out-File -FilePath $LogFile
"Log d'execution TCF Canada - 300151469"    | Out-File -FilePath $LogFile -Append
"Date : $Timestamp"                         | Out-File -FilePath $LogFile -Append
"Conteneur : $Container"                    | Out-File -FilePath $LogFile -Append
"========================================"  | Out-File -FilePath $LogFile -Append

Write-Output ""
Write-Output "========================================"
Write-Output " Chargement de la base : $Database"
Write-Output " Conteneur             : $Container"
Write-Output "========================================"

# --- Vérifier que le conteneur est actif ---
$ContainerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $ContainerRunning) {
    $msg = "ERREUR : le conteneur '$Container' n'est pas actif."
    Write-Output $msg
    $msg | Out-File -FilePath $LogFile -Append
    exit 1
}

Write-Output "Conteneur actif. Debut du chargement..."
Write-Output ""

# --- Boucle d'exécution des fichiers SQL ---
foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        $msg = "ERREUR : fichier manquant : $file"
        Write-Output $msg
        $msg | Out-File -FilePath $LogFile -Append
        exit 1
    }

    Write-Output "Execution de $file ..."
    ">> $file" | Out-File -FilePath $LogFile -Append

    $Output = Get-Content $file | docker exec -i $Container psql -U $User -d $Database
    $Output | Out-File -FilePath $LogFile -Append
    $Output | ForEach-Object { Write-Output "   $_" }

    Write-Output ""
}

# --- Temps d'exécution total (défi bonus) ---
$Chrono.Stop()
$Elapsed = $Chrono.Elapsed.TotalSeconds

$summary = "Chargement termine en $([math]::Round($Elapsed, 2)) secondes."
Write-Output "========================================"
Write-Output " $summary"
Write-Output " Log sauvegarde dans : $LogFile"
Write-Output "========================================"

$summary | Out-File -FilePath $LogFile -Append
"========================================" | Out-File -FilePath $LogFile -Append
