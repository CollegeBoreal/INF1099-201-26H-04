function Get-RubricLevelIdFromReadmeEmoji {
    param (
        [Parameter(Mandatory)]
        [string]$Emoji,

        [Parameter(Mandatory)]
        [int[]]$Levels  # [fail, silver, gold]
    )

    if ($Levels.Count -ne 3) {
        throw "Levels must contain exactly 3 values: [fail, silver, gold]"
    }

    $fail   = $Levels[0]
    $silver = $Levels[1]
    $gold   = $Levels[2]

    $Emoji = $Emoji.Trim()

    switch -Regex ($Emoji) {
        ':x:|❌'                   { return $fail }
        ':2nd_place_medal:|🥈'     { return $silver }
        ':1st_place_medal:|🥇'     { return $gold }
        default {
            throw "Unknown README emoji: $Emoji"
        }
    }
}

function Get-RubricLevelIdFromEmoji {
    param (
        [Parameter(Mandatory)]
        [string]$Emoji,

        [Parameter(Mandatory)]
        [int]$FailLevelId,

        [Parameter(Mandatory)]
        [int]$PassLevelId
    )

    $Emoji = $Emoji.Trim()

    if ($Emoji -match ':x:' -or $Emoji -match '❌') {
        return $FailLevelId
    }

    return $PassLevelId
}

function Get-LMSGradableUsers {
    param (
        [Parameter(Mandatory)]
        [int]$LMS_COURSE
    )

    # Ensure environment variables are set
    if (-not $env:LMS_URL -or -not $env:API_SYNC_TOKEN) {
        throw "LMS_URL or API_SYNC_TOKEN is not set!"
    }

    try {
        $responseLMS = Invoke-RestMethod -Method Post `
            -Uri "https://$($env:LMS_URL)/webservice/rest/server.php" `
            -Body @{
                wstoken              = $env:API_SYNC_TOKEN
                wsfunction           = "core_grades_get_gradable_users"
                courseid             = $LMS_COURSE
                moodlewsrestformat   = "json"
            }

        return $responseLMS

    } catch {
        throw "Failed to call Moodle API: $($_.Exception.Message)"
    }
}

# ---------------------
# Populate LMS Students
# ---------------------
function Get-LMSStudentInfo {
    param (
        [Parameter(Mandatory)]
        [object]$LMSResponse
    )

    $LMSStudents = @{}

    if (-not $LMSResponse.users) {
        throw "LMSResponse does not contain a 'users' property."
    }

    $LMSResponse.users | Where-Object { $_.idnumber } | ForEach-Object {
        $LMSStudents[$_.idnumber] = [PSCustomObject]@{
            moodleId = $_.id
            email    = $_.email
        }
    }

    return $LMSStudents
}

# ---------------------
# Grading
# ---------------------
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

