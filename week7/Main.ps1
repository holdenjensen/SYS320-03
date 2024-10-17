. "C:\Users\champuser\SYS320-03\week7\Email.ps1"
. "C:\Users\champuser\SYS320-03\week7\Scheduler.ps1"
. "C:\Users\champuser\SYS320-03\week7\Configuration.ps1"
. "C:\Users\champuser\SYS320-03\localusermanagementmenu\Event-Logs.ps1"

$config = readConfiguration
$daysToEvaluate = $config.DaysToEvaluate
$failed = atRiskUsers $daysToEvaluate
SendAlertEmail ($failed | Format-Table | Out-String)
$executionTime = $config.ExecutionTime
ChooseTimeToRun $executionTime


