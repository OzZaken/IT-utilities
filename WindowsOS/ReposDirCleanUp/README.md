# RepoDirCleanUp.ps1

### Description

`RepoDirCleanUp.ps1` is a PowerShell script designed to assist in cleaning up directories containing Git repositories and `node_modules` folders. The script identifies Git folders, cleans up `node_modules` folders, and logs the operations into a specified log file. It's an ideal tool for keeping your development directories clean and organized.

### Features:

- **Identify Git Repositories**: Scans a directory recursively for Git repositories and logs the paths.
- **Clean Up `node_modules`**: Automatically deletes empty `node_modules` directories and provides an interactive prompt for non-empty ones.
- **Customizable Log File**: Allows the user to specify the log file's name and directory. The default log file name is based on the last folder in the path and includes a timestamp.
- **Interactive Prompts**: Provides the user with options to delete or keep non-empty `node_modules` folders, with the default being deletion unless explicitly skipped.

---

### Usage

#### Running the Script:

1. Open PowerShell and navigate to the directory where the script is located.
2. Run the script by executing:
   ```powershell
   .\RepoDirCleanUp.ps1
   ```

#### Input Prompts:

- **Directory to Scan**: When prompted, enter the path where the script should look for Git repositories and `node_modules` directories. If left blank, the default directory (`D:\dev`) will be used.
- **Log File Directory**: Enter the path where you want the log file to be stored. If left blank, the default path (`C:\Logs`) will be used.
- **Log File Name**: Enter a custom log file name, or leave it blank to use the default name. The default name format is `<lastFolder>_GitClone_CleanUp-<date>.log`, where `<lastFolder>` is the name of the last folder in the provided path and `<date>` is the current date.

---

### Log File:

The script generates a log file that contains:
- The start time of the script.
- A list of all Git repositories found.
- A record of `node_modules` folders deleted or skipped.
- Any errors encountered during the run.
- A completion message at the end of the script execution.

---

### Example:

1. **User Input**:
   ```
   Enter the path to check for folders (default: D:\dev): C:\Projects
   Enter the log file directory (default: C:\Logs): C:\ProjectLogs
   Enter the log file name (default: Projects_GitClone_CleanUp-2024-10-04.log): CleanupLog.txt
   ```

2. **Log Output**:
   ```
   2024-10-04 12:34:56 - Script started for path: C:\Projects
   2024-10-04 12:35:10 - Git folders found:
       - C:\Projects\project1\.git
       - C:\Projects\project2\.git
   2024-10-04 12:35:30 - Deleted node_modules folder: C:\Projects\project1\node_modules
   2024-10-04 12:36:00 - Did not delete node_modules folder: C:\Projects\project2\node_modules
   2024-10-04 12:36:10 - Script completed successfully! Log file is located at: C:\ProjectLogs\CleanupLog.txt
   ```

---

### Script Requirements:

- PowerShell 5.0 or higher
- Windows OS

---

### Customization:

You can modify the default paths or customize the script further to fit your project needs. For example, the default path to scan or the structure of the log messages can easily be adjusted by modifying the respective parts of the script.

---
