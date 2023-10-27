param (
	[String]$installer
)
$currentDate = Get-Date -Format "yyyyMMdd"
function WriteLog {
	param (
		[String]$Msg
	)
	$timeStamp = Get-Date -Format "yy/MM/dd HH:mm:ss"
	Write-Output "[$timeStamp] $Msg" | Out-File -FilePath "C:\Users\Public\Documents\$installer-$currentDate.log" -Append
}

try {
	if ($installer) {
		$current = Get-Location
		$absolutePathToMsi = Join-Path $current "$installer"
		if (!(Test-Path $absolutePathToMsi)) {
		  WriteLog "[Error]: installer absent"
		  exit 1
		}
		Start-Process msiexec.exe -Wait -ArgumentList "/I $absolutePathToMsi /quiet"
		WriteLog "[Info]：$installer installation successful"
	} else {
		WriteLog "[Warning]： please enter installer name"
		exit 1
	}
} catch {
	WriteLog "[Error]: $_.Exception.Message"
	exit 1
}



