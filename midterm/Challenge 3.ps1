function Filter-LogsByIndicators {
    param (
        [array]$logs,        
        [array]$indicators  
    )

    $filteredLogs = $logs | Where-Object {
        $log = $_
        $matchFound = $false
        foreach ($indicator in $indicators) {
            if ($log.Page -like "*$indicator*") {
                $matchFound = $true
                break
            }
        }
        return $matchFound
    }

    if ($filteredLogs.Count -gt 0) {
        $filteredLogs | Format-Table -Property IP, Time, Method, Page, Protocol, Response, Referrer -AutoSize
    } else {
        Write-Host "No logs matched the given indicators."
    }
}

$logs = @(
    [PSCustomObject]@{IP = "10.0.17.5"; Time = "04/Mar/2024:14:45:31 CET"; Method = "GET"; Page = "/index.php?/bin/sh+simplebackdoor.bash"; Protocol = "HTTP/1.1"; Response = "200"; Referrer = '"-"'},
    [PSCustomObject]@{IP = "10.0.17.5"; Time = "04/Mar/2024:14:46:03 CET"; Method = "GET"; Page = "/index.php?a=1+OR+1=1--"; Protocol = "HTTP/1.1"; Response = "200"; Referrer = '"-"'},
    [PSCustomObject]@{IP = "10.0.17.5"; Time = "04/Mar/2024:14:45:01 CET"; Method = "GET"; Page = "/index.php?cmd=/bin/bash+myscript.bash"; Protocol = "HTTP/1.1"; Response = "200"; Referrer = '"-"'},
    [PSCustomObject]@{IP = "10.0.17.5"; Time = "04/Mar/2024:14:43:50 CET"; Method = "GET"; Page = "/index.php?cmd=etc/passwd"; Protocol = "HTTP/1.1"; Response = "200"; Referrer = '"-"'},
    [PSCustomObject]@{IP = "10.0.17.5"; Time = "04/Mar/2024:14:44:19 CET"; Method = "GET"; Page = "/index.php?cmd=cat+etc/passwd"; Protocol = "HTTP/1.1"; Response = "200"; Referrer = '"-"'},
    [PSCustomObject]@{IP = "10.0.17.6"; Time = "04/Mar/2024:14:49:44 CET"; Method = "GET"; Page = "/index.html?command=/bin/bash/+reverseshell.bash"; Protocol = "HTTP/1.1"; Response = "200"; Referrer = '"-"'},
    [PSCustomObject]@{IP = "10.0.17.6"; Time = "04/Mar/2024:14:50:24 CET"; Method = "GET"; Page = "/index.html?command=/bin/bash/+midtermcheatdetector.bash"; Protocol = "HTTP/1.1"; Response = "200"; Referrer = '"-"' }
)

$indicators = @("passwd", "OR 1=1", "/bin/sh", "/bin/bash", "simplebackdoor", "reverseshell")

Filter-LogsByIndicators -logs $logs -indicators $indicators
