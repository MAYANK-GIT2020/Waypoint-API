#create array used to capture hostname, mac and ip address
$outarray = @()

$getForest = [system.directoryservices.activedirectory.Forest]::GetCurrentForest()
$DCServers = @($getForest.domains | ForEach-Object {$_.DomainControllers} | ForEach-Object {$_.Name} )


#loop through each element in the array to retrieve Server name, mac and ip Address
foreach ( $servername in $DCServers )
{

#get mac and ip address
$colItems = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -ComputerName $servername -Filter "IpEnabled = TRUE"

#populate array with results
    foreach ($item in $colitems)
    {
        $outarray += New-Object PsObject -property @{
        'Server' = $item.DNSHostName
        'MAC' = $item.MACAddress
        'IP' = [string]$item.IPAddress
        }
    }
    

<#
#get timezone 

$Timezone = Get-WMIObject -class Win32_TimeZone -ComputerName $DCServers
            
                foreach ($item in $Timezone)
                {
                    $outarray += New-Object PsObject -property @{
                     'TimeZone' = $item.Caption}
                  }
 #>           
            
             
}

#export to .csv file
$outarray | export-csv C:\final.csv