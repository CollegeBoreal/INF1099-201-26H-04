# =========================
# CONFIG
# =========================
$LMSAssignmentID = 14
$DEBUG = $false

$EmojiToScore = @{
    ":x:" = 140
    ":boom:" = 141
    ":heavy_check_mark:" = 142
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
            $levels = @(127, 128, 129)  # fail, silver, gold
            $readScore = Get-RubricLevelIdFromReadmeEmoji `
                -Emoji $readEmoji `
                -Levels $levels

            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 130 `
                -PassLevelId 131

            # If images are displayed in README.md
            if ($readScore -gt 129) {
                $imgScore = 131
            }

            $ddlEmoji = ($cols[5]).Trim()
            $ddlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $ddlEmoji `
                -FailLevelId 132 `
                -PassLevelId 133

            $dmlEmoji = ($cols[6]).Trim()
            $dmlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dmlEmoji `
                -FailLevelId 134 `
                -PassLevelId 135

            $dqlEmoji = ($cols[7]).Trim()
            $dqlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dqlEmoji `
                -FailLevelId 136 `
                -PassLevelId 137

            $dclEmoji = ($cols[8]).Trim()
            $dclScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dclEmoji `
                -FailLevelId 138 `
                -PassLevelId 139

            $dbEmoji = ($cols[9]).Trim()
            $dbScore = $EmojiToScore[$dbEmoji]

            if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $ddlEmoji, $ddlScore
                    , $dmlEmoji, $dmlScore
                    , $dqlEmoji, $dqlScore
                    , $dclEmoji, $dclScore
                    , $dbEmoji, $dbScore
            }

            $results += [PSCustomObject]@{
                borealId  = $borealId
                readme    = $readScore
                image     = $imgScore
                ddl       = $ddlScore
                dml       = $dmlScore
                dql       = $dqlScore
                dcl       = $dclScore
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
        , "dcl"
        , "db"
    )

    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Build rubric
    $rubric = @(
        @{ criterionid = 55;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 56;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 57;  levelid = $Entry.ddl;       remark = "Présence DDL.sql" }
        @{ criterionid = 58;  levelid = $Entry.dml;       remark = "Présence DML.sql" }
        @{ criterionid = 59;  levelid = $Entry.dql;       remark = "Présence DQL.sql" }
        @{ criterionid = 60;  levelid = $Entry.dcl;       remark = "Présence DCL.sql" }
        @{ criterionid = 61;  levelid = $Entry.db;        remark = "Éxécution Batch dans la DB" }
    )

    # Validate level IDs (avoid Moodle crash)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}

