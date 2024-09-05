$files = Get-ChildItem -Recurse -File | Where-Object { $_.Extension -eq '.csv' }
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File | Select-Object Name, LastWriteTime, Length
