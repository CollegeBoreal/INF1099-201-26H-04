#!/usr/bin/env pwsh

# ================================================
# certaines erreurs :
# ne déclencheront pas le catch,
# seront seulement affichées,
# et le script pourrait continuer comme si de rien n’était.
# ================================================

$ErrorActionPreference = "Stop"
# $ErrorActionPreference = "Continue"
# $ErrorActionPreference = "Stop"
# $ErrorActionPreference = "SilentlyContinue"
# $ErrorActionPreference = "Ignore"

function Start-PostgresLab {
    docker rm -f postgres-lab 2>$null | Out-Null

    docker run -d -q `
        --name postgres-lab `
        -e POSTGRES_PASSWORD=postgres `
        -e POSTGRES_DB=ecole `
        postgres | Out-Null
}

function Wait-PostgresReady {
    param(
        [int]$MaxAttempts = 15,
        [int]$DelaySeconds = 1
    )

    for ($i = 0; $i -lt $MaxAttempts; $i++) {
        $status = docker exec postgres-lab pg_isready 2>$null
        if ($status -match "accepting connections") {
            return $true
        }

        Start-Sleep -Seconds $DelaySeconds
    }

    return $false
}

function Initialize-PostgresDatabase {
    docker exec postgres-lab psql -U postgres -c "CREATE DATABASE ecole;" 2>$null | Out-Null
}

function Stop-PostgresLab {
    docker rm -f postgres-lab 2>$null | Out-Null
}

function Test-LoadDB {
    param(
        [string]$StudentID
    )

    Start-PostgresLab

    try {
        $ready = Wait-PostgresReady
        if (-not $ready) {
            return ":x:"
        }

        Initialize-PostgresDatabase

        Push-Location $StudentID
        try {
            pwsh ./load-db.ps1 *> "$StudentID-db.txt"
            return ":heavy_check_mark:"
        }
        finally {
            Pop-Location
        }
    }
    catch {
        return ":x:"
    }
    finally {
        Stop-PostgresLab
    }
}
