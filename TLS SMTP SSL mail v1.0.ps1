###########Author : Mayank Tripathi
###########Date   : 4th April 2022

$StartTime = (Get-Date).ToString('T')
$EndTime = (Get-Date).ToString('T')
#read-host "Enter PCS Password" -assecurestring | convertfrom-securestring | out-file .\username-password-PCS.txt
$username = "CSLRCXEBOZ@seimens.com"
$password = cat .\username-password-PCS.txt | convertto-securestring
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$fromaddress = "dwp.windows.it@siemens.com"
$toaddress = "naresh.dulipalla.ext@siemens.com"
$filenameAndPath = "C:\Users\z004fmes\Desktop\testmail.txt"
$Subject = "mail test"
$bdy = "Hi,<br><br>"
$bdy += "Mail test successfull.<br>"
$bdy += "Trigger started at $StartTime and end time at: $EndTime.<br><br>"
$bdy += "Regards,<br>"
$bdy += "IT Team"
$attachment = New-Object System.Net.Mail.Attachment($filenameAndPath)



$smtpserver = "139.25.239.160"
$message = new-object System.Net.Mail.MailMessage
$message.From = $fromaddress
$message.To.Add($toaddress)
$message.IsBodyHtml = $True
$message.Subject = $Subject
$message.body = $bdy
$message.Attachments.Add($attachment)



$smtp = New-Object Net.Mail.SmtpClient($SmtpServer, 25)
$smtp.EnableSsl = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential("username", "password");
$smtp.Send($SMTPMessage)
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$smtp.Send($message)