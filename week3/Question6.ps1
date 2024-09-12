. (Join-Path $PSScriptRoot 'Questions1-5.ps1')

clear

$loginoutsTable = Get-LoginLogoffEvents(15)
$loginoutsTable

$shutdownsTable = Get-StartupShutdownEvents -days 25
$shutdownsTable