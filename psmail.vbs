set args=WScript.arguments.Named
Set objShell = WScript.CreateObject("WScript.Shell")
Set fs = CreateObject("Scripting.FileSystemObject")
rndPS=objShell.ExpandEnvironmentStrings("%tmp%\"&rnd()&rnd()&rnd()&rnd())
Sub CreateTempPS(from,sendto,subject,body,server,port,user,pass,cc,replyto,files,proto,mime,bodyfile)
Set a = fs.CreateTextFile(rndPS, True)
a.writeline("$SMTPServer = "&chr(34)&server&chr(34))
a.writeline("$SMTPPort = "&chr(34)&port&Chr(34))
if len(pass)*len(user)>0 then
a.writeline("$Username = "&chr(34)&user&chr(34))
a.writeline("$Password = "&Chr(34)&pass&chr(34))
end if
a.writeline("$cc = "&Chr(34)&cc&Chr(34))
a.writeline("$subject = "&chr(34)&subject&Chr(34))
a.writeline("$body = "&chr(34)&body&chr(34))
a.writeline("$message = New-Object System.Net.Mail.MailMessage")
a.writeline("$message.subject = $subject")
a.writeline("$message.body = $body")
addr=split(sendto,",")
for i = 0 to ubound(addr)
a.writeline("$message.to.add("&chr(34)&addr(i)&chr(34)&")")
next
addr=split(cc)
for i = 0 to ubound(addr)
a.writeline("$message.cc.add("&chr(34)&addr(i)&chr(34)&")")
next
a.writeline("$message.from = "&chr(34)&from&chr(34))
afiles=split(files)
for i = 0 to ubound(afiles)
a.writeline("$message.attachments.add("&chr(34)&afiles(i)&chr(34)&")")
next
if len(mime)*len(bodyfile)>0 then
a.writeline("$altv=New-Object System.Net.Mail.AlternateView("&chr(34)&args("bodyfile")&chr(34)&","&chr(34)&mime&chr(34)&")")
a.writeline("$message.AlternateViews.add($altv)")
end if
a.writeline("$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);")
if UCase(proto)="SSL" then
a.writeline("$smtp.EnableSSL = $true")
end if
if len(user)*len(pass) then
a.writeline("$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);")
end if
a.writeline("$smtp.send($message)")
a.writeline("exit")
a.close
end sub
if args.count=0 then
set readme_md=fs.opentextfile("README.md")
WScript.echo readme_md.ReadAll
readme_md.close
WScript.Quit(0)
end if
server=args("server")
port=CInt("0"&args("port"))
if len(server)=0 then
server="127.0.0.1"
end if
if port<1 then
port=25
end if
std=args("std")
if len(std)=0 then
std="nul"
end if
CreateTempPS args("from"),args("to"),args("subject"),args("body"),server,port,args("user"),args("pass"),args("cc"),args("replyto"),args("attach"),args("protocol"),args("mime"),args("bodyfile")
objShell.run objShell.ExpandEnvironmentStrings("%Comspec% /C powershell.exe<"&rndPS&">"&std),0,true