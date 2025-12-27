####################################This script is intentded to copy the the data on weekly basis from D drive to our new archeive drive########################

cd\
cd C:\temp
$uncPath   = 'C:\temp'  # enter the UNC path here
$hours = (Get-Date).AddHours(-144) #for past 6 days data
$hours

# get an array of full file names for any files that was last updates in the last 144 hours
$files = (Get-ChildItem -Recurse -Path $uncPath -Filter '*.*' -File | 
          Where-Object { $_.LastWriteTime -ge $hours }).FullName
$files.Count
$files


# get an array of full foldernames for any folder that was last updates in the last 144 hours
$folder = (Get-ChildItem -Recurse -Path $uncPath -Filter '*.*' -Directory | 
          Where-Object { $_.LastWriteTime -ge $hours }).FullName
$folder.Count
$folder


if ($files -or $folder)
{
Copy-Item $files -Destination 'D:\mayanktripathi\' -Recurse -Force 
Copy-Item $folder -Destination 'D:\mayanktripathi\' -Recurse -Force
}
else{Write-Output "No new data this week"}