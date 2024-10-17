function SendAlertEmail($Body) {
    $From = "holden.jensen@mymail.champlain.edu"
    $To = "holden.jensen@mymail.champlain.edu"
    $Subject = "Suspicious Activity"
 
    $Password = "apxblsotrpbbcdmf" | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password
    
    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
    -port 587 -UseSsl -Credential $Credential
}

# Example usage of the function
SendAlertEmail "Body of email"
