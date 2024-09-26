#Deliverable 2
Get-Content C:\xampp\apache\logs\access.log

#Deliverable 3
Get-Content C:\xampp\apache\logs\access.log -Last 5

#Deliverable 4
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 '

#Deliverable 5
Get-Content C:\xampp\apache\logs\access.log | Select-String '200' -NotMatch

#Deliverable 6
$A = Get-Content C:\xampp\apache\logs\*.log | Select-String 'error'
$A[-5..-1]

#Deliverable 7
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String 404
$regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"
$ipsUnorganized = $regex.Matches($notfounds)
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
$ips += [pscustomobject]@{ IP = $ipsUnorganized[$i].Value }
}
$ips | Where-Object { $_.IP -ilike "10.*" }

#Deliverable 8
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object IP
$counts | Select-Object Count, Name
