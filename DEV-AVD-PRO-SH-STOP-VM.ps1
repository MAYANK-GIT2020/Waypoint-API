Param(
 [string]$resourceGroupname,
 [string]$hostpoolname,
 [string]$method
)

# Ensure all errors are caught
$ErrorActionPreference = "Stop"

$automationAccount = "GXS-DEV-AUTOMATION"

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process | Out-Null

try {
    # Connect using a Managed Service Identity
    $AzureContext = (Connect-AzAccount -Identity).context
    
    # set and store context
    $AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription `
        -DefaultProfile $AzureContext

    if ($method -eq "SA")
    {
        Write-Output "Using system-managed identity"
    }
    else
    {
        Write-Output "Invalid method. Choose SA."
        exit
    }

    # Get the session hosts
    $sessionHosts = Get-AzWvdSessionHost -ResourceGroupName $resourceGroupname -HostPoolName $hostpoolname

    # Loop through the session hosts
    foreach ($sessionHostObj in $sessionHosts) {
        # Get the session details for the session host
        $sessionHost = ($sessionHostObj.Name -split "/")[1]
        $sessionDetails = Get-AzWvdUserSession -ResourceGroupName $resourceGroupname -HostPoolName $hostpoolname -SessionHostName $sessionHost

        # Check if there are any active sessions
        if ($sessionDetails.Count -eq 0) {
            # If there are no active sessions, stop the session host VM
            Write-Host "No active sessions found on $sessionHost. Stopping session host VM."

            $SessionHost = $sessionHost.Replace(".gxssg.com", "")
            $vmstate  = Get-AzVM -ResourceGroupName $resourceGroupname -Name $sessionHost -Status
            if ($vmstate.Statuses[1].Code -eq "PowerState/running") {
                Stop-AzVM -ResourceGroupName $resourceGroupname -Name $sessionHost -Force
                Write-Host "Stopped $sessionHost VM."
            } else {
                Write-Host "$sessionHost VM is not running. Skipping stop operation."
            }
        } else {
            Write-Host "There are active sessions. Skipping stop operation."
        }
    }
} catch {
    Write-Output "Failed to execute the script. $($_.Exception.Message)"
}
