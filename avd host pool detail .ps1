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

$a = Get-AzWvdHostPool -ResourceGroupName GXS-DEV-AVD-SG -Name DEV-AVD-PRO-PER-HP
$a

$a = Get-AzWvdHostPool -ResourceGroupName GXS-DEV-AVD-SG -Name DEV-AVD-PRO-PER-HP
$a.Name


$a = Get-AzWvdWorkspace -ResourceGroupName GXS-DEV-AVD-SG -Name DEV-AVD-PRO-PER-HP
$a
