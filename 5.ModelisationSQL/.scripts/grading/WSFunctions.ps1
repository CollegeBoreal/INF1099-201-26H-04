# =========================
# CONFIG
# =========================
$LMSAssignmentID = 13
$DEBUG = $false

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
            $levels = @(111, 112, 113)  # fail, silver, gold
            $readScore = Get-RubricLevelIdFromReadmeEmoji `
                -Emoji $readEmoji `
                -Levels $levels

            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 114 `
                -PassLevelId 115

            # If images are displayed in README.md
            if ($readScore -gt 113) {
                $imgScore = 115
            }

            $ddlEmoji = ($cols[5]).Trim()
            $ddlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $ddlEmoji `
                -FailLevelId 119 `
                -PassLevelId 120

            $dmlEmoji = ($cols[6]).Trim()
            $dmlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dmlEmoji `
                -FailLevelId 121 `
                -PassLevelId 122

            $dqlEmoji = ($cols[7]).Trim()
            $dqlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dqlEmoji `
                -FailLevelId 123 `
                -PassLevelId 124

            $dclEmoji = ($cols[8]).Trim()
            $dclScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dclEmoji `
                -FailLevelId 125 `
                -PassLevelId 126

                if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $ddlEmoji, $ddlScore
                    , $dmlEmoji, $dmlScore
                    , $dqlEmoji, $dqlScore
                    , $dclEmoji, $dclScore
            }

            $results += [PSCustomObject]@{
                borealId  = $borealId
                readme    = $readScore
                image     = $imgScore
                ddl       = $ddlScore
                dml       = $dmlScore
                dql       = $dqlScore
                dcl       = $dclScore
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
    )

    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Build rubric
    $rubric = @(
        @{ criterionid = 48;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 49;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 51;  levelid = $Entry.ddl;       remark = "Présence DDL.sql" }
        @{ criterionid = 52;  levelid = $Entry.dml;       remark = "Présence DML.sql" }
        @{ criterionid = 53;  levelid = $Entry.dql;       remark = "Présence DQL.sql" }
        @{ criterionid = 54;  levelid = $Entry.dcl;       remark = "Présence DCL.sql" }
    )

    # Validate level IDs (avoid Moodle crash)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}

