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
            # 5 = abacus emoji

            if ($cols.Count -lt 6) { continue }

            if ($cols[2] -match '(\d{9})') {
                $borealId = $matches[1]
            } else {
                continue
            }

            $emoji = ($cols[5]).Trim()

            $score = $EmojiToScore[$emoji]

            if ($null -eq $score) { continue }

            $results += [PSCustomObject]@{
                borealId = $borealId
                score    = $score
            }
        }
    }

    return $results
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

