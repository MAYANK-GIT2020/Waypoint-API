#$vcenter = "192.168.18.15"
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
#Connect-VIServer -Server "192.168.18.11" -User newroot -Password centrifY$#@!1
#Connect-VIServer -Server "192.168.18.13" -User newroot -Password centrifY$#@!1
#Connect-VIServer -Server "192.168.18.15" -User newroot -Password centrifY$#@!1
Connect-VIServer -Server "192.168.18.17" -User newroot -Password centrifY$#@!1

Add-PSSnapin VMware.VimAutomation.Core -ErrorAction 'SilentlyContinue'

Get-VMHost -Name "192.168.18.17" | Get-VM | Select Name,PowerState,Version,NumCPU,MemoryGB,ProvisionedSpaceGB,UsedSpaceGB,

    @{N='GuestOS';E={$_.Guest.OSFUllName}},

    @{N='PortgroupName';E={(Get-NetworkAdapter -VM $_).NetworkName -join '|'}},

    @{N='PortgroupVlanId';E={(Get-VirtualPortGroup -Name (Get-NetworkAdapter -VM $_).NetworkName -VMHost $_.VMHost).VlanId -join '|'}},

    @{N='Cluster';E={(Get-Cluster -VM $_).Name}},

    @{N='HostName';E={$_.VMHost.Name}} |

Export-Csv -Path C:\temp\vmsrv03report.csv -NoTypeInformation -UseCulture