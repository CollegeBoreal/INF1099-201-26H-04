param([string]$Container = "postgres-immo")

$Database = "immobilier"
$User     = "postgres"
$Files    = @("DDL.sql", "DML.sql", "DQL.sql")

foreach ($file in $Files) {
    Write-Host "Execution $file"
    Get-Content $file | docker exec -i $Container psql -U $User -d $Database
}