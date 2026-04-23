# =====================================================================
# SCRIPT ENTRYPOINT
# =====================================================================
# This script reads participation data from Markdown,
# maps students to Moodle users, builds rubric payloads,
# and submits grades to the LMS.
# =====================================================================

# Exit immediately on any unhandled error
# (Prevents partial or inconsistent grading)
$ErrorActionPreference = "Stop"

# ---------------------------------------------------------------------
# LOAD DEPENDENCIES
# ---------------------------------------------------------------------
# Student mapping utilities
. ../.scripts/students.ps1

# Core grading helpers (emoji parsing, rubric builders, etc.)
. ../.scripts/grading/functions.ps1

# Moodle / LMS web service functions
. .scripts/grading/WSfunctions.ps1

# ---------------------------------------------------------------------
# FETCH GRADABLE USERS FROM LMS
# ---------------------------------------------------------------------
# Retrieves all students eligible for grading in the LMS course
$responseLMS = Get-LMSGradableUsers -LMS_COURSE $LMS_COURSE

# Builds a lookup table keyed by Boréal ID
# {
#   "123456789" = { moodleId, email }
# }
$LMSStudents = Get-LMSStudentInfo -LMSResponse $responseLMS

# ---------------------------------------------------------------------
# READ PARTICIPATION FILES
# ---------------------------------------------------------------------
# List of Markdown files containing participation tables
$files = @(
    "./.scripts/Participation.md"
)

# Parse participation entries from each file
$participation = $files | ForEach-Object {
    Get-ParticipationGrades -Path $_
}

# Optional debug output to validate extracted data
if ($DEBUG) {
    Write-Output $participation
    Write-Host "Total entries:" $participation.Count
}

# ---------------------------------------------------------------------
# PROCESS EACH STUDENT ENTRY
# ---------------------------------------------------------------------
foreach ($entry in $participation) {

    # Skip entries missing a Boréal ID
    # (Cannot be matched to LMS users)
    if (-not $entry.borealId) {
        Write-Warning "Missing borealId in entry: $entry"
        continue
    }

    # Skip students not found in LMS
    if (-not $LMSStudents.ContainsKey($entry.borealId)) {
        Write-Warning "No Moodle user found for ID: $($entry.borealId)"
        continue
    }

    # Retrieve Moodle user ID for grade submission
    $moodleId = $LMSStudents[$entry.borealId].moodleId
    if ($DEBUG) {
        Write-Output $moodleId, $entry.borealId
    }

    # Build LMS-compatible rubric payload
    $rubric = New-LMSRubricFromEntry -Entry $entry

    # -----------------------------------------------------------------
    # SUBMIT GRADE TO LMS
    # -----------------------------------------------------------------
    $response = Send-LMSRubricGrade `
        -LMS_URL $env:LMS_URL `
        -TOKEN $env:API_SYNC_TOKEN `
        -AssignmentId $LMSAssignmentID `
        -UserId $moodleId `
        -Rubric $rubric

    # Output confirmation / API response
    Write-Output "--------------------------------------"
    Write-Output $response
}