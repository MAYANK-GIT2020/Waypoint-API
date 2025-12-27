try
{

# Import System.Web assembly
Add-Type -AssemblyName System.Web

$SubID = "80ea84e8-afce-4851-928a-9e2219724c69" 
$RgName = "1-d399a574-playground-sandbox" 
$Location = "East US"

Connect-AzAccount
Set-AzContext -Subscription $SubID
Select-AzSubscription -SubscriptionId $SubID

# Get the VM object
$set = Get-AzVM -ResourceGroupName $RgName
$vms = $set.Name
#$vms

[ValidateNotNullOrEmpty()]$SecureString = [System.Web.Security.Membership]::GeneratePassword(16,1)
$SecureString
$SecureString = $SecureString|ConvertTo-SecureString -AsPlainText -Force


# Authenticate to Azure Key Vault
$kv = Get-AzKeyVault -VaultName $keyVaultName

# Set the password as a secret in Azure Key Vault
Set-AzKeyVaultSecret -VaultName "keyvaultfortestvm" -Name "useronboardingtest" -SecretValue $SecureString

$getsecret = Get-AzKeyVaultSecret -VaultName "keyvaultfortestvm" -Name "useronboardingtest" -AsPlainText
$getsecret.SecretValue


foreach ($vm in $vms) {

$Username = 'sumit' 
($creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $SecureString)
Set-AzVMAccessExtension -ResourceGroupName 1-d399a574-playground-sandbox -Location "East US" -VMName $vm -Credential $creds  -typeHandlerVersion "2.0" -Name VMAccessAgent

}

}
catch{
}