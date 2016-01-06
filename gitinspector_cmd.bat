:: install the gitinspectro first by running `python setup.py install` in gitinspector(https://github.com/ejwa/gitinspector) folder
:: gitinspector.exe should appeared in python/script folder

@echo off
setlocal
:: ================== customize path ===============================
set gitInstallDir="C:\Program Files\Git"
set outputFolder="%temp%\gitactivity"
:: =================================================================

set outputFile="%outputFolder:"=%\gitinspector.html"
set gitcmdPath="%gitInstallDir:"=%\git-cmd.exe" 
set targetGitRepo=%~f1

:: remove the folder if exist and create a new one
if exist %outputFolder% rmdir /s /q %outputFolder%
mkdir %outputFolder%

:: cd to the folder contain this script
set thisFolderPath=%~dp0
cd %thisFolderPath%

start /wait "" %gitcmdPath% "gitinspector.exe --format=html -w -T --file-types=* %targetGitRepo% > %outputFile% & exit"

:: open the webpage
start "" %outputFile%
endlocal
