
# Define the download URL and the destination

#$notepadppUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.6/npp.8.5.6.Installer.x64.exe"
#TreeSizeFreeSetup_Vista_Win7.exe
$treesizeurl = "https://github.com/MAYANK-GIT2020/mayankrepo/blob/main/TreeSizeFreeSetup_Vista_Win7.exe"

#$destination = "$env:TEMP\notepadpp_installer.exe"
$destination = "$env:TEMP\TreeSizeFreeSetup_Vista_Win7.exe"


# Download Notepad++ installer
#Invoke-WebRequest -Uri $notepadppUrl -OutFile $destination
Invoke-WebRequest -Uri $treesizeurl -OutFile $destination

# Install Notepad++ silently
#Start-Process -FilePath "$env:TEMP\notepadpp_installer.exe" -ArgumentList "/S"
Start-Process -FilePath "$env:TEMP\TreeSizeFreeSetup_Vista_Win7.exe" -ArgumentList "/S"

#************************************************************************************************
#installing app forcefully on remote server
#$pathvargs = {cmd /c C:\temp\vlc-3.0.12-win32.exe /S /v/qn }
$pathvargs = {cmd /c C:\Users\maya4070\AppData\Local\Temp\TreeSizeFreeSetup_Vista_Win7.exe /S /v/qn }

Invoke-Command -ComputerName 'localhost' -ScriptBlock $pathvargs