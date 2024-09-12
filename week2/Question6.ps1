. (Join-Path $PSScriptRoot 'Questions1-5.ps1')

clear

$loginoutsTable = Get-LoginLogoffEvents -days 15
$loginoutsTable

$shutdownsTable = Get-StartupShutdownEvents -days 25
$shutdownsTable