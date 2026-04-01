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
    docker rm -f tp_postgres 2>$null | Out-Null

    docker run -d `
        --name tp_postgres `
        -e POSTGRES_USER=etudiant `
        -e POSTGRES_PASSWORD=etudiant `
        -e POSTGRES_DB=tpdb `
        -p 5432:5432 `
        -v $(Get-Location)/init:/docker-entrypoint-initdb.d `
        postgres:15 | Out-Null
}

function Wait-PostgresReady {
    param(
        [int]$MaxAttempts = 15,
        [int]$DelaySeconds = 1
    )

    for ($i = 0; $i -lt $MaxAttempts; $i++) {
        $status = docker exec tp_postgres pg_isready 2>$null
        if ($status -match "accepting connections") {
            return $true
        }

        Start-Sleep -Seconds $DelaySeconds
    }

    return $false
}

function Initialize-PostgresDatabase {
    docker exec tp_postgres psql -U postgres -c "CREATE DATABASE ecole;" 2>$null | Out-Null
}

function Stop-PostgresLab {
    docker rm -f tp_postgres 2>$null | Out-Null
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
