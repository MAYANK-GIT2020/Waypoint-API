cd\
cd C:\temp

#read-host "Enter Administrator Password" -assecurestring | convertfrom-securestring | out-file .\username-password-Administrator.txt
$username = "nda1f1r1\Administrator"
#$username = "Administrator@nda1f1r1.com"
$password = cat .\username-password-Administrator.txt | convertto-securestring
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password


#Variables
$computername = Get-Content list.txt
$sourcefile = "C:\temp\vlc-3.0.12-win32.exe"
#This section will install the software 
foreach ($computer in $computername) 
{
    $destinationFolder = "\\$computer\C$\Temp"
    #It will copy $sourcefile to the $destinationfolder. If the Folder does not exist it will create it.

    if (!(Test-Path -path $destinationFolder))
    {
        New-Item $destinationFolder -Type Directory
    }
    Copy-Item -Path $sourcefile -Destination $destinationFolder
    #Invoke-Command -ComputerName $computer -Credential $cred -ScriptBlock {Start-Process 'c:\temp\vlc-3.0.12-win32.exe'}

#installing app forcefully on remote server
$pathvargs = {cmd /c C:\temp\vlc-3.0.12-win32.exe /S /v/qn }
Invoke-Command -ComputerName $computer -Credential $cred -ScriptBlock $pathvargs

}