]########Author : Mayank triapthi ######### Creation Date : 29/Oct/2021 ########## Purpose: Intended to check any vulnerabilities##########

try {
$comp = hostname

Get-Childitem –Path C:\ -Include *ua-parser-js* -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath C:\report_$($comp)_$($DateVal).txt  -Append -Encoding ASCII -Width 50
Get-Childitem –Path C:\ -Include *sdd.dll* -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath C:\report_$($comp)_$($DateVal).txt -Append -Encoding ASCII -Width 50
Get-Childitem –Path C:\ -Include *create.dll* -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath C:\report_$($comp)_$($DateVal).txt -Append -Encoding ASCII -Width 50
Get-Childitem –Path C:\ -Include *preinstall.bat* -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath C:\report_$($comp)_$($DateVal).txt -Append -Encoding ASCII -Width 50
Get-Childitem –Path C:\ -Include *jsextension* -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath C:\report_$($comp)_$($DateVal).txt -Append -Encoding ASCII -Width 50
Get-Childitem –Path C:\ -Include *jsextension.exe* -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath C:\report_$($comp)_$($DateVal).txt -Append -Encoding ASCII -Width 50
#Get-Childitem –Path C:\ -Include *mayankshashank.txt* -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath C:\report_$($comp)_$($DateVal).txt -Append -Encoding ASCII -Width 50

try{
$message1 = 'This vulnerabilities test run by Bhavna centrify team' -f [Environment]::NewLine, ($files -join [Environment]::NewLine)
$fromaddress = "noreply@bhavnacorp.in"
$toaddress = "styagi@bhavnacorp.com,mtripathi@bhavnacorp.com,barton.ng@centrify.com"
$Subject = "Vulenaribilty test"
$body = get-content “C:\report_$($comp)_$($DateVal).txt”
$body = "Hi,<br><br>"
$body += "This vulnerabilities test run by Bhavna centrify team on the host $comp.<br><br>"
$body += "Regards,<br>"
$body += "IT Team"
$attachment = “C:\report_$($comp)_$($DateVal).txt”
$smtpserver = "192.168.22.30"
$message = new-object System.Net.Mail.MailMessage
$message.From = $fromaddress
$message.To.Add($toaddress)
$message.IsBodyHtml = $True
$message.Subject = $Subject
$attach = new-object Net.Mail.Attachment($attachment)
$message.Attachments.Add($attach)
$message.body = $body
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$smtp.Send($message)
} catch {
    $message = 'There were no files modified in the last 24 hours'
    }

}
catch {
try{
$message1 = 'This vulnerabilities  test run by Bhavna centrify team' -f [Environment]::NewLine, ($files -join [Environment]::NewLine)
$fromaddress = "noreply@bhavnacorp.in"
$toaddress = "styagi@bhavnacorp.com,mtripathi@bhavnacorp.com"
$Subject = "Vulenaribilty test"
$body = get-content “C:\report_$($comp)_$($DateVal).txt”
$body = "Hi,<br><br>"
$body += "This vulnerabilities test run by Bhavna centrify team and we did not found any threat file on the host $comp.<br><br>"
$body += "Regards,<br>"
$body += "IT Team"
$attachment = “C:\report_$($comp)_$($DateVal).txt”
$smtpserver = "192.168.22.30"
$message = new-object System.Net.Mail.MailMessage
$message.From = $fromaddress
$message.To.Add($toaddress)
$message.IsBodyHtml = $True
$message.Subject = $Subject
$attach = new-object Net.Mail.Attachment($attachment)
$message.Attachments.Add($attach)
$message.body = $body
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$smtp.Send($message)
} catch {
#    $message = 'There were no files modified in the last 24 hours'
$message1 = 'This vulnerabilities  test run by Bhavna centrify team' -f [Environment]::NewLine, ($files -join [Environment]::NewLine)
$fromaddress = "noreply@bhavnacorp.in"
$toaddress = "styagi@bhavnacorp.com,mtripathi@bhavnacorp.com"
$Subject = "Vulenaribilty test"
$body = get-content “C:\report_$($comp)_$($DateVal).txt”
$body = "Hi,<br><br>"
$body += "This vulnerabilities test run by Bhavna centrify team and we did not found any threat file on the host $comp.<br><br>"
$body += "Regards,<br>"
$body += "IT Team"
$attachment = “C:\report_$($comp)_$($DateVal).txt”
$smtpserver = "192.168.22.30"
$message = new-object System.Net.Mail.MailMessage
$message.From = $fromaddress
$message.To.Add($toaddress)
$message.IsBodyHtml = $True
$message.Subject = $Subject
$attach = new-object Net.Mail.Attachment($attachment)
$message.Attachments.Add($attach)
$message.body = $body
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$smtp.Send($message)
    
    }
    }