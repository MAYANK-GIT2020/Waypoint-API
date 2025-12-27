###################### OS Update ######################
$sourcefile = "C:\temp\vlc-3.0.12-win32.exe"
$destinationFolder = "\\$computer\C$\Temp"
(Copy-Item -Path $sourcefile -Destination $destinationFolder -Force -Recurse)

$taskname = "Popup Update" 
$exepath = "$env:ProgramData\Accenture"
$scriptfolder = "$env:ProgramData\Accenture"
$scriptname = popup.ps1
$file = Join-Path -Path $scriptfolder -ChildPath $scriptname
$psscriptfullpath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$day = (Get-Date).DayOfWeek
$time = (Get-Date).Hour + 1

try {

$build = (Get-CimInstance Win32_OperatingSystem).BuildNumber 
$version = (Get-WmiObject Win32_OperatingSystem).version
if ($version -eq '10.0.19042')
{
 if ($build -eq '19042')
 { 
  
  Write-Output $version
  Write-Output "Match"

  #Schedule Task 
  $Action = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument '-NonInteractive -NoLogo -NoProfile -File "C:\MyScript.ps1"'

  #Create Trigger
  $Trigger = New-ScheduledTaskTrigger -Once -At 3am
  #$Trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek $day -At $St

  #Create Setting 
  $Settings = New-ScheduledTaskSettingsSet
  #$Settings = New-ScheduledTaskSettingsSet -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries

  #Create Schedule Task
  Register-ScheduledTask -TaskName 'My PowerShell Script' -InputObject $Task -User 'username' -Password 'passhere'

 }
} 

else {
Write-Output "mis matched"
Write-Output $version
}
}

catch {}