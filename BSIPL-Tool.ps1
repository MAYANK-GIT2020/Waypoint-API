function Show-Menu {
    param (
        [string]$Title = 'BHAVNA SOFTWARE INDIA PVT LTD. IT AUTOMATION TOOL'
    )
    Clear-Host
    Write-Host "======================== $Title ========================"
    
    Write-Host "01: Press '1'  for   BSIPL - Set New Local Administrator password."
    Write-Host "02: Press '2'  for   BSIPL - Enable the Administrator account."
    Write-Host "03: Press '3'  for   BSIPL - Enable the Remote access policy."
    Write-Host "04: Press '4'  for   BSIPL - Change Local Hostname of the Machine."
    Write-Host "05: Press '5'  for   BSIPL - Ad-Join the Bhavna Domain Controller."
    Write-Host "06: Press '6'  for   BSIPL - Allow Inbound Firewall Policy On Domian/Public/Private."
    Write-Host "07: Press '7'  for   BSIPL - Block Inbound Firewall Policy On Domian/Public/Private."
    Write-Host "08: Press '8'  for   BSIPL - Access NAS, Copy/Paste required Packages for New Machine."
    Write-Host "09: Press '9'  for   BSIPL - Silent Installation for all required Packages."
    Write-Host "10: Press '10' for   BSIPL - Restart this local machine."
    Write-Host "11: Press '11' for   BSIPL - Shutdown this local machine."
	Write-Host "Q:  Press 'Q' to quit."
}
do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    $NewPassword = ConvertTo-SecureString "password@123" -AsPlainText -Force
    Set-LocalUser -Name Administrator -Password $NewPassword
    } '2' {
    Get-LocalUser -Name "Administrator" | Enable-LocalUser
    } '3' {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    } '4' {
    $newName = Read-Host -Prompt "Enter New Computer Name"
$ComputerName = "$newName"
  
Remove-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -name "Hostname" 
Remove-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -name "NV Hostname"
 

Set-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\Computername\Computername" -name "Computername" -value $ComputerName
Set-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\Computername\ActiveComputername" -name "Computername" -value $ComputerName
Set-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -name "Hostname" -value $ComputerName
Set-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -name "NV Hostname" -value  $ComputerName
Set-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -name "AltDefaultDomainName" -value $ComputerName
Set-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -name "DefaultDomainName" -value $ComputerName
restart-computer -force
    } '5' {
    $domain = "bhavnacorp.net"
    $username = "$domain\pawasthi"
    $password = "Passwprd@1" | ConvertTo-SecureString -asPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username,$password)
    Add-Computer -DomainName $domain -Credential $credential
    restart-computer -force
    } '6'{
    Set-NetFirewallProfile -Name Domain,Public,Private -DefaultInboundAction Allow
    } '7' {
    Set-NetFirewallProfile -Name Domain,Public,Private -DefaultInboundAction Block
    } '8' {
            $uncServer = "\\192.168.1.250"
            $uncFullPath = "\\192.168.1.250\All Software_Dump\IT_Common\Laptop_Basic_Setup\Basic\*.*"
            $username = "bhavnacorp\pawasthi"
            $password = "Passwprd@1"
            net use $uncServer $password /USER:$username
            $source = "\\192.168.1.250\All Software_Dump\IT_Common\Laptop_Basic_Setup\Basic\*.*"
            $destination = "C:\Users\Administrator\Downloads\"
            Copy-Item -Path $source -Destination $destination
    } '9'{ 
            & "C:\Users\Administrator\Downloads\Chrome.exe" /silent /install
            & "C:\Users\Administrator\Downloads\npp.exe" /silent /install /L=1033 /S /NCRC
            & "C:\Users\Administrator\Downloads\winrar.exe" /silent /install /L=1033 /S /NCRC 
            & "C:\Users\Administrator\Downloads\GVC.exe" /q
            & "C:\Users\Administrator\Downloads\AdobeReader.exe" /msi EULA_ACCEPT=YES /qn
            & msiexec /i "C:\Users\Administrator\Downloads\tightvnc.msi" /quiet /norestart ADDLOCAL=Server SET_USEVNCAUTHENTICATION=1 VALUE_OF_USEVNCAUTHENTICATION=1 SET_PASSWORD=1 VALUE_OF_PASSWORD=mainpass SET_USECONTROLAUTHENTICATION=1 VALUE_OF_USECONTROLAUTHENTICATION=1 SET_CONTROLPASSWORD=1 VALUE_OF_CONTROLPASSWORD=admpass
            & "C:\Users\Centrify Admin\Downloads\FramePkg.exe" /s /v /qn
} '10' {restart-computer -force
} '11' {shutdown -s -t 0
}
 }
 Pause 
 }
 until ($selection -eq 'Q')