$explorerPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
$advancedPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$recentFilesPath = Join-Path $env:APPDATA "Microsoft\Windows\Recent"

# Don't show recent files and stop tracking them.
New-ItemProperty -Path $explorerPath -Name "ShowRecent" -PropertyType DWord -Value 0 -Force | Out-Null
Write-Host "✓ Recent files disabled" -ForegroundColor Green

New-ItemProperty -Path $explorerPath -Name "ShowFrequent" -PropertyType DWord -Value 0 -Force | Out-Null
Write-Host "✓ Frequent folders disabled" -ForegroundColor Green

Write-Host "✓ Document tracking disabled" -ForegroundColor Green
New-ItemProperty -Path $advancedPath -Name "Start_TrackDocs" -PropertyType DWord -Value 0 -Force | Out-Null

# Display hidden files, show extensions and open explorer in "This PC".
New-ItemProperty -Path $advancedPath -Name "Hidden" -PropertyType DWord -Value 1 -Force | Out-Null
Write-Host "✓ Hidden files visible" -ForegroundColor Green

New-ItemProperty -Path $advancedPath -Name "HideFileExt" -PropertyType DWord -Value 0 -Force | Out-Null
Write-Host "✓ File extensions visible" -ForegroundColor Green

New-ItemProperty -Path $advancedPath -Name "LaunchTo" -PropertyType DWord -Value 1 -Force | Out-Null
Write-Host "✓ Explorer opens in This PC" -ForegroundColor Green

# Clean recent files
if (Test-Path $recentFilesPath) {
    Get-ChildItem $recentFilesPath -Force | Remove-Item -Force -Recurse
    Write-Host "✓ Recent files history cleared" -ForegroundColor Green
}

Write-Host "Restarting Explorer..." -ForegroundColor Cyan
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer
Write-Host "✓ Explorer restarted" -ForegroundColor Green