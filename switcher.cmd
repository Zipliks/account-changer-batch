@echo off
color B
Title Selector 

REM echo lines below are just for art to make terminal looks better and not so blank
:start
cls
echo.
echo   /$$     /$$ /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$ 
echo  ^|  $$   /$$//$$__  $$^| $$$ ^| $$ /$$__  $$ /$$__  $$
echo   \  $$ /$$/^| $$  \ $$^| $$$$^| $$^| $$  \__/^| $$  \__/
echo    \  $$$$/ ^| $$$$$$$$^| $$ $$ $$^|  $$$$$$ ^|  $$$$$$ 
echo     \  $$/  ^| $$__  $$^| $$  $$$$ \____  $$ \____  $$
echo      ^| $$   ^| $$  ^| $$^| $$\  $$$ /$$  \ $$ /$$  \ $$
echo      ^| $$   ^| $$  ^| $$^| $$ \  $$^|  $$$$$$/^|  $$$$$$/
echo      ^|__/   ^|__/  ^|__/^|__/  \__/ \______/  \______/ 
echo.
echo Made by Zipliks for Ascension / Eidolon
echo.


IF EXIST "settings.cfg" (
	call :parser
) ELSE (
  mkdir C:\yanss
  echo You should enter your accounts first. Please wait...
  ping 127.0.0.1 -n 3 >nul 2>&1
  call :creator
)

REM Parsing saved login from [settings.cfg] and making variables
:parser
SetLocal EnableExtensions
for /f "tokens=1,2,3,4,5 delims=," %%G in (settings.cfg) do (
	set testa=%%G
	set testb=%%H
	set testc=%%I
	set testd=%%J
	set teste=%%K
)

REM  So this one should list all available accs and prompt user for a choice
@echo 1: Main (%testa%)
@echo 2: Second (%testb%)
@echo 3: Third (%testc%)
@echo 4: Extra (%testd%)
@echo 5: Extra+ (%teste%)
echo.
@echo 6: Rewrite/Load new users
@echo 0: Exit
@echo.
@set /p userchoice= "Your decision > "
echo.

REM  This one makes sure that only numbers can be used and it changes [userchoice] variable to a pref acc
REM  [set userchoice=*login*] should be changed to preferred login (one for a line)
SET "var="&for /f "delims=0123456" %%i in ("%userchoice%") do set var=%%i
if defined var (call :start)
if "%userchoice%"=="1" (set userchoice=%testa%)
if "%userchoice%"=="2" (set userchoice=%testb%)
if "%userchoice%"=="3" (set userchoice=%testc%)
if "%userchoice%"=="4" (set userchoice=%testd%)
if "%userchoice%"=="5" (set userchoice=%teste%)
if "%userchoice%"=="6" (call :creator)
if "%userchoice%"=="0" (exit)

:switcher
echo Killing Steam process...
echo ---------------------------------------------------
REM ping 127.0.0.1 -n 1 >nul 2>&1 rem sleep-like line which pinging to localhost. -n (number) means seconds
taskkill.exe /F /IM Steam.exe
echo.
REM ping 127.0.0.1 -n 2 >nul 2>&1

REM  changing user login inside registry and makes sure that password is remembered (no one wants to enter it again) 
reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %userchoice% /f >nul
reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f >nul

REM  starting steam client using uri scheme
echo Starting Steam...
echo.
ping 127.0.0.1 -n 1 >nul 2>&1
start steam:"-console -silent"
rem start d:\steam\steam.exe -silent
echo Succesfully changed to %userchoice%
REM ping 127.0.0.1 -n 2 > nul
exit

REM  Prompt user for account names and saves it to [settings.cfg]
REM  then going to start
:creator
set /p newAcc= "Set new login >> "
set /p newAcc1= "Set new login2 >> "
set /p newAcc2= "Set new login3 >> "
set /p newAcc3= "Set new login4 >> "
set /p newAcc4= "Set new login5 >> "
echo %newAcc%,%newAcc1%,%newAcc2%,%newAcc3%,%newAcc4% > settings.cfg
call :start