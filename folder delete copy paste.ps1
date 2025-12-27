#Copy-Item -Path C:\elim-monitoring\script\logs\*  -Destination \\noinapb02\psdstore4\U$\pvts_CM\bin.wint\lsfdrm\elim_logs -Recurse

cd\
cd C:\HealthCheck\test
$allinfo = @()
# -------------------------- Enter PCS Password one time--------------
#Password can't transfer and need to enter first time, password will save in *-PCS.txt file and can capture from next Time after comment.

#read-host "Enter PCS Password" -assecurestring | convertfrom-securestring | out-file .\username-password-PCS.txt
$username = "Global\PCS"
$password = cat .\username-password-PCS.txt | convertto-securestring
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password


$StartTime = (get-date).ToString('T')
$StartTime
Get-Content .\list.txt | %{
$computername  = $_
Write-Host $computername -Foregroundcolor Yellow
          
if (Test-Connection $_ -Quiet -Count 2)
{ 
$session = New-PSSession –ComputerName $computername
#Removing directory to remote location
#Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock{Remove-Item -Path C:\Windows\Temp\script -Force}
#Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock{Remove-Item -Path c:\temp -Force}

#Creating a new folder to remote location
#Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock{new-item -type directory -path C:\elim-monitoring\script -Force}
#Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock{new-item -type directory -path C:\elim-monitoring\script\logs -Force}

#Copying a file to remote location
#Copy-Item –Path C:\elim-monitoring\script\logs\* -FromSession $session -Destination \\noinapb02\psdstore4\U$\pvts_CM\bin.wint\lsfdrm\elim_logs -Recurse -Force
Copy-Item –Path C:\HealthCheck\test\elim.hi.bat –Destination 'C:\LSF_10.1\10.1\etc' –ToSession $session
#Copy-Item –Path C:\HealthCheck\test\testps.ps1 –Destination 'C:\elim-monitoring\script' –ToSession $session
} else { $record.Online = $false }

}
$EndTime = (get-date).ToString('T')
$EndTime