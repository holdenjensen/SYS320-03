function getFailedLogins {
    Write-Host "Fetching the last 10 failed login attempts..."
    $logs = Get-Content /var/log/auth.log | Select-String -Pattern "Failed password" -Tail 10
    $logs | ForEach-Object { Write-Host $_ }
}

function atRiskUsers {
    Write-Host "Checking for at-risk users..."
    $failedLogins = Get-Content /var/log/auth.log | Select-String -Pattern "Failed password"
    $failedLoginCounts = @{}
    foreach ($log in $failedLogins) {
        $user = ($log -split ' ')[-1]
        if ($failedLoginCounts.ContainsKey($user)) {
            $failedLoginCounts[$user]++
        } else {
            $failedLoginCounts[$user] = 1
        }
    }
    $atRiskUsers = $failedLoginCounts.GetEnumerator() | Where-Object { $_.Value -gt 5 }
    if ($atRiskUsers.Count -eq 0) {
        Write-Host "No users are currently at risk."
    } else {
        Write-Host "At risk users:"
        $atRiskUsers | ForEach-Object { Write-Host "$($_.Key): $($_.Value) failed login attempts" }
    }
}
