$connectTestResult = Test-NetConnection -ComputerName testavddiag.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"testavddiag.file.core.windows.net`" /user:`"localhost\testavddiag`" /pass:`"iVgRpju8TNNt8l4Q1M/aAEZLiDShHVGPtS9uVbyP75NA7U941dFDz8cKBrGh4dukgg4+gXfKQzq0+ASt6MsOlg==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\testavddiag.file.core.windows.net\adobe" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}