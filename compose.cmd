@echo off
::Begin compose.cmd settings
set smtpfrom=changeme@example.com
set smtpaddr=127.0.0.1
set smtpport=25
set smtpuser=
set smtppass=
set smtpproto=
::set smtpproto blank for no SSL or SSL for ssl
set editor=start /w notepad.exe
set signature=nul
::signature file. Set to nul for a blank signature
set smtpmime=text/plain
::End compose.cmd settings
Set /p smtpto=To: 
set /p smtpsubj=Subject: 
set bodyfile=%TMP%\%random%-%random%-%random%-%random%
type %signature%>%bodyfile%
%editor% %bodyfile%
start /w psmail.vbs /to:%smtpto% /subject:"%smtpsubj%" /server:%smtpaddr% /port:%smtpport% /from:%smtpfrom% /protocol:%smtpproto% /user:%smtpuser% /pass:%smtppass% /bodyfile:%bodyfile% /mime:%smtpmime% /std:psmail.log
del %bodyfile%
set smtpfrom=
set smtpaddr=
set smtpport=
set smtpuser=
set smtppass=
set smtpproto=
set editor=
set signature=
Set smtpto= 
set smtpsubj= 
set bodyfile=
set smtpmime=
