#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

# Importer les fonctions
. .scripts/functions.ps1

# Importer la liste des étudiants
. ../.scripts/students.ps1
. ../.scripts/commons.ps1

Write-ParticipationHeader
Write-PresenceHeader

$i = 0
$s = 0

foreach ($entry in $STUDENTS) {
    $parts = $entry -split '\|'
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]

    $paths  = Get-StudentPaths -StudentID $StudentID
    $checks = Get-StudentChecks -Paths $paths
    $url    = Get-GitHubAvatarLink -GitHubID $GitHubID -AvatarID $AvatarID

    Write-StudentRow `
        -Index $i `
        -StudentID $StudentID `
        -GitHubLink $url `
        -ReadmePath $paths.README `
        -Checks $checks

    if (Test-AllRequiredFilesPresent -Checks $checks) {
        $s++
    }

    $i++
}

Write-Summary -SuccessCount $s -TotalCount $i

