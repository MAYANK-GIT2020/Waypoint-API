try {

$comp = hostname
$counter = 0   
$starttime = Get-Date -format "dd-MMM-yyyy HH:mm:ss"
$endtime = Get-Date -format "dd-MMM-yyyy HH:mm:ss"
$DateVal = $((Get-Date).ToString('MM-dd-yyyy'))
$error_time = Get-Date -format "dd-MMM-yyyy HH:mm:ss"

Get-ChildItem -Path  C:\elim-monitoring\script\counter.txt -Recurse -File | Where-Object LastWriteTime -lt  (Get-Date).AddDays(-0)  | Remove-Item -Force -Verbose
Get-ChildItem -Path  \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Recurse -File | Where-Object LastWriteTime -lt  (Get-Date).AddDays(-0)  | Remove-Item -Force -Verbose
#\\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt

#------------------------------------------------------------------------- D drive -----------------------------------------------------------------------------------
try

{
$driveinfo=get-wmiobject win32_volume -ComputerName 'localhost' | where { $_.driveletter -eq 'D:' } | select-object Freespace, capacity,driveletter

# 80 percent cutoff space
$Percent=.2

# 80% of maximum space is our warning level
$WarningLevel=$driveinfo.capacity *  $Percent

if ($driveinfo.Freespace -lt $WarningLevel)
{

send-mailmessage -from "Noida SPB Health Check <noreply@cadence.com>" -to "kartik@cadence.com","shivamb@cadence.com","vikashg@cadence.com","ashutosh@cadence.com","tmayank@cadence.com" -subject "The D drive free space is below 80%" -body "The d drive free space is full on $comp. It is runing with $driveinfo.Freespace in bytes" -priority High -dno onSuccess, onFailure -smtpServer mailin
badmin hclose -C "By Health Check Automated script  - D Drive space full" $comp
#$record.FarmStatus = Write-Output "Closed"

}

else
{

}
}
catch {}

    
try {

$SBD = gwmi win32_service -ComputerName 'localhost' -ErrorAction Stop
if ($SBD.Name -eq 'SBD')
    {
     $SBD_Status = gwmi win32_service -Filter "name='SBD'" -ComputerName 'localhost' -ErrorAction Stop
    if ($SBD_Status.State -eq 'Running')
     {
     $counter++
     $SBD = "SBD is running"
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject "$starttime---start elim check cycle---" -Encoding ASCII -Width 50
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $SBD -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $SBD -Encoding ASCII -Width 50
     } else {
             $procs = 'SBD is not running'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }
     } else {
     $procs = 'SBD not found'
     Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
     Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
     }
    } catch {
             $procs = 'SBD not found'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }

try {

$RES = gwmi win32_service -ComputerName 'localhost' -ErrorAction Stop
if ($RES.Name -eq 'RES')
    {
     $RES_Status = gwmi win32_service -Filter "name='RES'" -ComputerName 'localhost' -ErrorAction Stop
    if ($RES_Status.State -eq 'Running')
     {
     $counter++
     $RES = "RES is running"
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $RES -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $RES -Encoding ASCII -Width 50         
     }
     else
         {
         $procs = 'RES is not running'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50                        
         }
     }
     else
     {
     $procs = 'RES not found'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
         }

} catch {
         $procs = 'RES not found'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
         }

#3-------------------------------------------------LIM SERVICE-------------------------------------------

try {

$LIM = gwmi win32_service -ComputerName 'localhost' -ErrorAction Stop
if ($LIM.Name -eq 'LIM')
    {
     $LIM_Status = gwmi win32_service -Filter "name='LIM'" -ComputerName 'localhost' -ErrorAction Stop
    if ($LIM_Status.State -eq 'Running')
     {
     $counter++
     $LIM = "LIM is running"
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $LIM -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $LIM -Encoding ASCII -Width 50
     }
     else
         {
         $procs = 'LIM is not running'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
         }
     }
     else
     {
         $procs = 'LIM not found'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
         }

} catch {
         $procs = 'LIM not found'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
         }

#4-------------------------------------------------UAC STATUS-------------------------------------------


try {
$UAC = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA }).enableLUA 
     if ($uac -eq '0')
     {   $counter++
     $UAC = "UAC is 1"
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $UAC -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $UAC -Encoding ASCII -Width 50
     } else {
         $procs = 'UAC is 0'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
         }

    } catch {
        $procs = 'UAC is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
         
        }


#5-------------------------------------------------FIREWALL STATUS-------------------------------------------    
    
