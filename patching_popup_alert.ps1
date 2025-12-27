#Author : Mayank Tripathi
#Company : RACKSPACE TECHNOLOGY
# THIS SCRIPT IS IN DEVLOPMENTAL STAGE (23Aug 2023)
# PowerShell.exe
# -windowstyle hidden C:\Scripts\patching_popup_alert.ps1
# Script sends popus mesaages to user/later performs reboot /logged the session with local Administrator

<#
[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
[System.Windows.Forms.MessageBox]::Show('Automatic logoff after 1 hour of inactivity','WARNING')

param (
          [string]$Title = 'SYSTEM IS ABOUT TO REBOOT AS PER THE MAINTENANCE WINDOW'
       )
$delay = 10
$Counter_Form = New-Object System.Windows.Forms.Form
$Counter_Form.Text = "ALERT"
$Counter_Form.Width = 600
$Counter_Form.Height = 200
$Counter_Label = New-Object System.Windows.Forms.Label
$Counter_Label.AutoSize = $true 
$Counter_Form.Controls.Add($Counter_Label)

while ($delay -ge 0)
{
     $Counter_Form.Show()
     $Counter_Label.Text = "Your machine will auto reboot in Seconds Remaining: $($delay)"
     $delay -= 1
     Start-Sleep -Seconds 1
}
$Counter_Form.Close()
#>

try
{

# Import System.Web assembly
Add-Type -AssemblyName System.Web
#Install-Module AzureRM

$SubID = "1fa00c10-81ee-48e7-b152-5096655dd4d1"
$RgName = "GXS-DEV-AVD-SG" 
$Location = "Japan East"

Connect-AzAccount
Set-AzContext -Subscription $SubID
Select-AzSubscription -SubscriptionId $SubID

# Get the VM object
$set = Get-AzVM -ResourceGroupName $RgName
$vms = $set.Name
#$vms
$Title = "vm rebooted sucessfully"

foreach ($vm in $vms) {
$vm

#Restart-AzVM -ResourceGroupName "$RgName" -Name "$vm"
#Write-Host "======================== $vm $Title ========================"

}

}
catch{}

# >>>>>>>>>>>>>>>>>>>>>>>>>access denied while working registry from local laptop need to setup the server with sufficient previdelge (azure connection/winrm/rpc/NSG rule created)<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

<#
# Set variables
$UserName = "avdadmin"
$Password = ""
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($UserName, $SecurePassword)

# Create a credential object for the remote session
#$credential = New-Object PSCredential($UserName, (ConvertTo-SecureString $Password -AsPlainText -Force))


# Configure AutoLogon in the Windows Registry
$AutoLogonPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $AutoLogonPath -Name "DefaultUserName" -Value $UserName
Set-ItemProperty -Path $AutoLogonPath -Name "DefaultPassword" -Value $Password
Set-ItemProperty -Path $AutoLogonPath -Name "AutoAdminLogon" -Value 1

# Restart the computer to apply changes
#Restart-Computer

# Wait for the machine to restart and log in the user
#Start-Sleep -Seconds 180  # Adjust this delay as needed
$ErrorActionPreference = "Stop"
#$null = New-PSSession -ComputerName "localhost" -Credential $Credential

# Remove the AutoLogon configuration from the Registry (optional)
#Set-ItemProperty -Path $AutoLogonPath -Name "AutoAdminLogon" -Value 0
#Remove-ItemProperty -Path $AutoLogonPath -Name "DefaultUserName"
#Remove-ItemProperty -Path $AutoLogonPath -Name "DefaultPassword"


foreach ($vm in $vms) 
{
# Create a remote PowerShell session to the VM
$session = New-PSSession -ComputerName $vm -Credential $Credential

# Query for active user sessions using QWinsta
$queryScript = {
    qwinsta | ForEach-Object {
        $fields = $_.Trim() -split '\s+'
        if ($fields[1] -match "^\d+$") {
            [PSCustomObject]@{
                SessionId   = $fields[1]
                Username    = $fields[2]
                State       = $fields[3]
                IdleTime    = $fields[4]
                LogonTime   = $fields[5..8] -join " "
            }
        }
    }
}
}
# Invoke the query script on the remote VM
$activeSessions = Invoke-Command -Session $session -ScriptBlock $queryScript

# Display the active sessions
$activeSessions | Format-Table -AutoSize

# Close the remote session
Remove-PSSession $session

#>