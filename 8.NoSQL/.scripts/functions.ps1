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
        INIT     = "$StudentID/init.sql"
        PROG     = "$StudentID/app.py"
        REQ      = "$StudentID/requirements.txt"
    }
}

function Get-StudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        README = Test-CommonItemExists -Path $Paths.README -IsReadme
        Images = Test-CommonItemExists -Path $Paths.Images
        INIT   = Test-ItemExists -Path $Paths.INIT
        PROG   = Test-ItemExists -Path $Paths.PROG
        REQ    = Test-ItemExists -Path $Paths.REQ
    }
}

function Test-AllRequiredFilesPresent {
    param(
        [hashtable]$Checks
    )

    return (
        $Checks.README -eq ":1st_place_medal:" -or ":2nd_place_medal:" -and
        $Checks.Images -eq ":heavy_check_mark:" -and
        $Checks.INIT   -eq ":heavy_check_mark:" -and
        $Checks.PROG   -eq ":heavy_check_mark:" -and
        $Checks.REQ    -eq ":heavy_check_mark:"
    )
}

function Write-PresenceHeader {
    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    Write-Output "|:hash:| Boréal :id: | README.md | images | init.sql | app.py | requirements.txt  | :mouse_trap: DB | :wood: log |"
    Write-Output "|------|-------------|-----------|--------|----------|--------|-------------------|-----------------|------------|"
}


function Write-StudentRow {
    param(
        [int]$Index,
        [string]$StudentID,
        [string]$GitHubLink,
        [hashtable]$Checks,
        [string]$DbStatus,
        [string]$LogLink,
        [string]$ReadmePath
    )

    Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $($Checks.INIT) | $($Checks.PROG) | $($Checks.REQ) | $DbStatus | $LogLink |"
}

