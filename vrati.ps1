# Define paths
$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'))
$public = 'C:/Users/Public'
$backupFilePath = [System.IO.Path]::Combine($public, "lule/name_backup.txt")
# Revert files to original names
if (Test-Path -Path $backupFilePath) {
    $backupData = Get-Content -Path $backupFilePath
    foreach ($line in $backupData) {
        $parts = $line -split "\|"
        $originalName = $parts[0]
        $newName = $parts[1]

        # Rename the file back to its original name
        Rename-Item -Path ([System.IO.Path]::Combine($desktopPath, $newName)) -NewName $originalName
    }

    # Remove the backup file
    Remove-Item -Path $backupFilePath
} else {
    Write-Host "Backup file not found. No changes to revert."
}
