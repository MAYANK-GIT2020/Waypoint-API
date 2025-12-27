Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer -Server "192.168.18.11" -User newroot -Password centrifY$#@!1
#Connect-VIServer -Server "192.168.18.13" -User newroot -Password centrifY$#@!1
#Connect-VIServer -Server "192.168.18.15" -User newroot -Password centrifY$#@!1
#Connect-VIServer -Server "192.168.18.17" -User newroot -Password centrifY$#@!1

Add-PSSnapin VMware.VimAutomation.Core -ErrorAction 'SilentlyContinue'
#$value = Get-VM | Get-Snapshot | Where {$_.Created -lt (Get-Date).AddDays(-7)}
$value = Get-VM | Get-Snapshot | Where {$_.Created -lt (Get-Date).AddDays(7)}

$value | Select-Object VM, Name, Created, SizeGB |Export-Csv -Path C:\temp\vm_snapshot_report17.csv -NoTypeInformation -UseCulture
$value = $fre
$fre = Select-Object VM |Export-Csv -Path C:\temp\vm_snapshot_report17777.csv -NoTypeInformation -UseCulture


#$vmname = Get-VM | Select-Object VM
#$vmname
#$vmname |Export-Csv -Path C:\temp\vm_snapshot_report11.csv -NoTypeInformation -UseCulture

#Removing the snapshot of the VM
#Remove-VMSnapshot -VMName MSSQL01 -Name “snapshot_1”


###############################################################
#$vmlist = Get-Content C:\Servers.txt
#Get-VM $vmlist | Get-Snapshot | Remove-Snapshot -Confirm:$false
###############################################################
