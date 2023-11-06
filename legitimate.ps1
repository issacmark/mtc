# Define a regular expression pattern that matches the id format
$pattern = 'CHG\\d{7}'

# Define an id to test
$id = 'CHG1234567'

# Use the -match operator to compare the id with the pattern
if ($id -match $pattern) {
    Write-Output "The id $id matches the pattern $pattern"
} else {
    Write-Output "The id $id does not match the pattern $pattern"
}

# Alternatively, use the [regex] class to create a regex object and use its methods
$regex = [regex]::new($pattern)
if ($regex.IsMatch($id)) {
    Write-Output "The id $id matches the pattern $pattern"
} else {
    Write-Output "The id $id does not match the pattern $pattern"
}
