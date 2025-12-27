cd\
cd C:\temp
$Machines = get-content RemoteMachines.txt
$Disks = get-content Disks.txt
foreach ($Machine in $Machines) {
    foreach ($Disk in $Disks) {
        if (Test-Path \\$Machine\$Disk$) {
            Write-Host Checking $Machine Disk $Disk
            Get-ChildItem -Path \\$Machine\$Disk$\ -Filter *mayank.txt -Recurse -Name -Force | Out-File .\OUTput\$Machine$Disk.txt
        }
    }
}