# Fix-Romanian-Diacritics
This PowerShell script is designed to be run from the context menu (right-click) on a folder containing subtitle files (.srt, .sub).
This script can scan files and replace incorrect Romanian diacritic characters with their proper Unicode equivalents.

## Features

- Detects and fixes common Romanian diacritic issues
- Batch processing of multiple files
- Integration with Windows Explorer context menu
- Supports .srt and .sub files
- Handles multiple encodings robustly
- Preserves folder structure
- Enforces UTF-8 without BOM
- Uses case-sensitive character replacements
- Logs all changes
- Works with right-click context menu
- Adds .ro only when needed

## Installation

1. Copy all `.ps1` files to a directory of your choice (e.g., `C:\Scripts\Fix-RomanianDiacritics`).
2. Edit the `$scriptPath` variable in the script (below the comment "Define the path to the script that will be executed from the context menu") to match your chosen directory.
3. Save the script after editing.
4. Right-click `Install-ContextMenu.ps1` and select **Run with PowerShell** to add the context menu entry. Accept the prompt to run the script as administrator (required for registry changes).


## Uninstallation

To remove the context menu entry, right-click `Uninstall-ContextMenu.ps1` and select **Run with PowerShell**. Accept the prompt to run the script as administrator (required for registry changes).

## Usage

1. Right-click the folder containing your subtitle files.
2. Select **Fix Romanian Diacritics** from the context menu.
3. Choose the destination folder for the corrected files when prompted.
4. Access your modified files in the destination folder.

---

**Author:** Wilhelm Tomasi
