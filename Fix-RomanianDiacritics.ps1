<#
.SYNOPSIS
    Fixes Romanian diacritics in subtitle files (.srt, .sub) by replacing incorrect characters with the correct ones.
.DESCRIPTION
    This PowerShell script is designed to be run from the context menu (right-click) on a folder containing subtitle files (.srt).
    It will prompt the user to select a destination folder where the corrected files will be saved. The script reads each subtitle file, replaces incorrect Romanian diacritics with the correct ones, and saves the modified files in the specified destination folder.
    The script also generates a log file detailing which files were processed and whether any changes were made.
    Written by: Wilhelm Tomasi on 14 July 2025
#>
param (
    [string]$sourceDir  # Provided automatically by right-click (%V)
)
Add-Type -AssemblyName System.Windows.Forms

function Select-Folder($description) {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $description
    $dialog.ShowNewFolderButton = $true
    if ($dialog.ShowDialog() -eq 'OK') {
        return $dialog.SelectedPath
    } else {
        Write-Host "Cancelled by user." -ForegroundColor Yellow
        Read-Host -Prompt "Press Enter to finish the script and close this window."
        exit
    }
}

# Ensure the script is run with UTF-8 encoding
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# If somehow no sourceDir was passed (failsafe)
if (-not $sourceDir -or -not (Test-Path $sourceDir)) {
    Write-Error "No valid source directory passed. This script must be run from right-click context menu."
    exit 1
}

# Ask user for destination folder
$destinationDir = Select-Folder -description "Select the destination folder to save corrected files"


if (-not $destinationDir) {
    Write-Host "No destination folder selected. Exiting script." -ForegroundColor Yellow
    exit 0
}   

# Start transcript for logging
$destinationDir = [System.IO.Path]::GetFullPath($destinationDir)
Start-Transcript -Path (Join-Path $destinationDir "FixTranscript.txt")

# Setup log
$logPath = Join-Path $destinationDir "FixLog.txt"
"Fix Romanian Diacritics Log - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logPath -Encoding UTF8

# Case-sensitive replacement table
$replacements = New-Object 'System.Collections.Hashtable' ([System.StringComparer]::Ordinal)
$replacements['þ'] = [char]0x021B  # ț
$replacements['Þ'] = [char]0x021A  # Ț
$replacements['º'] = [char]0x0219  # ș
$replacements['ª'] = [char]0x0218  # Ș
$replacements['ş'] = [char]0x0219  # ș
$replacements['Ş'] = [char]0x0218  # Ș
$replacements['ţ'] = [char]0x021B  # ț
$replacements['Ţ'] = [char]0x021A  # Ț
$replacements['ã'] = [char]0x0103  # ă
$replacements['Ã'] = [char]0x0102  # Ă
$replacements['â'] = [char]0x00E2  # â
$replacements['Â'] = [char]0x00C2  # Â
$replacements['î'] = [char]0x00EE  # î
$replacements['Î'] = [char]0x00CE  # Î

# Encoding
$encoding1252 = [System.Text.Encoding]::GetEncoding(1252)
$encodingUtf8 = [System.Text.UTF8Encoding]::new($false)

# Process all .srt files in the selected source folder
Get-ChildItem -Path $sourceDir -Recurse -Include "*.srt","*.sub" | ForEach-Object {
    $inputPath = $_.FullName
    $relativePath = $inputPath.Substring($sourceDir.Length).TrimStart('\')
    $outputPath = Join-Path $destinationDir $relativePath

    # Ensure output subfolders exist
    $outputDir = Split-Path $outputPath -Parent
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }

    # Read with legacy encoding
    $bytes = [System.IO.File]::ReadAllBytes($inputPath)
    $text = $encoding1252.GetString($bytes)
    $originalText = $text

    # Replace invalid diacritics
    foreach ($key in $replacements.Keys) {
        $text = [regex]::Replace($text, [regex]::Escape($key), [string]$replacements[$key], [System.Text.RegularExpressions.RegexOptions]::None)
    }

    # Save as UTF-8 (no BOM)
    [System.IO.File]::WriteAllText($outputPath, $text, $encodingUtf8)

    # Log changes
    if ($text -ne $originalText) {
        "✔ Fixed: $relativePath" | Out-File -FilePath $logPath -Append -Encoding UTF8
    } else {
        "– Unchanged: $relativePath" | Out-File -FilePath $logPath -Append -Encoding UTF8
    }

    Write-Host "Processed: $relativePath"
}

Write-Host "Done. Log saved to: $logPath" -ForegroundColor Green
Stop-Transcript
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# End of script
exit 0
