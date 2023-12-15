$chromeInstallDir = (Get-RegistryKey -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome').InstallLocation
if ($chromeInstallDir) {
    Write-Host "Chrome is installed at: $chromeInstallDir"
} else {
    Write-Host "Chrome is not installed."
}



# Uninstall Google Chrome
$chrome = Get-WmiObject -Query "Select * from Win32_Product Where (Name like 'Google Chrome%')" 
if ($chrome) {
    $chrome.Uninstall()
    Write-Output "Google Chrome has been uninstalled."
} else {
    Write-Output "Google Chrome is not installed."
}

# Verify the uninstallation
$chrome_check = Get-WmiObject -Query "Select * from Win32_Product Where (Name like 'Google Chrome%')"
if (-not $chrome_check) {
    Write-Output "Verified: Google Chrome has been successfully uninstalled."
} else {
    Write-Output "Google Chrome is still installed."
}
