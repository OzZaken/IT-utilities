# FindLatestFolders

`FindLatestFolders.ps1` is a PowerShell script that retrieves the most recently created folders within a specified directory. The script allows the user to specify both the directory path and the number of recent folders to display, with default values if none are provided.

## Features
- Prompts the user to input a directory path, with `C:\` as the default.
- Prompts for the number of folders to retrieve, defaulting to `10`.
- Displays the folder path, name, and creation date for each of the most recently created folders.
- Includes error handling for invalid directory paths and non-integer inputs for the number of folders.

## Usage
1. Open PowerShell.
2. Run the script by navigating to the directory where it’s located and executing:
   ```powershell
   .\FindLatestFolders.ps1
   ```
3. When prompted:
   - Enter a directory path or press Enter to use `C:\`.
   - Enter the number of folders to retrieve or press Enter to use the default value of `10`.
4. The script outputs the path, name, and creation date of each of the most recent folders in the specified directory.

## Example Output
```plaintext
Enter the directory path (Press Enter for default: C:\): C:\Users\ozzak
Enter the number of folders to find (Press Enter for default: 10): 5
Path: C:\Users\ozzak\Scripts, Created On: 10/03/2024 23:29:55
Path: C:\Users\ozzak\Refresh, Created On: 05/31/2023 01:17:49
Path: C:\Users\ozzak\logs, Created On: 05/25/2023 15:37:53
Path: C:\Users\ozzak\util, Created On: 03/30/2023 01:45:27
Path: C:\Users\ozzak\xampp, Created On: 03/25/2023 16:10:06
Press Enter to exit
```

## Error Handling
- If an invalid directory path is entered, an error message will be displayed.
- If the entered number of folders is not an integer, it will default to `10`.

## Script Code
```powershell
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
```
