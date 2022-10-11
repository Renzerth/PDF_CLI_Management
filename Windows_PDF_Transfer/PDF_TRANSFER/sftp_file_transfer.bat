@echo off
rem Script for PDF files transfer to linux machine

rem Connection configuration setup
set ROOT_DIRECTORY=%USERPROFILE%\SCRIPTS\PDF_TRANSFER\
set IP_SCRIPT_FOLDER=%USERPROFILE%\SCRIPTS\MAC_IP\
set SOURCE_FOLDER=%USERPROFILE%\Desktop

set USERNAME=ubuntu
set PPK_PATH=%ROOT_DIRECTORY%\KEYS\myLocalKey.ppk
rem set PASSWORD=""
rem set SERVER_NAME=""

rem Get SERVER IP from DHCP Network
set SERVER_MAC_ADDRESS=A_MAC_ADDRESS
for /f %%i in ('%IP_SCRIPT_FOLDER%\ip_by_mac.bat %SERVER_MAC_ADDRESS%') do set SERVER_NAME=%%i
rem echo %SERVER_NAME% > test.log

rem Local host script files
set SCRIPT_FILE=%ROOT_DIRECTORY%FILES\sftp_file_transfer.txt
set LOG_FILE=%ROOT_DIRECTORY%FILES\sftp_file_transfer.log

rem Attempt to transfer files using script
"winscp.exe" /console /ini=nul /script=%SCRIPT_FILE% /log=%LOG_FILE% /loglevel=1

rem Notify success or error
if %ERRORLEVEL% equ 0 (
  echo Success
  exit /b 1
) else (
  echo Error!
  exit 0 %ERRORLEVEL%
)