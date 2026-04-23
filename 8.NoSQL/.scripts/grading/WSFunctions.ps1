# =========================
# CONFIG
# =========================
$LMSAssignmentID = 16
$DEBUG = $false

$EmojiToScore = @{
    ":x:" = 170
    ":boom:" = 171
    ":heavy_check_mark:" = 172
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
            $levels = @(159, 160, 161)  # fail, silver, gold
            $readScore = Get-RubricLevelIdFromReadmeEmoji `
                -Emoji $readEmoji `
                -Levels $levels

            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 162 `
                -PassLevelId 163

            # If images are displayed in README.md
            if ($readScore -gt 161) {
                $imgScore = 163
            }

            $ddlEmoji = ($cols[5]).Trim()
            $ddlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $ddlEmoji `
                -FailLevelId 164 `
                -PassLevelId 165

            $dmlEmoji = ($cols[6]).Trim()
            $dmlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dmlEmoji `
                -FailLevelId 166 `
                -PassLevelId 167

            $dqlEmoji = ($cols[7]).Trim()
            $dqlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dqlEmoji `
                -FailLevelId 168 `
                -PassLevelId 169

            $dbEmoji = ($cols[8]).Trim()
            $dbScore = $EmojiToScore[$dbEmoji]

            if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $ddlEmoji, $ddlScore
                    , $dmlEmoji, $dmlScore
                    , $dqlEmoji, $dqlScore
                    , $dbEmoji, $dbScore
            }

            $results += [PSCustomObject]@{
                borealId  = $borealId
                readme    = $readScore
                image     = $imgScore
                ddl       = $ddlScore
                dml       = $dmlScore
                dql       = $dqlScore
                db        = $dbScore
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
        , "ddl"
        , "dml"
        , "dql"
        , "db"
    )

    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Build rubric
    $rubric = @(
        @{ criterionid = 69;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 70;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 71;  levelid = $Entry.ddl;       remark = "Présence init.sql" }
        @{ criterionid = 72;  levelid = $Entry.dml;       remark = "Présence app.py" }
        @{ criterionid = 73;  levelid = $Entry.dql;       remark = "Présence requirements.txt" }
        @{ criterionid = 74;  levelid = $Entry.db;        remark = "Éxécution Batch dans la DB" }
    )

    # Validate level IDs (avoid Moodle crash)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}

