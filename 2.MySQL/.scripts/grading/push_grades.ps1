# Exit on error
$ErrorActionPreference = "Stop"

. ../.scripts/students.ps1
. ../.scripts/grading/functions.ps1

. .scripts/grading/WSfunctions.ps1

$responseLMS = Get-LMSGradableUsers -LMS_COURSE $LMS_COURSE
$LMSStudents = Get-LMSStudentInfo -LMSResponse $responseLMS

$files = @(
    "./.scripts/Participation.md"
)

$participation = $files | ForEach-Object {
    Get-ParticipationGrades -Path $_
}

if ($DEBUG) {
    Write-Output $participation
    Write-Host "Total entries:" $participation.Count
}

foreach ($entry in $participation) {

    if (-not $entry.borealId) {
        Write-Warning "Missing borealId in entry: $entry"
        continue
    }

    if (-not $LMSStudents.ContainsKey($entry.borealId)) {
        Write-Warning "No Moodle user found for ID: $($entry.borealId)"
        continue
    }

    $moodleId = $LMSStudents[$entry.borealId].moodleId
    if ($DEBUG) { Write-Output $moodleId, $entry.borealId }

    $rubric = New-LMSRubricFromEntry -Entry $entry

    $response = Send-LMSRubricGrade `
        -LMS_URL $env:LMS_URL `
        -TOKEN $env:API_SYNC_TOKEN `
        -AssignmentId $LMSAssignmentID `
        -UserId $moodleId `
        -Rubric $rubric

    Write-Output "--------------------------------------"
    Write-Output $response

}


