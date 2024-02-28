$installations = @("C:\Program Files\google\chrome.exe", "C:\Program Files (x86)\google\chrome.exe")
$autoFix = $false
$latestVersion = "75.0.3770.100"

function Update-Chrome {
    param(
        [string]$originalPath,
		[string]$originalName,
        [string]$newName,
		[string]$isReset,
		[string]$latestVersion
    ) 

    $newPath = $originalPath -replace "chrome.exe", $newName
    $chromeProcesses = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

    if (Test-Path $newPath -and $autoFix) {
        Stop-Process -Id $chromeProcesses.Id -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        Remove-Item -Path $originalPath
        Rename-Item -Path $newPath -NewName "chrome.exe" -Force
        Write-Output "Chrome updated to $latestVersion"
        return $true
    } else {
        Write-Output "Chrome is not up to date. Please update manually."
        return $false
    }
}

foreach ($installation in $installations) {
    if (Test-Path $installation) {
        try {
            $version = (Get-Item -Path $installation -ErrorAction Stop).VersionInfo.ProductVersion

            if ($version -eq $latestVersion) {
                return $true
            }

            if ($installation -like "*chrome*") {
                if (Update-Chrome -originalPath $installation -newName "new_chrome.exe") {
                    return $true
                } else {
                    Write-Output "Error updating Chrome."
                    return $false
                }
            } else {
                Write-Output "No chrome installation found."
                return $true
            }
        } catch {
            continue
        }
    } else {
        Write-Output "Installation path not found: $installation"
        return $false
    }
}

Write-Output "No valid Chrome installation found."
return $false
