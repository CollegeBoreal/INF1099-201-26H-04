#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell participation script using $STUDENTS array
# --------------------------------------

# Import variables from another script (students.ps1)
. ../.scripts/students.ps1

# Header
Write-Output "# Participation au $(Get-Date -Format 'dd-MM-yyyy HH:mm')"
Write-Output ""

Write-Output "| Table des matières            | Description                                             |"
Write-Output "|-------------------------------|---------------------------------------------------------|"
Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

Write-Output ""
Write-Output "## Légende"
Write-Output ""
Write-Output "| Signe              | Signification                 |"
Write-Output "|--------------------|-------------------------------|"
Write-Output "| :heavy_check_mark: | Prêt à être corrigé           |"
Write-Output "| :x:                | Fichier inexistant            |"

Write-Output ""
Write-Output "## :a: Présence"
Write-Output ""

Write-Output "|:hash:| Boréal :id: | README.md | images | DDL.sql | DML.sql | DQL.sql | DCL.sql |"
Write-Output "|------|-------------|-----------|--------|---------|---------|---------|---------|"

# Initialize counters
$i = 0
$s = 0

foreach ($entry in $STUDENTS) {

    $parts = $entry -split '\|'
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/{1}?s=460&v=4' width=20 height=20></image>](https://github.com/{0})" -f $GitHubID, $AvatarID

    $README  = "$StudentID/README.md"
    $FOLDER  = "$StudentID/images"

    $DDL = "$StudentID/DDL.sql"
    $DML = "$StudentID/DML.sql"
    $DQL = "$StudentID/DQL.sql"
    $DCL = "$StudentID/DCL.sql"

    function Check($path) {
        if (Test-Path $path) { ":heavy_check_mark:" } else { ":x:" }
    }

    $r  = Check $README
    $img = Check $FOLDER
    $ddl = Check $DDL
    $dml = Check $DML
    $dql = Check $DQL
    $dcl = Check $DCL

    Write-Output "| $i | [$StudentID](../$README) :point_right: $URL | $r | $img | $ddl | $dml | $dql | $dcl |"

    # Success if ALL files exist
    if ($r -eq ":heavy_check_mark:" -and
        $img -eq ":heavy_check_mark:" -and
        $ddl -eq ":heavy_check_mark:" -and
        $dml -eq ":heavy_check_mark:" -and
        $dql -eq ":heavy_check_mark:" -and
        $dcl -eq ":heavy_check_mark:") {
        $s++
    }

    $i++
}

$COUNT = "\$\\frac{$s}{$i}\$"

if ($i -gt 0) {
    $STATS = [math]::Round(($s * 100.0 / $i), 2)
}
else {
    $STATS = 0
}

$SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i\$"

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $s |"
