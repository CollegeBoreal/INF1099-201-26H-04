#!/usr/bin/env pwsh

function Test-ItemExists {
    param(
        [string]$Path
    )

    if (Test-Path $Path) {
        return ":heavy_check_mark:"
    }

    return ":x:"
}

function Get-StudentPaths {
    param(
        [string]$StudentID
    )

    return @{
        README   = "$StudentID/README.md"
        Images   = "$StudentID/images"
    }
}

function Get-StudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        README = Test-CommonItemExists -Path $Paths.README -IsReadme
        Images = Test-CommonItemExists -Path $Paths.Images
    }
}

function Test-AllRequiredFilesPresent {
    param(
        [hashtable]$Checks
    )

    return (
        $Checks.README -eq ":1st_place_medal:" -or ":2nd_place_medal:" -and
        $Checks.Images -eq ":heavy_check_mark:"
    )
}

function Write-PresenceHeader {
    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    Write-Output "|:hash:| Boréal :id: | README.md | images | :abacus: |"
    Write-Output "|------|-------------|-----------|--------|----------|"
}


function Write-StudentRow {
    param(
        [int]$Index,
        [string]$StudentID,
        [string]$GitHubLink,
        [hashtable]$Checks,
        [string]$ImagesCount,
        [string]$ReadmePath
    )

    Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $(Num-ToEmoji $($ImagesCount)) | "
}

