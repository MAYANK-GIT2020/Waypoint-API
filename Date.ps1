$DateVal = $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))
$DateVal
$DateVal >> C:\temp\file.txt



$Date = [DateTime]"2021-11-10 12:45:43";
$newdate = '{0:yyyy-MM-dd HH:mm:ss}' -f $Date
$newdate




#check for wrong date format and change it to "2021-11-10 12:45:43"



if ($DateVal -eq $newdate)
{

Write-Output "matched"
}
 else {
         $newdate | Set-Content -Path C:\temp\file.txt
         $x = Get-Content C:\temp\file.txt
         Write-Output "Date changed to following format : $x"

          }