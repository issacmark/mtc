param (
	[String]$installer
)
$currentDate = Get-Date -Format "yyyyMMdd"
function WriteLog {
	param (
		[String]$Msg
	)
	$timeStamp = Get-Date -Format "yy/MM/dd HH:mm:ss"
	Write-Output "[$timeStamp] $Msg" | Out-File -FilePath "$currentDate.log" -Append
}

try {
	if ($installer) {
		$current = Get-Location
		$absolutePathToMsi = Join-Path $current "$installer"
		Start-Process msiexec.exe -Wait -ArgumentList "/I $absolutePathToMsi /quiet"
		WriteLog "$installer installation successful"
	} else {
		WriteLog "please enter installer name"
		exit 1
	}
} catch {
	WriteLog "$_.Exception.Message"
	exit 1
}



