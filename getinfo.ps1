$regex = @"
CB Check browser_patching_(?<browser>\w+)_(?<collection>\w+)_1:WIN\d+
"@

$input = "CB Check browser_patching_chrome_CO_1:WIN000091"

$match = $regex.Match($input)

if ($match.Success) {
    $browser = $match.Groups["browser"].Value
    $collection = $match.Groups["collection"].Value
    Write-Host "Browser: $browser"
    Write-Host "Collection: $collection"
} else {
    Write-Host "Invalid input format."
}