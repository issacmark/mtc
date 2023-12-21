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



import csv
import json

def csv_to_json_grouped(csv_file_path):
    """Converts a CSV file to a JSON dictionary with data grouped by collection."""

    grouped_data = {}
    with open(csv_file_path, 'r') as csv_file:
        reader = csv.DictReader(csv_file)
        for row in reader:
            collection = row["Collection"]
            data = {
                "Host": row["Host"],
                "Available": row["Available"],
                "Deadline": row["Deadline"],
                "Browser": row["Browser"],
                "Version": row["Version"]
            }
            if collection not in grouped_data:
                grouped_data[collection] = []
            grouped_data[collection].append(data)

    return json.dumps(grouped_data, indent=4)

# Example usage:
csv_file_path = 'your_csv_file.csv'
json_data = csv_to_json_grouped(csv_file_path)
print(json_data)

# To save the JSON to a file:
with open('output.json', 'w') as json_file:
    json_file.write(json_data)

