
<#
.SYNOPSIS
    Uninstalls the right-click context menu item for fixing Romanian diacritics in subtitle files.
.DESCRIPTION
    This PowerShell script removes the context menu item that was previously registered to allow users to fix Romanian diacritics in subtitle files (.srt) by right-clicking on a folder. It is designed to be run with administrative privileges to ensure it can modify the Windows Registry.
    Written by: Wilhelm Tomasi on 14 July 2025
#>

# Ensure the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Restarting script as administrator..." -ForegroundColor Yellow
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
    $psi.Verb = "runas"
    try {
        [System.Diagnostics.Process]::Start($psi) | Out-Null
    } catch {
        Write-Host "Failed to restart as administrator." -ForegroundColor Red
    }
    exit
}

# Name of the custom menu
$menuName = "Fix Romanian Diacritics"
$regPath = "HKCU:\Software\Classes\Directory\shell\$menuName"

# Check if it exists and remove it
if (Test-Path $regPath) {
    Remove-Item -Path $regPath -Recurse -Force
    Write-Host "Right-click context menu '$menuName' removed successfully." -ForegroundColor Green
} else {
    Write-Host "Context menu '$menuName' was not found." -ForegroundColor Yellow
}

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# End of script
exit 0