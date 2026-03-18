# ===============================================================
# Script PowerShell AVANCÉ pour charger PostgreSQL
# Boutique de réparation de smartphones
# #300150205
#
# Usage :
#   ./load-db-advanced.ps1                   ← valeurs par défaut
#   ./load-db-advanced.ps1 mon-conteneur     ← conteneur en paramètre
#
# Fonctionnalités bonus :
#   ✅ Nom du conteneur en paramètre
#   ✅ Génération d'un fichier log (execution.log)
#   ✅ Affichage du temps d'exécution
# ===============================================================

param (
    [string]$Container = "postgres2"
)

$Database  = "reparation_smartphones"
$User      = "postgres"
$LogFile   = "execution.log"

$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)

# ---------------------------------------------------------------
# Fonction : écrire dans la console ET dans le log
# ---------------------------------------------------------------
function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$timestamp] $Message"
    Write-Output $line
    Add-Content -Path $LogFile -Value $line
}

# ---------------------------------------------------------------
# Initialisation du log
# ---------------------------------------------------------------
$startTime = Get-Date
"" | Set-Content $LogFile
Write-Log "========================================"
Write-Log "Démarrage du chargement"
Write-Log "Conteneur : $Container"
Write-Log "Base      : $Database"
Write-Log "========================================"

# ---------------------------------------------------------------
# Vérification : le conteneur est-il actif ?
# ---------------------------------------------------------------
$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {
    Write-Log "ERREUR : le conteneur '$Container' n'est pas actif."
    Write-Log "Lancez-le avec : docker run -d --name $Container -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=$Database -p 5432:5432 postgres"
    exit 1
}

Write-Log "Conteneur '$Container' détecté. Démarrage du chargement..."

# ---------------------------------------------------------------
# Chargement des fichiers SQL dans l'ordre
# ---------------------------------------------------------------
foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        Write-Log "ERREUR : fichier manquant : $file"
        exit 1
    }

    Write-Log "Execution de $file..."

    $fileStart = Get-Date

    Get-Content $file -Encoding UTF8 | docker exec -i $Container psql -U $User -d $Database

    $fileEnd      = Get-Date
    $fileDuration = ($fileEnd - $fileStart).TotalSeconds

    Write-Log "$file terminé en $([math]::Round($fileDuration, 2)) secondes."
}

# ---------------------------------------------------------------
# Résumé final
# ---------------------------------------------------------------
$endTime      = Get-Date
$totalSeconds = ($endTime - $startTime).TotalSeconds

Write-Log "========================================"
Write-Log "Base de données chargée avec succès."
Write-Log "Temps total : $([math]::Round($totalSeconds, 2)) secondes."
Write-Log "Log sauvegardé dans : $LogFile"
Write-Log "========================================"