try {
     
$Firewall = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile -Name EnableFirewall}).enablefirewall

     if ($Firewall -eq '0')
     {  $counter++
     $Firewall = "Firewall is 1"
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $Firewall -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $Firewall -Encoding ASCII -Width 50
     } else {
        $procs = 'Firewall is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
        }

    } catch {
        $procs = 'Firewall is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
        }


#6-------------------------------------------------P4 login STATUS-------------------------------------------

try {

$filename = 'p4.exe'
$searchinfolder = 'C:\Program Files\Perforce'
$a = Get-ChildItem -Path $searchinfolder -Filter $filename | Select-Object Name

if ($a.Name = 'p4.exe') {
    $P4Login = Invoke-Command -ComputerName 'localhost' -ScriptBlock{cmd /c 'p4.exe' login -s} -ErrorAction Stop
     if ($P4Login -ne 'User PCS ticket expires in 150206 hours 12 minutes.') 
     {  $counter++
      $P4Login = 'P4Login is 1'
      Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $P4Login -Encoding ASCII -Width 50
      Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $P4Login -Encoding ASCII -Width 50
     } else {
        $procs = 'P4Login is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
        }       
} else {
        $procs = 'P4Login is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
        }
} catch {
        $procs = 'P4Login is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
        }

#7-------------------------------------------------P4 USER STATUS-------------------------------------------

try {

$pathvar1 = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name P4USER )})
#Array Length PS------ Write-Host $PathVars.Length
$pathvar1 | % { $_ } | Out-File .\path1.txt
$P4user_status = Select-String -Path ".\path1.txt" -Pattern "PCS" -SimpleMatch

if ($P4user_status -ne " ")
    {
     $P4User = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name P4USER)} -ErrorAction Stop).P4USER
     if ($P4User -eq 'PCS')
     {  $counter++
      $P4User = 'P4User is 1'
      Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $P4User -Encoding ASCII -Width 50
      Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $P4User -Encoding ASCII -Width 50
     } else {
        $procs = 'P4User is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
        }
    }
else 
    {
     $procs = 'P4User is not mapped in registry'
     Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
     Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
     }

} catch {
         $procs = 'P4User is not found'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
        }

#8-------------------------------------------------BASH_ENV STATUS-------------------------------------------
try {

$BASH_ENV1 = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment' -Name BASH_ENV)} -ErrorAction Stop).BASH_ENV
$BASH_ENV1 | % { $_ } | Out-File .\BASH_ENV.txt
$Bash_status = Select-String -Path ".\BASH_ENV.txt" -Pattern "C:\cygwin\home\PCS\cadence_cygwin_profile" -SimpleMatch

if ($Bash_status -ne " ")
    {     
     if ($BASH_ENV1 -eq 'C:\cygwin\home\PCS\cadence_cygwin_profile')
     {  $counter++
     $procs1 = 'BASH_ENV is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $procs1 -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $procs1 -Encoding ASCII -Width 50
     } else {
        $procs2 = 'BASH_ENV is 0'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs2 -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs2 -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs2 -Encoding ASCII -Width 50
        }
    } else {
        $procs3 = 'BASH_ENV is not mapped in registry'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs3 -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs3 -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs3 -Encoding ASCII -Width 50
        }

} catch {
        $procs3 = 'BASH_ENV is not mapped in registry'
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs3 -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs3 -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
        Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs3 -Encoding ASCII -Width 50
        }

try {
$pathvar2 = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name Path )}).Path -split ';'|fl | Format-Table -AutoSize -Wrap
$pathvar2 | % { $_ } | Out-File .\path2.txt

#-------------------multiple variable------------------------------
#9-------------------- #PVTS_CM------------------------------------

$PVTS_status = Select-String -Path ".\path2.txt" -Pattern 'U:\pvts_CM\bin.wint\software\perl\bin' -SimpleMatch

if ($PVTS_status -ne " ")
{     
$pvts = (Get-Content .\path2.txt | where {$_ -like "U:\pvts_CM\bin.wint\software\perl\bin"})

   if ($pvts -eq 'U:\pvts_CM\bin.wint\software\perl\bin')
     {  $counter++
     $procs1 = 'PVTS_CM is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $procs1 -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $procs1 -Encoding ASCII -Width 50
     }
 } else {
         $procs2 = 'PVTS_CM is 0'
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs2 -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs2 -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
         Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs2 -Encoding ASCII -Width 50
        }

#10-------------------- #Cygwin------------------------------------

$cygwin = (Get-Content .\path2.txt | where {$_ -like "C:\cygwin\bin"})

if ($cygwin -eq 'C:\cygwin\bin')
     {  $counter++
     $cygwinSEL = 'cygwin is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $cygwinSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $cygwinSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'cygwin is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             }

