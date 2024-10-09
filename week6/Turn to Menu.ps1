. .\ApacheLogs1.ps1
. .\UserManagement.ps1
. .\ProcessManagement.ps1

function Display-Menu {
    Clear-Host
    Write-Host "Menu Options:"
    Write-Host "1. Display last 10 apache logs"
    Write-Host "2. Display last 10 failed logins for all users"
    Write-Host "3. Display at risk users"
    Write-Host "4. Start Chrome web browser and navigate to champlain.edu (if not already running)"
    Write-Host "5. Exit"
}

function Get-UserSelection {
    param (
        [string]$Prompt = "Please select an option (1-5): "
    )
    $validInput = $false
    while (-not $validInput) {
        $selection = Read-Host -Prompt $Prompt
        if ($selection -match '^[1-5]$') {
            $validInput = $true
        }
        else {
            Write-Host "Invalid selection. Please enter a number between 1 and 5." -ForegroundColor Red
        }
    }
    return [int]$selection
}

do {
    Display-Menu
    $userChoice = Get-UserSelection

    switch ($userChoice) {
        1 {
            Write-Host "Displaying the last 10 Apache logs..."
            ApacheLogs1
        }
        2 {
            Write-Host "Displaying the last 10 failed logins for all users..."
            getFailedLogins
        }
        3 {
            Write-Host "Displaying at risk users..."
            atRiskUsers
        }
        4 {
            Write-Host "Starting Chrome web browser and navigating to champlain.edu if it's not already running..."
            startChromeIfNotRunning
        }
        5 {
            Write-Host "Exiting the program. Goodbye!"
        }
    }

    if ($userChoice -ne 5) {
        Write-Host "Press Enter to continue..." -ForegroundColor Yellow
        [void][System.Console]::ReadLine()
    }

} while ($userChoice -ne 5)
