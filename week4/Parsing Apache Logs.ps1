function ApacheLogs {
    $logsNotFormatted = Get-Content "C:\xampp\apache\logs\access.log"
    $tableRecords = @()

    for ($i = 0; $i -lt $logsNotFormatted.Count; $i++) {

        $words = $logsNotFormatted[$i] -split " "

        $tableRecords += [pscustomobject]@{
            "IP"        = $words[0] 
            "Time"      = "$($words[3].Trim('[')) $($words[4].Trim(']'))"  
            "Method"    = $words[5].Trim('"') 
            "Page"      = $words[6]  
            "Protocol"  = $words[7].Trim('"')  
            "Response"  = $words[8]  
            "Referrer"  = $words[10].Trim('"')  
            "Client"    = if ($words.Count -gt 11) { $words[11].Trim('"') } else { "N/A" } 
        }
    }

    return $tableRecords | Where-Object { $_.IP -like "10.*" }
}

$tableRecords = ApacheLogs

$tableRecords | Format-Table -AutoSize -Wrap
