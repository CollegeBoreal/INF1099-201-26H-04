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

