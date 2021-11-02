# psmail
A Simple Powershell VBScript to send email
Usage: psmail.vbs </to:addresses> </from:address> [/body:"text"] [/subject:"text"] [/bodyfile:"filename"] [/mime:mimetype] [/attach:"filenames"] [/cc:addresses] [/replyto:address]

Example send email from rickk@example.com to morty@example.com
psmaii.vbcs /to:morty@example.com /subject:"next adventure" /body:"i got this idea pls reply back" /server:mail.example.com

All parameters betweeb <> must be used while ones between [] are optional
