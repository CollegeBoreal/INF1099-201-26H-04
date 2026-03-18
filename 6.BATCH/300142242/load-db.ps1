$Container = "postgres-lab"
$Database  = "ecole"
$User      = "postgres"
$Files = @("DDL.sql", "DML.sql", "DCL.sql", "DQL.sql")

foreach ($file in $Files) {
    if (Test-Path $file) {
        Write-Output "Execution de $file"
        Get-Content $file | docker exec -i $Container psql -U $User -d $Database
    } else {
        Write-Output "ERREUR : $file introuvable"
    }
}