@echo off

REM Misha's PowerShell Setup Script

:Introductions
REM Introductions
echo These scripts are designed to help speed up Windows and PowerShell setup.
echo Please ensure you have selected your Chocolatey packages before running the script.
echo This script needs to be run as an administrator
goto Prompt1

:Prompt1
	set admin="n"
	set /p admin=Are you running CMD as an administrator? (Y or N) 
	if /I "%WSL%"=="yes" goto Prompt2
	if /I "%WSL%"=="y" goto Prompt2
	if /I "%WSL%"=="no" goto NoAdmin
	if /I "%WSL%"=="n" goto NoAdmin
	
:Prompt2
	set admin="n"
	set /p admin=Are you running CMD as an administrator? (Y or N) 
	if /I "%WSL%"=="yes" goto Script
	if /I "%WSL%"=="y" goto Script
	if /I "%WSL%"=="no" goto NoPackages
	if /I "%WSL%"=="n" goto NoPackages

:Script
REM - Allow PowerShell to run scripts
call "%~dp0Parts\Part_1.bat"

REM - Install Chocolatey
start "Install Chocolatey" /wait "%~dp0Parts\Part_2.bat"

REM - Install packages via Chocolatey
start "Install Packages" /wait "%~dp0Parts\Part_3.bat"
color 2F
echo Chocolatey Packages have been installed
echo In the 'Tools' folder is a file called 'Make Choco Auto-Update.txt'
echo Follow those instructions to keep Chocolatey packages up to date automatically!
echo Press any key to continue  . . . 
Pause > nul
color 0F

REM - Install Linux prompt
	set WSL="n"
	set /p WSL=Would you like to install Linux via WSL? (Y or N) 
	if /I "%WSL%"=="yes" goto Part_4
	if /I "%WSL%"=="y" goto Part_4
	if /I "%WSL%"=="no" goto Fin
	if /I "%WSL%"=="n" goto Fin
	
:Part_4
REM - Install Linux via WSL2
call "%~dp0Parts\Part_4.bat"
Goto Fin

:Fin
echo You have reached the end of the script. Please restart your PC if needed, and set up everything else as desired.
echo.
echo Press any key to exit the script . . .  
Pause > nul
exit

REM ==============================================================================================================================
REM 			Conditional endings
REM ==============================================================================================================================

:NoAdmin
REM - If the user is not running CMD as admin, ask user to restart script as admin
echo The script has not run, please rerun the script as administrator
echo Press any key to exit . . .  
Pause > nul
exit

:NoPackages
REM - If the user has not selected packages, tell them to select packages prior to running the script as admin
echo The script has not run.
echo In the 'Tools' folder there is a Package Selection shortcut for an interactive checklist of the most common packages.
echo There is both an online and offline version of this file.
echo Please select your packages there and add them to 'packages.txt' for the script to fetch them.
echo Remember to list all your packages on one line separated by a space.
echo And remember to run this script as administrator!
echo Press any key to exit . . .  
Pause > nul
exit
