#Question 1 
Get-EventLog System -source Microsoft-Windows-Winlogon

#Question 2/3
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() 
for ($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].EventID -eq 7001) {$event="Logon"}
if($loginouts[$i].EventID -eq 7002) {$event="Logoff"}


$user = $loginouts[$i].ReplacementStrings[1]

$SID = New-Object System.Security.Principal.SecurityIdentifier($user)
$objUser = $SID.Translate([System.Security.Principal.NTAccount])
$user = $objUser.Value

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].EventID;
                                        "Event" = $event;
                                        "User" = $user;
                                        }
}
$loginoutsTable | Format-Table -AutoSize -wrap

#Question 4
function Get-LoginLogoffEvents($days){
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays($days)

$loginoutsTable = @() 
for ($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].EventID -eq 7001) {$event="Logon"}
if($loginouts[$i].EventID -eq 7002) {$event="Logoff"}


$user = $loginouts[$i].ReplacementStrings[1]

$SID = New-Object System.Security.Principal.SecurityIdentifier($user)
$objUser = $SID.Translate([System.Security.Principal.NTAccount])
$user = $objUser.Value

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].EventID;
                                        "Event" = $event;
                                        "User" = $user;
                                        }
}
}
Get-LoginLogoffEvents(14)
$loginoutsTable | Format-Table -AutoSize -wrap

$results = Get-LoginLogoffEvents -days 14

$results | Format-Table -AutoSize

#Question 5
# Function to obtain computer start and shut-down times
function Get-StartupShutdownEvents {
    param (
        [int]$days
    )

    # Get startup and shutdown records from Windows Events and save to a variable
    $events = Get-EventLog -LogName System -After (Get-Date).AddDays(-$days)

    $startupShutdownTable = @() # Empty array to fill customly

    for($i=0; $i -lt $events.Count; $i++) {

        $event = ""
        
        # Identifying Startup or Shutdown events
        if($events[$i].EventID -eq 6005) { 
            $event = "Startup" 
        } elseif($events[$i].EventID -eq 6006) { 
            $event = "Shutdown" 
        } else {
            continue # Skip any other events
        }

        # User is constant value "System"
        $user = "System"

        # Adding each new line (in form of a custom object) to our empty array
        $startupShutdownTable += [pscustomobject]@{
            "Time"  = $events[$i].TimeGenerated;
            "Id"    = $events[$i].EventID;
            "Event" = $event;
            "User"  = $user;
        }
    }

    # Return the results table
    return $startupShutdownTable
}

# Call the function with the parameter for number of days
$results = Get-StartupShutdownEvents -days 14

# Print the results to the screen
$results | Format-Table -AutoSize

#Question 6

