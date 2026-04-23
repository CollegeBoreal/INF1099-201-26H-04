# =========================
# CONFIG
# =========================
$LMSAssignmentID = 15
$DEBUG = $false

$EmojiToScore = @{
    ":x:" = 156
    ":boom:" = 157
    ":heavy_check_mark:" = 158
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
            $levels = @(143, 144, 145)  # fail, silver, gold
            $readScore = Get-RubricLevelIdFromReadmeEmoji `
                -Emoji $readEmoji `
                -Levels $levels

            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 146 `
                -PassLevelId 147

            # If images are displayed in README.md
            if ($readScore -gt 145) {
                $imgScore = 147
            }

            $ddlEmoji = ($cols[5]).Trim()
            $ddlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $ddlEmoji `
                -FailLevelId 148 `
                -PassLevelId 149

            $dmlEmoji = ($cols[6]).Trim()
            $dmlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dmlEmoji `
                -FailLevelId 150 `
                -PassLevelId 151

            $dqlEmoji = ($cols[7]).Trim()
            $dqlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dqlEmoji `
                -FailLevelId 152 `
                -PassLevelId 153

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
        @{ criterionid = 62;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 63;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 64;  levelid = $Entry.ddl;       remark = "Présence 01-ddl.sql" }
        @{ criterionid = 65;  levelid = $Entry.dml;       remark = "Présence 02-dml.sql" }
        @{ criterionid = 66;  levelid = $Entry.dql;       remark = "Présence 03-programmation.sql" }
        @{ criterionid = 68;  levelid = $Entry.db;        remark = "Éxécution Batch dans la DB" }
    )

    # Validate level IDs (avoid Moodle crash)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}

