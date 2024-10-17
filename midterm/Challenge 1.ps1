function Get-IOC {
    $url = "http://10.0.17.5/IOC.html"

    try {
        $response = Invoke-WebRequest -Uri $url -ErrorAction Stop
    }
    catch {
        Write-Error "Failed to retrieve IOC page: $_"
        return
    }

    $content = $response.Content
    $iocs = @()

    $iocPatterns = @{
        'etc/passwd' = 'Access attempt to Linux users list'
        'cmd=' = 'Windows reverse shell attempt'
        '/bin/bash' = 'Linux shell attempt'
        '/bin/sh' = 'Linux shell attempt'
        '1=1#' = 'SQL injection attempt'
        '1=1--' = 'SQL injection attempt'
    }

    foreach ($line in $content -split "`n") {
        foreach ($pattern in $iocPatterns.Keys) {
            if ($line -match $pattern) {
                $iocs += [PSCustomObject]@{
                    Pattern      = $pattern
                    Explanation  = $iocPatterns[$pattern]
                }
            }
        }
    }

    $iocs | Format-Table -AutoSize
}

Get-IOC
