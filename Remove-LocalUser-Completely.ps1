
function Remove-LocalUserCompletely {

    Param(
        $Name
    )

    process {
        $user = Get-LocalUser -Name $Name -ErrorAction Continue

        # Remove the user from the account database
        Remove-LocalUser -SID $user.SID -Verbose #-WhatIf

        # Remove the profile of the user (both, profile directory and profile in the registry)
        Get-CimInstance -Class Win32_UserProfile | ? SID -eq $user.SID | Remove-CimInstance  -ErrorAction Continue -Verbose #-WhatIf
    }
}

# Delete All bca* Active Users Completely (Registry as well as profile folder)

$collection = Get-LocalUser | Select-Object Name, Description  
foreach($item in $collection)
{
    if ($item.Name -match 'bca') 
    {
        $bca = $item.Name
        Remove-LocalUserCompletely -Name $bca
    }
}


# Delete All bca* None Active Users Completely (Registry as well as profile folder)
$SIDs = Get-CimInstance -Class Win32_UserProfile | Select-Object LocalPath, SID |Where-Object {$_.LocalPath -like "C:\Users\bca*"}

foreach ($item in $SIDs.SID)
{
    Get-CimInstance -Class Win32_UserProfile | ? SID -eq $item | Remove-CimInstance -Verbose #-WhatIf
}