function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.45/Courses.html

    $trs = $page.ParsedHtml.getElementsByTagName('tr')

    $FullTable = @()

    for($i=1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName('td')

        $Times = $tds[5].innerText.split('-')

        $FullTable += [pscustomobject]@{ `
            "Class Code" = $tds[0].innerText; `
            "Title"      = $tds[1].innerText; `
            "Days"       = $tds[4].innerText; `
            "Time Start" = $Times[0]; `
            "Time End"   = $Times[1]; ` 
            "Instructor" = $tds[6].innerText; `
            "Location"   = $tds[9].innerText; `
        }
       
    }
     return $FullTable
}

function daysTranslator($FullTable){
    for($i=0; $i -lt $FullTable.length; $i++){
        $Days = @()

        if($FullTable[$i].Days -ilike "M*")   { $Days += "Monday" }
        if($FullTable[$i].Days -ilike "*T[TWF]*")    { $Days += "Tuesday" }
        if($FullTable[$i].Days -ilike "T")    { $Days += "Tuesday" }
        if($FullTable[$i].Days -ilike "*W*")   { $Days += "Wednesday" }
        if($FullTable[$i].Days -ilike "*TH*")  { $Days += "Thursday" }
        if($FullTable[$i].Days -ilike "*F*")   { $Days += "Friday" }

        $FullTable[$i].Days = $Days

    }
    return $FullTable
}


