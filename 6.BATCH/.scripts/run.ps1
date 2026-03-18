#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell equivalent of:
# bash .scripts/participation.sh > .scripts/Participation.md 2>/dev/null
# --------------------------------------

# Run the participation script and redirect its output
# Standard output -> .scripts/Participation.md
# Errors -> $null (discarded)

pwsh .scripts/participation.ps1 > .scripts/Participation.md 2>$null

