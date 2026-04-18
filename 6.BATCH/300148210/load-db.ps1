<<<<<<< HEAD
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

=======
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

>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
Write-Output "Chargement terminé."