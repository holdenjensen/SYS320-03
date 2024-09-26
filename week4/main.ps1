
. ./Apache-Logs.ps1

$page = "index.html" 
$httpCode = 404       
$browser = "Firefox"  

$ipResults = Get-FilteredIPs -Page $page -HTTPCode $httpCode -Browser $browser

$ipResults
