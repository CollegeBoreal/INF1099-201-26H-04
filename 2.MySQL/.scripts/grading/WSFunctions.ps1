# =========================
# CONFIG
# =========================
$LMSAssignmentID = 10
$DEBUG = $false

$EmojiToScore = @{
    ":zero:"     = 86
    ":one:"      = 87
    ":asterisk:" = 94
}

function Get-ParticipationGrades {
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    $lines = Get-Content $Path
    $results = @()

    foreach ($line in $lines) {

        # Only data rows start with "| <number> |"
        if ($line -match '^\|\s*\d+\s*\|') {

            $cols = $line -split '\|'

            # Columns (0 is empty):
            # 1 = index
            # 2 = Boréal ID link column
            # 3-4 = others

            if ($cols[2]  -match '\[(\d{9})\]') {
                $borealId = $matches[1]
            } else {
                continue
            }

            $readEmoji = ($cols[3]).Trim()
            $levels = @(81, 82, 83)  # fail, silver, gold
            $readScore = Get-RubricLevelIdFromReadmeEmoji `
                -Emoji $readEmoji `
                -Levels $levels

            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 84 `
                -PassLevelId 85

            $abacusEmoji = ($cols[5]).Trim()
            if ($abacusEmoji -match ':zero:' -or $abacusEmoji -match ':one:') {
                $abacusScore = $EmojiToScore[$abacusEmoji]
            } else {
                $abacusEmoji = ':asterisk:'
                $abacusScore = $EmojiToScore[$abacusEmoji]
            }

            # If images are displayed in README.md
            if ($abacusScore -gt 86) {
                $imgScore = 85
            }

            if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $abacusEmoji, $abacusScore
            }

            $results += [PSCustomObject]@{
                borealId  = $borealId
                readme    = $readScore
                image     = $imgScore
                abacus    = $abacusScore
            }
        }
    }

    return $results
}

function New-LMSRubricFromEntry {
    param (
        [Parameter(Mandatory)]
        [object]$Entry
    )

    # Validate required fields exist
    $requiredFields = @(
         "readme"
        , "image"
        , "abacus"
    )

    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Build rubric
    $rubric = @(
        @{ criterionid = 36;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 37;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 38;  levelid = $Entry.abacus;    remark = "Présence de copies d'écran" }
    )

    # Validate level IDs (avoid Moodle crash)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}

