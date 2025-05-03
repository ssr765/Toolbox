$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$keys = @("AppsUseLightTheme", "SystemUsesLightTheme")

function Choose-Mode {
    param([ref]$value, [ref]$choice)
    $input = Read-Host "Choose mode: 'light' or 'dark'"
    
    switch ($input.ToLower()) {
        "light" {
            $value.Value = 1
            $choice.Value = $input
        }
        "dark" {
            $value.Value = 0
            $choice.Value = $input
        }
        default {
            Write-Host "Invalid choice. Please enter 'light' or 'dark'." -ForegroundColor Red
            Choose-Mode -value $value -choice $choice
        }
    }
}

$value = 0
$choice = ""

Choose-Mode -value ([ref]$value) -choice ([ref]$choice)

foreach ($key in $keys) {
    Set-ItemProperty -Path $path -Name $key -Value $value | Out-Null
}

# Restart Windows Explorer
Write-Host "Restarting Windows Explorer..." -ForegroundColor Cyan
Stop-Process -Name explorer -Force
Start-Process explorer.exe

Write-Host "Theme mode set to '$($choice)' successfully!" -ForegroundColor Green
