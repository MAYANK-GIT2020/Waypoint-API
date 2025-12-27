$subscriptionId = "your-subscription-id"
$resourceGroupName = "your-resource-group-name"
$hostpoolName = "your-hostpool-name"
$kbnumbers = @('KB4562830', 'KB5012170')

Connect-AzAccount

$vms = Get-AzWvdSessionHost -ResourceGroupName $resourceGroupName -HostPoolName $hostpoolName -SubscriptionId $subscriptionId

foreach ($vm in $vms) {
    $vmname = $vm.Name
    Write-Host "Checking KBs on $vmname"
    foreach ($kbnumber in $kbnumbers) {
        $query = "SELECT * FROM Win32_QuickFixEngineering WHERE HotFixID = '$kbnumber'"
        $hotfixes = Invoke-AzVmScript -ResourceGroupName $resourceGroupName -VMName $vmname -ScriptText $query -ErrorAction SilentlyContinue
        $installed = $hotfixes | Where-Object {$_.HotFixID -eq $kbnumber}

        if ($installed) {
            Write-Host "KB$($installed.HotFixID) is installed on $vmname, installed on $($installed.InstalledOn)"
        } else {
            Write-Host "KB$kbnumber is not installed on $vmname"
        }
    }
}