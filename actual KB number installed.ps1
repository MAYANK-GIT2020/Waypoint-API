#replace XXXXXX with the actual KB number you want to check

$kbnumbers = @('KB4562830','KB5012170')

foreach ($kbnumber in $kbnumbers)
{
$update = Get-HotFix | Where-Object {$_.HotFixID -eq $kbnumber}

if ($update) {
    #Write-Host "KB$kbnumber is installed on this machine"

    Write-Host "KB$($update.HotFixID) installed on this machine $($update.InstalledOn)"

} else {
    Write-Host "KB$kbnumber is not installed on this machine"
}
}