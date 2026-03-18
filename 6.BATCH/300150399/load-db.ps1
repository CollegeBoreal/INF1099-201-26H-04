$Container = "postgres"
$Database  = "maillotsdb"
$User      = "postgres"

$Files = @(
"DDL.sql",
"DML.sql",
"DCL.sql",
"DQL.sql"
)

Write-Output "Chargement de la base de données..."

foreach ($file in $Files) {

    if (Test-Path $file) {

        Write-Output "Execution de $file"

        Get-Content $file | podman exec -i $Container psql -U $User -d $Database

    }
    else {

        Write-Output "ERREUR : fichier $file introuvable"
    }

}

Write-Output "Chargement terminé."