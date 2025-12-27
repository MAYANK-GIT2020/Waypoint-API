$dcm = Get-CimInstance -Namespace root -Class __Namespace | where-object Name -eq DCIM
$dcm

if (!$dcm) {
    Write-Output "DCM is not installed. Exiting...."
    ##
    $output += " is set on $env:COMPUTERNAME."
    $output
    ##
    return
}
$passwords = Get-CimInstance -Namespace root\dcim\sysman -classname dcim_biospassword 
$passwords | foreach-Object {
        $output = $_.AttributeName
  
        if ($_.IsSet -match "True") {
            $output += " is set on $env:COMPUTERNAME."
        }
        elseif ($_.IsSet -match "False") {
            $output += " is not set on $env:COMPUTERNAME."
        }
        else
        {
        }
        Write-Output $output
      } 

      #08feb2022 WMI discovery Mayank Tripathi