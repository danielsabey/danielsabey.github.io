# sync-paper.ps1 - Updates the paper PDF from apa_project to the website
param(
    [switch]$CommitAndPush
)

$source = "C:\Users\danie\Documents\apa_project\paper\main.pdf"
$dest1 = "$PSScriptRoot\Can_Machine_Learning_Help_Teachers_Predict_and_Improve_Student_Outcomes.pdf"
$dest2 = "$PSScriptRoot\Better_Predictions_Worse_Outcomes.pdf"

if (-not (Test-Path $source)) {
    Write-Error "Source file not found at: $source"
    exit 1
}

Write-Host "Copying latest paper PDF from $source..."
Copy-Item -Path $source -Destination $dest1 -Force
Copy-Item -Path $source -Destination $dest2 -Force
Write-Host "Updated PDFs successfully." -ForegroundColor Green

if ($CommitAndPush) {
    Set-Location $PSScriptRoot
    git add $dest1 $dest2
    git commit -m "Update paper draft PDF"
    git push
    Write-Host "Pushed changes to GitHub." -ForegroundColor Green
} else {
    Write-Host "Run 'git commit' and 'git push', or use '.\sync-paper.ps1 -CommitAndPush' to publish directly."
}
