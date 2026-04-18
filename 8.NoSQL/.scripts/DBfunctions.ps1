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

    docker rm -f postgres-nosql 2>$null | Out-Null

    docker run -d `
        --name postgres-nosql `
        -e POSTGRES_USER=postgres `
        -e POSTGRES_PASSWORD=postgres `
        -e POSTGRES_DB=ecole `
        -p 5432:5432 `
        -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql `
        -d postgres:15 2>$null | Out-Null

}

function Wait-PostgresReady {
    param(
        [int]$MaxAttempts = 15,
        [int]$DelaySeconds = 1
    )

    for ($i = 0; $i -lt $MaxAttempts; $i++) {
        $status = docker exec postgres-nosql pg_isready 2>$null
        if ($status -match "accepting connections") {
            return $true
        }

        Start-Sleep -Seconds $DelaySeconds
    }

    return $false
}

function Initialize-PostgresDatabase {
    docker exec postgres-nosql psql -U postgres -c "CREATE DATABASE ecole;" 2>$null | Out-Null
}

function Stop-PostgresLab {
    docker rm -f postgres-nosql 2>$null | Out-Null
}

function Test-LoadDB {
    param(
        [string]$StudentID
    )

    Push-Location $StudentID

    Start-PostgresLab

    try {
        $ready = Wait-PostgresReady
        if (-not $ready) {
            return ":x:"
        }

        Initialize-PostgresDatabase

        pip install -r requirements.txt 2>$null | Out-Null
        python app.py *> "$StudentID-db.txt"

        # Check for errors in the generated file
        if (Test-Path "$StudentID-db.txt") {
            $content = Get-Content "$StudentID-db.txt" -ErrorAction SilentlyContinue
            $hasError = $content | Where-Object { $_ -match '(?i)error|exception ' }
            
            if ($hasError) {
                # Write-Host "Errors found in $StudentID-db.txt"
                return ":boom:"
            }
        }

        return ":heavy_check_mark:"

    }
    catch {
        return ":x:"
    }
    finally {
        Stop-PostgresLab
        Pop-Location
    }
}
