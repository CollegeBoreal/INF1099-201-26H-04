$Container = "labo-postgres"
$Database  = "laboratoire"
$User      = "admin"

$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)

Write-Output "Chargement base laboratoire..."

foreach ($file in $Files) {

    if (Test-Path $file) {

        Write-Output "Execution de $file"

        Get-Content $file | docker exec -i $Container psql -U $User -d $Database

    } else {

        Write-Output "ERREUR fichier manquant : $file"
        exit
    }
}

Write-Output "Chargement terminé."