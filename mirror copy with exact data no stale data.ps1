try

{

#Invoke-Command -ScriptBlock{Remove-Item -Path D:\test\* -recurse -Force} |  out-file D:\copied.txt

#(Get-ChildItem C:\temp -Recurse).FullName |  out-file D:\copied.txt -Append

Copy-Item –Path C:\temp\* –Destination 'D:\test\' -Recurse -Force | out-file D:\copied.txt -Append

}


catch { Write-Host " Get-ErrorReport $_ " -ForegroundColor Yellow}