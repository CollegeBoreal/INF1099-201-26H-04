param([string]$Container = "postgres-immo")

$Database="immobilier"
$User="postgres"

Write-Host "Execution DDL"
Get-Content DDL.sql | docker exec -i $Container psql -U $User -d $Database

Write-Host "Execution DML"
Get-Content DML.sql | docker exec -i $Container psql -U $User -d $Database

Write-Host "Execution DCL"
Get-Content DCL.sql | docker exec -i $Container psql -U $User -d $Database

Write-Host "Execution DQL"
Get-Content DQL.sql | docker exec -i $Container psql -U $User -d $Database