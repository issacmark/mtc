function ExtractBrowserAndCollection($text) {
  # Split the string into parts using underscores
  $parts = $text.Split('_')

  # Extract the browser type
  $browserType = $parts[4]

  # Extract the collection name
  $collectionName = $parts[5]

  # Combine the collection name parts if necessary
  if ($collectionName.Length -eq 3) {
    $collectionName = $collectionName[0] + "_" + $collectionName[1] + $collectionName[2]
  }

  # Return a tuple containing the extracted information
  return @{
    BrowserType = $browserType
    CollectionName = $collectionName
  }
}

# Example usage
$text1 = "CB Check browser_patching_chrome_CO_1:WIN000091"
$text2 = "CB Check browser_patching_edge_CS_1:WIN000092"

$result1 = ExtractBrowserAndCollection($text1)
$result2 = ExtractBrowserAndCollection($text2)

Write-Host "Text 1: Browser type: $($result1.BrowserType), Collection name: $($result1.CollectionName)"
Write-Host "Text 2: Browser type: $($result2.BrowserType), Collection name: $($result2.CollectionName)"
