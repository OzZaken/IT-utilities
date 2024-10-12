# WinTempCleanUp.ps1

### Description

`WinTempCleanUp.ps1` is a PowerShell script designed to automate the cleanup of temporary files and directories on Windows machines. It removes files from system-defined temporary directories, ensuring that unused or unnecessary data is cleared. This script logs every action, providing insights into what has been deleted or skipped, and handles errors gracefully.

### Features:

- **Deletes Temporary Files**: Cleans up files in Windows temp directories, including `$env:TEMP`, `C:\Windows\Temp`, and more.
- **Log System**: Logs each action into a specified log file (`C:/temp/temp_cleanup.log`) with time-stamped entries.
- **File-in-use Detection**: Skips files currently in use and logs a warning.
- **Empty Directory Removal**: Removes empty directories once the files have been deleted.
- **Error Handling**: Catches and logs errors for files or directories that cannot be deleted.

---

### Usage

#### Running the Script:

1. Open PowerShell as an administrator.
2. Navigate to the directory where the script is saved.
3. Run the script by executing:
   ```powershell
   .\WinTempCleanUp.ps1
   ```

#### Log File:

- The log file is stored in `C:/temp/temp_cleanup.log` and contains:
  - **INFO**: General information about the directories being processed.
  - **SUCCESS**: Files or directories that were successfully deleted.
  - **WARN**: Files that were skipped (e.g., files in use, directories that aren't empty).
  - **ERROR**: Files or directories that could not be deleted due to an error.

---

### Log Example:

```
2024-10-04 12:45:23 [INFO] Cleaning directory: C:\Windows\Temp
2024-10-04 12:45:24 [SUCCESS] Deleted: C:\Windows\Temp\tempFile1.txt
2024-10-04 12:45:25 [WARN] Skipping file in use: C:\Windows\Temp\lockedFile.dll
2024-10-04 12:45:26 [SUCCESS] Deleted empty directory: C:\Windows\Temp\OldDir
2024-10-04 12:45:30 [ERROR] Failed to delete: C:\Windows\Temp\someFile.txt - Cannot delete file because it's open in another process
2024-10-04 12:45:40 [SUCCESS] Temporary file cleanup completed successfully.
```

---

### Script Requirements:

- PowerShell 5.0 or higher
- Windows OS

---

### Customization:

- **Log Directory**: The default log directory is `C:/temp`. You can change this by modifying the `$logDir` variable at the beginning of the script.
- **Additional Directories**: You can add or remove directories from the `$directories` array to customize which folders are cleaned.
  
---

### Notes:

- Run this script as an administrator to ensure all temporary files and directories can be accessed and deleted.
- Files currently in use will not be deleted, and this is logged with a warning.

---
