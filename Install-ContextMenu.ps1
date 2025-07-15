<#
.SYNOPSIS
    Registers a right-click context menu item for fixing Romanian diacritics in subtitle files.
.DESCRIPTION
    This PowerShell script registers a context menu item that allows users to fix Romanian diacritics in subtitle files (.srt) by right-clicking on a folder. The script will execute another PowerShell script that performs the actual diacritic fixing.
    The script is designed to be run with administrative privileges to ensure it can modify the Windows Registry.
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

# Define the path to the script that will be executed from the context menu
$scriptPath = "D:\Work\Powershell\Fix-RomanianDiacritics\Fix-RomanianDiacritics.ps1"  # update this path

# Check if the script file exists
if (-not (Test-Path $scriptPath)) {
    Write-Host "Script file not found at $scriptPath" -ForegroundColor Red
    exit 1
}
$menuName = "Fix Romanian Diacritics"
$command = "powershell.exe -ExecutionPolicy Bypass -File `"$scriptPath`" `"%V`""

# Register the context menu item in the Windows Registry
$regPath = "HKCU:\Software\Classes\Directory\shell\$menuName"
$cmdPath = "$regPath\command"

New-Item -Path $regPath -Force | Out-Null
Set-ItemProperty -Path $regPath -Name "Icon" -Value "powershell.exe"
New-Item -Path $cmdPath -Force | Out-Null
Set-ItemProperty -Path $cmdPath -Name "(default)" -Value $command

Write-Host "Right-click context menu registered. Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# End of script
exit 0