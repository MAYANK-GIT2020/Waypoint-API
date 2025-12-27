repadmin /replsum | Out-File -FilePath C:\Users\Administrator\Documents\healthcheckscript\replication-summary.txt
Out-File -FilePath C:\Users\Administrator\Documents\healthcheckscript\replication-summary.txt -Append -InputObject "---------------------C DRIVE STATUS---------------------" -Width 100
$allinfo = @()
$StartTime = (get-date).ToString('T')

$getForest = [system.directoryservices.activedirectory.Forest]::GetCurrentForest()
$DCServers = @($getForest.domains | ForEach-Object {$_.DomainControllers} | ForEach-Object {$_.Name} )
$DCServers

foreach ($DC in $DCServers){
$DC | Out-File -FilePath C:\Users\Administrator\Documents\healthcheckscript\replication-summary.txt -Append
$d = @(Invoke-Command -ComputerName $DC {Get-PSDrive | Where {$_.Free -gt 0}})| Out-File -FilePath C:\Users\Administrator\Documents\healthcheckscript\replication-summary.txt -Append
}

$EndTime =(get-date).ToString('T')

$fromaddress = "noreply@bhavnacorp.in"
$toaddress = "styagi@bhavnacorp.com,mtripathi@bhavnacorp.com,barton.ng@centrify.com"
#$toaddress = "mtripathi@bhavnacorp.com,styagi@bhavnacorp.com"
$Subject = "PAS ENV1 Replication Summary Result"
$bdy = "Hi,<br><br>"
$bdy += "Please find the attached Replication summary result for PAS Environment 1.<br>"
$bdy += "Trigger started at $StartTime and end time at: $EndTime.<br><br>"
$bdy += "Regards,<br>"
$bdy += "IT Team"
$filename = "C:\Users\Administrator\Documents\healthcheckscript\replication-summary.txt"
$attachment = "$filename"
$smtpserver = "192.168.22.30"
$message = new-object System.Net.Mail.MailMessage
$message.From = $fromaddress
$message.To.Add($toaddress)
$message.IsBodyHtml = $True
$message.Subject = $Subject
$attach = new-object Net.Mail.Attachment($attachment)
$message.Attachments.Add($attach)
$message.body = $bdy
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$smtp.Send($message)