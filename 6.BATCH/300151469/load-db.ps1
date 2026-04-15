# -----------------------------------------------
# load-db.ps1
# Auteure : Rabia BOUHALI | Matricule : 300151469
# Script PowerShell pour charger PostgreSQL (TCF Canada)
# Usage  : ./load-db.ps1
# Bonus  : ./load-db.ps1 postgres-lab
# -----------------------------------------------

# --- Paramètre optionnel (défi bonus) ---
param (
    [string]$Container = "postgres-lab"
)

$Database = "tcf_canada_300151469"
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

# --- Initialiser le fichier log (défi bonus) ---
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

Write-Output "Conteneur actif."
Write-Output ""

# -----------------------------------------------
# CORRECTION : Créer la base de données si elle
# n'existe pas encore, avant d'exécuter les SQL.
# PostgreSQL n'accepte pas "CREATE DATABASE IF NOT EXISTS"
# donc on vérifie d'abord dans pg_database.
# -----------------------------------------------
Write-Output "Verification de la base de donnees '$Database'..."
">> Verification base de donnees" | Out-File -FilePath $LogFile -Append

$DbExists = docker exec -i $Container psql -U $User -tAc `
    "SELECT 1 FROM pg_database WHERE datname = '$Database';"

if ($DbExists -match "1") {
    Write-Output "   Base '$Database' deja existante. On continue."
    "   Base deja existante." | Out-File -FilePath $LogFile -Append
} else {
    Write-Output "   Creation de la base '$Database'..."
    $CreateOutput = docker exec -i $Container psql -U $User -c `
        "CREATE DATABASE $Database;"
    $CreateOutput | Out-File -FilePath $LogFile -Append
    Write-Output "   Base '$Database' creee avec succes."
    "   Base creee avec succes." | Out-File -FilePath $LogFile -Append
}

Write-Output ""
Write-Output "Debut du chargement des fichiers SQL..."
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

    $Output = Get-Content $file | docker exec -i $Container psql -U $User
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
