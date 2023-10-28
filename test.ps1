cd\
cd C:\temp
$test = test-path -path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HealthService\Parameters\Service Connector Services\Log Analytics - 40320f07-57ee-4d41-a053-256c1998ce21'
$test
if(-not($test)){
   $pathvargs = {cmd /c C:\temp\MMA.bat}
Invoke-Command -ScriptBlock $pathvargs

}
else{

$MMA = (Invoke-Command -ComputerName 'localhost' -ScriptBlock{Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HealthService\Parameters\Service Connector Services\Log Analytics - 40320f07-57ee-4d41-a053-256c1998ce21' -Name 'Is Cloud Workspace'}).'Is Cloud Workspace'
$MMA
if ($MMA -eq '1')
                 {
                   Write-Host "MMA is already installed"  -Foregroundcolor Red
                 }


else{
$pathvargs = {cmd /c C:\temp\MMA.bat}
Invoke-Command -ScriptBlock $pathvargs

}

}