# Prompt the user for the directory to search, with a default value
$directory = Read-Host -Prompt "Enter the directory path (Press Enter for default: C:\)"
if ([string]::IsNullOrEmpty($directory)) {
    $directory = "C:\"
}

# Prompt the user for the number of folders to find, with a default value of 10
$numFolders = Read-Host -Prompt "Enter the number of folders to find (Press Enter for default: 10)"
if ([string]::IsNullOrEmpty($numFolders)) {
    $numFolders = 10
}

# Validate that $numFolders is a valid integer
if (-not [int]::TryParse($numFolders, [ref]$numFolders)) {
    Write-Output "Invalid number entered. Using default value of 10."
    $numFolders = 10
}

try {
    # Get the specified number of most recently created folders
    $recentFolders = Get-ChildItem -Path $directory -Directory |
        Sort-Object CreationTime -Descending |
        Select-Object -First $numFolders

    # Display results with folder path, name, and creation date
    foreach ($folder in $recentFolders) {
        Write-Output "Path: $($folder.FullName), Created On: $($folder.CreationTime)"
    }
} catch {
    Write-Output "An error occurred: $($_.Exception.Message)"
}

# Pause at the end
Read-Host -Prompt "Press Enter to exit"
