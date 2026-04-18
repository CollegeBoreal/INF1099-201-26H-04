# ------------------------------------------------------------
# load-db.ps1 - Script d'automatisation Moodle (ID 300142242)
# ------------------------------------------------------------

# Défi bonus : Accepter le nom du conteneur en paramètre
param([string]$Container = "postgres-moodle")

$Database = "moodle_db"
$User     = "postgres"
$LogFile  = "execution.log"
# Ordre strict imposé par le laboratoire
$Files    = @("DDL.sql", "DML.sql", "DCL.sql", "DQL.sql")

# Fonction pour écrire dans la console et dans le log (Défi bonus)
function Write-Log {
    param([string]$Message)
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $Message"
    Write-Output $line
    Add-Content -Path $LogFile -Value $line
}

$start = Get-Date
Write-Log "--- Démarrage du chargement de Moodle ---"

# Vérification du conteneur (Version avancée)
$containerRunning = podman ps --format "{{.Names}}" | Select-String $Container
if (-not $containerRunning) {
    Write-Log "ERREUR : le conteneur $Container n'est pas actif."
    exit
}

foreach ($file in $Files) {
    if (-not (Test-Path $file)) {
        Write-Log "ERREUR : fichier manquant : $file"
        exit
    }
    
    Write-Log "Execution de $file"
    # Envoi du script dans le conteneur
    Get-Content $file | podman exec -i $Container psql -U $User -d $Database
}

# Défi bonus : Afficher le temps d'exécution
$duree = ((Get-Date) - $start).TotalSeconds
Write-Log "Base de données chargée avec succès en $([math]::Round($duree, 2)) secondes."