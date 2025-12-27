#$vcenter = "192.168.18.15"
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
#Connect-VIServer -Server "192.168.18.11" -User newroot -Password centrifY$#@!1
#Connect-VIServer -Server "192.168.18.13" -User newroot -Password centrifY$#@!1
#Connect-VIServer -Server "192.168.18.15" -User newroot -Password centrifY$#@!1
Connect-VIServer -Server "192.168.18.17" -User newroot -Password centrifY$#@!1

Add-PSSnapin VMware.VimAutomation.Core -ErrorAction 'SilentlyContinue'

<#
Clear-Host
$esxi = Get-VMHost | Sort Name

$D = $esxi | Select-object @{N="HostName";E={ $_ | Get-VMHostNetwork | select -ExpandProperty Hostname}},Manufacturer,Model,ProcessorType,NumCpu,MemoryTotalGB,Version,Build
$D | Export-Csv C:\temp\shell.csv -NoTypeInformation -Force
#>

# Get CPU and RAM detailed info and usage per host 
#$allhosts = @()
#$hosts = Get-VMHost

<#
foreach($vmHost in $hosts){
  $hoststat = "" | Select HostName, MemoryInstalled, MemoryAllocated, MemoryConsumed, MemoryUsage, CPUMax, CPUAvg, CPUMin
  $hoststat.HostName = $vmHost.name
  
  $statcpu = Get-Stat -Entity ($vmHost)-start (get-date).AddDays(-30) -Finish (Get-Date)-MaxSamples 10000 -stat cpu.usage.average
  $statmemconsumed = Get-Stat -Entity ($vmHost)-start (get-date).AddDays(-30) -Finish (Get-Date)-MaxSamples 10000 -stat mem.consumed.average
  $statmemusage = Get-Stat -Entity ($vmHost)-start (get-date).AddDays(-30) -Finish (Get-Date)-MaxSamples 10000 -stat mem.usage.average
  $statmemallocated = Get-VMhost $vmHost.name | Select @{N="allocated";E={$_ | Get-VM | %{$_.MemoryGB} | Measure-Object -Sum | Select -ExpandProperty Sum}}
  $statmeminstalled = Get-VMHost $vmHost.name | select MemoryTotalGB
  $statmeminstalled = $statmeminstalled.MemoryTotalGB

  $cpu = $statcpu | Measure-Object -Property value -Average -Maximum -Minimum
  $memconsumed = $statmemconsumed | Measure-Object -Property value -Average
  $memusage = $statmemusage | Measure-Object -Property value -Average
  
  $CPUMax = "{0:N0}" -f ($cpu.Maximum)
  $CPUAvg = "{0:N0}" -f ($cpu.Average)
  $CPUMin = "{0:N0}" -f ($cpu.Minimum)
  $allocated = "{0:N0}" -f ($statmemallocated.allocated)
  $consumed = "{0:N0}" -f ($memconsumed.Average/1024/1024)
  $usage = "{0:P0}" -f ($memusage.Average/100)
  $installed = "{0:N0}" -f ($statmeminstalled)

  $CPUMax = $CPUMax.ToString() + " %"
  $CPUAvg = $CPUAvg.ToString() + " %"
  $CPUMin = $CPUMin.ToString() + " %"
  $MemoryInstalled = $installed.ToString() + " GB"
  $MemoryAllocated = $allocated.ToString() + " GB"
  $MemoryConsumed = $consumed.ToString() + " GB"
  $MemoryUsage = $usage.ToString()

  $hoststat.CPUMax = $CPUMax
  $hoststat.CPUAvg = $CPUAvg
  $hoststat.CPUMin = $CPUMin
  $hoststat.MemoryInstalled = $MemoryInstalled
  $hoststat.MemoryAllocated = $MemoryAllocated
  $hoststat.MemoryConsumed = $MemoryConsumed
  $hoststat.MemoryUsage = $MemoryUsage
  $allhosts += $hoststat
}
$allhosts | Select HostName, MemoryInstalled, MemoryAllocated, MemoryConsumed, MemoryUsage, CPUMax, CPUAvg, CPUMin | Export-Csv C:\temp\gather-host-perf-stats.csv -NoTypeInformation -Force

