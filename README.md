# Fix-Romanian-Diacritics
This PowerShell script is designed to be run from the context menu (right-click) on a folder containing subtitle files (.srt, .sub).
PowerShell scripts for automatically correcting Romanian diacritics in text files. These scripts scan files and replace incorrect or missing Romanian diacritic characters with their proper Unicode equivalents.

## Features

- Detects and fixes common Romanian diacritic issues
- Batch processing of multiple files
- Integration with Windows Explorer context menu

## Installation

1. Copy all `.ps1` files to a directory of your choice (e.g., `C:\Scripts\Fix-RomanianDiacritics`).
2. Edit the `$scriptPath` variable in the script (below the comment "Define the path to the script that will be executed from the context menu") to match your chosen directory.
3. Save the script after editing.
4. Right-click `Install-ContextMenu.ps1` and select **Run with PowerShell** to add the context menu entry.

## Uninstallation

To remove the context menu entry, right-click `Uninstall-ContextMenu.ps1` and select **Run with PowerShell**.

## Usage

1. Right-click the folder containing your subtitle files.
2. Select **Fix Romanian Diacritics** from the context menu.
3. Accept the prompt to run the script as administrator (required for registry changes).
4. Choose the destination folder for the corrected files when prompted.
5. Access your modified files in the destination folder.

---

**Author:** Wilhelm Tomasi
