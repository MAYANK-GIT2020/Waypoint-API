cd\
cd 'D:\automation script\My Ps script\sys admin PS script'
$allinfo = @()
# -------------------------- Enter PCS Password one time--------------
#Password can't transfer and need to enter first time, password will save in *-PCS.txt file and can capture from next Time after comment.

read-host "Enter Administrator Password" -assecurestring | convertfrom-securestring | out-file .\username-password-PCS.txt
$username = "Administrator"
$password = cat .\username-password-PCS.txt | convertto-securestring
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password

$StartTime = (get-date).ToString('T')
$StartTime

Get-Content .\list.txt | %{
$computername  = $_
Write-Host $computername -Foregroundcolor Green
         
if (Test-Connection $_ -Quiet -Count 2)
{
$session = New-PSSession -ComputerName $computername -Credential $cred

#Creating a new folder to remote location
Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock{new-item -type directory -path C:\temp -Force}

#Copying a .exe file from shared network path to remote location
Copy-Item –Path \\192.168.9.10 –Destination C:\temp -ToSession $Session

#installing .exe file on remote server
$pathvargs = {cmd /c C:\temp\.exe /S /v/qn }  # ---> enter your exe file name
Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock $pathvargs

#Shutdown remote server
#Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock{Stop-Computer -Force}

#Reboot the remote server
#Invoke-Command -ComputerName $computername -Credential $cred -ScriptBlock{Restart-Computer $computername -Force}

} else { $record.Online = $false }
}

$EndTime = (get-date).ToString('T')
$EndTime