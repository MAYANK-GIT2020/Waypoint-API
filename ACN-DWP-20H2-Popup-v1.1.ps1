SCHTASKS /delete /tn "UpgradePopup" /f
[void](Copy-Item -Container "$PSScriptRoot\Popup" -Destination "$env:ProgramData\Accenture\Scripts" -Force -Recurse)
$TaskName = "UpgradePopup"
$ExePath = "$env:ProgramData\Accenture\Scripts\Popup\20H2PopUp.exe"
$ScriptsFolder = "$env:ProgramData\Accenture\Scripts\PopUp"
$popupscriptname = "PopUp.ps1"
$file = Join-Path -Path $ScriptsFolder -ChildPath $popupscriptname
$argument = "-NoProfile -WindowStyle Hidden -File `"$file`""
$PowershellExeFullPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$MsgFolder = "c:\temp\"

$checkTask = Get-ScheduledTaskInfo -TaskName $TaskName -ErrorAction SilentlyContinue
If ($checkTask) {
        [void](Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false)
    }
 
    try {
    #SCHTASKS /Create /tn "UpgradePopup"  /tr "Powershell.exe -File ""$ScriptsFolder\PopUp.ps1""" /ru interactive /sc onlogon /f
    #SCHTASKS /Create /sc daily /st 00:00 /mo 12 /sd 15/03/2022 /tn "UpgradePopup"  /tr "Powershell.exe -File ""$ScriptsFolder\PopUp.ps1""" /ru interactive 
    #SCHTASKS /Create /sc daily /st 05:00 /tn "UpgradePopup"  /tr "Powershell.exe -File ""$ScriptsFolder\PopUp.ps1""" /ru interactive 
    #SCHTASKS /Create /sc hourly /st 00:00 /mo 12 /sd 15/03/2022 /tn "UpgradePopup"  /tr "Powershell.exe -File ""$ScriptsFolder\PopUp.ps1""" /ru interactive 
    #SCHTASKS /Create /sc hourly /mo 05 /tn "UpgradePopup"  /tr "Powershell.exe -File ""$ScriptsFolder\PopUp.ps1""" 
    SCHTASKS /Create /tn "UpgradePopup" /tr ""Powershell.exe" -File ""$ScriptsFolder\PopUp.ps1"""  /sc DAILY /f /RI 300 /du 24:00

    }
    catch {

    }

<#
$day = (Get-Date).DayOfWeek
$Time = (Get-Date).Hour + 1

if($Time -ge "12")
{
    if($Time -eq "12")
        {$ST = "12pm"}
    else
        {$ST = ($Time - 12).ToString() + "pm"}
}
else{
    if($Time -eq "00")
        { $ST = "12am"}
    else
        {$ST = $Time + "am"}
}

$action = New-ScheduledTaskAction -Execute $PowershellExeFullPath -Argument $argument
#$trigger =  New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek $day -At $ST
$Trigger = New-ScheduledTaskTrigger -Daily -At $ST
#$Trigger = New-ScheduledTaskTrigger -Daily -At
$STSet = New-ScheduledTaskSettingsSet -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries
$checkTask = Get-ScheduledTaskInfo -TaskName $TaskName -ErrorAction SilentlyContinue
$user = (Get-WMIObject -class Win32_ComputerSystem | select username).username 

    If ($checkTask) {
        [void](Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false)
    }
 
    try {
    [void](Register-ScheduledTask -TaskName $TaskName -Trigger $trigger -User $user -Action $action -Settings $STSet -RunLevel Limited -Force)
    }
    catch {

    }
    #>
 