#!/usr/bin/env pwsh

function Test-ItemExists {
    param(
        [string]$Path,
        [switch]$CheckMermaid
    )

    if (-not (Test-Path $Path)) {
        return ":x:"
    }

    # If no mermaid check requested → just existence
    if (-not $CheckMermaid) {
        return ":heavy_check_mark:"
    }

    # Only check mermaid if it's a README.md (or any file you want)
    $content = Get-Content $Path -Raw

    if ($content -match '```mermaid') {
        return ":compass:"
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
        MERMAID  = "$StudentID/README.md"
        FILE_1FN = "$StudentID/1FN.txt"
        FILE_2FN = "$StudentID/2FN.txt"
        FILE_3FN = "$StudentID/3FN.txt"
    }
}

function Get-StudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        README    = Test-CommonItemExists -Path $Paths.README -IsReadme
        Images    = Test-CommonItemExists -Path $Paths.Images
        MERMAID   = Test-ItemExists -Path $Paths.MERMAID -CheckMermaid
        FILE_1FN  = Test-ItemExists -Path $Paths.FILE_1FN
        FILE_2FN  = Test-ItemExists -Path $Paths.FILE_2FN
        FILE_3FN  = Test-ItemExists -Path $Paths.FILE_3FN
    }
}

function Test-AllRequiredFilesPresent {
    param(
        [hashtable]$Checks
    )

    return (
        $Checks.README    -eq ":heavy_check_mark:" -and
        $Checks.Images    -eq ":heavy_check_mark:" -and
        $Checks.MERMAID   -eq ":heavy_check_mark:" -and
        $Checks.FILE_1FN  -eq ":heavy_check_mark:" -and
        $Checks.FILE_2FN  -eq ":heavy_check_mark:" -and
        $Checks.FILE_3FN  -eq ":heavy_check_mark:"
    )
}

function Write-PresenceHeader {
    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    Write-Output "|:hash:| Boréal :id: | README.md | images | Modele  | 1FN.txt | 2FN.txt | 3FN.txt |"
    Write-Output "|------|-------------|-----------|--------|---------|---------|---------|---------|"
}


function Write-StudentRow {
    param(
        [int]$Index,
        [string]$StudentID,
        [string]$GitHubLink,
        [string]$ReadmePath,
        [hashtable]$Checks
    )

    Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $($Checks.MERMAID) | $($Checks.FILE_1FN) | $($Checks.FILE_2FN) | $($Checks.FILE_3FN) |"
}

