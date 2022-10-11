@echo off
if "%1" == "" echo "No MAC address given" & exit /b 1

rem Return IP value from ARP
rem https://stackoverflow.com/questions/22432369/parse-ip-address-from-arp-command-batch
for /f "tokens=1 delims= " %%i in ('arp -a ^| find /i "%1"') do set IP=%%i

rem If no IP, check net for coincident MAC
rem https://nhutils.ru/blog/en/ip-by-mac/

if "%IP%" == "" (
	for /L %%a in (1,1,254) do @start /b ping 192.168.1.%%a -n 2 > nul
	ping 127.0.0.1 -n 3 > nul
	for /f "tokens=1 delims= " %%i in ('arp -a ^| find /i "%1"') do set IP=%%i
)

if "%IP%" == "" (echo "No MAC address found" & exit /b 1) else (echo %IP%)