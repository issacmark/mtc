$chromeInstallDir = (Get-RegistryKey -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome').InstallLocation
if ($chromeInstallDir) {
    Write-Host "Chrome is installed at: $chromeInstallDir"
} else {
    Write-Host "Chrome is not installed."
}