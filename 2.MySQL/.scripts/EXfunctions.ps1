#!/usr/bin/env pwsh

# ================================================
# certaines erreurs :
# ne déclencheront pas le catch,
# seront seulement affichées,
# et le script pourrait continuer comme si de rien n’était.
# ================================================

function Get-StudentReport {
    param (
        [string]$id
    )

    $md = "$id/README.md"
    $imagesCount = 0

    if (Test-Path $md) {
        try {
            # Lire tout le contenu du README
            $content = Get-Content $md -Raw

            # Compter les images Markdown : ![alt](url)
            $markdownImages = [regex]::Matches(
                $content,
                '!\[.*?\]\(.*?\)'
            ).Count

            # Compter les balises HTML <img ...>
            $htmlImages = [regex]::Matches(
                $content,
                '<img\s+[^>]*>',
                [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
            ).Count

            $imagesCount = $markdownImages + $htmlImages
        }
        catch {
            Write-Warning "Erreur lors de l'analyse de $md : $_"
        }
    }

    # --- Return structured result ---
    return [PSCustomObject]@{
        Id          = $id
        ImagesCount = $imagesCount
    }
}