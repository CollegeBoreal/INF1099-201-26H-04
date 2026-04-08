<#
.SYNOPSIS
    Script d'automatisation PostgreSQL avec Docker
#>

param(
    [string]$ContainerName = "postgres-lab",
    [string]$Database = "ecole",
    [string]$User = "postgres"
)

$LogFile = "execution.log"
$StartTime = Get-Date

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogEntry = "[$Timestamp] [$Level] $Message"
    Add-Content -Path $LogFile -Value $LogEntry
    Write-Output $LogEntry
}

# Initialisation du log
"=== Démarrage du script ===" | Out-File -FilePath $LogFile
Write-Log "Conteneur: $ContainerName | Base: $Database | Utilisateur: $User"

# Vérification du conteneur
Write-Log "Vérification du conteneur $ContainerName..."
$containerRunning = docker ps --format "{{.Names}}" | Select-String -Pattern "^$ContainerName$"

if (-not $containerRunning) {
    Write-Log "Conteneur non trouvé. Tentative de creation..." "WARN"
    
    docker run -d `
        --name $ContainerName `
        -e POSTGRES_PASSWORD=postgres `
        -e POSTGRES_DB=$Database `
        -p 5432:5432 `
        postgres:latest
    
    Write-Log "Attente du demarrage (5s)..."
    Start-Sleep -Seconds 5
} else {
    Write-Log "Conteneur actif detecte"
}

# Liste des fichiers SQL
$Files = @("DDL.sql", "DML.sql", "DCL.sql", "DQL.sql")
$SuccessCount = 0
$ErrorCount = 0

Write-Log "Debut du chargement des scripts..."

foreach ($file in $Files) {
    Write-Log "Traitement de $file..."
    
    if (-not (Test-Path $file)) {
        Write-Log "ERREUR: Fichier manquant - $file" "ERROR"
        $ErrorCount++
        continue
    }
    
    try {
        $Output = Get-Content $file -Raw | docker exec -i $ContainerName psql -U $User -d $Database -a 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "SUCCES: $file execute"
            $SuccessCount++
        } else {
            Write-Log "ERREUR SQL dans $file : $Output" "ERROR"
            $ErrorCount++
        }
    } catch {
        Write-Log "EXCEPTION dans $file : $_" "ERROR"
        $ErrorCount++
    }
}

# Temps d'execution
$EndTime = Get-Date
$Duration = $EndTime - $StartTime

Write-Log "=== RAPPORT FINAL ==="
Write-Log "Scripts reussis: $SuccessCount"
Write-Log "Scripts en erreur: $ErrorCount"
Write-Log "Temps d'execution: $($Duration.TotalSeconds) secondes"

Write-Output "`nResume:"
Write-Output "- Succes: $SuccessCount"
Write-Output "- Erreurs: $ErrorCount"
Write-Output "- Duree: $($Duration.TotalSeconds)s"
Write-Output "- Log: $LogFile"
