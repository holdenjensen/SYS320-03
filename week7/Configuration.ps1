function readConfiguration {
    $filePath = "C:\Users\champuser\Documents\configuration.txt"
    if (Test-Path -Path $filePath) {
        $configContent = Get-Content -Path $filePath
        $config = [PSCustomObject]@{
            "DaysToEvaluate" = $configContent[0]
            "ExecutionTime"  = $configContent[1]
        }
        $config
    } else {
        Write-Host "Configuration file not found."
    }
}

function changeConfiguration {
    $filePath = "C:\Users\champuser\Documents\configuration.txt"
    $newDays = Read-Host "Enter number of days for logs to evaluate (digits only)"
    
    while (-not ($newDays -match '^\d+$')) {
        $newDays = Read-Host "Invalid input. Please enter a valid number of days (digits only)"
    }
    
    $newTime = Read-Host "Enter execution time (format: HH:MM AM/PM)"
    
    while (-not ($newTime -match '^\d{1,2}:\d{2} [APap][Mm]$')) {
        $newTime = Read-Host "Invalid input. Please enter a valid execution time (format: HH:MM AM/PM)"
    }
    
    $newConfig = @("$newDays", "$newTime")
    $newConfig | Set-Content -Path $filePath
    Write-Host "Configuration updated successfully."
}

function configurationMenu {
    do {
        Write-Host "1. Show configuration"
        Write-Host "2. Change configuration"
        Write-Host "3. Exit"
        
        $choice = Read-Host "Enter your choice (1, 2, or 3)"
        
        switch ($choice) {
            1 { readConfiguration }
            2 { changeConfiguration }
            3 { Write-Host "Exiting..."; break }
            default { Write-Host "Invalid choice. Please enter 1, 2, or 3." }
        }
    } while ($choice -ne 3)
}

configurationMenu
