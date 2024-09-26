
function Get-FilteredIPs {
    param (
        [string]$Page,
        [int]$HTTPCode,
        [string]$Browser
    )

    $regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"

    $logs = Get-Content "C:\xampp\apache\logs\access.log"

    $filteredLogs = $logs | Where-Object {
        ($_ -match $Page) -and ($_ -match $HTTPCode) -and ($_ -match $Browser)
    }

    $filteredLogs
    if ($filteredLogs) {
    $ipsUnorganized = $regex.Matches($filteredLogs)
    } else {
        Write-Host "No matching logs found."
    }

    $ips = @()
    for ($i = 0; $i -lt $ipsUnorganized.Count; $i++) {
        $ips += [pscustomobject]@{ IP = $ipsUnorganized[$i].Value }
    }

    $ipCounts = $ips | Group-Object IP

    return $ipCounts | Select-Object Count, Name
}

