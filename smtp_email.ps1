$smtpServer = "192.168.22.30"
$smtpFrom = "shashank@bhavnacorp.in"
$smtpTo = "mayank@bhavnacorp.in"
$messageSubject = "test"
$messageBody = "test"

 

$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($smtpFrom,$smtpTo,$messagesubject,$messagebody)