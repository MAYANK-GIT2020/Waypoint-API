cd\
cd D:\Script\
$uncPath   = 'F:\DropboxRepository'  # enter the UNC path here
$day = (Get-Date).AddDays(0).Date

# get an array of full filenames for any file that was last updates in the last 24 hours
$files = (Get-ChildItem -Path $uncPath -Filter '*.*' -File | 
          Where-Object { $_.LastWriteTime -ge $day }).FullName
          $files
# get an array of full foldernames for any folder that was last updates in the last 24 hours
$folder = (Get-ChildItem -Path $uncPath -Filter '*.*' -Directory | 
          Where-Object { $_.LastWriteTime -ge $day }).FullName
$folder

if ($files -or  $folder) {
$message1 = 'The new files were added in the last 24 hours:{0}{1}' -f [Environment]::NewLine, ($files -join [Environment]::NewLine)
$message2 = '  The new folders were added in the last 24 hours:{0}{1}' -f [Environment]::NewLine, ($folders -join [Environment]::NewLine)
$message2 += $folder
$fromaddress = "dropbox@bhavnacorp.in"
$toaddress = "styagi@bhavnacorp.com,mtripathi@bhavnacorp.com"
$Subject = "Robocopy Task Completion on Dropbox Server"
$body = get-content “D:\Script\robologs.txt”
$body = "Hi,<br><br>"
$body += "Script successfully executed and data copied from Dropbox to Local repository.<br><br>"
$body += "$message1 <br><br>"
$body += "$message2 <br><br>"
$body += "Source : C:\Users\dropbox\Dropbox (Centrify)\Build Team\ <br>"
$body += "Dest : F:\DropboxRepository\ <br><br>"
$body += "Logs attached for more details. <br><br>"
$body += "Regards,<br>"
$body += "IT Team"
$attachment = “D:\Script\robologs.txt”
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
else {
    $message = 'There were no files modified in the last 24 hours'
    }