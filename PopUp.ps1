$result = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
$Osversion = "1909"
if($Osversion -eq $result)
{
Start-Process -FilePath "C:\ProgramData\ACCENTURE\Scripts\Popup\1909popup.exe" -NoNewWindow -ErrorAction SilentlyContinue
}