cd\
cd D:\
#Start-Transcript -Path D:\
#Copy-Item –Path C:\temp\* –Destination 'D:\' -Recurse -force
#Copy-Item –Path C:\Users\Mtripathi\Downloads\* –Destination 'D:\' -Recurse -force
#Copy-Item –Path C:\Users\Mtripathi\Desktop\* –Destination 'D:\' -Recurse -force

send-mailmessage -from "dropbox build alert <dropbox@bhavnacorp.in>" -to "mayank@bhavnacorp.in" -subject "The copy of build on drop box completed" -body "The copy of build on drop box completed" -priority High -dno onSuccess, onFailure -SmtpServer 192.168.22.30

#send-mailmessage -from "dropbox build alert <dropbox@bhavnacorp.com>" -to "mayank@bhavnacorp.com" -subject "The copy of build on drop box completed" -body "The copy of build on drop box completed" -priority High -dno onSuccess, onFailure -SmtpServer 192.168.22.30
#Stop-Transcript