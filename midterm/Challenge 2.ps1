function Get-ApacheLog {
    param (
        [string]$logFilePath
    )

    $logData = Get-Content -Path $logFilePath

    $logPattern = '^(?<IP>\d{1,3}(?:\.\d{1,3}){3}) - - \[(?<Time>[^\]]+)\] "(?<Method>\w+) (?<Page>[^\s]+) (?<Protocol>[^"]+)" (?<Response>\d{3})'

    $logEntries = @()

    foreach ($line in $logData) {
        if ($line -match $logPattern) {
            $timeCET = $matches['Time'] -replace " -0500", " CET"

            $datePart = $timeCET.Substring(0, 11) -replace ":", "/"
            $timePart = $timeCET.Substring(12)

            $timeFormatted = "$datePart`:$timePart"

            $logEntry = [PSCustomObject]@{
                IP        = $matches['IP']
                Time      = $timeFormatted
                Method    = $matches['Method']
                Page      = $matches['Page']
                Protocol  = $matches['Protocol']
                Response  = $matches['Response']
                Referrer  = '"-"'
            }

            Write-Host "Matched log entry: $($logEntry.IP), $($logEntry.Time), $($logEntry.Method), $($logEntry.Page), $($logEntry.Protocol), $($logEntry.Response), $($logEntry.Referrer)"

            $logEntries += $logEntry
        } else {
            Write-Host "No match for line: $line"
        }
    }

    if ($logEntries.Count -gt 0) {
        Write-Host "Displaying log entries..."
        $logEntries | Format-Table -Property IP, Time, Method, Page, Protocol, Response, Referrer -AutoSize
    } else {
        Write-Host "No matching log entries were found."
    }
}

Get-ApacheLog -logFilePath "C:\Users\champuser\Downloads\Midterm\access.log"
