Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
Connect-AzAccount


# Import System.Web assembly
Add-Type -AssemblyName System.Web
#Install-Module AzureRM


#########################*****************************************************************************************************##########################

# Azure resource group name and location
$resourceGroupName = "GXS-DEV-AVD-SG"
$location = "Japan East" # Change to your desired Azure region
$SubID = "1fa00c10-81ee-48e7-b152-5096655dd4d1"

Connect-AzAccount
Set-AzContext -Subscription $SubID
Select-AzSubscription -SubscriptionId $SubID

# AVD details
$avdWorkspaceName = "DEV-AVD-MED-PER-WS1"
$avdHostPoolName = "DEV-AVD-MED-PER-HP1"
$avdDesktopGroupName = "DEV-AVD-MED-PER-DAG1"

# Defining here AVD session host VM details (you can add more as needed)
$vmConfigurations = @(
    @{
        VMName = "TESTVM1"
        VMSize = "Standard_D4ds_v5" # Change to your desired VM size
    },
    @{
        VMName = "TESTVM2"
        VMSize = "Standard_D4ds_v5" # Change to your desired VM size
    }
    # Add more VM configurations here
)



# Create an Azure Virtual Desktop workspace

New-AzWvdWorkspace -ResourceGroupName 'GXS-DEV-AVD-SG' -Name 'DEV-AVD-MED-PER-WS1' -Location 'Japan East' -ApplicationGroupReference $null 

# Create an Azure Virtual Desktop host pool

$parameters = @{
    Name = 'DEV-AVD-MED-PER-HP1'
    ResourceGroupName = 'GXS-DEV-AVD-SG'
    
    WorkspaceName = 'GXS-DEV-AVD-WS'
    
    #HostPoolType = 'Pooled'
    HostPoolType = 'Personal'
    #LoadBalancerType = 'BreadthFirst'
    #LoadBalancerType = 'consistent'
    LoadBalancerType = 'Persistent'

    PreferredAppGroupType = 'Desktop'
    MaxSessionLimit = '5'
    Location = 'Japan East'
}

New-AzWvdHostPool @parameters


$HostPool = Get-AzWvdHostPool -Name 'DEV-AVD-MED-PER-HP1' -ResourceGroupName 'GXS-DEV-AVD-SG'
$HostPool

# Create an Azure Virtual Desktop desktop application group
New-AzWvdApplicationGroup   -Name 'DEV-AVD-MED-PER-DAG1'-ResourceGroupName 'GXS-DEV-AVD-SG' -ApplicationGroupType 'Desktop' -HostPoolArmPath $HostPool.id -Location 'Japan East'

$DAG = Get-AzWvdApplicationGroup -Name 'DEV-AVD-MED-PER-WS1' -ResourceGroupName 'GXS-DEV-AVD-SG'

$hostPoolName = 'az140-24-hp3'
$workspaceName = 'az140-24-ws1'
$dagAppGroupName = "$hostPoolName-DAG"
New-AzWvdHostPool -ResourceGroupName $resourceGroupName -Name $hostPoolName -WorkspaceName $workspaceName -HostPoolType Pooled -LoadBalancerType BreadthFirst -Location $location -DesktopAppGroupName $dagAppGroupName -PreferredAppGroupType Desktop 




# Register an Azure Virtual Desktop desktop application group
Register-AzWvdApplicationGroup  -ResourceGroupName 'GXS-DEV-AVD-SG' -WorkspaceName 'DEV-AVD-MED-PER-WS1' -ApplicationGroupPath $DAG.id



#New-AzWvdWorkspace -Name <Name> -ResourceGroupName <ResourceGroupName>

# Loop through the VM configurations and create session host VMs
foreach ($vmConfig in $vmConfigurations) {
    $vmName = $vmConfig.VMName
    $vmSize = $vmConfig.VMSize

    # Create an Azure Virtual Desktop session host VM

    #New-AzVm -ResourceGroupName 'GXS-DEV-AVD-SG' -Name $vmName -Location 'Japan East' -Image 'MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition:latest' -VirtualNetworkName 'GS-DEV-VNET-AVD' -SubnetName 'GS-DEV-AVD-SN1' -SecurityGroupName 'GS-DEV-AVD-SN1-NSG' -PublicIpAddressName 'myPublicIpAddress' -OpenPorts 80,3389

    New-AzVm -ResourceGroupName 'GXS-DEV-AVD-SG' -Name $vmName -Location 'Japan East' -Image "MicrosoftWindowsDesktop:Windows-10:19h2-pro:18363.1556.2103161610" -Size $vmSize  --admin-username 'avdadmin' --admin-password 'P@$$w0rd@007' --custom-data "EnableRDPEndpoint.cmd"

    # Add the VM to the Azure Virtual Desktop host pool

<#    $parameters1 = @{
    HostPoolName = 'DEV-AVD-MED-PER-HP1'
    ResourceGroupName = 'GXS-DEV-AVD-SG'
    ExpirationTime = $((Get-Date).ToUniversalTime().AddHours(24).ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ'))
}

New-AzWvdRegistrationInfo @parameters1
#>
    #az avd sessionhost add --resource-group $resourceGroupName --hostpool-name $avdHostPoolName --name $vmName --vm-name $vmName
}

#>