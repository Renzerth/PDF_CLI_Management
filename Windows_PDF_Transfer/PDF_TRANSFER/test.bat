@echo off

"WinSCP.com" ^
  /log="%HOMEPATH%\SCRIPTS\PDF_TRANSFER\FILE_TRANSFER\sftp_file_transfer.log" /ini=nul ^
  /command ^
    "open sftp://ubuntu@192.168.1.1/ -hostkey=""ssh-ed KEY"" -privatekey=""myLocalKey.ppk""" ^
    "exit"

set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
) else (
  echo %ERRORLEVEL%
)

exit /b %WINSCP_RESULT%
