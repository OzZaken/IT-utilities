# ReposDirCleanUp.ps1

### Description

`RepoDirCleanUp.ps1` is a PowerShell script designed to identify Git repositories and `node_modules` folders within a specified directory. The script provides options to clean up `node_modules` folders, particularly the non-empty ones, while logging the actions performed. This tool helps to clean up unnecessary files while keeping the structure of Git projects intact.

### Features:
- **Identify Git Repositories**: Scans a directory recursively and logs all Git repositories found.
- **Clean Up `node_modules`**: Identifies `node_modules` directories, deletes empty ones automatically, and prompts the user to delete non-empty ones.
- **Customizable Logging**: Logs all actions into a log file whose name and location can be customized.
- **Interactive Prompts**: Asks the user whether to delete non-empty `node_modules` directories, with the default action being deletion unless the user specifies otherwise.

---

### Usage

#### Running the Script:

1. Open PowerShell and navigate to the directory where the script is located.
2. Run the script by executing the following command:
   ```powershell
   .\RepoDirCleanUp.ps1```

   
