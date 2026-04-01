#!/usr/bin/env pwsh

function Test-CommonItemExists {
    param(
        [string]$Path,
        [switch]$IsReadme
    )

    if (-not (Test-Path $Path)) {
        return ":x:"
    }

    if ($IsReadme) {
        $Content = Get-Content $Path -Raw
        $HasText = ($Content -match '\S')
        $HasImageInReadme = (
            ($Content -match '!\[.*\]\(.*\)') -or
            ($Content -match '<img.*?>') -or
            ($Content -match '<image.*?>')
        )

        if ($HasText -and $HasImageInReadme) {
            return ":1st_place_medal:"
        }
        else {
            return ":2nd_place_medal:"
        }
    }

    return ":heavy_check_mark:"
}


function Get-GitHubAvatarLink {
    param(
        [string]$GitHubID,
        [string]$AvatarID
    )

    return "[<image src='https://avatars0.githubusercontent.com/u/{1}?s=460&v=4' width=20 height=20></image>](https://github.com/{0})" -f $GitHubID, $AvatarID
}

function Write-ParticipationHeader {
    Write-Output "# Participation"
    Write-Output ""

    Write-Output "| Table des matières            | Description                                             |"
    Write-Output "|-------------------------------|---------------------------------------------------------|"
    Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
    Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

    Write-Output ""
    Write-Output "## Légende"
    Write-Output ""
    Write-Output "| Signe              | Signification                 |"
    Write-Output "|--------------------|-------------------------------|"
    Write-Output "| :heavy_check_mark: | Prêt à être corrigé           |"
    Write-Output "| :x:                | Fichier inexistant            |"

}

function Write-Summary {
    param(
        [int]$SuccessCount,
        [int]$TotalCount
    )

    $COUNT = "\$\frac{$SuccessCount}{$TotalCount}\$"

    if ($TotalCount -gt 0) {
        $STATS = [math]::Round(($SuccessCount * 100.0 / $TotalCount), 2)
    }
    else {
        $STATS = 0
    }

    $SUM = "\$\displaystyle\sum_{i=1}^{$TotalCount} s_i\$"

    Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $SuccessCount |"
}


