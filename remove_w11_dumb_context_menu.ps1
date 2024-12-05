# Save script state in case of error
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Switch to the classic context menu
Write-Host "Applying the classic context menu..." -ForegroundColor Cyan

# Registry path
$registryPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

try {
    # Create the registry key
    New-Item -Path $registryPath -Force | Out-Null

    # Ensure the default value is empty
    Set-ItemProperty -Path $registryPath -Name "(default)" -Value "" | Out-Null

    Write-Host "Registry key successfully created." -ForegroundColor Green

    # Restart Windows Explorer
    Write-Host "Restarting Windows Explorer..." -ForegroundColor Cyan
    Stop-Process -Name explorer -Force
    Start-Process explorer.exe

    Write-Host "The classic context menu has been applied." -ForegroundColor Green
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}