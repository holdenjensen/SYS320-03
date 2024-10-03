. (Join-Path "C:\Users\champuser\SYS320-03\week5" ClassScraper.ps1)

$classes = gatherClasses

$classes | Format-Table -AutoSize
