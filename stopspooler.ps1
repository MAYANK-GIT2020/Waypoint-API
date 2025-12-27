$svc_name = "Spooler"
Get-service | Where-Object {$_.Name -eq $svc_name} |  Stop-Service
Set-Service $svc_name -StartupType  Disabled
Get-Service -Name Spooler | Select-Object -Property * > "spollerlog.txt"
pause