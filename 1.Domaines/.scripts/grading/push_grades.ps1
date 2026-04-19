# Exit on error
$ErrorActionPreference = "Stop"

. ../.scripts/students.ps1
. ../.scripts/grading/functions.ps1

$responseLMS = Get-LMSGradableUsers -LMS_COURSE $LMS_COURSE
$LMSStudents = Get-LMSStudentInfo -LMSResponse $responseLMS

foreach ($entry in $STUDENTS) {
    $parts = $entry -split '\|'
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]

    Write-Output $LMSStudents[$StudentID].moodleId
    # Write-Output $LMSStudents[$StudentID].email

}


