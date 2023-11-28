


$ChromePathList=1,2,3

foreach ($ChromePath in $ChromePathList) {
	if (Test-Path -Path $ChromePath) {
		try {
			$ChromeVersion = (Get-Item -Path $ChromePath -ErrorAction Stop).VersionInfo.ProductVersion
			if ($ChromeVersion) {
				return $ChromeVersion
			} else {}
		} catch {
			continue
		}
	}
}
return $false