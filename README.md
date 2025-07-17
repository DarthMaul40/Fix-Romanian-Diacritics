# Fix-Romanian-Diacritics
This PowerShell script is designed to be run from the context menu (right-click) on a folder containing subtitle files (.srt, .sub).
This script can scan files and replace incorrect Romanian diacritic characters with their proper Unicode equivalents.

## Why This Script Matters: Fixing Romanian Diacritics in Subtitle Files
Many Romanian subtitle files available online are encoded using legacy formats like ANSI (Windows-1252) or ISO-8859-1. These encodings often contain incorrect or legacy representations of Romanian diacritic characters such as ş, ţ, ã, or even substitute characters like þ, º, and ª. As a result:

✅ Characters appear garbled or incorrect in modern video players
❌ Proper Romanian spelling is broken, affecting readability and viewer experience
⚠ Subtitle rendering may fail entirely on players expecting Unicode input

## 🎯 Why UTF-8 Is Important
Modern video players — including VLC, Plex, Kodi, and most smart TVs — expect subtitle files to be encoded in UTF-8, preferably without a Byte Order Mark (BOM). UTF-8:
- Supports all Unicode characters cleanly and consistently
- Is backward-compatible with ASCII
- Is the de facto standard encoding for subtitles and web content

If the subtitles are not encoded in UTF-8:
- Characters like ș, ț, or ă may appear as Ã, þ, ¸, or ?
- The text may fail to render or cause playback errors on certain devices
- Accessibility and professionalism are compromised

# What This Script Does
This PowerShell script solves these issues by:
- Detecting and correcting encoding issues in .srt and .sub files
- Replacing incorrect or legacy characters with correct Romanian diacritics
- Saving clean UTF-8 encoded files without BOM, compatible with all major media players
- Preserving folder structure and renaming outputs with a .ro suffix
- Providing a detailed log of processed and corrected files

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

If you don't want to mess up with the Windows Explorer's context menu and registry, just fire up a Powershell windows and launch the script either by
- specifying the directory containing the subtitles:

  `.\Fix-RomanianDiacritics.ps1 -sourceDir "your_source_directory"`
- without any parameter. The script will open a dialog asking you to specify both source and destination directories:

  `.\Fix-RomanianDiacritics.ps1`
---

**Author:** Wilhelm Tomasi
