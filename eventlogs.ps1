Set-Variable -Name EventAgeDays -Value 10 #we will take events for the latest 7 days
Set-Variable -Name CompArr -Value @("vwsrv-spb2k1602", "vwsrv-spb2k1604") # replace it with your server names
Set-Variable -Name LogNames -Value @("System") # Checking app and system logs
Set-Variable -Name EventTypes -Value @("Error", "Warning", "Information") # Loading only Errors and Warnings
Set-Variable -Name ExportFolder -Value "C:\"

$el_c = @() #consolidated error log
$now=get-date
$startdate=$now.adddays(-$EventAgeDays)
$ExportFile=$ExportFolder + "el" + $now.ToString("yyyy-MM-dd---hh-mm-ss") + ".csv" # we cannot use standard delimiteds like ":"

foreach($comp in $CompArr)
{
foreach($log in $LogNames)
{
Write-Host Processing $comp\$log
$el = get-eventlog -ComputerName $comp -log $log -After $startdate -EntryType $EventTypes
$el_c += $el #consolidating
}
}
$el_sorted = $el_c | Sort-Object TimeGenerated #sort by time
Write-Host Exporting to $ExportFile
$el_sorted|Select EntryType, TimeGenerated, Source, EventID, MachineName, Message | Export-CSV $ExportFile -NoTypeInfo #EXPORT
Write-Host Done!