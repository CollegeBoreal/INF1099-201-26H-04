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
        DDL      = "$StudentID/DDL.sql"
        DML      = "$StudentID/DML.sql"
        DQL      = "$StudentID/DQL.sql"
        DCL      = "$StudentID/DCL.sql"
        DBScript = "$StudentID/load-db.ps1"
    }
}

function Get-StudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        README = Test-CommonItemExists -Path $Paths.README -IsReadme
        Images = Test-CommonItemExists -Path $Paths.Images
        DDL    = Test-ItemExists -Path $Paths.DDL
        DML    = Test-ItemExists -Path $Paths.DML
        DQL    = Test-ItemExists -Path $Paths.DQL
        DCL    = Test-ItemExists -Path $Paths.DCL
    }
}

function Test-AllRequiredFilesPresent {
    param(
        [hashtable]$Checks
    )

    return (
        $Checks.README -eq ":heavy_check_mark:" -and
        $Checks.Images -eq ":heavy_check_mark:" -and
        $Checks.DDL    -eq ":heavy_check_mark:" -and
        $Checks.DML    -eq ":heavy_check_mark:" -and
        $Checks.DQL    -eq ":heavy_check_mark:" -and
        $Checks.DCL    -eq ":heavy_check_mark:"
    )
}

function Write-PresenceHeader {
    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    Write-Output "|:hash:| Boréal :id: | README.md | images | DDL.sql | DML.sql | DQL.sql | DCL.sql | :mouse_trap: DB | :wood: log |"
    Write-Output "|------|-------------|-----------|--------|---------|---------|---------|---------|-----------------|------------|"
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

    Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $($Checks.DDL) | $($Checks.DML) | $($Checks.DQL) | $($Checks.DCL) | $DbStatus | $LogLink |"
}

