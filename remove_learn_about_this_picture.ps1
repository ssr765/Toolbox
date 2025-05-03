$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$name = "{2CC5CA98-6485-489A-920E-B3E88A6CCCE3}"
$value = 1

Set-ItemProperty -Path $path -Name $name -Value $value -Type DWord -Force

Write-Host "Refresh your desktop to remove the shortcut." -ForegroundColor Green
