cd\
cd D:\Script\
$uncPath   = 'F:\DropboxRepository'  # enter the UNC path here
#$uncPath  = "\\192.168.9.10\F$\DropboxRepositoryMirror"
#$day = (Get-Date).AddDays(0).Date
$hours = (Get-Date).AddHours(-1)
$hours

# get an array of full filenames for any file that was last updates in the last 24 hours
$files = (Get-ChildItem -Recurse -Path $uncPath -Filter '*.*' -File | 
          Where-Object { $_.LastWriteTime -ge $hours }).FullName
$files.Count
$files

# get an array of full foldernames for any folder that was last updates in the last 24 hours
$folder = (Get-ChildItem -Recurse -Path $uncPath -Filter '*.*' -Directory | 
          Where-Object { $_.LastWriteTime -ge $hours }).FullName
$folder.Count
$folder

if ($files -or  $folder) {
#$message1 = ' The new files were added:{0}{1} ' -f [Environment]::NewLine, "<br>`n <br>  ($files -join [Environment]::NewLine)"
$message1 = ' The new files were added:{0}{1} ' -f [Environment]::NewLine, "<br>`n <br>  $files "
#$message1 += $files
$message2 = ' The new folders were added:{0}{1} ' -f [Environment]::NewLine, ($folders -join [Environment]::NewLine)
$message2 += "<br>`n <br>"
$message2 += $folder
$fromaddress = "dropbox@bhavnacorp.in"
#$toaddress = "styagi@bhavnacorp.com,mtripathi@bhavnacorp.com,barton.ng@centrify.com"
$toaddress = "styagi@bhavnacorp.com,mtripathi@bhavnacorp.com"
$Subject = "Robocopy Task Completion on Dropbox Server"
$body = get-content “D:\Script\robologs.txt”
$body = "Hi,<br><br>"
$body += "Script successfully executed and data copied from Dropbox to Local repository.<br><br>"
$body += "$message1 <br><br>"
#$body += ' The new files were added:{0}{1} '  -f [Environment]::NewLine, ($files -join [Environment]::NewLine)
$body += "$message2 <br><br>"
$body += "Source : Dropbox (Centrify)\Build Team\ <br>"
$body += "Dest : DropboxRepository\ <br><br>"
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