#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

# Importer les fonctions
. .scripts/functions.ps1
. .scripts/EXfunctions.ps1

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

    $ImagesCount = [PSCustomObject]@{
        Id          = $id
        ImagesCount = 0
    }
    
    if (Test-Path $paths.README) {
        $ImagesCount  = Get-StudentReport -id $StudentID
    }

    Write-StudentRow `
        -Index $i `
        -StudentID $StudentID `
        -GitHubLink $url `
        -Checks $checks `
        -ImagesCount $ImagesCount.ImagesCount `
        -ReadmePath $paths.README

    if (Test-AllRequiredFilesPresent -Checks $checks) {
        $s++
    }

    $i++
}

Write-Summary -SuccessCount $s -TotalCount $i

