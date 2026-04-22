# =========================
# CONFIG
# =========================
$LMSAssignmentID = 5
$DEBUG = $false

$EmojiToScore = @{
    ":x:" = 30
    ":2nd_place_medal:" = 31
    ":1st_place_medal:" = 32
    ":compass:" = 74
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

            # "levels": { "id": 30, "score": 0 },
            #           { "id": 31, "score": 1 },
            #           { "id": 32, "score": 2 } 
            $readEmoji = ($cols[3]).Trim()
            $readScore = $EmojiToScore[$readEmoji]

            # "levels": { "id": 71, "score": 0 },
            #           { "id": 72, "score": 1 },
            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 71 `
                -PassLevelId 72

            # "levels": { "id": 73, "score": 0 },
            #           { "id": 74, "score": 1 },
            $modelEmoji = ($cols[5]).Trim()
            if ($modelEmoji -match ':x:') {
                $modelEmoji = ':x:'
                $modelScore = 73
            } else {
                $modelScore = $EmojiToScore[$modelEmoji]
            }

            # "levels": { "id": 75, "score": 0 },
            #           { "id": 76, "score": 1 },
            $1fnEmoji = ($cols[6]).Trim()
            $1fnScore = Get-RubricLevelIdFromEmoji `
                -Emoji $1fnEmoji `
                -FailLevelId 75 `
                -PassLevelId 76

            # "levels": { "id": 77, "score": 0 },
            #           { "id": 78, "score": 1 },
            $2fnEmoji = ($cols[7]).Trim()
            $2fnScore = Get-RubricLevelIdFromEmoji `
                -Emoji $2fnEmoji `
                -FailLevelId 77 `
                -PassLevelId 78

            # "levels": { "id": 79, "score": 0 },
            #           { "id": 80, "score": 1 },
            $3fnEmoji = ($cols[8]).Trim()
            $3fnScore = Get-RubricLevelIdFromEmoji `
                -Emoji $3fnEmoji `
                -FailLevelId 79 `
                -PassLevelId 80

            if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $modelEmoji, $modelScore
                    , $1fnEmoji, $1fnScore
                    , $2fnEmoji, $2fnScore
                    , $3fnEmoji, $3fnScore
            }

            $results += [PSCustomObject]@{
                borealId  = $borealId
                readme    = $readScore
                image     = $imgScore
                model     = $modelScore
                fn1       = $1fnScore
                fn2       = $2fnScore
                fn3       = $3fnScore
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
        , "model"
        , "fn1"
        , "fn2"
        , "fn3"
    )

    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Build rubric
    $rubric = @(
        @{ criterionid = 13;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 31;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 32;  levelid = $Entry.model;     remark = "Présence du modèle" }
        @{ criterionid = 33;  levelid = $Entry.fn1;       remark = "Présence de 1FN.txt" }
        @{ criterionid = 34;  levelid = $Entry.fn2;       remark = "Présence de 2FN.txt" }
        @{ criterionid = 35;  levelid = $Entry.fn3;       remark = "Présence de 3FN.txt" }
    )

    # Validate level IDs (avoid Moodle crash)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}

function Send-LMSRubricGrade {
    param (
        [Parameter(Mandatory)]
        [string]$LMS_URL,

        [Parameter(Mandatory)]
        [string]$TOKEN,

        [Parameter(Mandatory)]
        [int]$AssignmentId,

        [Parameter(Mandatory)]
        [int]$UserId,

        [Parameter(Mandatory)]
        [array]$Rubric,

        [int]$AttemptNumber = 0,

        [string]$WorkflowState = "graded"
    )

    # -------------------------
    # BUILD BASE PAYLOAD
    # -------------------------
    $body = @{
        wstoken            = $TOKEN
        wsfunction         = "local_gradesaver_save_grade"
        moodlewsrestformat = "json"
        assignmentid       = $AssignmentId
        userid             = $UserId
        attemptnumber      = $AttemptNumber
        workflowstate      = $WorkflowState
    }

    # -------------------------
    # ADD RUBRIC DYNAMICALLY
    # -------------------------
    for ($i = 0; $i -lt $Rubric.Count; $i++) {
        $entry = $Rubric[$i]

        if (-not $entry.criterionid -or -not $entry.levelid) {
            throw "Invalid rubric entry at index $i"
        }

        $body["rubric[criteria][$i][criterionid]"] = $entry.criterionid
        $body["rubric[criteria][$i][levelid]"]     = $entry.levelid
        $body["rubric[criteria][$i][remark]"]      = $entry.remark
    }

    if ($DEBUG) { $body | ConvertTo-Json -Depth 10 }

    # -------------------------
    # CALL MOODLE API
    # -------------------------
    try {
        $response = Invoke-RestMethod -Method Post `
            -Uri "https://$LMS_URL/webservice/rest/server.php" `
            -Body $body

        return $response
    }
    catch {
        throw "Moodle API call failed: $($_.Exception.Message)"
    }
}