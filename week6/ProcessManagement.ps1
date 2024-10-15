function startChromeIfNotRunning {
    $chromeProcess = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
    if (-not $chromeProcess) {
        Start-Process "chrome" "https://www.champlain.edu"
        Write-Host "Chrome started and navigating to champlain.edu."
    } else {
        Write-Host "Chrome is already running."
    }
}
