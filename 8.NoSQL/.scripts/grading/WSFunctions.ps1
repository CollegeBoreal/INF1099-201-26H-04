# =====================================================================
# CONFIGURATION
# =====================================================================
# Static IDs and flags used throughout participation grading
# =====================================================================

# LMS assignment ID where participation grades will be submitted
$LMSAssignmentID = 16

# Enables verbose/debug output when set to $true
$DEBUG = $false

# Explicit emoji → rubric level mapping for DB execution criterion
# (Used when the emoji represents more than pass/fail)
$EmojiToScore = @{
    ":x:"               = 170
    ":boom:"            = 171
    ":heavy_check_mark:"= 172
}

# =====================================================================
# PARTICIPATION EXTRACTION FROM README.md
# =====================================================================

function Get-ParticipationGrades {
    <#
        Parses a Markdown table from a README.md file and converts
        emoji-based participation indicators into LMS rubric level IDs.

        Each valid row produces one grading entry keyed by Boréal ID.
    #>
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    # Read README.md line-by-line
    $lines = Get-Content $Path
    $results = @()

    foreach ($line in $lines) {

        # Only process Markdown table rows starting with:
        # | <number> |
        if ($line -match '^\|\s*\d+\s*\|') {

            # Split on column separators
            $cols = $line -split '\|'

            # Column index reference (0 is empty due to leading pipe):
            # 1 = Row index
            # 2 = Boréal ID link
            # 3-4 = others

            # Extract Boréal ID (expected format: [300000000])
            if ($cols[2] -match '\[(\d{9})\]') {
                $borealId = $matches[1]
            } else {
                # Skip malformed rows
                continue
            }

            # ---------------------------------
            # README.md quantity (fail/silver/gold)
            # ---------------------------------
            $readEmoji = ($cols[3]).Trim()
            $levels = @(159, 160, 161)  # fail, silver, gold
            $readScore = Get-RubricLevelIdFromReadmeEmoji `
                -Emoji $readEmoji `
                -Levels $levels

            # ---------------------------------
            # Images folder presence (pass/fail)
            # ---------------------------------
            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 162 `
                -PassLevelId 163

            # If README.md exceeds expectations,
            # images folder is implicitly considered present
            if ($readScore -gt 161) {
                $imgScore = 163
            }

            # ---------------------------------
            # init.sql presence
            # ---------------------------------
            $ddlEmoji = ($cols[5]).Trim()
            $ddlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $ddlEmoji `
                -FailLevelId 164 `
                -PassLevelId 165

            # ---------------------------------
            # app.py presence
            # ---------------------------------
            $dmlEmoji = ($cols[6]).Trim()
            $dmlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dmlEmoji `
                -FailLevelId 166 `
                -PassLevelId 167

            # ---------------------------------
            # requirements.txt presence
            # ---------------------------------
            $dqlEmoji = ($cols[7]).Trim()
            $dqlScore = Get-RubricLevelIdFromEmoji `
                -Emoji $dqlEmoji `
                -FailLevelId 168 `
                -PassLevelId 169

            # ---------------------------------
            # Database batch execution
            # ---------------------------------
            $dbEmoji = ($cols[8]).Trim()
            $dbScore = $EmojiToScore[$dbEmoji]

            # Debug trace for validation / troubleshooting
            if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $ddlEmoji, $ddlScore
                    , $dmlEmoji, $dmlScore
                    , $dqlEmoji, $dqlScore
                    , $dbEmoji, $dbScore
            }

            # Accumulate normalized grading entry
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

# =====================================================================
# RUBRIC OBJECT BUILDER
# =====================================================================

function New-LMSRubricFromEntry {
    <#
        Converts a normalized participation entry into
        an LMS-compatible rubric payload.

        Designed to prevent invalid submissions that
        could crash Moodle grading APIs.
    #>
    param (
        [Parameter(Mandatory)]
        [object]$Entry
    )

    # Required grading components
    $requiredFields = @(
          "readme"
        , "image"
        , "ddl"
        , "dml"
        , "dql"
        , "db"
    )

    # Validate entry completeness
    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Construct rubric payload in LMS criterion order
    $rubric = @(
        @{ criterionid = 69; levelid = $Entry.readme; remark = "Quantité README.md" }
        @{ criterionid = 70; levelid = $Entry.image;  remark = "Présence répertoire images" }
        @{ criterionid = 71; levelid = $Entry.ddl;    remark = "Présence init.sql" }
        @{ criterionid = 72; levelid = $Entry.dml;    remark = "Présence app.py" }
        @{ criterionid = 73; levelid = $Entry.dql;    remark = "Présence requirements.txt" }
        @{ criterionid = 74; levelid = $Entry.db;     remark = "Éxécution Batch dans la DB" }
    )

    # Safety check: ensure all level IDs exist
    # (Null level IDs can cause Moodle submission failures)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}