#11-------------------- #Perl64\site path ------------------

$Perl_SiteSEL = (Get-Content .\path2.txt | where {$_ -like "C:\Perl64\site\bin"})
if ($Perl_SiteSEL -eq 'C:\Perl64\site\bin')
     {  $counter++
     $Perl_SiteSEL = 'Perl_Site is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $Perl_SiteSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $Perl_SiteSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'Perl_Site is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }

     
#12-------------------- #Perl64\bin path ------------------

$Perl_binSEL = (Get-Content .\path2.txt | where {$_ -like "C:\Perl64\bin"})
if ($Perl_binSEL -eq 'C:\Perl64\bin')
     {  $counter++
     $Perl_binSEL = 'Perl_bin is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $Perl_binSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $Perl_binSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'Perl_bin is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }
                      


#13-------------------- #LSF_10.1\10.1\bin path ------------------
$LSF10_binSEL = (Get-Content .\path2.txt | where {$_ -like "C:\LSF_10.1\10.1\bin"})
if ($LSF10_binSEL -eq 'C:\LSF_10.1\10.1\bin')
     {    $counter++
     $LSF10_binSEL = 'LSF10_bin is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $LSF10_binSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $LSF10_binSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'LSF10_bin is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }
    

#14-------------------- #LSF_10.1\10.1\lib path ------------------
$LSF10_libSEL = (Get-Content .\path2.txt | where {$_ -like "C:\LSF_10.1\10.1\lib"})

if ($LSF10_libSEL -eq 'C:\LSF_10.1\10.1\lib')
     {    $counter++
     $LSF10_libSEL = 'LSF10_lib is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $LSF10_libSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $LSF10_libSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'LSF10_lib is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }

#15-------------------- #U:\pvts_CM\bin.wint\software\pstools1.12 path ------------------
$pstoolsSEL = (Get-Content .\path2.txt | where {$_ -like "U:\pvts_CM\bin.wint\software\pstools1.12"})
if ($pstoolsSEL -eq 'U:\pvts_CM\bin.wint\software\pstools1.12')
     {    $counter++
     $pstoolsSEL = 'pstools is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $pstoolsSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $pstoolsSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'pstools is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }
     
          