#Get Datastore Usage and save to CSV
Get-Datastore | Select Name,@{N="TotalSpaceGB";E={[Math]::Round(($_.ExtensionData.Summary.Capacity)/1GB,0)}},@{N="UsedSpaceGB";E={[Math]::Round(($_.ExtensionData.Summary.Capacity - $_.ExtensionData.Summary.FreeSpace)/1GB,0)}}, @{N="ProvisionedSpaceGB";E={[Math]::Round(($_.ExtensionData.Summary.Capacity - $_.ExtensionData.Summary.FreeSpace + $_.ExtensionData.Summary.Uncommitted)/1GB,0)}},@{N="NumVM";E={@($_ | Get-VM | where {$_.PowerState -eq "PoweredOn"}).Count}} | Sort Name | Export-Csv C:\temp\gather-host-perf-stats-datastores.csv -noTypeInformation

#Disconnect from current vCenter
#Disconnect-VIServer $vcenter -Confirm:$false





#$allinfo | Export-Csv .\spbfarminfo$((Get-Date).ToString('MM-dd-yyyy_HHmm')).csv -NoTypeInformation -Force
<#
Find-Module -Name VMware.PowerCLI
Install-Module -Name VMware.PowerCLI -Scope CurrentUser
Get-Command -Module *VMWare*
Import-Module VMware.VimAutomation.Core

Get-ExecutionPolicy -List | Format-Table -AutoSize
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
#>

#Get-VMHost -Name "192.168.18.15" | Get-VM |Format-List -Property *

#@{N="NumDisks";E={@($_.Guest.Disk.Length)}} | Sort-Object -Descending NumDisks 

#Get-VMHost -Name "192.168.18.17" |Get-VM |  Select Name,MemoryGB,NumCpu,VMHost,@{N='Vm IP';E={$_.Guest.IPAddress[0]}} | Export-CSV C:\temp\192.168.18.17_report.csv -NoTypeInformation -Force
#Get-VMHost -Name "192.168.18.15" |Get-VM |  Select Name,MemoryGB,NumCpu,@{N='Vm IP';E={$_.Guest.IPAddress[0]}} | Export-CSV C:\temp\192.168.18.15_report.csv -NoTypeInformation -Force

#Get-VMHost -Name "192.168.18.11" |Get-VM |  Select Name,MemoryGB,ProvisionedSpaceGB,UsedSpaceGB,NumCpu,@{N='Vm IP';E={$_.Guest.IPAddress[0]}}| Export-CSV C:\temp\192.168.18.11_report.csv -NoTypeInformation -Force
#Get-VMHost -Name "192.168.18.13" |Get-VM |  Select Name,MemoryGB,ProvisionedSpaceGB,UsedSpaceGB,NumCpu,@{N='Vm IP';E={$_.Guest.IPAddress[0]}}| Export-CSV C:\temp\192.168.18.13_report.csv -NoTypeInformation -Force
#Get-VMHost -Name "192.168.18.15" |Get-VM |  Select Name,MemoryGB,ProvisionedSpaceGB,UsedSpaceGB,NumCpu,@{N='Vm IP';E={$_.Guest.IPAddress[0]}}| Export-CSV C:\temp\192.168.18.15_report.csv -NoTypeInformation -Force
Get-VMHost -Name "192.168.18.17" |Get-VM |  Select Name,MemoryGB,ProvisionedSpaceGB,UsedSpaceGB,NumCpu,@{N='Vm IP';E={$_.Guest.IPAddress[0]}}| Export-CSV C:\temp\192.168.18.17_report.csv -NoTypeInformation -Force