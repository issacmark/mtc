# Backup user data
function Backup-ChromeData {
    param (
        [string] $userDataPath = "C:\Users\<username>\AppData\Local\Google\Chrome\User Data"
    )

    if (Test-Path -Path $userDataPath) {
        $backupPath = "$userDataPath.bak-$(Get-Date -Format yyyy-MM-dd)"
        Write-Host "Backing up user data to $backupPath..."
        Remove-Item -Path $backupPath -Force -Recurse
        Copy-Item -Path $userDataPath -Destination $backupPath -Recurse
        Write-Host "Backup completed."
    }
}

# Uninstall Chrome
function Uninstall-ChromeSilently {
    param (
        [string] $msiPath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.msi"
    )

    Write-Host "Uninstalling Chrome..."
    msiexec /x "$msiPath" /quiet /norestart
    Write-Host "Chrome uninstalled."
}

# Download desired Chrome version
function Download-ChromeVersion {
    param (
        [string] $url = "https://www.google.com/chrome/",
        [string] $version = "88.0.4324.190"
    )

    Write-Host "Downloading Chrome version $version..."
    $fileName = "chrome_installer.exe"
    $downloadPath = "$env:TEMP\$fileName"
    Invoke-WebRequest -Uri $url -OutFile $downloadPath
    Write-Host "Download completed."
}

# Install downloaded Chrome version
function Install-ChromeVersion {
    param (
        [string] $installerPath = "$env:TEMP\chrome_installer.exe"
    )

    Write-Host "Installing Chrome version..."
    Start-Process -FilePath $installerPath -ArgumentList "/silent /install /norestart"
    Write-Host "Chrome installation completed."
}

# Restore Chrome data
function Restore-ChromeData {
    param (
        [string] $backupPath = "C:\Users\<username>\AppData\Local\Google\Chrome\User Data.bak-2023-12-13",
        [string] $userDataPath = "C:\Users\<username>\AppData\Local\Google\Chrome\User Data"
    )

    if (Test-Path -Path $backupPath) {
        Write-Host "Restoring user data from $backupPath..."
        Remove-Item -Path $userDataPath -Force -Recurse
        Copy-Item -Path $backupPath -Destination $userDataPath -Recurse
        Write-Host "Restore completed."
    }
}

# Clear temporary files
function Clean-TempFiles {
    Write-Host "Cleaning up temporary files..."
    Remove-Item -Path "$env:TEMP\*chrome_installer.exe*" -Force
}

# Start the rollback process
try {
    Backup-ChromeData
    Uninstall-ChromeSilently
    Download-ChromeVersion -version "88.0.4324.190"
    Install-ChromeVersion
    # Restore-ChromeData
    Clean-TempFiles

    Write-Host "Chrome rollback completed successfully!"
}
catch {
    Write-Error "Error during rollback process: $($_.Exception)"
    # Restore user data in case of error
    Restore-ChromeData
    Clean-TempFiles
}
