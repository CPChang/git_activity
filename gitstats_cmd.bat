:: Requirement
:: 	1. Python 2.7
::	2. GNUplot
::  [3. already included as submodule] trybeee/GitStats: https://github.com/trybeee/GitStats (There is another gitstats with all small caption)

:: temporary path will be %temp%\gitactivity\[git_folder_name]
:: For example, use .\..\Matlab, then git_folder_name will be Matlab
:: In this case, the files from different repository will not be overwritten.

@echo off
setlocal
:: don't contaminate the PATH env

:: ================== customize path ===============================
set gitInstallDir="C:\Program Files\Git"
set python2path="C:\Python27\python.exe"
set outputFolder="%temp%\gitactivity\%~n1"
:: =================================================================


set gitbashpath="%gitInstallDir:"=%\bin\sh.exe"
set targetGitRepo=%~f1


:: remove the folder if exist and create a new one
if exist %outputFolder% rmdir /s /q %outputFolder%
mkdir %outputFolder%

:: cd to the folder contain this script
set thisFolderPath=%~dp0
cd %thisFolderPath%


:: need to double the back slash before pass it into bash.
:: seems like no need to remove the double quote at all
set python2path_Bash=%python2path:\=\\\\%
set outputFolder_Bash=%outputFolder:\=\\\\%
set targetGitRepo_Bash=%targetGitRepo:\=\\\\%

:: call the gitbash
:: be careful this is the bash syntax
:: the gitstats_bash.sh takes 3 args: (python2 path),(gitrepo path),(outputPath)
cmd /c  "%gitbashpath% --login -i -c "bash gitstats_bash.sh %python2path_Bash% %outputFolder_Bash% %targetGitRepo_Bash%""

:: open the webpage
start "" %outputFolder%\activity.html

endlocal