#16------------------- #WindowsPowerShell\v1.0\ path ------------------
$PshellSEL = (Get-Content .\path2.txt | where {$_ -like "C:\Windows\System32\WindowsPowerShell\v1.0\"})
if ($PshellSEL -eq 'C:\Windows\System32\WindowsPowerShell\v1.0\')
     {    $counter++
     $PshellSEL = 'Powershell is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $PshellSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $PshellSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'Powershell is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }


#17-------------------- #Program Files\Perforce ------------------
$PerforceSEL = (Get-Content .\path2.txt | where {$_ -like "C:\Program Files\Perforce"})
if ($PerforceSEL -eq 'C:\Program Files\Perforce')
     {    $counter++
     $PerforceSEL = 'Perforce is 1'
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject "$endtime---end elim check cycle---" -Encoding ASCII -Width 50
     Out-File -FilePath C:\elim-monitoring\script\logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $PerforceSEL -Encoding ASCII -Width 50
     Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\elim_$($comp)_$($DateVal).txt -Append -InputObject $PerforceSEL -Encoding ASCII -Width 50
     } else {
             $procs = 'Perforce is 0'
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\current_error_$comp -Append -InputObject $procs -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject "$error_time---elim error---" -Encoding ASCII -Width 50
             Out-File -FilePath \\noinapb02\psdstore4\pvts_CM\bin.wint\lsfdrm\elim_logs\$($comp)_error_$($DateVal).txt -Append -InputObject $Procs -Encoding ASCII -Width 50
             Out-File -FilePath C:\elim-monitoring\script\logs\$($comp)_error_$($DateVal).txt -Append -InputObject $procs -Encoding ASCII -Width 50
            }

} catch {}

<# 
#19-------------------- #L DRIVE ------------------

$Networkpath = "L:\"
$pathExists = Test-Path -Path $Networkpath
#$pathExists
$time19 = Get-Date
If ($pathExists -eq 'True') {
$L_Drive = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Network\L')} -$comp_error_$DateValAction Stop).RemotePath
     if ($L_Drive -eq '\\noinapb01\PVTS')
     {
     $counter++
     #$counter
     $L_Drive = 'L_Drive is 1'
     #$L_Drive
     Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $L_Drive -Encoding ASCII -Width 50
     $time19
     Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $time19 -Encoding ASCII -Width 50
     }
}
ELSE {
$L_Drive = 'L_Drive is not mapped'
#$L_Drive
Out-File -FilePath U:\pvts_CM\bin.wint\lsfdrm\elim_logs\$comp_error_$DateVal_$comp.results -Append -InputObject $L_Drive -Encoding ASCII -Width 50
#$counter
}
     
                 
#20-------------------- #N DRIVE ------------------
$Networkpath = "N:\"
$pathExists = Test-Path -Path $Networkpath
#$pathExists
$time20 = Get-Date
If ($pathExists -eq 'True') {
$N_Drive = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Network\N')} -$comp_error_$DateValAction Stop).RemotePath
     if ($N_Drive -eq '\\noiclapa02\psd_install')
     {
     $counter++
     #$counter
     $N_Drive = 'N_Drive is 1'
     #$N_Drive
     Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $N_Drive -Encoding ASCII -Width 50
     $time20
     Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $time20 -Encoding ASCII -Width 50
     } 
}
ELSE {
$N_Drive = 'N_Drive is not mapped'
#$N_Drive
Out-File -FilePath U:\pvts_CM\bin.wint\lsfdrm\elim_logs\$comp_error_$DateVal_$comp.results -Append -InputObject $N_Drive -Encoding ASCII -Width 50
#$counter
}
     
#21-------------------- #S DRIVE ------------------
$Networkpath = "S:\"
$pathExists = Test-Path -Path $Networkpath
#$pathExists
$time21 = Get-Date
If ($pathExists -eq 'True') {
$S_Drive = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Network\S')} -$comp_error_$DateValAction Stop).RemotePath
     if ($S_Drive -eq '\\noiclapa02\share')
     {
     $counter++
     #$counter
     $S_Drive = 'S_Drive is 1'
     #$S_Drive
     Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $S_Drive -Encoding ASCII -Width 50
     $time21
     Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $time21 -Encoding ASCII -Width 50
     }
     }
ELSE {
$S_Drive = 'S_Drive is not mapped'
#$S_Drive
Out-File -FilePath U:\pvts_CM\bin.wint\lsfdrm\elim_logs\$comp_error_$DateVal_$comp.results -Append -InputObject $S_Drive -Encoding ASCII -Width 50
#$counter
}


#22-------------------- #U DRIVE ------------------
     
$Networkpath = "U:\"
$pathExists = Test-Path -Path $Networkpath
#$pathExists
$time22 = Get-Date
If ($pathExists -eq 'True') {
$U_Drive = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Network\U')} -$comp_error_$DateValAction Stop).RemotePath
     if ($U_Drive -eq '\\noinapb02\psdstore4')
     {
     $counter++
     #$counter
     $U_Drive = 'U_Drive is 1'
     #$U_Drive
        Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $U_Drive -Encoding ASCII -Width 50
        $time22
        Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $time22 -Encoding ASCII -Width 50
     }
     }

ELSE {
$U_Drive = 'U_Drive is not mapped'
#$U_Drive
Out-File -FilePath U:\pvts_CM\bin.wint\lsfdrm\elim_logs\$comp_error_$DateVal_$comp.results -Append -InputObject $U_Drive -Encoding ASCII -Width 50
#$counter
}


#23-------------------- #Y DRIVE ------------------
                 
$Networkpath = "Y:\"
$pathExists = Test-Path -Path $Networkpath
#$pathExists
$time23 = Get-Date
If ($pathExists -eq 'True') {
$Y_Drive = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{(Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Network\Y')} -$comp_error_$DateValAction Stop).RemotePath
      if ($Y_Drive -eq '\\noinapb01\cm\cdrom\SPB')
      {
      $counter++
      #$counter
      $Y_Drive = 'Y_Drive is 1'
      #$Y_Drive
      $time23
      Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $Y_Drive -Encoding ASCII -Width 50
      Out-File -FilePath C:\elim-monitoring\script\logs\elim.txt -Append -InputObject $time23 -Encoding ASCII -Width 50
     }
     }


ELSE {
$Y_Drive = 'Y_Drive is not mapped'
#$Y_Drive
Out-File -FilePath U:\pvts_CM\bin.wint\lsfdrm\elim_logs\$comp_error_$DateVal_$comp.results -Append -InputObject $Y_Drive -Encoding ASCII -Width 50
}
#>

Get-ChildItem -Path  C:\elim-monitoring\script\logs\ -Recurse -File | Where-Object LastWriteTime -lt  (Get-Date).AddDays(-7)  | Remove-Item -Force -Verbose
Out-File -FilePath C:\elim-monitoring\script\counter.txt -InputObject $counter -Encoding ASCII -Width 50
} catch {}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~end of PS script~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##### #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~start of elim.bat ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~@echo off
