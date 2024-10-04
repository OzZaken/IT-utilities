# Prompt for Path
$Path = Read-Host "Enter the path to check for folders (default: C:\dev)"
if (-not $Path) {
    $Path = "C:\dev"
}

# Get last folder name in the path
$lastFolderName = Split-Path -Leaf $Path

# Default Log File Name using last folder and current date
$logFileNameDefault = "$lastFolderName`_CleanUp-$(Get-Date -Format 'yyyy-MM-dd').log"

# Prompt for LogPath
$LogPath = Read-Host "Enter the log file directory (default: C:\Logs)"
if (-not $LogPath) {
    $LogPath = "C:\Logs"
}

# Prompt for LogFileName with dynamic default
$LogFileName = Read-Host "Enter the log file name (default: $logFileNameDefault)"
if (-not $LogFileName) {
    $LogFileName = $logFileNameDefault
}

# Function to create a log entry
function Write-Log {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath "$LogPath\$LogFileName"
}

# Ensure the log directory exists
if (-Not (Test-Path -Path $LogPath)) {
    New-Item -Path $LogPath -ItemType Directory | Out-Null
    Write-Log "Log directory created at: $LogPath"
}

# Log file initialization
if (-Not (Test-Path -Path "$LogPath\$LogFileName")) {
    New-Item -Path "$LogPath\$LogFileName" -ItemType File | Out-Null
}

Write-Log "Script started for path: $Path"

try {
    # Get all subfolders
    $subfolders = Get-ChildItem -Path $Path -Recurse -Directory

    # Initialize logging lists
    $gitFolders = @()
    $deletedNodeModules = @()
    $nodeModulesNotDeleted = @()

    foreach ($folder in $subfolders) {
        # Skip checking inside node_modules to avoid subsubsub-folder issues
        if ($folder.FullName -like "*\node_modules*") {
            continue
        }

        # Check for .git folder
        if (Test-Path -Path "$($folder.FullName)\.git") {
            $gitFolders += $folder.FullName
        }

        # Check for node_modules folder
        if (Test-Path -Path "$($folder.FullName)\node_modules") {
            $nodeModulesPath = "$($folder.FullName)\node_modules"
            if ((Get-ChildItem -Path $nodeModulesPath).Count -eq 0) {
                # Delete empty node_modules folder
                Remove-Item -Path $nodeModulesPath -Recurse -Force
                Write-Log "Deleted empty node_modules folder: $nodeModulesPath"
                $deletedNodeModules += $nodeModulesPath
            } else {
                # Show the folder path in Cyan and prompt user for action
                Write-Host "Found non-empty node_modules folder: " -ForegroundColor Cyan -NoNewline
                Write-Host $nodeModulesPath -ForegroundColor Cyan
                
                # Prompt user to delete the non-empty node_modules folder
                $response = Read-Host "Do you want to delete it? (Y/N, default is delete if blank)"
                if (-not $response -or $response -eq 'Y' -or $response -eq 'y') {
                    # Delete non-empty node_modules folder
                    Remove-Item -Path $nodeModulesPath -Recurse -Force
                    Write-Log "Deleted non-empty node_modules folder: $nodeModulesPath"
                    $deletedNodeModules += $nodeModulesPath
                } else {
                    # Do not delete the folder
                    Write-Log "Did not delete node_modules folder: $nodeModulesPath"
                    $nodeModulesNotDeleted += $nodeModulesPath
                }
            }
        }
    }

    # Logging results in list format
    if ($gitFolders.Count -gt 0) {
        Write-Log "Git folders found:"
        foreach ($gitFolder in $gitFolders) {
            Write-Log "  - $gitFolder"
        }
    } else {
        Write-Log "No Git folders found."
    }

    if ($deletedNodeModules.Count -gt 0) {
        Write-Log "Deleted node_modules folders:"
        foreach ($deleted in $deletedNodeModules) {
            Write-Log "  - $deleted"
        }
    } else {
        Write-Log "No node_modules folders deleted."
    }

    if ($nodeModulesNotDeleted.Count -gt 0) {
        Write-Log "Node_modules folders not deleted:"
        foreach ($notDeleted in $nodeModulesNotDeleted) {
            Write-Log "  - $notDeleted"
        }
    }

} catch {
    Write-Log "An error occurred: $_"
} finally {
    Write-Log "Script completed."
    Write-Host "Script completed successfully! Log file is located at: $LogPath\$LogFileName" -ForegroundColor Green
    Write-Log "Script execution finished successfully."
}
