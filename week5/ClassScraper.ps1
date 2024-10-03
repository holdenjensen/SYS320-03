function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.45/courses.html

    $trs = $page.ParsedHtml.getElementsByTagName('tr')

    $FullTable = @()

    for($i=1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName('td')

        $Times = $tds[5].innerText.split('-')

        $FullTable += [pscustomobject]@{ `
            "Class Code" = $tds[0].innerHtml; `
            "Title"      = $tds[1].getElementsByTagName("a")[0].innerText; `
            "Days"       = $tds[4].innerHtml; `
            "Time Start" = $Times[0]; `
            "Time End"   = $Times[1]; ` 
            "Instructor" = $tds[6].getElementsByTagName("a")[0].innerText; `
            "Location"   = $tds[9].innerText; `
        }
    }

    return $FullTable
}


function daysTranslator($FullTable){
    for($i=0; $i -lt $FullTable.length; $i++){
        $Days = @()

        if($FullTable[$i].Days -ilike "*M*")   { $Days += "Monday" }
        if($FullTable[$i].Days -ilike "*T[!H]*")    { $Days += "Tuesday" }
        if($FullTable[$i].Days -ilike "*W*")   { $Days += "Wednesday" }
        if($FullTable[$i].Days -ilike "*TH*")  { $Days += "Thursday" }
        if($FullTable[$i].Days -ilike "*F*")   { $Days += "Friday" }

        $FullTable[$i].Days = $Days
    }

    return $FullTable
}


#Deliverable 1 
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | Where {$_."Instructor" -ilike "* Paligu" }

#Deliverable 2
$FullTable | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.Days -contains "Monday") } | Sort-Object "Time Start" | Select-Object "Time Start", "Time End", "Class Code"

#Deliverable 3
$ITSInstructors = $FullTable | Where-Object { 
    ($_. "Class Code" -like "SYS*") -or
    ($_. "Class Code" -like "NET*") -or
    ($_. "Class Code" -like "SEC*") -or
    ($_. "Class Code" -like "FOR*") -or
    ($_. "Class Code" -like "CSI*") -or
    ($_. "Class Code" -like "DAT*")
} | Select-Object "Instructor" -Unique | Sort-Object "Instructor"

$ITSInstructors

#Deliverable 4
$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } |
    Group-Object -Property "Instructor" | 
    Select-Object Count, Name | 
    Sort-Object Count -Descending
