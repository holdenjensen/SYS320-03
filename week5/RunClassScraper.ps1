. (Join-Path "C:\Users\champuser\SYS320-03\week5" ClassScraper.ps1)
. (Join-Path $PSScriptRoot daysTranslator.ps1)

$FullTable = gatherClasses

$FullTable = daysTranslator $FullTable

#$FullTable

#Deliverable 6.1 
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | Where {$_."Instructor" -ilike "* Paligu" }

#Deliverable 2
#$FullTable | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.Days -contains "Monday") } | Sort-Object "Time Start" | Select-Object "Time Start", "Time End", "Class Code", Location

<#Deliverable 3
$ITSInstructors = $FullTable | Where-Object { 
    ($_. "Class Code" -like "SYS*") -or
    ($_. "Class Code" -like "NET*") -or
    ($_. "Class Code" -like "SEC*") -or
    ($_. "Class Code" -like "FOR*") -or
    ($_. "Class Code" -like "CSI*") -or
    ($_. "Class Code" -like "DAT*")
} | Select-Object "Instructor" -Unique | Sort-Object "Instructor"

#$ITSInstructors

#Deliverable 4
$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } |
    Group-Object -Property "Instructor" | 
    Select-Object Count, Name | 
    Sort-Object Count -Descending
    #>